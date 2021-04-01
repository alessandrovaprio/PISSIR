package it.uniupo.giiot.iot.core;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import it.uniupo.giiot.iot.api.DetectionAgent;
import it.uniupo.giiot.iot.api.FeedbackChangeEvent;
import it.uniupo.giiot.iot.api.FeedbackProvider;
import it.uniupo.giiot.iot.api.IotSubsystem;
import org.eclipse.paho.client.mqttv3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Set;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

/**
 * TODO: questo doc
 * TODO: logging
 */
public class AulosIotSubsystem extends Thread implements IotSubsystem, MqttCallback
{
    private final Logger logger = LoggerFactory.getLogger(AulosIotSubsystem.class);

    /**
     * La coda degli eventi da processare.
     */
    private final BlockingQueue<DetectionEvent> incomingEvents = new LinkedBlockingQueue<>();

    /**
     * La coda dei messaggi MQTT da processare.
     */
    private final BlockingQueue<byte[]> incomingMessages = new LinkedBlockingQueue<>();

    /**
     * La Collection dei {@link FeedbackProvider} a cui segnalare gli eventi.
     */
    private final Collection<FeedbackProvider> feedbackProviders = new ArrayList<>();

    /**
     * La Collection dei {@link DetectionAgent} a cui segnalare gli eventi.
     */
    private final Collection<DetectionAgent> detectionAgents = new ArrayList<>();

    /**
     * Il topic MQTT da utilizzare per inviare eventi al backend.
     */
    private final MqttTopic mqttTopic;

    /**
     * L'ID di questo dispositivo IoT.
     */
    private final String id;

    /**
     * La capacità della stanza gestita.
     */
    private volatile int roomCapacity = -1;

    /**
     * L'occupazione della stanza gestita.
     */
    private volatile int roomOccupancy = -1;
    
    public AulosIotSubsystem(String id, MqttTopic mqttTopic)
    {
        this.id = id;
        this.mqttTopic = mqttTopic;
    }

    /**
     * Imposta i {@link FeedbackProvider} e i {@link DetectionAgent} a cui il sottosistema notifica gli eventi.
     */
    public void setPlugins(Set<FeedbackProvider> feedbackProviders, Set<DetectionAgent> detectionAgents)
    {
        /*
         * Nota: le proprietà della classe sono di tipo Collection, per permettere l'uso di collezioni con iteratore
         * efficiente, mentre noi accettiamo Set per garantire l'unicità degli oggetti. Sarebbe comunque stato
         * corretto copiare le collezioni in input.
         */
        
        this.feedbackProviders.clear();
        this.feedbackProviders.addAll(feedbackProviders);
        
        this.detectionAgents.clear();
        this.detectionAgents.addAll(detectionAgents);
        
        logger.info("Caricati {} FeedbackProvider e {} DetectionAgent",
                this.feedbackProviders.size(), this.detectionAgents.size());
    }

