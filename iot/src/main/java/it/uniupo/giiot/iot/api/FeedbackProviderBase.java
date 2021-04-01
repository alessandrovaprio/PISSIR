package it.uniupo.giiot.iot.api;

/**
 * Classe che i plugin per fornire feedback implementano.
 */
public abstract class FeedbackProviderBase implements FeedbackProvider
{
    /**
     * L'istanza di {@link IotSubsystem} che ha avviato questo plugin.
     * <p>
     * Iniettata da {@link FeedbackProviderFactory} tramite {@link #setIotSubsystem(IotSubsystem)}.
     */
    private IotSubsystem iotSubsystem;

    /**
     * Ritorna l'istanza di IotSubsystem che ha avviato questo plugin.
     */
    @Override
    public final IotSubsystem getIotSubsystem()
    {
        return iotSubsystem;
    }

    /**
     * Inietta l'istanza di IotSubsystem.
     * @param iotSubsystem L'istanza di IotSubsystem da iniettare.
     */
    void setIotSubsystem(IotSubsystem iotSubsystem)
    {
        this.iotSubsystem = iotSubsystem;
    }
}
