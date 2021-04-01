package it.uniupo.giiot.iot.api;

/**
 * Questa interfaccia viene implementata dagli agenti che segnalano i passaggi.
 * <p>
 * Questi sono i plugin che ricevono, tramite qualunque tipo di interfaccia, le segnalazioni di passaggio in entrata ed
 * uscita.
 * <p>
 * Un agente di segnalazione non dovrebbe implementare direttamente questa interfaccia; dovrebbe invece estendere la
 * classe astratta {@link DetectionAgentBase}, che fornisce l'implementazione di metodi d'utilità per i plugin.
 */
public interface DetectionAgent
{
    /**
     * Metodo chiamato quando il FeedbackProvider viene avviato.
     */
    void onStart();

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
