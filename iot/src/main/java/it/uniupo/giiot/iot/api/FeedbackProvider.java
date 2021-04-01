package it.uniupo.giiot.iot.api;

/**
 * Questa interfaccia viene implementata dai provider di Feedback.
 * <p>
 * Questi sono i plugin che espongono, tramite qualunque tipo di interfaccia, le informazioni di feedback del sistema
 * (capienza dell'aula, stato di occupazione).
 * <p>
 * Un provider di Feedback non dovrebbe implementare direttamente questa interfaccia; dovrebbe invece estendere la
 * classe astratta {@link FeedbackProviderBase}, che fornisce l'implementazione di metodi d'utilità per i plugin.
 */
public interface FeedbackProvider
{
    /**
     * Metodo chiamato quando il FeedbackProvider viene avviato.
     */
    void onStart();

    /**
     * Metodo chiamato quando i dati di feedback sono cambiati.
     * @param event Oggetto che descrive l'evento
     */
    void onChange(FeedbackChangeEvent event);

    /**
     * Metodo chiamato quando il FeedbackProvider viene fermato.
     * <p>
     * Il tempo massimo di esecuzione di questo metodo potrebbe essere limitato.
     */
    void onStop();

    /**
     * Ritorna l'istanza di IotSubsystem attuale.
     * <p>
     * Nota per gli implementatori: questo metodo è implementato da {@link FeedbackProviderBase}; questa interfaccia
     * non andrebbe implementata direttamente, andrebbe invece estesa tale classe.
     */
    IotSubsystem getIotSubsystem();
}
