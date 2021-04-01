package it.uniupo.giiot.iot.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.InvalidClassException;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

/**
 * Factory per istanziare un {@link FeedbackProvider}, iniettandogli un {@link IotSubsystem} se questo è anche un
 * {@link FeedbackProviderBase}.
 */
public abstract class FeedbackProviderFactory
{
    private static final Logger logger = LoggerFactory.getLogger(FeedbackProviderFactory.class);

    /**
     * Crea un'istanza del plugin passato, iniettandovi l'{@link IotSubsystem} se esso estende
     * {@link FeedbackProviderBase}.
     *
     * @param iotSubsystem L'IotSubsystem da iniettare
     * @param clazz La classe del plugin da istanziare
     * @return L'istanza del plugin
     * @throws InvalidClassException se il plugin non ha un costruttore no-arg pubblico oppure è abstract
     * @throws InvocationTargetException se viene lanciata un'eccezione dal costruttore del plugin
     */
    public static FeedbackProvider createInstance(IotSubsystem iotSubsystem, Class<? extends FeedbackProvider> clazz)
            throws InvalidClassException, InvocationTargetException
    {
        FeedbackProvider instance;
        try
        {
            Constructor<? extends FeedbackProvider> ctor = clazz.getDeclaredConstructor();
            instance = ctor.newInstance();
        }
        catch (NoSuchMethodException | IllegalAccessException | InstantiationException ignored)
        {
            throw new InvalidClassException(
                    String.format("%s doesn't have a no-arg public constructor or is abstract", clazz.getName()));
        }

        logger.debug(String.format("Creata istanza di %s", clazz.getName()));

        // se è un'istanza di FeedbackProviderBase, inietta la dipendenza, altrimenti emetti un warning
        if (instance instanceof FeedbackProviderBase)
            ((FeedbackProviderBase) instance).setIotSubsystem(iotSubsystem);
        else
            logger.warn(String.format("Caricato plugin %s che non estende FeedbackProviderBase", clazz.getName()));
        
        return instance;
    }
}
