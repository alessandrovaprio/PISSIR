package it.uniupo.giiot.iot.core;

import it.uniupo.giiot.iot.api.DetectionAgentFactory;
import it.uniupo.giiot.iot.api.FeedbackProviderFactory;
import it.uniupo.giiot.iot.plugins.detection.HttpDetection;
import it.uniupo.giiot.iot.plugins.feedback.HttpFeedback;
import it.uniupo.giiot.iot.plugins.feedback.SmartLightsFeedback;
import org.eclipse.paho.client.mqttv3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

public class AulosIot {
    private static final Logger logger = LoggerFactory.getLogger(AulosIot.class);

    private static final MqttConnectOptions co = new MqttConnectOptions();

    static {
        co.setCleanSession(false);
        co.setAutomaticReconnect(true);
    }

    public static final File PROPERTIES_FILE = new File("iot.properties");

    private static MqttClient cl;

    public static void main(String[] args) throws MqttException, IOException, InvocationTargetException, InterruptedException {
        Properties props = new Properties();
        if (PROPERTIES_FILE.exists()) {
            try (InputStream is = new FileInputStream(PROPERTIES_FILE)) {
                props.load(is);
            } catch (FileNotFoundException ignored) {
            }
        }

        if (props.getProperty("uuid") == null)
            props.setProperty("uuid", UUID.randomUUID().toString());

        // verifica prima del binding che il file delle proprietà sia scrivibile - e salva l'UUID se è stato generato
        try (OutputStream os = new FileOutputStream(PROPERTIES_FILE)) {
            props.store(os, "aulos iot");
        }

        cl = new MqttClient(
                props.getProperty("hostname", "tcp://localhost"),
                String.format("aulos-iot-%s", props.getProperty("uuid")));

        doBinding(props);

        String idDispositivo = props.getProperty("idDispositivo");
        if (idDispositivo == null)
            throw new IllegalStateException("binding fallito");

        try (OutputStream os = new FileOutputStream(PROPERTIES_FILE)) {
            props.store(os, "aulos iot");
        }

        AulosIotSubsystem subsystem = new AulosIotSubsystem(props.getProperty("uuid"),
                cl.getTopic(String.format("iotevents/movement/%s", idDispositivo)));
        registerComponents(subsystem);
        cl.setCallback(subsystem);

        if (!cl.isConnected())  // se abbiamo fatto il binding, il client è già connesso
            cl.connect(co);
        cl.subscribe(String.format("iotevents/update/%s", idDispositivo), 2);

        subsystem.start();
    }

    /**
     * Inizializza il client MQTT, e se necessario lo connette ed effettua la procedura di binding con il backend.
     *
     * @param props La configurazione
     * @throws MqttException        todo: documenta
     * @throws InterruptedException todo: documenta
     */
    private static void doBinding(Properties props) throws MqttException, InterruptedException {
        if (props.getProperty("idDispositivo") != null)  // se non è necessario fare il binding
            return;

        String uuid = props.getProperty("uuid");
        logger.info("Inizio procedura di binding: {}", uuid);

        cl.connect(co);

        final String bindResponseTopic = String.format("iotbind/res/%s", uuid);

        cl.subscribe(bindResponseTopic);

        final Semaphore bindWait = new Semaphore(0);
        final AtomicInteger idDispositivo = new AtomicInteger(-1);
        cl.setCallback(new MqttCallback() {
            @Override
            public void connectionLost(Throwable cause) {
                logger.error("Disconnesso durante il binding: {}", cause.getMessage());
                bindWait.release();
            }

            @Override
            public void messageArrived(String topic, MqttMessage message) throws Exception {
                assert topic.equals(bindResponseTopic);
                cl.unsubscribe(bindResponseTopic);

                String payload = new String(message.getPayload(), StandardCharsets.UTF_8);
                int id;
                try {
                    id = Integer.parseInt(payload);
                } catch (NumberFormatException ignored) {
                    logger.error("Ricevuto messaggio malformato durante il binding: {}", payload);
                    bindWait.release();
                    return;
                }

                idDispositivo.set(id);
                bindWait.release();
            }

            @Override
            public void deliveryComplete(IMqttDeliveryToken token) {
            }
        });

	final String iotName = props.getProperty("iotName", "aulos-iot-v1");

        MqttMessage bindInitiationMessage = new MqttMessage(iotName.getBytes(StandardCharsets.UTF_8));
        bindInitiationMessage.setQos(2);
        cl.publish(String.format("iotbind/req/%s", uuid), bindInitiationMessage);
        if (!bindWait.tryAcquire(30, TimeUnit.SECONDS)) {
            logger.error("Timeout durante la procedura di binding");
            cl.disconnect();
        } else {
            logger.info("Binding riuscito: {}", idDispositivo.get());
            props.setProperty("idDispositivo", Integer.toString(idDispositivo.get()));
        }
    }

    private static void registerComponents(AulosIotSubsystem subsystem) throws InvalidClassException, InvocationTargetException {
        subsystem.setPlugins(
                Set.of(
                        FeedbackProviderFactory.createInstance(subsystem, HttpFeedback.class),
                        FeedbackProviderFactory.createInstance(subsystem, SmartLightsFeedback.class)
                ),
                Set.of(
                        DetectionAgentFactory.createInstance(subsystem, HttpDetection.class)
                )
        );
    }
}
