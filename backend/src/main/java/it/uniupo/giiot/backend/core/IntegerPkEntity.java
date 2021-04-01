package it.uniupo.giiot.backend.core;

import java.util.Collection;

/**
 * Interfaccia che rappresenta un'entità del database con chiave primaria di tipo <code>Integer</code>.
 */
public interface IntegerPkEntity<T extends IntegerPkEntity<T>>
{
    /**
     * Restisce la chiave primaria dell'entità
     *
     * @return la chiave primaria dell'entità
     */
    Integer getPk();

    /**
     * Setta la chiave primaria.
     */
    void setPk(Integer pk);

    /**
     * Ritorna una collezione di tutte le entità disponibili.
     *
     * @return la collezione di tutte le entità disponibili.
     */
    Collection<T> getAll();
}
