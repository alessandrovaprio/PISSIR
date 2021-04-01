package it.uniupo.giiot.iot.api;

/**
 * Rappresenta le operazioni che i plugin possono richiedere al sottosistema IoT.
 */
public interface IotSubsystem
{
    /**
     * Ritorna la capacità della stanza gestita dal sottosistema IoT.
     * @return La capacità della stanza gestita dal sottosistema IoT
     */
    int getRoomCapacity();

    /**
     * Ritorna l'occupazione della stanza gestita dal sottosistema IoT.
     * @return L'occupazione della stanza gestita dal sottosistema IoT
     */
    int getRoomOccupancy();

    /**
     * Segnala l'ingresso di una persona nella stanza gestita dal sottosistema IoT.
     */
    void ingressDetected();

    /**
     * Segnala l'uscita di una persona dalla stanza gestita dal sottosistema IoT.
     */
    void egressDetected();

    /**
     * Ritorna l'id di questo dispositivo IoT.
     * @return l'id di questo dispositivo IoT
     */
    String getIotId();
}
