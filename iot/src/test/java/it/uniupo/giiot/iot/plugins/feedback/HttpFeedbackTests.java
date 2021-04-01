package it.uniupo.giiot.iot.plugins.feedback;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import it.uniupo.giiot.iot.api.FeedbackChangeEvent;
import it.uniupo.giiot.iot.api.FeedbackProvider;
import it.uniupo.giiot.iot.api.FeedbackProviderFactory;
import it.uniupo.giiot.iot.api.IotSubsystem;
import okhttp3.*;
import org.jetbrains.annotations.NotNull;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.InvalidClassException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigInteger;
import java.util.Objects;
import java.util.Random;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

/**
 * Test per il plugin HttpFeedback.
 * <p>
 * Testa tutti gli endpoint, compreso quello websocket.
 */
public class HttpFeedbackTests
{
    /** Implementazione mock di {@link IotSubsystem}, inizializzata da {@link #setup_HttpFeedback()} */
    private static MockIotSubsystem iS;
    
    /** Istanza di {@link HttpFeedback, inizializzata da {@link #setup_HttpFeedback()} */
    private static FeedbackProvider dA;

    @BeforeClass
    public static void setup_HttpFeedback() throws InvalidClassException, InvocationTargetException
    {
        iS = new MockIotSubsystem();
        dA = FeedbackProviderFactory.createInstance(iS, HttpFeedback.class);
        dA.onStart();
    }

    @AfterClass
    public static void teardown_HttpFeedback()
    {
        dA.onStop();
    }

    @Test
    public void testGetRoomOccupancy_HttpFeedback() throws Exception
    {
        // genera un numero casuale e inietta nell'implementazione mock
        int expected = BigInteger.probablePrime(16, new Random()).intValue();
        iS.setRoomOccupancy(expected);

        // fai una chiamata HTTP al plugin
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(String.format("http://%s:%s/roomOccupancy", HttpFeedback.HTTP_HOST, HttpFeedback.HTTP_PORT))
                .get()
                .build();

        Response response = client.newCall(request).execute();
        String responseString = Objects.requireNonNull(response.body()).string();

        // verifica che il valore sia quello iniettato prima
        JsonElement obj = new Gson().fromJson(responseString, JsonElement.class);

        assertEquals("occupancy", obj.getAsJsonObject().get("type").getAsJsonPrimitive().getAsString());
        assertEquals(expected, obj.getAsJsonObject().get("value").getAsJsonPrimitive().getAsInt());
    }

    @Test
    public void testGetRoomCapacity_HttpFeedback() throws Exception
    {
        // genera un numero casuale e inietta nell'implementazione mock
        int expected = BigInteger.probablePrime(16, new Random()).intValue();

        iS.setRoomCapacity(expected);

        // fai una chiamata HTTP al plugin
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(String.format("http://%s:%s/roomCapacity", HttpFeedback.HTTP_HOST, HttpFeedback.HTTP_PORT))
                .get()
                .build();

        Response response = client.newCall(request).execute();
        String responseString = Objects.requireNonNull(response.body()).string();

        // verifica che il valore sia quello iniettato prima
        JsonElement obj = new Gson().fromJson(responseString, JsonElement.class);

        assertEquals("capacity", obj.getAsJsonObject().get("type").getAsJsonPrimitive().getAsString());
        assertEquals(expected, obj.getAsJsonObject().get("value").getAsJsonPrimitive().getAsInt());
    }

    @Test
    public void testWsEvents_HttpFeedback() throws Exception
    {
        // genero due valori casuali da iniettare in seguito
        int expectedCapacity = BigInteger.probablePrime(16, new Random()).intValue();
        int expectedOccupancy = BigInteger.probablePrime(16, new Random()).intValue();

        // semaforo per sincronizzare il test con il websocket
        final Semaphore wsMutex = new Semaphore(0);

        // array per salvare i messaggi websocket ricevuti
        String[] messages = new String[2];

        // creo il websocket
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(String.format("ws://%s:%s/events", HttpFeedback.HTTP_HOST, HttpFeedback.HTTP_PORT))
                .build();

        WebSocket ws = client.newWebSocket(request, new WebSocketListener()
        {
            volatile int message = 0;

            @Override
            public void onOpen(@NotNull WebSocket webSocket, @NotNull Response response)
            {
                // rilascio il semaforo per la prima volta quando il websocket è connesso
                wsMutex.release();
            }

            @Override
            public synchronized void onMessage(@NotNull WebSocket webSocket, @NotNull String text)
            {
                messages[message++] = text;

                // rilascio il semaforo la seconda volta quando ho ricevuto tutti i messaggi attesi
                if (message == messages.length)
                    wsMutex.release();
            }
        });

        // attendo la connessione del websocket
        assertTrue(wsMutex.tryAcquire(5, TimeUnit.SECONDS));

        // genero due eventi iniettando due valori nel mock
        iS.setRoomCapacity(expectedCapacity);
        iS.setRoomOccupancy(expectedOccupancy);

        // attendo la ricezione delle risposte
        assertTrue(wsMutex.tryAcquire(5, TimeUnit.SECONDS));
        ws.cancel();

        // verifico che i valori degli eventi siano quelli attesi
        JsonElement capacityObj = new Gson().fromJson(messages[0], JsonElement.class);
        JsonElement occupancyObj = new Gson().fromJson(messages[1], JsonElement.class);

        assertEquals("capacity", capacityObj.getAsJsonObject().get("type").getAsJsonPrimitive().getAsString());
        assertEquals(expectedCapacity, capacityObj.getAsJsonObject().get("value").getAsJsonPrimitive().getAsInt());

        assertEquals("occupancy", occupancyObj.getAsJsonObject().get("type").getAsJsonPrimitive().getAsString());
        assertEquals(expectedOccupancy, occupancyObj.getAsJsonObject().get("value").getAsJsonPrimitive().getAsInt());
    }
    
    private static class FeedbackChangeEventImpl implements FeedbackChangeEvent
    {
        private final ChangeType type;

        FeedbackChangeEventImpl(ChangeType type)
        {
            this.type = type;
        }

        public ChangeType getChangeType()
        {
            return type;
        }
    }

    private static class MockIotSubsystem implements IotSubsystem
    {
        volatile int roomCapacity;
        volatile int roomOccupancy;
        
        private void setRoomCapacity(int n)
        {
            roomCapacity = n;
            dA.onChange(new FeedbackChangeEventImpl(FeedbackChangeEvent.ChangeType.CAPACITY));
        }

        private void setRoomOccupancy(int n)
        {
            roomOccupancy = n;
            dA.onChange(new FeedbackChangeEventImpl(FeedbackChangeEvent.ChangeType.OCCUPANCY));
        }

        @Override
        public int getRoomCapacity()
        {
            return roomCapacity;
        }

        @Override
        public int getRoomOccupancy()
        {
            return roomOccupancy;
        }

        @Override
        public void ingressDetected() { }

        @Override
        public void egressDetected() { }

        @Override
        public String getIotId() {
            return "test";
        }
    }
}
