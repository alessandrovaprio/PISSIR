package it.uniupo.giiot.iot.api;

import org.junit.Test;

import java.io.InvalidClassException;
import java.lang.reflect.InvocationTargetException;
import java.util.concurrent.atomic.AtomicBoolean;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Classe che racchiude tutti i test della API.
 * <p>
 * Questi test verificano solo il funzionamento delle factory e della dependency injection.
 */
public class ApiTests
{
    /**
     * Testa che la factory restituisca un'istanza del tipo passato per FeedbackProvider
     */
    @Test
    public void testEvents_FeedbackProvider() throws InvalidClassException, InvocationTargetException
    {
        FeedbackProvider instance = FeedbackProviderFactory.createInstance(null, MockFeedbackProvider.class);
        
        assertTrue(instance instanceof MockFeedbackProvider);

        MockFeedbackProvider mockInstance = (MockFeedbackProvider) instance;

        assertFalse(mockInstance.onStartCalled);
        instance.onStart();
        assertTrue(mockInstance.onStartCalled);
    }

    /**
     * Testa che la factory restituisca un'istanza del tipo passato per DetectionAgent
     */
    @Test
    public void testEvents_DetectionAgent() throws InvalidClassException, InvocationTargetException
    {
        DetectionAgent instance = DetectionAgentFactory.createInstance(null, MockDetectionAgent.class);

        assertTrue(instance instanceof MockDetectionAgent);

        MockDetectionAgent mockInstance = (MockDetectionAgent) instance;

        assertFalse(mockInstance.onStartCalled);
        instance.onStart();
        assertTrue(mockInstance.onStartCalled);
    }

    /**
     * Testa che la factory inietti l'istanza di IotSubsystem per FeedbackProvider.
     */
    @Test
    public void testInjection_FeedbackProvider() throws InvalidClassException, InvocationTargetException
    {
        final AtomicBoolean token = new AtomicBoolean(false);
        
        FeedbackProvider instance = FeedbackProviderFactory.createInstance(
                new IotSubsystem()
                {
                    @Override public int getRoomCapacity() { return -1; }
                    @Override public int getRoomOccupancy() { return -1; }
                    @Override public void ingressDetected() { token.set(true); }
                    @Override public void egressDetected() {}
                    @Override public String getIotId() { return "test"; }
                }, MockFeedbackProvider.class);

        assertTrue(instance instanceof MockFeedbackProvider);

        assertFalse(token.get());
        instance.onStart();
        assertTrue(token.get());
    }

    /**
     * Testa che la factory inietti l'istanza di IotSubsystem per DetectionAgent.
     */
    @Test
    public void testInjection_DetectionAgent() throws InvalidClassException, InvocationTargetException
    {
        final AtomicBoolean token = new AtomicBoolean(false);

        DetectionAgent instance = DetectionAgentFactory.createInstance(
                new IotSubsystem()
                {
                    @Override public int getRoomCapacity() { return -1; }
                    @Override public int getRoomOccupancy() { return -1; }
                    @Override public void ingressDetected() { token.set(true); }
                    @Override public void egressDetected() {}
                    @Override public String getIotId() { return "test"; }
                }, MockDetectionAgent.class);

        assertTrue(instance instanceof MockDetectionAgent);

        assertFalse(token.get());
        instance.onStart();
        assertTrue(token.get());
    }

    /**
     * Mock di FeedbackProvider che setta un flag per ciascuna funzione implementata che viene chiamata; onStart()
     * chiama il metodo ingressDetected() se è stata iniettata un'istanza di IotSubsystem.
     */
    private static class MockFeedbackProvider extends FeedbackProviderBase
    {
        boolean onStartCalled = false;
        boolean onChangeCalled = false;
        boolean onStopCalled = false;
        
        public MockFeedbackProvider() {}
        
        @Override
        public void onStart()
        {
            onStartCalled = true;
            
            if (getIotSubsystem() != null)
                getIotSubsystem().ingressDetected();
        }

        @Override
        public void onChange(FeedbackChangeEvent event)
        {
            onChangeCalled = true;
        }

        @Override
        public void onStop()
        {
            onStopCalled = true;
        }
    }

    /**
     * Mock di DetectionAgent che setta un flag per ciascuna funzione implementata che viene chiamata; onStart()
     * chiama il metodo ingressDetected() se è stata iniettata un'istanza di IotSubsystem.
     */
    private static class MockDetectionAgent extends DetectionAgentBase
    {
        boolean onStartCalled = false;
        boolean onStopCalled = false;

        public MockDetectionAgent() {}
        
        @Override
        public void onStart()
        {
            onStartCalled = true;

            if (getIotSubsystem() != null)
                getIotSubsystem().ingressDetected();
        }

        @Override
        public void onStop()
        {
            onStopCalled = true;
        }
    }
}
