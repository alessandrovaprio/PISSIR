package it.uniupo.giiot.backend.comms;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonPrimitive;
import it.uniupo.giiot.backend.core.IntegerPkEntity;
import it.uniupo.giiot.backend.core.attrezzatura.Attrezzatura;
import it.uniupo.giiot.backend.core.aula.Aula;
import it.uniupo.giiot.backend.core.dispositivo.Dispositivo;
import it.uniupo.giiot.backend.core.evento.Evento;
import it.uniupo.giiot.backend.core.responsabile.Responsabile;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.context.internal.ManagedSessionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.Route;
import spark.Service;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.Date;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.List;

/**
 * Implementazione del server REST per il backend.
 * @author Riccardo P. Bestetti
 */
public class RestServer
{
    // todo: dovrebbe essere configurabile, o ottenuta interrogando Keycloak
    private static final String REALM_PUBKEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqtOB+EB1r+zBtRpckWD1uqepo" +
            "3SCQPqrMP0thJicLhI7OcTbEw0jMM5UD3yJYIOrRX2CZSBE9zSEiUJ903dHP6iARqpzUHaRfFH6Hz5t6b+aWfBQSlUJ5Xm1K4m5ia5VK" +
            "kAvOivaE+n1QLc8yGqhRd4iPYJwAxX+KIpJviKrgsD6qF9X+7397Apv3/e0bB78wpIfjvCKI4vGM4DVzlMBKzeTjX9E175j30ZBktInj" +
            "w4YvCuRDF3l+WxKyS+TtSeVFXFbNI0kgE/YPZ08MIsDMHR4aXE7Xr1GCljzaaqP4Zr4MMxtE0HHgn5rjZlq+vKmDLAhNCENBg6tez5T2" +
            "eP2FwIDAQAB";

    // decodifico la chiave pubblica del realm per verificare i token JWT
    private static final Algorithm JWT_SIG_CHECKER;
    static {
        Algorithm jwtSigChecker = null;
        try {
            byte[] key = Base64.getDecoder().decode(REALM_PUBKEY);
            KeySpec spec = new X509EncodedKeySpec(key);
            jwtSigChecker = Algorithm.RSA256(
                    (RSAPublicKey) KeyFactory.getInstance("RSA").generatePublic(spec),
                    null);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
        }
        JWT_SIG_CHECKER = jwtSigChecker;
    }
    
    private static final Logger logger = LoggerFactory.getLogger(RestServer.class);

    public static final short REST_PORT = 15697;
    
    private static final Gson gson = GsonInstanceFactory.create();

    private static RestServer instance = null;

    private Service http;

    /**
     * Ottiene l'istanza singleton.
     */
    public static RestServer getInstance() {
        if (instance == null)
            return instance = new RestServer();
        else
            return instance;
    }
    
