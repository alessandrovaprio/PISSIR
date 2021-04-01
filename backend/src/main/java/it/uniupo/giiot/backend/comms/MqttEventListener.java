package it.uniupo.giiot.backend.comms;

/**
 * Interfaccia che rappresenta un ascoltatore di eventi Mqtt.
 */
public interface MqttEventListener {
    /**
     * Gestisce una richiesta di binding da un dispositivo.
     * @param deviceType la stringa fornita dal dispositivo che ne indica il tipo
     * @return l'id da assegnare a questo dispositivo, o <code>null</code> per rifiutarlo
     */
    Integer handleBindingRequest(String deviceType);  // todo ux: mostrare anche il nome/uuid

    /**
     * Segnala un cambiamento nell'occupazione di una stanza.
     * @param id l'id del dispositivo che ha segnalato il cambiamento
     * @param change cambiamento relativo dell'occupazione di una stanza
     */
    void occupancyChanged(int id, int change);
}
