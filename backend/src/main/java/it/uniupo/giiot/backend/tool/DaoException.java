package it.uniupo.giiot.backend.tool;

/**
 * Classe di eccezione personalizzata per identificare le eccezioni generate dal database.
 */
public class DaoException extends Error {
    public DaoException(String message) {
        super(message);
    }

    public DaoException(String message, Throwable cause) {
        super(message, cause);
    }
}
