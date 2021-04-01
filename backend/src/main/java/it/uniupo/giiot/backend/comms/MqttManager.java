package it.uniupo.giiot.backend.comms;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import org.eclipse.paho.client.mqttv3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.charset.StandardCharsets;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Classe che gestisce la comunicazione Mqtt.
 */
public class MqttManager implements MqttCallback {
    private static final Logger logger = LoggerFactory.getLogger(MqttManager.class);

    private static final Gson gson = new Gson();
    private MqttClient client;
    private MqttEventListener listener;
    private boolean isConnected = false;

    private final ExecutorService executor = Executors.newSingleThreadExecutor();

    /**
     * Restituisce l'istanza di MqttManager creata in base all'URI, all'id del client e al listerner MQTT passati
     * come parametri
     *
     * @param uri indirizzo del server
     * @param clientId id del client
     * @param listener listener di MQTT
     * @return
     * @throws MqttException se la creazione fallisce
     */
    public static MqttManager create(String uri, String clientId, MqttEventListener listener) throws MqttException {
        MqttManager instance = new MqttManager();
        instance.setListener(listener);
        instance.connect(uri, clientId);
        return instance;
    }

    /**
     * Configura la connessione al client MQTT.
     *
     * @param uri indirizzo del server.
     * @param clientId id del client.
     * @throws MqttException se la configurazione fallisce.
     */
    public void connect(String uri, String clientId) throws MqttException {
        if (isConnected())
            throw new IllegalStateException("già connesso");

        client = new MqttClient(uri, clientId);
        MqttConnectOptions co = new MqttConnectOptions();
        co.setCleanSession(false);
        co.setAutomaticReconnect(true);
        client.setCallback(this);
        client.connect(co);
        client.subscribe("iotbind/req/+", 2);
        client.subscribe("iotevents/movement/+", 2);

        isConnected = true;
    }

    /**
     * Restituisce true se è connesso, altrimenti false.
     *
     * @return true se è connesso, altrimenti false.
     */
    public boolean isConnected() {
        return isConnected;
    }

    /**
     * Imposta il listener MQTT.
     *
     * @param listener ascoltatore di eventi MQTT.
     */
    public void setListener(MqttEventListener listener) {
        this.listener = listener;
    }

    /**
     * Comunica il nuovo stato di riepimento dell'aula al dispositivo IoT con id passato come parametro.
     * L'azione non viene effettuata immediatamente, ma viene messa in una coda di elaborazione.
     *
     * @param id id del dispositivo
     * @param occupancy nuovo stato di riempimento dell'aula
     */
    public void updateOccupancy(int id, int occupancy) {
        executor.submit(() -> {
            JsonObject obj = new JsonObject();
            obj.add("occupancy", new JsonPrimitive(occupancy));
            obj.add("capacity", new JsonPrimitive(-1));  // invariata
            MqttMessage msg = new MqttMessage(gson.toJson(obj).getBytes(StandardCharsets.UTF_8));
            msg.setQos(0);
            try {
                client.publish(String.format("iotevents/update/%s", id), msg);
            }
            catch (MqttException ignored) {
                logger.error("Pubblicazione MQTT fallita");
            }
        });
    }

    /**
     * Comunica la capacità dell'aula al dispositivo IoT con id passato come parametro.
     * L'azione non viene effettuata immediatamente, ma viene messa in una coda di elaborazione.
     *
     * @param id id del dispositivo
     * @param capacity nuova capacità del riempimento dell'aula
     */
    public void updateCapacity(int id, int capacity) {
        executor.submit(() -> {
            JsonObject obj = new JsonObject();
            obj.add("occupancy", new JsonPrimitive(-1));
            obj.add("capacity", new JsonPrimitive(capacity));  // invariata
            MqttMessage msg = new MqttMessage(gson.toJson(obj).getBytes(StandardCharsets.UTF_8));
            msg.setQos(0);
            try {
                client.publish(String.format("iotevents/update/%s", id), msg);
            }
            catch (MqttException ignored) {
                logger.error("Pubblicazione MQTT fallita");
            }
        });
    }

    @Override
    public void connectionLost(Throwable cause) {
        // todo: viene lanciato anche con la riconnessione automatica?
    }

    /**
     * Viene chiamato in modo asincrono quando arriva un messaggio dal server.
     * Se è un messaggio del tipo <code>iotbind</code>, richiama il metodo <code>bind</code>.
     * Se è un messaggio del tipo <code>iotevents</code>, richiama il metodo <code>movement</code>.
     * Altrimenti non fa nulla.
     *
     * @param topic nome del topic del messaggio
     * @param message il messaggio.
     * @throws Exception
     */
    @Override
    public void messageArrived(String topic, MqttMessage message) throws Exception {
        String[] topicParts = topic.split("/");
        if (topicParts.length != 3) {
            logger.warn("Ricevuto messaggio sconosciuto in {}", topic);
            return;
        }

        switch (topicParts[0]) {
            case "iotbind":
                if (topicParts[1].equals("req"))
                    bind(topicParts[2], new String(message.getPayload(), StandardCharsets.UTF_8));
                    return;
            case "iotevents":
                if (topicParts[1].equals("movement"))
                    movement(topicParts[2], new String(message.getPayload(), StandardCharsets.UTF_8));
                    return;
        }

        logger.warn("Ricevuto messaggio sconosciuto in {}", topic);
    }

    /**
     * Richiama il listener delle richieste di binding, ottenendo un id per il nuovo
     * dispositivo e glielo comunica.
     *
     * @param uuid id del dispositivo
     * @param message messaggio da abbinare
     */
    private void bind(String uuid, String message) {
        logger.info("Richiesta di binding da {}: {}", uuid, message);

        Integer id = listener.handleBindingRequest(message);
        if (id == null)  // da interfaccia, il binding viene rifiutato
            return;

        MqttMessage msg = new MqttMessage(id.toString().getBytes(StandardCharsets.UTF_8));
        msg.setQos(2);
        try {
            client.publish(String.format("iotbind/res/%s", uuid), msg);
        }
        catch (MqttException e) {
            logger.error("Pubblicazione della risposta di binding fallita per {}", id);
        }
    }

    /**
     * Notifica al listener gli eventi di entrata/uscita dalle aule registrati dai dispositivi IoT.
     *
     * @param id id del dispositivo IoT
     * @param message messaggio che contiene le informazioni.
     */
    private void movement(String id, String message) {
        logger.debug("Evento di movimento da {}: {}", id, message);

        JsonObject eventObject;
        int numericId, ingress, egress;
        try
        {
            numericId = Integer.parseInt(id);
            eventObject = gson.fromJson(message, JsonObject.class);
            ingress = eventObject.getAsJsonPrimitive("ingress").getAsInt();
            egress = eventObject.getAsJsonPrimitive("egress").getAsInt();
        }
        catch (Throwable e)
        {
            logger.error("Ricevuto messaggio MQTT non valido da {}", id);
            return;
        }

        listener.occupancyChanged(numericId, ingress - egress);
    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken token) {}
}
