package it.uniupo.giiot.iot.api;

/**
 * Interfaccia che rappresenta le operazioni di accesso alle informazioni relative ad un evento di cambiamento delle
 * informazioni di feedback.
 */
public interface FeedbackChangeEvent
{
    /**
     * Ritorna il tipo di cambiamento che è avvenuto.
     * @return Il tipo di cambiamento che è avvenuto
     */
    ChangeType getChangeType();
    
    enum ChangeType
    {
        /** La capacità della stanza è stata modificata */              CAPACITY,
        /** Il grado di occupazione della stanza è stato modificato */  OCCUPANCY
    }
}