    @Override
    public void run()
    {
        for (DetectionAgent o : detectionAgents)
        {
            logger.debug("Avvio del DetectionAgent {}", o.getClass().getSimpleName());
            o.onStart();
        }
        
        for (FeedbackProvider o : feedbackProviders)
        {
            logger.debug("Avvio del FeedbackProvider {}", o.getClass().getSimpleName());
            o.onStart();
        }
        /*
         * Il ciclo di processamento è, a livello logico, strutturato come segue.
         * - Vengono processati gli eventi di ingresso e uscita che arrivano dai plugin, e vengono contati
         * - Gli eventi vengono segnalati al backend in forma aggregata
         * - Vengono processati gli eventi in ingresso dal backend
         * - Gli eventi vengono segnalati ai plugin in forma aggregata
         */
        final Gson gson = new Gson();
        while (!isInterrupted())
        {
            logger.trace("Iniziato ciclo di processamento");
            
            int ingressAmt = 0;
            int egressAmt = 0;

            // - processa gli eventi dai plugin
            /* Per evitare la starvation, utilizzo come bound il numero di elementi presenti nella coda all'inizio del
             * processamento. */
            int queued = incomingEvents.size();
            while (queued-- > 0 && !incomingEvents.isEmpty())
            {
                switch (incomingEvents.poll())
                {
                    case INGRESS:  ingressAmt++; logger.debug("Ingresso"); break;
                    case EGRESS:   egressAmt++;  logger.debug("Uscita");   break;
                }
            }

            if (ingressAmt > 0 || egressAmt > 0)
            {
                logger.info("Rilevati {} ingressi e {} uscite", ingressAmt, egressAmt);

                // - invia aggiornamenti MQTT
                JsonObject obj = new JsonObject();
                obj.add("ingress", new JsonPrimitive(ingressAmt));
                obj.add("egress", new JsonPrimitive(egressAmt));
                MqttMessage outgoingMessage = new MqttMessage(gson.toJson(obj).getBytes(StandardCharsets.UTF_8));
                outgoingMessage.setQos(2);

                try
                {
                    mqttTopic.publish(outgoingMessage);
                }
                catch (MqttException e)
                {
                    logger.error("Impossibile recapitare evento MQTT: [{}] {}", e.getReasonCode(), e.getMessage());
                }
            }

            // - ricevi aggiornamenti MQTT
            boolean isCapacityChanged = false;
            boolean isOccupancyChanged = false;

            /* Per evitare la starvation, utilizzo come bound il numero di elementi presenti nella coda all'inizio del
             * processamento. */
            queued = incomingMessages.size();
            while (queued-- > 0 && !incomingMessages.isEmpty())
            {
                String message = new String(incomingMessages.poll(), StandardCharsets.UTF_8);
                JsonObject eventObject;
                int newCapacity, newOccupancy;
                try
                {
                    eventObject = gson.fromJson(message, JsonObject.class);
                    newCapacity = eventObject.getAsJsonPrimitive("capacity").getAsInt();
                    newOccupancy = eventObject.getAsJsonPrimitive("occupancy").getAsInt();
                }
                catch (Throwable e)
                {
                    logger.error("Ricevuto messaggio MQTT non valido: {}", e.getClass().getSimpleName());
                    continue;
                }
                
                if (newCapacity != -1 && newCapacity != roomCapacity)
                {
                    logger.info("Nuova capacità: {}", newCapacity);
                    roomCapacity = newCapacity;
                    isCapacityChanged = true;
                }
                
                if (newOccupancy != -1 && newOccupancy != roomOccupancy)
                {
                    logger.info("Nuova occupazione: {}", newOccupancy);
                    roomOccupancy = newOccupancy;
                    isOccupancyChanged = true;
                }
            }
            
            // - segnala ai plugin di feedback
            Fce capacityFce = isCapacityChanged ? new Fce(FeedbackChangeEvent.ChangeType.CAPACITY) : null;
            Fce occupancyFce = isOccupancyChanged ? new Fce(FeedbackChangeEvent.ChangeType.OCCUPANCY) : null;
            for (FeedbackProvider o : feedbackProviders)
            {
                if (capacityFce != null)
                    o.onChange(capacityFce);
                
                if (occupancyFce != null)
                    o.onChange(occupancyFce);
            }
        }

        for (DetectionAgent o : detectionAgents)
        {
            logger.debug("Terminazione del DetectionAgent {}", o.getClass().getSimpleName());
            o.onStop();
        }

        for (FeedbackProvider o : feedbackProviders)
        {
            logger.debug("Terminazione del FeedbackProvider {}", o.getClass().getSimpleName());
            o.onStop();
        }
    }

    /**
     * Ritorna la capacità della stanza gestita dal sottosistema IoT.
     */
    @Override
    public int getRoomCapacity()
    {
        return roomCapacity;
    }

    /**
     * Ritorna l'occupazione della stanza gestita dal sottosistema IoT.
     */
    @Override
    public int getRoomOccupancy()
    {
        return roomOccupancy;
    }

    /**
     * Aggiunge un evento di ingresso alla coda degli eventi.
     */
    @Override
    public void ingressDetected()
    {
        incomingEvents.add(DetectionEvent.INGRESS);
    }

    /**
     * Aggiunge un evento di uscita alla coda degli eventi.
     */
    @Override
    public void egressDetected()
    {
        incomingEvents.add(DetectionEvent.EGRESS);
    }

    @Override
    public String getIotId()
    {
        return id;
    }

    /**
     * Callback MQTT: chiamato quando avviene una disconnessione dal server.
     */
    @Override
    public void connectionLost(Throwable cause)
    {
        logger.warn("Connessione all'endpoint MQTT persa: {}", cause.getMessage());
    }

    /**
     * Callback MQTT: chiamato quando arriva un messaggio dal server.
     */
    @Override
    public void messageArrived(String topic, MqttMessage message)
    {
        incomingMessages.add(message.getPayload());
    }

    /**
     * Callback MQTT: ignorato.
     */
    @Override
    public void deliveryComplete(IMqttDeliveryToken token) {}

    private enum DetectionEvent
    {
        INGRESS, EGRESS
    }
    
    private static class Fce implements FeedbackChangeEvent
    {
        private final ChangeType ct;
        
        Fce(ChangeType ct)
        {
            this.ct = ct;
        }

        @Override
        public ChangeType getChangeType()
        {
            return ct;
        }
    }
}
