package it.uniupo.giiot.iot.plugins.detection;

import it.uniupo.giiot.iot.api.DetectionAgentBase;
import it.uniupo.giiot.iot.api.IotSubsystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.Request;
import spark.Response;
import spark.Service;

public class HttpDetection extends DetectionAgentBase
{
    public static final String HTTP_HOST = "127.0.0.1";
    public static final short HTTP_PORT = 1245;

    private final Logger logger = LoggerFactory.getLogger(HttpDetection.class);

    /** L'istanza di Spark che serve questo plugin */
    private Service http = null;

    /**
     * Avvia il server HTTP.
     */
    @Override
    public void onStart()
    {
        http = Service.ignite()
                .ipAddress(HTTP_HOST)
                .port(HTTP_PORT);

        http.post("/ingress", this::ingressRoute);
        http.post("/egress", this::egressRoute);
        
        http.awaitInitialization();

        logger.debug("Plugin avviato");
    }
    
    private String ingressRoute(Request req, Response res)
    {
        res.type("application/json");

        IotSubsystem is = getIotSubsystem();
        if (is == null)
            return "null";
        
        is.ingressDetected();

        return "true";
    }

    private String egressRoute(Request req, Response res)
    {
        res.type("application/json");

        IotSubsystem is = getIotSubsystem();
        if (is == null)
            return "null";
        
        is.egressDetected();

        return "true";
    }

    /**
     * Ferma il server HTTP.
     */
    @Override
    public void onStop()
    {
        http.stop();
    }
}
