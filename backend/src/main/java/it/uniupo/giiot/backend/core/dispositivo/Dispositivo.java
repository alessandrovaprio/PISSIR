package it.uniupo.giiot.backend.core.dispositivo;

import com.google.gson.annotations.Expose;
import it.uniupo.giiot.backend.core.IntegerPkEntity;
import it.uniupo.giiot.backend.core.aula.Aula;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * Rappresenta un oggetto di tipo Dispositivo.
 *
 * Un oggetto di tipo Dispositivo ha un id, l'aula a cui è assegnato, un suo un nome, la sua marca
 * e la data d'installazione.
 */
@Entity
@Table(name = "Dispositivo")
public class Dispositivo implements IntegerPkEntity<Dispositivo> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "dipositivo_id")
    @Expose
    private Integer idDispositivo;

    @ManyToOne
    @JoinColumn(name = "aula_id", nullable = true)
    @Expose
    private Aula aulaDispositivo;

    @Column(name = "dispositivo_nome")
    @Expose
    private String nomeDispositivo;

    @Column(name = "dispositivo_marca", nullable = true)
    @Expose
    private String marcaDispositivo;

    @Column(name = "dispositivo_data_installazione")
    @Expose
    private LocalDate dataInstallazione;

    public Dispositivo() {

    }


    /**
     * Crea un oggetto di tipo dispositivo non ancora inserito nel database.
     * Richiama i metodi <code>setAulaDispositivo</code>, <code>setNomeDispositivo</code>,
     * <code>setMarcaDispositivo</code>, <code>setDataInstallazione</code>.
     * Se i parametri non sono validi, viene lanciata un'<code>IllegalArgumentException</code>.
     *
     * @param aulaDispositivo aula del dispositivo
     * @param nomeDispositivo nome del dispositivo
     * @param marcaDispositivo marca del dispositivo
     * @param dataInstallazione data installazione del dispositivo
     */
    public Dispositivo(Aula aulaDispositivo, String nomeDispositivo, String marcaDispositivo, LocalDate dataInstallazione)
            throws DaoException {
        setAulaDispositivo(aulaDispositivo);
        setNomeDispositivo(nomeDispositivo);
        setMarcaDispositivo(marcaDispositivo);
        setDataInstallazione(dataInstallazione);
    }

    /**
     * Overload del costruttore.
     * Imposta <code>idDispositivo</code>, richiamando <code>setIdDispositivo</code>.
     * Se i parametri non sono validi, viene lanciata un'<code>IllegalArgumentException</code>.
     *
     * @param idDispositivo id del dispositivo
     * @param aulaDispositivo aula del dispositivo
     * @param nomeDispositivo nome del dispositivo
     * @param marcaDispositivo marca del dispositivo
     * @param dataInstallazione data installazione del dispositivo
     * @throws DaoException
     */
    public Dispositivo (Integer idDispositivo, Aula aulaDispositivo, String nomeDispositivo, String marcaDispositivo,
                        LocalDate dataInstallazione) throws DaoException {
        this(aulaDispositivo, nomeDispositivo, marcaDispositivo, dataInstallazione);

        setIdDispositivo(idDispositivo);
    }

    /**
     * Restituisce l'id del dispositivo
     *
     * @return l'id del dispositivo
     */
    public Integer getIdDispositivo() {
        return idDispositivo;
    }

    /**
     * Imposta l'id del dispositivo
     *
     * @param idDispositivo id del dispositivo
     */
    public void setIdDispositivo(Integer idDispositivo) {
        this.idDispositivo = idDispositivo;
    }

    /**
     * Restituisce l'id del dispositivo.
     * Richiama il metodo <code>getIdDispositivo</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @return  l'id del dispositivo.
     */
    @Override
    public Integer getPk() {
        return getIdDispositivo();
    }

    /**
     * Imposta l'id del dispositivo.
     * Richiama il metodo <code>setIdDispositivo</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @param pk id del dispositivo.
     */
    @Override
    public void setPk(Integer pk) {
        setIdDispositivo(pk);
    }

    /**
     * Restituisce l'aula del dispositivo
     *
     * @return aula del dispositivo
     */
    public Aula getAulaDispositivo() {
        return aulaDispositivo;
    }

    /**
     * Imposta l'aula del dispositivo
     *
     * @param aulaDispositivo aula del dispositivo
     */
    public void setAulaDispositivo(Aula aulaDispositivo) throws DaoException {
        this.aulaDispositivo = aulaDispositivo;
    }

    /**
     * Restituisce il nome del dispositivo
     *
     * @return nome del dispositivo
     */
    public String getNomeDispositivo() {
        return nomeDispositivo;
    }

    /**
     * Imposta il nome del dispositivo.
     * Se viene passato un parametro null, viene lanciata una <code>DaoException</code>.
     *
     * @param nomeDispositivo nome del dispositivo
     */
    public void setNomeDispositivo(String nomeDispositivo) throws DaoException {
        if(!isNull(nomeDispositivo)) {
            this.nomeDispositivo = nomeDispositivo;
        } else {
            throw new DaoException("DISPOSITIVO: il nome del dispositivo inserito è null");
        }
    }

    /**
     * Restituisce la marca del dispositivo
     *
     * @return la marca del dispositivo
     */
    public String getMarcaDispositivo() {
        return marcaDispositivo;
    }

    /**
     * Imposta la marca del dispositivo.
     *
     * @param marcaDispositivo marca del dispositivo
     */
    public void setMarcaDispositivo(String marcaDispositivo) throws DaoException {
        if(!isNull(marcaDispositivo)) {
            this.marcaDispositivo = marcaDispositivo;
        } else {
            this.marcaDispositivo = null;
        }
    }

    /**
     * Restituisce la data di installazione del dispositivo
     *
     * @return la data installazione del dispositivo
     */
    public LocalDate getDataInstallazione() {
        return dataInstallazione;
    }

    /**
     * Imposta la data di installazione del dispositivo.
     * Se <code>dataInstallazione</code> è null, viene lanciata una <code>DaoException</code>.
     *
     * @param dataInstallazione: data installazione del dispositivo
     */
    public void setDataInstallazione(LocalDate dataInstallazione) throws DaoException {
        if(!isNull(dataInstallazione)) {
            this.dataInstallazione = dataInstallazione;
        } else {
            throw new DaoException("DISPOSITIVO: la data d'installazione del dispositivo inserito è null");
        }
    }

    /**
     * Restituisce true se <code>object</code> è null, altrimenti false.
     *
     * @param object oggetto da controllare
     * @param <T> tipo generio
     * @return true se <code>object</code> è null, altrimenti false.
     */
    private <T> boolean isNull(T object) {
        return object == null;
    }

    /**
     * Restituisce tutte i dispositivi presenti nel database.
     * Richiama il metodo <code>cercaDispositivo</code>.
     *
     * @return Collection dei dispositivi nel database.
     */
    @Override
    public Collection<Dispositivo> getAll() {
        return cercaDispositivo(HibernateUtil.getCurrentSession(), null, null, null, null);
    }

    /**
     * Restistuisce la lista dei dispositivi
     * presenti nel database in base ai parametri passati come input.
     * Restituisce una lista vuota se non viene trovato nulla.
     * Se tutte le stringe passate come parametro sono nulle, vengono restituiti tutti gli
     * oggetti di tipo resposabile presenti nel database.
     * La ricerca viene effettuata solo per i valori non nulli.
     *
     * @return lista che contiene i dispositivi trovati
     */
    public static List<Dispositivo> cercaDispositivo(Session session, Aula aulaDispositivo, String nomeDispositivo,
                                                String marcaDispositivo, LocalDate dataInstallazione) {
        List<Dispositivo> list = null;
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Dispositivo> query = builder.createQuery(Dispositivo.class);
            Root<Dispositivo> root = query.from(Dispositivo.class);
            Predicate[] pr = buildPredicate(builder, root, aulaDispositivo, nomeDispositivo, marcaDispositivo,
                    dataInstallazione);
            if(pr.length > 0) {
                query.select(root).where(pr);
            } else {
                query.select(root).where();
            }
            query.orderBy(builder.asc(root.get("idDispositivo")));
            Query<Dispositivo> q = session.createQuery(query);
            list = q.getResultList();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Permette di costruire in modo dinamico la query di ricerca
     * per i dispositivi nel database.
     * Le stringhe non nulle non vengono aggiunte alle query.
     * La ricerca per nome e marca sono fatte per <code>like</code> e non per <code>equal</code>
     *
     * @param builder oggetto usato per costruire le query
     * @param root tipo di entità a cui fa riferimento la radice
     * @return oggetto predicate che indica con quali restrizioni fare la ricerca
     */
    private static Predicate[] buildPredicate(CriteriaBuilder builder, Root<Dispositivo> root,  Aula aulaDispositivo,
                                              String nomeDispositivo, String marcaDispositivo, LocalDate dataInstallazione) {
        List<Predicate> predicates = new ArrayList<>();
        if(aulaDispositivo != null) {
            Predicate aula;
            aula = builder.equal(root.get("aulaDispositivo"), aulaDispositivo);
            predicates.add(aula);
        }
        if(nomeDispositivo != null) {
            Predicate nome;
            nome = builder.like(root.get("nomeDispositivo"), "%" + nomeDispositivo + "%");
            predicates.add(nome);
        }
        if(marcaDispositivo != null) {
            Predicate marca;
            marca = builder.like(root.get("marcaDispositivo"), "%" + marcaDispositivo + "%");
            predicates.add(marca);
        }
        if(dataInstallazione != null) {
            Predicate data;
            data = builder.equal(root.get("dataInstallazione"), dataInstallazione);
            predicates.add(data);
        }
        Predicate [] pr = new Predicate[predicates.size()];
        return predicates.toArray(pr);
    }

    /**
     * Restituisce true se due oggetti di tipo dispositivo sono uguali, altrimenti false.
     *
     * Due oggetti di tipo dispositivo sono uguali se hanno lo stesso id.
     *
     * @param o oggetto con cui fare il confronto
     * @return true se i due oggetti sono uguali, altrimenti false
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Dispositivo that = (Dispositivo) o;
        return Objects.equals(idDispositivo, that.idDispositivo);
    }

    @Override
    public int hashCode()
    {
        return Objects.hash(idDispositivo);
    }
}
