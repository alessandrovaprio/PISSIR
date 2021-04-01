package it.uniupo.giiot.backend.comms;

import it.uniupo.giiot.backend.core.aula.Aula;
import it.uniupo.giiot.backend.core.dispositivo.Dispositivo;
import it.uniupo.giiot.backend.core.evento.Evento;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.hibernate.Session;
import org.hibernate.context.internal.ManagedSessionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Implementa la logica di gestione degli eventi. Inoltre fa da entry point per l'applicazione.
 */
public class Cerebrum implements MqttEventListener {
    private static final Logger logger = LoggerFactory.getLogger(Cerebrum.class);

    /**
     * Tempo di polling per processare gli eventi
     * @see #tmr
     */
    public final long POLLING_RATE_MS = 5000;

    /** Timer per processare gli eventi */
    private final Timer tmr = new Timer(true);

    /** Oggetto lock per {@link #currentEventi} */
    private final Object currentEventiLock = new Object();
    /** Eventi attualmente in corso, mappati dalla relativa Aula */
    private final Map<Aula, Evento> currentEventi = new HashMap<>();
    /** Server REST */
    private RestServer restServer;
    /** Manager MQTT */
    private MqttManager mqttManager;

    // impedisci l'istanziazione esplicita dall'esterno
    private Cerebrum() {}

    public static void main(String[] args) {
        Cerebrum instance = new Cerebrum();

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            instance.restServer.stop();
            instance.tmr.cancel();
        }));

        try {
            instance.instanceMain();
        }
        catch (Throwable t) {
            t.printStackTrace(System.err);
        }
    }

    /**
     * Fornisce l'entry point dell'applicazione
     * @throws MqttException se è impossibile connettersi al broker MQTT
     */
    private void instanceMain() throws MqttException {
        restServer = RestServer.getInstance();
        mqttManager = MqttManager.create("tcp://localhost", "cerebrum", this);
        startTimer();
    }

    /**
     * Avvia il timer di polling degli Eventi.
     */
    private void startTimer() {
        tmr.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                long ctm = System.currentTimeMillis();
                logger.debug("Iniziato ciclo di processamento");

                Session s = HibernateUtil.getSessionFactory().openSession();
                s.beginTransaction();

                ManagedSessionContext.bind(s);

                synchronized (currentEventiLock) {
                    currentEventi.clear();
                    handleEventFinalizations();
                    Evento.cercaEventiCorrenti(HibernateUtil.getCurrentSession())
                            .forEach(e -> currentEventi.put(e.getAulaEvento(), e));
                }

                ManagedSessionContext.unbind(HibernateUtil.getSessionFactory());

                s.getTransaction().commit();
                s.close();

                logger.debug("Ciclo di processamento terminato in {} ms", System.currentTimeMillis() - ctm);
            }
        }, 0, POLLING_RATE_MS);
    }

    /**
     * Ottiene l'evento corrente per un'Aula, sincronizzandosi al ciclo di polling.
     * @param aula l'Aula di cui ottenere l'Evento
     * @return l'Evento in corso in aula, se presente; <code>null</code> altrimenti
     */
    public Evento getCurrentEvento(Aula aula) {
        synchronized (currentEventiLock) {
            return currentEventi.get(aula);
        }
    }

    /**
     * Gestisce il passaggio tra eventi, spostando eventuali partecipanti dagli eventi precedenti a quello corrente.
     */
    private void handleEventFinalizations() {
        Map<Aula, List<Evento>> eventiAule = Evento.cercaEventiNonFinalizzati(HibernateUtil.getCurrentSession())
                .stream()
                .collect(Collectors.groupingBy(Evento::getAulaEvento));

        for (List<Evento> eventiAula : eventiAule.values())
            handleEventFinalizationFor(new ArrayList<>(eventiAula));  // todo: raggrupparre già per ArrayList
    }

    /**
     * @see #handleEventFinalizations()
     */
    private void handleEventFinalizationFor(ArrayList<Evento> eventi) {
        int lastIndex = eventi.size() - 1;
        Evento last = eventi.get(lastIndex);
        eventi.remove(lastIndex);

        int presenti = 0;
        for (Evento e : eventi) {
            presenti += e.getnPresenti();
            e.setNPresenti(0);
            e.setFinalizzato();
        }

        last.modificaPresenti(presenti);

        for (Dispositivo dispositivo : last.getAulaEvento().getDispositivi()) {
            mqttManager.updateCapacity(dispositivo.getIdDispositivo(), last.getMaxPartecipanti());
            mqttManager.updateOccupancy(dispositivo.getIdDispositivo(), last.getnPresenti());
        }
    }

    /**
     * Gestisce una richiesta di binding da un dispositivo IoT.
     * @param deviceType la stringa fornita dal dispositivo che ne indica il tipo
     * @return l'id assegnato al dispositivo
     */
    @Override
    public Integer handleBindingRequest(String deviceType) {
        Dispositivo dispositivo = new Dispositivo(null, deviceType, deviceType, LocalDate.now());
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Integer id = HibernateUtil.insertWithIntegerPk(session, dispositivo);
        session.getTransaction().commit();
        session.close();

        return id;
    }

    /**
     * Gestisce l'evento generato da un dispositivo IoT che indica un cambiamento nelle presenze di un'Aula.
     * @param id l'id del dispositivo che ha segnalato il cambiamento
     * @param change cambiamento relativo dell'occupazione di una stanza
     */
    @Override
    public void occupancyChanged(int id, int change) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();

        Dispositivo dispositivo = HibernateUtil.getWithIntegerPk(session, Dispositivo.class, id);
        Aula aula = dispositivo.getAulaDispositivo();
        if (aula == null) {  // ignora gli eventi se il dispositivo non è associato ad un'aula
            session.close();
            return;
        }

        session.getTransaction().commit();  // libero il lock SQL sul dispositivo e l'aula per evitare deadlock
        session.beginTransaction();

        Evento eventoAula = getCurrentEvento(aula);
        if (eventoAula == null) {  // ignora gli eventi se non c'è un evento in corso
            session.getTransaction().rollback();
            session.close();
            return;
        }

        // ottieni un'istanza managed dell'evento e aggiorna la versione nella hashmap
        eventoAula = HibernateUtil.getWithIntegerPk(session, Evento.class, eventoAula.getPk());

        eventoAula.modificaPresenti(change);

        // aggiorno tutti i dispositivi dell'aula
        for (Dispositivo dis : aula.getDispositivi())
            mqttManager.updateOccupancy(dis.getIdDispositivo(), eventoAula.getnPresenti());

        session.getTransaction().commit();
        session.close();
    }
}
