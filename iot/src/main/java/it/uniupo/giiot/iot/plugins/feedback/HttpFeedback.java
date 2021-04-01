package it.uniupo.giiot.iot.plugins.feedback;

import it.uniupo.giiot.iot.api.FeedbackChangeEvent;
import it.uniupo.giiot.iot.api.FeedbackProviderBase;
import it.uniupo.giiot.iot.api.IotSubsystem;
import org.eclipse.jetty.websocket.api.Session;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketClose;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketConnect;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketMessage;
import org.eclipse.jetty.websocket.api.annotations.WebSocket;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.Request;
import spark.Response;
import spark.Service;

import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.Set;

@WebSocket
public class HttpFeedback extends FeedbackProviderBase
{
    public static final String HTTP_HOST = "127.0.0.1";
    public static final short HTTP_PORT = 1244;
    
    private final Logger logger = LoggerFactory.getLogger(HttpFeedback.class);
    
    /** La stringa per i messaggi di capacità */
    private final String CAPACITY_FMT = "{'type': 'capacity', 'value': %s}";

    /** La stringa per i messaggi di occupazione */
    private final String OCCUPANCY_FMT = "{'type': 'occupancy', 'value': %s}";

    /** L'istanza di Spark che serve questo plugin */
    private Service http = null;

    /** I client iscritti agli eventi */
    private final Set<Session> eventSubscribers = Collections.synchronizedSet(new LinkedHashSet<>());

    /**
     * Avvia il server HTTP.
     */
    @Override
    public void onStart()
    {
        http = Service.ignite()
                .ipAddress(HTTP_HOST)
                .port(HTTP_PORT);

        http.webSocket("/events", this);
        http.get("/roomCapacity", this::getRoomCapacityRoute);
        http.get("/roomOccupancy", this::getRoomOccupancyRoute);

        http.awaitInitialization();
        
        logger.debug("Plugin avviato");
    }

    @OnWebSocketConnect
    public void connected(Session session)
    {
        eventSubscribers.add(session);
        logger.debug(String.format("Sessione aggiunta: %s", session));
    }

    @OnWebSocketClose
    public void closed(Session session, int statusCode, String reason)
    {
        eventSubscribers.remove(session);
        logger.debug(String.format("Sessione terminata: %s", session));
    }

    @OnWebSocketMessage
    public void message(Session session, String message)
    {
        logger.warn(String.format("Ricevuto messaggio da sessione: %s", session));
    }
    
    private String getRoomCapacityRoute(Request req, Response res)
    {
        res.type("application/json");

        IotSubsystem is = getIotSubsystem();
        if (is == null)
            return "null";
        
        return String.format(CAPACITY_FMT, is.getRoomCapacity());
    }

    private String getRoomOccupancyRoute(Request req, Response res)
    {
        res.type("application/json");

        IotSubsystem is = getIotSubsystem();
        if (is == null)
            return "null";

        return String.format(OCCUPANCY_FMT, is.getRoomOccupancy());
    }

    /**
     * Metodo chiamato quando i dati di feedback sono cambiati.
     *
     * @param event Oggetto che descrive l'evento
     */
    @Override
    public void onChange(FeedbackChangeEvent event)
    {
        IotSubsystem is = getIotSubsystem();
        if (is == null)
        {
            logger.warn("Chiamata ad onChange ma getIotSubsystem() è null");
            return;
        }

        // TODO: convertire adeguatamente i BigInteger a stringa
        switch (event.getChangeType())
        {
            case CAPACITY:
                sendToSubscribers(String.format(CAPACITY_FMT, is.getRoomCapacity()));
                break;
                
            case OCCUPANCY:
                sendToSubscribers(String.format(OCCUPANCY_FMT, is.getRoomOccupancy()));
                break;
        }
    }

    /**
     * Manda un messaggio in broadcast a tutti i WebSocket aperti.
     */
    private void sendToSubscribers(String message)
    {
        synchronized (eventSubscribers)
        {
            for (Session subscriber : eventSubscribers)
            {
                try
                {
                    subscriber.getRemote().sendString(message);
                }
                catch (Throwable ignored)  // Spark ha un comportamento non documentato per cui ritorna una
                {                          // WebSocketException se la controparte ha chiuso la connessione
                    logger.error(String.format("Impossibile inviare evento al sottoscrittore: %s", subscriber));
                }
            }
        }
    }

    /**
     * Svuota il set dei sottoscrittori e ferma il server HTTP.
     */
    @Override
    public void onStop()
    {
        eventSubscribers.clear();
        http.stop();
    }
}
