package it.uniupo.giiot.backend.core.evento;

import com.google.gson.annotations.Expose;
import it.uniupo.giiot.backend.core.IntegerPkEntity;
import it.uniupo.giiot.backend.core.aula.Aula;
import it.uniupo.giiot.backend.core.responsabile.Responsabile;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * Rappresenta un oggetto di tipo Evento.
 *
 * Un oggetto di tipo Evento ha un id, un Responsabile, un'Aula, un nome, la tipologia di evento, il numero massimo
 * di partecipanti, il numero attuale di presenti, il grado di riempiemento dell'aula, il numero massimo di
 * presenti raggiunti, la data e ora d'inizio e di fine.
 */
@Entity
@Table(name = "Evento")
public class Evento implements IntegerPkEntity<Evento> {
    @Transient
    final transient double GRAD_RIEMP_AULA_MAX = 1;

    @Transient
    final transient double GRAD_RIEMP_AULA_MIN = 0;

    @Transient
    final transient int DEFAULT_INT_MIN = 0;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "evento_id")
    @Expose
    private Integer idEvento;

    @ManyToOne
    @JoinColumn(name = "responsabile_id")
    @Expose
    private Responsabile respEvento;

    @ManyToOne
    @JoinColumn(name = "aula_id")
    @Expose
    private Aula aulaEvento;

    @Column(name = "evento_nome")
    @Expose
    private String nomeEvento;

    @Column(name = "evento_tipo")
    @Expose
    private String tipoEvento;

    /** Il numero di presenti in questo momento */
    @Column(name = "evento_n_presenti")
    @Expose
    private int nPresenti = 0;

    /** Il picco di persone registrate in aula contemporaneamente */
    @Column(name = "evento_max_presenti")
    @Expose
    private int maxPresenti = 0;

    /** Il grado di riempimento massimo impostato */
    @Column(name = "evento_grado_riemp_aula")
    @Expose
    private double gradoRiempAula;

    @Column(name = "evento_data_ora_inizio")
    @Expose
    private LocalDateTime dataOraInizio;

    @Column(name = "evento_data_ora_fine")
    @Expose
    private LocalDateTime dataOraFine;

    @Column(name = "finalizzato")
    private boolean finalizzato = false;

    public Evento() {

    }

    /**
     * Crea un oggetto di tipo evento non ancora inserito nel database.
     * Richiama i metodi <code>setRespEvento</code>, <code>setAulaEvento</code>,
     * <code>setNomeEvento</code>, <code>setTipoEvento</code>, <code>setMaxPresenti</code>,
     * <code>setNPresenti</code>, <code>setGradoRiempAula</code>, <code>setMaxPartecipanti</code>,
     * <code>setDataOraInizio</code>, <code>setDataOraFine</code>.
     * <code>maxPresenti</code>, <code>nPresenti</code>, <code>gradoRiempAula</code> sono impostati ai loro
     * valori di default.
     *
     *
     * @param respEvento responsabile dell'evento
     * @param aulaEvento aula dell'evento
     * @param nomeEvento nome dell'evento
     * @param tipoEvento tipologia dell'evento
     * @param dataOraInizio data ora inizio dell'evento
     * @param dataOraFine data ora fine dell'evento
     * @throws DaoException se <code>checkRespAula</code> non restituisce true.
     */
    public Evento(Responsabile respEvento, Aula aulaEvento, String nomeEvento, String tipoEvento,
                  LocalDateTime dataOraInizio, LocalDateTime dataOraFine) throws DaoException {
        if(checkRespAula(respEvento, aulaEvento)) {
            setRespEvento(respEvento);
            setAulaEvento(aulaEvento);
            setNomeEvento(nomeEvento);
            setTipoEvento(tipoEvento);
            setNPresenti(DEFAULT_INT_MIN);
            setGradoRiempAula(GRAD_RIEMP_AULA_MAX);
            setDataOraInizio(dataOraInizio);
            setDataOraFine(dataOraFine);
        }
    }

    /**
     * Overload del costruttore.
     * Permette personalizzare il numero massimo di partecipanti in base al grado di riempimento dell'aula.
     *
     * @param respEvento responsabile evento
     * @param aulaEvento aula dove si svolgerà l'evento
     * @param nomeEvento nome dell'evento
     * @param tipoEvento tipo dell'evento
     * @param gradoRiempAula grado di riempimento dell'aula
     * @param dataOraInizio data e ora d'inizio dell'evento
     * @param dataOraFine data e ora di fine dell'evento
     */
    public Evento(Responsabile respEvento, Aula aulaEvento, String nomeEvento, String tipoEvento,
                  Double gradoRiempAula, LocalDateTime dataOraInizio, LocalDateTime dataOraFine) throws DaoException {
        this(respEvento, aulaEvento, nomeEvento, tipoEvento, dataOraInizio, dataOraFine);
        setGradoRiempAula(gradoRiempAula);
    }

    /**
     * Restituisce l'id dell'evento.
     * Richiama il metodo <code>getIdEvento</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @return  id dell'evento.
     */
    @Override
    public Integer getPk() {
        return getIdEvento();
    }

    /**
     * Imposta l'id dell'evento.
     * Richiama il metodo <code>setIdEvento</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @param pk id dell'attrezzatura.
     */
    @Override
    public void setPk(Integer pk) {
        setIdEvento(pk);
    }

    /**
     * Restituisce tutte gli eventi presenti nel database.
     * Richiama il metodo <code>cercaEvento</code>.
     *
     * @return Collection degli eventi nel database.
     */
    @Override
    public Collection<Evento> getAll() {
        return cercaEvento(HibernateUtil.getCurrentSession(), null, null, null, null, null, null, false);
    }

    /**
     * Restituisce l'id dell'evento salvato nel database
     *
     * @return idEvento: id dell'evento
     */
    public Integer getIdEvento() {
        return idEvento;
    }

    /**
     * Imposta l'id dell'evento per il database
     *
     * @param idEvento id dell'evento
     */
    public void setIdEvento(Integer idEvento) {
        this.idEvento = idEvento;
    }

    /**
     * Restituisce il responsabile dell'evento
     *
     * @return responsabile dell'evento
     */
    public Responsabile getRespEvento() {
        return respEvento;
    }

    /**
     * Imposta il responsabile dell'evento.
     *
     * @param respEvento responsabile dell'evento.
     * @throws DaoException se <code>respEvento</code> è null.
     */
    public void setRespEvento(Responsabile respEvento) throws DaoException {
        if(!isNull(respEvento)) {
            this.respEvento = respEvento;
        } else {
            throw new DaoException("EVENTO: Il responsabile inserito è null");
        }
    }

    /**
     * Restituisce l'aula dell'evento.
     *
     * @return aulaEvento: aula dell'evento.
     */
    public Aula getAulaEvento() {
        return aulaEvento;
    }

    /**
     * Imposta l'aula dell'evento.
     *
     * @param aulaEvento aula dell'evento
     * @throws DaoException se <code>aulaEvento</code> è null.
     */
    public void setAulaEvento(Aula aulaEvento) throws DaoException {
        if(!isNull(aulaEvento)) {
            this.aulaEvento = aulaEvento;
        } else {
            throw new DaoException("EVENTO: L'aula inserita è null");
        }
    }

    /**
     * Restituisce il nome dell'evento.
     *
     * @return nomeEvento: nome dell'evento.
     */
    public String getNomeEvento() {
        return nomeEvento;
    }

    /**
     * Imposta il nome dell'evento.
     *
     * @param nomeEvento nome dell'evento.
     * @throws DaoException se <code>nomeEvento</code> è null.
     */
    public void setNomeEvento(String nomeEvento) throws DaoException {
        if(!isNull(nomeEvento)) {
            this.nomeEvento = nomeEvento;
        } else {
            throw new DaoException("EVENTO: il nome evento inserito è null");
        }
    }

    /**
     * Restituisce la tipologia dell'evento.
     *
     * @return tipologia dell'evento.
     */
    public String getTipoEvento() {
        return tipoEvento;
    }

    /**
     * Imposta il tipo dell'evento.
     *
     * @param tipoEvento tipo dell'evento.
     * @throws DaoException se <code>tipoEvento</code> è null.
     */
    public void setTipoEvento(String tipoEvento) throws DaoException {
        if(!isNull(tipoEvento)) {
            this.tipoEvento = tipoEvento;
        } else {
            throw new DaoException("EVENTO: il tipo evento inserito è null");
        }
    }

    /**
     * Restituisce il numero di massimo di partecipanti ammessi all'evento
     *
     * @return numero massimo di partecipanti ammessi all'evento
     */
    public int getMaxPartecipanti() {
        return Double.valueOf(Math.floor(aulaEvento.getCapienzaMax() * getGradoRiempAula())).intValue();
    }

    /**
     * Restituisce il numero presenti attuali all'evento
     *
     * @return numero di presenti attuali all'evento
     */
    public int getnPresenti() {
        return nPresenti;
    }

    /**
     * Imposta il numero di presenti attuali all'evento.
     * Se <code>nPresenti</code> diventa maggiore di <code>maxPresenti</code>, imposta <code>maxPresenti</code>
     * uguale a <code>nPresenti</code>.
     *
     * @param nPresenti numero di presenti attuali all'evento
     * @throws DaoException se <code>nPresenti</code> è minore del suo valore di default.
     */
    public void setNPresenti(int nPresenti) throws DaoException {
        if (!isMinore(nPresenti, DEFAULT_INT_MIN)) {
            this.nPresenti = nPresenti;
            if (nPresenti > maxPresenti) {
                maxPresenti = nPresenti;
            }
        } else {
            throw new DaoException(
                    "NUMERO DI PRESENTI: inserito un valore minore di " + DEFAULT_INT_MIN + ".");
        }
    }

    /**
     * Aggiunge <code>value</code> a <code>nPresenti</code>
     *
     * @param value valore da aggiungere
     * @throws DaoException se passa a <code>setNPresenti</code> un valore null.
     */
    public void modificaPresenti(int value) throws DaoException {
        setNPresenti(getnPresenti() + value);
    }

    /**
     * Restituisce il grado di riempimento dell'aula dell'evento
     *
     * @return gradoRiempAula: grado di riempimento dell'aula dell'evento
     */
    public double getGradoRiempAula() {
        return gradoRiempAula;
    }

    /**
     * Imposta il grado di riempimento dell'aula dell'evento
     *
     * @param  gradoRiempAula: grado di riempimento dell'aula dell'evento
     * @throws DaoException se <code>gradoRiempAula</code> non è compreso tra <code>GRAD_RIEMP_AULA_MIN</code> e
     * <code>GRAD_RIEMP_AULA_MAX</code>
     */
    public void setGradoRiempAula(double gradoRiempAula) throws DaoException {
        if(gradoRiempAula >= GRAD_RIEMP_AULA_MIN) {
            if (gradoRiempAula <= GRAD_RIEMP_AULA_MAX) {
                this.gradoRiempAula = gradoRiempAula;
            } else {
                throw new DaoException(
                        "GRADO RIEMPIMENTO AULA: inserito un valore maggiore di " + GRAD_RIEMP_AULA_MAX + ".");
            }
        } else {
            throw new DaoException(
                    "GRADO RIEMPIMENTO AULA: inserito un valore minore di " + GRAD_RIEMP_AULA_MIN + ".");
        }
    }

    /**
     * Restituisce il numero massimo di presenti raggiunti durante l'evento.
     *
     * @return numero massimo di presenti raggiunti durante l'evento.
     */
    public Integer getMaxPresenti() {
        return maxPresenti;
    }

    /**
     * Restituisce la data e l'ora d'inizio dell'evento.
     *
     * @return dataOraInizio: data e ora d'inizio dell'evento
     */
    public LocalDateTime getDataOraInizio() {
        return dataOraInizio;
    }

    /**
     * Imposta la data e l'ora d'inizio dell'evento
     *
     * @param dataOraInizio data e ora d'inizio dell'evento
     */
    public void setDataOraInizio(LocalDateTime dataOraInizio) {
        this.dataOraInizio = dataOraInizio;
    }

    /**
     * Modifica la data e l'ora d'inizio dell'evento.
     *
     * @param nuovaDataOraInizio
     * @throws DaoException se <code>nuovaDataOraInizio</code> è maggiore di <code>dataOraFine</code>.
     */
    public void modificaDataOraInizio(LocalDateTime nuovaDataOraInizio) throws DaoException {
        if(isMinore(nuovaDataOraInizio, getDataOraFine())) {
            setDataOraInizio(nuovaDataOraInizio);
        } else {
            throw new DaoException("DATA ORA INIZIO: Inserita una data o ora d'inizio evento successiva alla data di fine");
        }
    }

    /**
     * Restituisce la data e l'ora di fine dell'evento.
     *
     * @return data e ora di fine dell'evento
     */
    public LocalDateTime getDataOraFine() {
        return dataOraFine;
    }

    /**
     * Imposta la data e l'ora d'inizio dell'evento.
     *
     * @param dataOraFine data e ora di fine dell'evento
     * @throws DaoException se <code>dataOraFine</</code> è minore di <code>dataOraInizio</code>.
     */
    public void setDataOraFine(LocalDateTime dataOraFine) throws DaoException {
        if(isMinore(getDataOraInizio(), dataOraFine)) {
            this.dataOraFine = dataOraFine;
        } else {
            throw new DaoException("DATA ORA FINE: Inserita una data o ora di fine evento precedente alla data d'inizio");
        }
    }

    public boolean isFinalizzato() {
        return finalizzato;
    }

    public void setFinalizzato() {
        this.finalizzato = true;
    }

    /**
     * Restituisce true se il valore <code>value</code> è maggiore del valore
     * <code>min</code>.
     *
     * @param value valore da controllare
     * @param check valore con cui effettuare il confronto
     * @return true se il valore value è maggiore di min, altrimenti false
     */
    private <T extends Comparable<T>> boolean isMinore(T value, T check) {
        return value.compareTo(check) < 0;
    }

    /**
     * Restituisce true se due oggetti di tipo evento sono uguali, altrimenti false.
     *
     * Due oggetti di tipo evento sono uguali se hanno lo stesso id.
     *
     * @param o oggetto con cui fare il confronto
     * @return true se i due oggetti sono uguali, altrimenti false
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Evento evento = (Evento) o;
        return Objects.equals(idEvento, evento.idEvento);
    }

    @Override
    public int hashCode()
    {
        return Objects.hash(idEvento);
    }

    /**
     * Restituisce true se <code>responsabile</code> e <code>aula</code> non sono null.
     *
     * @param responsabile responsabile da controllare
     * @param aula aula da controllare
     * @return true se <code>responsabile</code> e <code>aula</code> non sono null
     * @throws DaoException se <code>responsabile</code> o <code>aula</code> sono null
     */
    private boolean checkRespAula(Responsabile responsabile, Aula aula) throws DaoException {
        if(isNull(responsabile)) {
            throw new DaoException("EVENTO: Il responsabile inserito è null");
        }
        if(isNull(aula)) {
            throw new DaoException("EVENTO: L'aula inserita è null");
        }
        return true;
    }

    public boolean isCorrente() {
        LocalDateTime now = LocalDateTime.now();
        return now.isAfter(dataOraInizio) && now.isBefore(dataOraFine);
    }

    /**
     * Restituisce true se <code>objcet</code> è null, altrimenti false.
     *
     * @param object oggetto da controllare
     * @param <T> tipo generico
     * @return true se <code>objcet</code> è null, altrimenti false.
     */
    private <T> boolean isNull(T object) {
        return object == null;
    }

    /**
     * Restituisce true se <code>maxPartecipanti</code> è minore uguale delle capacità massima dell'aula.
     *
     * @param maxPartecipanti numero massimo di partecipanti ammessi all'evento
     * @param aula aula da controllare
     * @return true se <code>maxPartecipanti</code> è minore uguale delle capacità massima dell'aula
     * @throws DaoException se <code>maxPartecipanti</code> è maggiore delle capacità massima dell'aula
     */
    private boolean checkCapacitaAula(int maxPartecipanti, Aula aula) throws DaoException {
        if(maxPartecipanti <= aula.getCapienzaMax()) {
            return true;
        } else {
            throw new DaoException("EVENTO CAPACITÀ AULA: Il numero massimo di partecipanti supera la capienza dell'aula");
        }
    }

    /**
     * Restituisce true se l'aula inserita è disponibile nelle date e nelle ore inserite. Altrimenti false.
     *
     * @param session sessione di hibernate
     * @param aula aula da controllare
     * @param dataOraInizio data ora d'inizio
     * @param dataOraFine data ora di fine
     * @return true se l'aula inserita è disponibile nelle date e nelle ore inserite. Altrimenti false.
     */
    public static boolean checkDispAula(Session session, Aula aula, LocalDateTime dataOraInizio, LocalDateTime dataOraFine) {
        return Evento.cercaEvento(session, null, aula,
                null, null, dataOraInizio, dataOraFine, true).size() <= 0;
    }

    /**
     * Restistuisce la lista degli eventi
     * presenti nel database in base ai parametri passati come input.
     * Restituisce una lista vuota se non viene trovato nulla.
     * Se tutte le stringe passate come parametro sono nulle, vengono restituiti tutti gli
     * oggetti di tipo evento presenti nel database.
     * La ricerca viene effettuata solo per i valori non nulli.
     * Se il parametro in input <code>range</code> è true, viene effettuata una ricerca per range di date.
     *
     * @return lista che contiene gli eventi trovati
     */
    public static List<Evento> cercaEvento(Session session, Responsabile respEvento, Aula aulaEvento, String nomeEvento, String tipoEvento,
                                           LocalDateTime dataOraInizio, LocalDateTime dataOraFine, boolean range) {
        List<Evento> list = null;
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Evento> query = builder.createQuery(Evento.class);
            Root<Evento> root = query.from(Evento.class);
            Predicate[] pr = buildPredicate(builder, root, respEvento, aulaEvento, nomeEvento, tipoEvento, dataOraInizio,
                    dataOraFine, range);
            if(pr.length > 0) {
                query.select(root).where(pr);
            } else {
                query.select(root).where();
            }
            query.orderBy(builder.asc(root.get("idEvento")));
            Query<Evento> q = session.createQuery(query);
            list = q.getResultList();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Restistuisce la lista degli non finalizzati con data di inizio precedente ad ora, ordinata per
     * <ol>
     *     <li>{@link #aulaEvento} crescente</li>
     *     <li>{@link #dataOraInizio} crescente</li>
     * </ol>
     */
    public static List<Evento> cercaEventiNonFinalizzati(Session session) {
        List<Evento> list = null;
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Evento> query = builder.createQuery(Evento.class);
            Root<Evento> root = query.from(Evento.class);
            List<Predicate> pr = new ArrayList<>();
            pr.add(builder.lessThanOrEqualTo(root.get("dataOraInizio"), builder.currentTimestamp()));
            pr.add(builder.equal(root.get("finalizzato"), false));
            query.select(root).where(pr.toArray(new Predicate[0]));
            query.orderBy(builder.asc(root.get("aulaEvento")), builder.asc(root.get("dataOraInizio")));
            Query<Evento> q = session.createQuery(query);
            list = q.getResultList();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Restistuisce la lista degli eventi correnti.
     */
    public static List<Evento> cercaEventiCorrenti(Session session) {
        List<Evento> list = null;
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Evento> query = builder.createQuery(Evento.class);
            Root<Evento> root = query.from(Evento.class);
            List<Predicate> pr = new ArrayList<>();
            pr.add(builder.lessThanOrEqualTo(root.get("dataOraInizio"), builder.currentTimestamp()));
            pr.add(builder.greaterThan(root.get("dataOraFine"), builder.currentTimestamp()));
            query.select(root).where(pr.toArray(new Predicate[0]));
            Query<Evento> q = session.createQuery(query);
            list = q.getResultList();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Costruisce in modo dinamico la query di ricerca per gli eventi nel database.
     * Le stringhe non nulle non vengono aggiunte alle query.
     * Se <code>dupl</code> è positivo la query di ricerca per il nome dell'aula
     * utilizza l'operatore AND, altrimenti LIKE.
     *
     * @param builder oggetto usato per costruire le query
     * @param root tipo di entità a cui fa riferimento la radice
     * @return oggetto predicate che indica con quali restrizioni fare la ricerca
     */
    private static Predicate[] buildPredicate(CriteriaBuilder builder, Root<Evento> root, Responsabile respEvento,
                                       Aula aulaEvento, String nomeEvento, String tipoEvento,
                                       LocalDateTime dataOraInizio, LocalDateTime dataOraFine, boolean range) {
        List<Predicate> predicates = new ArrayList<>();
        if(respEvento != null) {
            Predicate resp;
            resp = builder.equal(root.get("respEvento"), respEvento);
            predicates.add(resp);
        }
        if(aulaEvento != null) {
            Predicate aula;
            aula = builder.equal(root.get("aulaEvento"), aulaEvento);
            predicates.add(aula);
        }
        if(nomeEvento != null) {
            Predicate nome;
            nome = builder.like(root.get("nomeEvento"), "%" + nomeEvento + "%");
            predicates.add(nome);
        }
        if(tipoEvento != null) {
            Predicate tipo;
            tipo = builder.like(root.get("tipoEvento"), "%" + tipoEvento + "%");
            predicates.add(tipo);
        }
        if (range) {
            Predicate dateRangeInizio;
            dateRangeInizio = builder.between(root.get("dataOraInizio"), dataOraInizio, dataOraFine);
            Predicate dateRangeFine;
            dateRangeFine = builder.between(root.get("dataOraFine"), dataOraInizio, dataOraFine);
            Predicate dataRange;
            dataRange = builder.or(dateRangeInizio, dateRangeFine);
            predicates.add(dataRange);
        } else {
            if(dataOraInizio != null) {
                Predicate inizio;
                inizio = builder.equal(root.get("dataOraInizio"), dataOraInizio);
                predicates.add(inizio);
            }
            if(dataOraFine != null) {
                Predicate fine;
                fine = builder.equal(root.get("dataOraFine"), dataOraFine);
                predicates.add(fine);
            }
        }
        Predicate [] pr = new Predicate[predicates.size()];
        return predicates.toArray(pr);
    }
}


