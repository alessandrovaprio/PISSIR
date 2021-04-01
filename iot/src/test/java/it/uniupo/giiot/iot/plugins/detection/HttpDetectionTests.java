package it.uniupo.giiot.iot.plugins.detection;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import it.uniupo.giiot.iot.api.DetectionAgent;
import it.uniupo.giiot.iot.api.DetectionAgentFactory;
import it.uniupo.giiot.iot.api.IotSubsystem;
import okhttp3.*;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.InvalidClassException;
import java.lang.reflect.InvocationTargetException;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class HttpDetectionTests
{
    private static MockIotSubsystem iS;
    private static DetectionAgent dA;
    
    @BeforeClass
    public static void setup_HttpDetection() throws InvalidClassException, InvocationTargetException
    {
        iS = new MockIotSubsystem();
        dA = DetectionAgentFactory.createInstance(iS, HttpDetection.class);
        dA.onStart();
    }

    @AfterClass
    public static void teardown_HttpDetection()
    {
        dA.onStop();
    }

    @Test
    public void testIngress_HttpDetection() throws Exception
    {
        int curIngress = iS.ingress.get();

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(String.format("http://%s:%s/ingress", HttpDetection.HTTP_HOST, HttpDetection.HTTP_PORT))
                .post(RequestBody.create("", MediaType.get("application/json; charset=utf-8")))
                .build();

        Response response = client.newCall(request).execute();
        String responseString = Objects.requireNonNull(response.body()).string();

        JsonElement obj = new Gson().fromJson(responseString, JsonElement.class);

        assertTrue(obj.getAsJsonPrimitive().getAsBoolean());
        assertEquals(curIngress + 1, iS.ingress.get());
    }

    @Test
    public void testEgress_HttpDetection() throws Exception
    {
        int curEgress = iS.egress.get();

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(String.format("http://%s:%s/egress", HttpDetection.HTTP_HOST, HttpDetection.HTTP_PORT))
                .post(RequestBody.create("", MediaType.get("application/json; charset=utf-8")))
                .build();

        Response response = client.newCall(request).execute();
        String responseString = Objects.requireNonNull(response.body()).string();

        JsonElement obj = new Gson().fromJson(responseString, JsonElement.class);

        assertTrue(obj.getAsJsonPrimitive().getAsBoolean());
        assertEquals(curEgress + 1, iS.egress.get());
    }
    
    private static class MockIotSubsystem implements IotSubsystem
    {
        AtomicInteger ingress = new AtomicInteger(0);
        AtomicInteger egress = new AtomicInteger(0);
        
        @Override
        public int getRoomCapacity() { return -1; }

        @Override
        public int getRoomOccupancy() { return -1; }

        @Override
        public void ingressDetected()
        {
            ingress.incrementAndGet();
        }

        @Override
        public void egressDetected()
        {
            egress.incrementAndGet();
        }

        @Override
        public String getIotId() {
            return "test";
        }
    }
}
