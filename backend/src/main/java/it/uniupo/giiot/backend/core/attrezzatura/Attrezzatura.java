package it.uniupo.giiot.backend.core.attrezzatura;

import com.google.gson.annotations.Expose;
import it.uniupo.giiot.backend.core.IntegerPkEntity;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * Rappresenta un oggetto di tipo Attrezzatura.
 *
 * Un oggetto di tipo attrezzatura ha un id e un nome.
 * Sono forniti i metodi statici per cercare gli oggetti attrezzatura e trovare duplicati nel database
 * tramite Hibernate.
 * Estende la classe IntegerPkEntity.
 */
@Entity
@Table(name = "Attrezzatura")
public class Attrezzatura implements IntegerPkEntity<Attrezzatura> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attrezzatura_id")
    @Expose
    private Integer idAttrezzatura;

    @Column(name = "attrezzatura_nome")
    @Expose
    private String nomeAttrezzatura;

    public Attrezzatura () {}

    /**
     * Crea un oggetto di tipo attrezzatura non ancora inserito nel database.
     * Per questo motivo idAttrezzatura non viene settato.
     *
     * @param nomeAttrezzatura nome dell'attrezzatura
     */
    public Attrezzatura(String nomeAttrezzatura) {
        setNomeAttrezzatura(nomeAttrezzatura);
    }

    /**
     * Crea un oggetto di tipo attrezzatura.
     *
     * @param idAttrezzatura id nel database.
     * @param nomeAttrezzatura nome dell'attrezzatura.
     */
    public Attrezzatura(int idAttrezzatura, String nomeAttrezzatura) {
        this(nomeAttrezzatura);
        setIdAttrezzatura(idAttrezzatura);
    }

    /**
     * Restituisce l'id dell'attrezzatura.
     * Richiama il metodo <code>getIdAttrezzatura</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @return l'id dell'attrezzatura.
     */
    @Override
    public Integer getPk() {
        return getIdAttrezzatura();
    }

    /**
     * Imposta l'id dell'attrezzatura.
     * Richiama il metodo <code>setIdAttrezzatura</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @param pk id dell'attrezzatura.
     */
    @Override
    public void setPk(Integer pk) {
        setIdAttrezzatura(pk);
    }

    /**
     * Restituisce tutte le attrezzature presenti nel database.
     * Richiama il metodo <code>cercaAttrezzatura</code>.
     *
     * @return Collection delle attrezzature nel database.
     */
    @Override
    public Collection<Attrezzatura> getAll() {
        return cercaAttrezzatura(HibernateUtil.getCurrentSession(), null, false);
    }

    /**
     * Restituisce l'id dell'attrezzatura.
     *
     * @return l'id dell'attrezzatura.
     */
    public Integer getIdAttrezzatura() {
        return idAttrezzatura;
    }

    /**
     * Imposta l'id dell'attrezzatura.
     *
     * @param idAttrezzatura id dell'attrezzatura.
     */
    public void setIdAttrezzatura(Integer idAttrezzatura) {
        this.idAttrezzatura = idAttrezzatura;
    }

    /**
     * Restituisce il nome dell'attrezzatura.
     *
     * @return il nome dell'attrezzatura.
     */
    public String getNomeAttrezzatura() {
        return nomeAttrezzatura;
    }

    /**
     * Imposta il nome dell'attrezzatura.
     * Se la stringa passata come parametro è null, lancia un'<code>IllegalArgumentException</code>.
     *
     * @param nomeAttrezzatura nome dell'attrezzatura
     */
    public void setNomeAttrezzatura(String nomeAttrezzatura) {
        if(nomeAttrezzatura.length() > 0) {
            this.nomeAttrezzatura = nomeAttrezzatura;
        } else {
            throw new IllegalArgumentException("Inserita una stringa vuota");
        }
    }

    /**
     * Restituisce true se due oggetti di tipo attrezzatura sono
     * uguali, altrimenti false.
     * Due oggetti di tipo attrezzatura sono uguali se hanno lo stesso id e
     * lo stesso nome.
     *
     * @param o oggetto con cui fare il confronto.
     * @return true se i due oggetti sono uguali, altrimenti false.
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Attrezzatura that = (Attrezzatura) o;
        return Objects.equals(idAttrezzatura, that.idAttrezzatura);
    }

    @Override
    public int hashCode()
    {
        return Objects.hash(idAttrezzatura);
    }

    /**
     * Restistuisce la lista degli oggetti di tipo attrezzata presenti nel database.
     * Se <code>nomeAttrezzatura</code> non è null e <code>dupl</code> è true, viene cercata
     * un'attrezzatura che ha il nome uguale a <code>nomeAttrezzatura</code>.
     * Se <code>nomeAttrezzatura</code> non è null e <code>dupl</code> è false, vengono cercate
     * le attrezzature che contengono nel nome <code>nomeAttrezzatura</code>.
     * Se <code>nomeAttrezzatura</code> è null vengono restituite tutte le attrezzature presenti nel database.
     * Se non viene trovato nulla, viene restituita una lista vuota.
     *
     * @param session sessione per hibernate.
     * @param nomeAttrezzatura nome dell'attrezzatura da cercare.
     * @param dupl true: le attrezzature cercate devono avere il nome uguale a <code>nomeAttrezzatura</code>;
     *             false: le attrezzature cercate devono avere il nome che contiene <code>nomeAttrezzatura</code>.
     * @return lista delle attrezzature trovate.
     */
    public static List<Attrezzatura> cercaAttrezzatura(Session session, String nomeAttrezzatura, boolean dupl) {
        List<Attrezzatura> list = null;
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Attrezzatura> query = builder.createQuery(Attrezzatura.class);
            Root<Attrezzatura> root = query.from(Attrezzatura.class);
            if (nomeAttrezzatura != null) {
                if(dupl) {
                    query.select(root).where(builder.equal(root.get("nomeAttrezzatura"), nomeAttrezzatura));
                } else {
                    query.select(root).where(builder.like(root.get("nomeAttrezzatura"), "%" + nomeAttrezzatura + "%"));
                }
            } else {
                query.select(root);
            }
            query.orderBy(builder.asc(root.get("idAttrezzatura")));
            Query<Attrezzatura> q = session.createQuery(query);
            list = q.getResultList();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Controlla se sono presenti duplicati nel database.
     * Richiama il metodo <code>cercaAttrezzatura</code>.
     * Se sono presenti restituisce true, altrimenti false.
     *
     * @param session sessione per hibernate
     * @param nomeAttrezzatura nome dell'attrezzatura da controllare
     * @return true, se sono presenti duplicati nel database, altrimenti false
     */
    public static boolean searchDuplicates (Session session, String nomeAttrezzatura) {
        List<Attrezzatura> duplicati = cercaAttrezzatura(session, nomeAttrezzatura, true);
        return duplicati.size() > 0;
    }
}