    private RestServer()
    {
        if (JWT_SIG_CHECKER == null)
            logger.warn("Le firme dei JWT non verranno verificate!");
        
        http = Service
                .ignite()
                .port(REST_PORT);
        
        /*
         * Endpoint REST.
         * DTO o non DTO? Per questo progetto, si è scelto di non avere un DTO per la ridotta quantità di entità
         * che sono gestite (e il vincolo di utilizzare Java Spark).
         * Quindi "listiamo" manualmente gli endpoint REST, e li implementiamo uno ad uno.
         */
        
        // set up e tear down della sessione hibernate per ogni richiesta
        http.before((req, res) -> {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            ManagedSessionContext.bind(session);  // bind della sessione al thread di questa richiesta
        });

        http.afterAfter((req, res) -> {
            Session session = session();
            Transaction transaction = session.getTransaction();
            if (transaction != null)
                transaction.commit();
            session.close();
            ManagedSessionContext.unbind(HibernateUtil.getSessionFactory());
        });

        // imposta il tipo di risposta su tutte le richieste
        http.before((req, res) -> res.type("application/json"));

        // CORS
        http.before((req, res) -> res.header("Access-Control-Allow-Origin", "*"));

        // route per le attrezzature
        http.get(String.format("/%s", "attrezzatura"), authRoute(get_route(Attrezzatura.class)));
        http.get(String.format("/%s/:id", "attrezzatura"), authRoute(get_id_route(Attrezzatura.class)));
        http.post(String.format("/%s", "attrezzatura"),
                authRoute(post_route(Attrezzatura.class), "supervisore", "amministratore"));
        http.put(String.format("/%s/:id", "attrezzatura"),
                authRoute(put_id_route(Attrezzatura.class), "supervisore", "amministratore"));
        http.delete(String.format("/%s/:id", "attrezzatura"),
                authRoute(delete_id_route(Attrezzatura.class), "supervisore", "amministratore"));

        // route per le aule
        http.get(String.format("/%s", "aula"), authRoute(get_route(Aula.class)));
        http.get(String.format("/%s/:id", "aula"), authRoute(get_id_route(Aula.class)));
        http.post(String.format("/%s", "aula"),
                authRoute(post_route(Aula.class), "supervisore", "amministratore"));
        http.put(String.format("/%s/:id", "aula"),
                authRoute(put_id_route(Aula.class), "supervisore", "amministratore"));
        http.delete(String.format("/%s/:id", "aula"),
                authRoute(delete_id_route(Aula.class), "supervisore", "amministratore"));

        // route per gli eventi
        http.get(String.format("/%s", "evento"), authRoute(get_route(Evento.class)));
        http.get(String.format("/%s/:id", "evento"), authRoute(get_id_route(Evento.class)));
        http.post(String.format("/%s", "evento"),
                authRoute(post_route(Evento.class), "supervisore", "amministratore"));
        http.put(String.format("/%s/:id", "evento"),
                authRoute(put_id_route(Evento.class), "supervisore", "amministratore"));
        http.delete(String.format("/%s/:id", "evento"),
                authRoute(delete_id_route(Evento.class), "supervisore", "amministratore"));

        // route per i responsabili
        http.get(String.format("/%s", "responsabile"), authRoute(get_route(Responsabile.class)));
        http.get(String.format("/%s/:id", "responsabile"), authRoute(get_id_route(Responsabile.class)));
        http.post(String.format("/%s", "responsabile"),
                authRoute(post_route(Responsabile.class), "supervisore", "amministratore"));
        http.put(String.format("/%s/:id", "responsabile"),
                authRoute(put_id_route(Responsabile.class), "supervisore", "amministratore"));
        http.delete(String.format("/%s/:id", "responsabile"),
                authRoute(delete_id_route(Responsabile.class), "supervisore", "amministratore"));

        // route per i dispositivi - non esiste l'endpoint POST
        http.get("/dispositivo", authRoute(get_route(Dispositivo.class)));
        http.get("/dispositivo/:id", authRoute(get_id_route(Dispositivo.class)));
        http.put("/dispositivo/:id",
                authRoute(put_id_route(Dispositivo.class), "amministratore"));
        http.delete("/dispositivo/:id",
                authRoute(delete_id_route(Dispositivo.class), "amministratore"));

        // CORS
        http.options("/*", (req, res) -> {
            String acrHeaders = req.headers("Access-Control-Request-Headers");
            if (acrHeaders != null)
                res.header("Access-Control-Allow-Headers", acrHeaders);

            String acrMethod = req.headers("Access-Control-Request-Method");
            if (acrMethod != null)
                res.header("Access-Control-Allow-Methods", acrMethod);

            return "";
        });
    }

    /**
     * Ferma il server Spark e pulisce tutti gli indirizzi
     */
    public void stop() {
        http.stop();
    }

