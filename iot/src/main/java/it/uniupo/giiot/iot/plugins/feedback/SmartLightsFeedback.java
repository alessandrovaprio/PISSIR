package it.uniupo.giiot.iot.plugins.feedback;

import io.github.zeroone3010.yahueapi.Color;
import io.github.zeroone3010.yahueapi.Hue;
import io.github.zeroone3010.yahueapi.Light;
import io.github.zeroone3010.yahueapi.State;
import it.uniupo.giiot.iot.api.FeedbackChangeEvent;
import it.uniupo.giiot.iot.api.FeedbackProviderBase;
import it.uniupo.giiot.iot.api.IotSubsystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.Arrays;
import java.util.Collection;
import java.util.Properties;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

public class SmartLightsFeedback extends FeedbackProviderBase {
    public final File PROPERTIES_FILE = new File("lights.properties");

    private final Logger logger = LoggerFactory.getLogger(SmartLightsFeedback.class);

    private Collection<Light> lights;

    @Override
    public void onStart() {
        Properties props = new Properties();
        if (PROPERTIES_FILE.exists()) {
            try (InputStream is = new FileInputStream(PROPERTIES_FILE)) {
                props.load(is);
            }
            catch (IOException e) {
                throw new RuntimeException("impossibile leggere la configurazione", e);
            }
        }

        final String bridgeIp = props.getProperty("bridgeHostname");

        String apiKey = props.getProperty("apiKey");
        if (apiKey == null) {
            logger.info("Premi il pulsante Link sul bridge...");
            final String appName = String.format("aulos-%s", getIotSubsystem().getIotId().substring(0, 8));
            final CompletableFuture<String> apiKeyFuture;
            
            try {
                apiKeyFuture = Hue.hueBridgeConnectionBuilder(bridgeIp).initializeApiConnection(appName);
            }
            catch (Throwable t) {  // catturo tutto perché la API non espone i tipi delle eccezioni...
                logger.error("Impossibile inizializzare il plugin: connessione con il bridge fallita");
                return;  // non blocco l'avvio del sottosistema
            }

            try {
                apiKey = apiKeyFuture.get();
            } catch (InterruptedException | ExecutionException e) {
                logger.error("Impossibile inizializzare il plugin: binding con il brige fallito");
                return;  // non blocco l'avvio del sottosistema
            }

            props.setProperty("apiKey", apiKey);
            try (OutputStream os = new FileOutputStream(PROPERTIES_FILE)) {
                props.store(os, "aulos iot - smartlights");
            }
            catch (IOException e) {
                logger.warn("Impossibile scrivere la configurazione: la API key non verrà salvata ({})", e.getMessage());
            }
        }

        Collection<String> lightNames = Arrays.stream(props.getProperty("lightNames", "").split(","))
                .collect(Collectors.toUnmodifiableSet());

        Hue hue = new Hue(bridgeIp, apiKey);
        
        try {
            hue.getRaw().getLights();  // causa il caricamento della cache
            lights = hue.getLights().stream()
                    .filter(l -> lightNames.contains(l.getName()))
                    .collect(Collectors.toUnmodifiableSet());
        }
        catch (Throwable t) {  // catturo tutto perché la API non espone i tipi delle eccezioni...
            logger.error("Impossibile inizializzare il plugin: connessione con il bridge fallita");
        }
    }

    @Override
    public void onChange(FeedbackChangeEvent event) {
        IotSubsystem subsystem = getIotSubsystem();
        float ratio = ((float) subsystem.getRoomOccupancy()) / subsystem.getRoomCapacity();

        if (ratio < .75f) {
            setLights(Color.of(0f, 1f, 0f));  // verde
        } else if (ratio < 1f) {
            setLights(Color.of(.5f, .5f, 0f));  // arancio
        } else {
            setLights(Color.of(1f, 0f, 0f));  // rosso
        }
    }

    @Override
    public void onStop() {}

    private void setLights(Color color) {
        lights.forEach(l -> { l.setState(State.builder().color(color).on()); l.setBrightness(254); });
    }
}