    /**
     * Filtra la route passata, richiedendo che il client abbia almeno una delle role specificate. Se non viene
     * specificata alcuna role, consente l'accesso a tutti i client autenticati.
     * <p>
     * Se il client non possiede nessuna delle role specificate, viene ritornato un errore 401.
     * 
     * @param route la route
     * @param requiredRoles le roles che consentono l'accesso alla route
     * @return una route che verifica la presenza della role, e poi delega la richiesta alla route passata
     */
    private static Route authRoute(Route route, String... requiredRoles) {
        final String BEARER_PREFIX = "Bearer ";
        return (req, res) -> {
            String token = req.headers("Authorization");
            if (token == null) {
                res.status(401);  // unauthorized
                logger.info("Accesso senza header di autorizzazione");
                return "";
            }
            
            if (!token.startsWith(BEARER_PREFIX)) {
                res.status(401);  // unauthorized
                logger.info("Accesso con bearer token malformato");
                return "";
            }
            
            token = token.substring(BEARER_PREFIX.length());
            DecodedJWT jwt = JWT.decode(token);
            
            if (JWT_SIG_CHECKER != null) {
                try {
                    JWT_SIG_CHECKER.verify(jwt);
                }
                catch (SignatureVerificationException e) {
                    res.status(401);  // unauthorized
                    logger.info("Firma del bearer token non valida");
                    return "";
                }
            }
            else {
                logger.info("Accesso consentito senza bearer token");
            }

            if (!Date.from(Instant.now()).before(jwt.getExpiresAt())) {
                res.status(401);  // unauthorized
                logger.info("Bearer token scaduto");
                return "";
            }

            List<String> roles = new ArrayList<>();
            try {
                Object rolesObject = jwt.getClaim("realm_access").asMap().get("roles");
                assert rolesObject instanceof List;
                for (Object o : (List<?>) rolesObject) {  // sanifichiamo
                    roles.add((String) o);
                }
            }
            catch (NullPointerException | JWTDecodeException | ClassCastException e) {
                res.status(401);  // unauthorized
                logger.info("Bearer token non contiene le role di accesso al realm");
                return "";
            }

            List<String> entryRoles = new ArrayList<>();  // role che, in questa richiesta, danno accesso alla route
            if (requiredRoles.length != 0) {
                for (String role : requiredRoles) {
                    if (roles.contains(role))
                        entryRoles.add(role);
                }

                if (entryRoles.size() == 0) {
                    res.status(401);  // unauthorized
                    logger.info("Bearer token non contiene la role richiesta");
                    return "";
                }
            }

            req.attribute("entryRoles", entryRoles);
            req.attribute("allRoles", roles);
            return route.handle(req, res);
        };
    }

    /**
     * Genera una nuova classe funzionale che risponde alle richieste di tipo GET, restituendo
     * tutte le entità del tipo passato.
     *
     * @param type tipo dell'entità
     * @return tutte le entità del tipo passato.
     */
    private static <T extends IntegerPkEntity<T>> Route get_route(Class<T> type) {
        return (req, res) -> {
            // estrai tutte le entità dal database
            Constructor<T> ctor = null;
            try {
                ctor = type.getConstructor();
            } catch (NoSuchMethodException e) {
                // todo: logging
            }

            if (ctor == null) {
                // todo: logging
                res.status(500);  // internal server error
                return gson.toJson(new JsonPrimitive("errore del server"));
            }

            Collection<T> entita = getNewEntity(type).getAll();

            JsonArray jsonRoot = new JsonArray();
            for (T a : entita)
                jsonRoot.add(gson.toJsonTree(a));

            return gson.toJson(jsonRoot);
        };
    }

    /**
     * Genera una nuova classe funzionale che risponde alle richieste di tipo GET, restituendo
     * le entità del tipo passato con tale id.
     *
     * @param type tipo dell'entità
     * @return tutte le entità del tipo passato.
     */
    private static <T extends IntegerPkEntity<T>> Route get_id_route(Class<T> type) {
        return (req, res) -> {
            // estrai l'entità richiesta
            int id;
            try {
                id = Integer.parseInt(req.params("id"));
            }
            catch (ArithmeticException ignored) {
                res.status(400);  // bad request
                return gson.toJson(new JsonPrimitive("richiesta con parametro non valido"));
            }

            T a;
            try
            {
                a = HibernateUtil.getWithIntegerPk(session(), type, id);
            } catch (DaoException e)
            {
                res.status(500);  // not found
                return gson.toJson(new JsonPrimitive("errore dao"));
            }

            if (a == null) {
                res.status(404);  // not found
                return gson.toJson(new JsonPrimitive("oggetto non trovato"));
            }

            return gson.toJson(a);
        };
    }

    /**
     * Genera una nuova classe funzionale che risponde alle richieste di tipo POST, inserendo una
     * nuova entità del tipo passato.
     *
     * @param type tipo dell'entità
     */
    private static <T extends IntegerPkEntity<T>> Route post_route(Class<T> type) {
        return (req, res) -> {
            T newEntity = gson.fromJson(req.body(), type);

            if (newEntity.getPk() != null) {
                res.status(400);  // bad request
                return gson.toJson(new JsonPrimitive("specificato id in richiesta POST"));
            }

            try {
                Integer pk = HibernateUtil.insertWithIntegerPk(session(), newEntity);
                return gson.toJson(new JsonPrimitive(pk));
            }
            catch (DaoException e) {
                res.status(500);  // internal server error
                return gson.toJson(new JsonPrimitive(e.getMessage()));
            }
        };
    }

    /**
     * Genera una nuova classe funzionale che risponde alle richieste di tipo PUT, modificando una
     * l'entità del tipo passato con tale id.
     *
     * @param type tipo dell'entità
     * @return restituisce l'entità modificata
     */
    private static <T extends IntegerPkEntity<T>> Route put_id_route(Class<T> type) {
        return (req, res) -> {
            T newEntity = gson.fromJson(req.body(), type);

            if (newEntity.getPk() == null) {
                res.status(400);  // bad request
                return gson.toJson(new JsonPrimitive("non specificato id in richiesta PUT"));
            }

            session().merge(newEntity);
            return gson.toJson(new JsonPrimitive(true));
        };
    }

    /**
     * Genera una nuova classe funzionale che risponde alle richieste di tipo DELETE, eliminando
     * l'entità del tipo passato con tale id.
     *
     * @param type tipo dell'entità
     * @return restituisce l'entità eliminata
     */
    private static <T extends IntegerPkEntity<T>> Route delete_id_route(Class<T> type) {
        return (req, res) -> {
            int id;
            try {
                id = Integer.parseInt(req.params("id"));
            }
            catch (ArithmeticException ignored) {
                res.status(400);  // bad request
                return gson.toJson(new JsonPrimitive("richiesta con parametro non valido"));
            }

            T entity = getNewEntity(type);
            entity.setPk(id);
            session().delete(entity);

            return gson.toJson(new JsonPrimitive(true));
        };
    }

    /**
     * Restituisce l'entità del tipo passato, generata tramite reflection.
     *
     * @param type tipo dell'entità da generare
     * @return la nuova entità generata
     * @throws InstantiationError se avviene un errore durante l'istanziamento
     */
    private static <T extends IntegerPkEntity<T>> T getNewEntity(Class<T> type) throws InstantiationError {
        Constructor<T> ctor;
        try {
            ctor = type.getConstructor();
        } catch (NoSuchMethodException e) {
            // todo: logging
            throw (InstantiationError) new InstantiationError("errore durante l'istanziamento").initCause(e);
        }

        T entity;
        try {
            entity = ctor.newInstance();
        } catch (InstantiationException | IllegalAccessException | InvocationTargetException e) {
            // todo: logging
            throw (InstantiationError) new InstantiationError("errore durante l'istanziamento").initCause(e);
        }
        
        return entity;
    }

    /**
     * Restituisce la sessione corrente di Hibernate.
     *
     * @return la sessione corrente di Hibernate.
     */
    private static Session session() {
        return HibernateUtil.getCurrentSession();
    }
}
