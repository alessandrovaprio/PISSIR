package it.uniupo.giiot.backend.core.aula;

import com.google.gson.annotations.Expose;
import it.uniupo.giiot.backend.core.IntegerPkEntity;
import it.uniupo.giiot.backend.core.attrezzatura.Attrezzatura;
import it.uniupo.giiot.backend.core.dispositivo.Dispositivo;
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
import java.util.*;

/**
 * Rappresenta un oggetto di tipo Aula.
 *
 * Un oggetto di tipo Aula ha un id, un suo un nome, una capienza massima, una
 * capienza minima e le attrezzature di cui è dotata.
 */
@Entity
@Table(name = "Aula")
public class Aula implements IntegerPkEntity<Aula> {
    @Transient
    final int MIN_CAPACITY = 0;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "aula_id")
    @Expose
    private Integer idAula;

    @Column(name = "aula_nome")
    @Expose
    private String nomeAula;

    @Column(name = "aula_capienza_max")
    @Expose
    private Integer capienzaMax;

    @Column(name = "aula_capienza_min")
    @Expose
    private Integer capienzaMin;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "aula_attrezzatura",
            joinColumns = {@JoinColumn(name = "aula_id")},
            inverseJoinColumns = {@JoinColumn (name = "attrezzatura_id")}
    )
    @Expose
    private List<Attrezzatura> attrezzature;

    @OneToMany(mappedBy = "aulaDispositivo", fetch = FetchType.EAGER)
    private Set<Dispositivo> dispositivi;

    public Aula() {

    }

    /**
     * Crea un oggetto di tipo aula non ancora inserito nel database.
     * Richiama i metodi <code>setAula</code>, <code>setCapienza</code</code>,
     * <code>setCapienzaMin</code>.
     *
     * @param nomeAula nome dell'aula.
     * @param capienzaMax capienza massima dell'aula.
     * @param capienzaMin capienza minima dell'aula.
     */
    public Aula(String nomeAula, Integer capienzaMax, Integer capienzaMin) {
        setNomeAula(nomeAula);
        setCapienzaMax(capienzaMax);
        setCapienzaMin(capienzaMin);

        this.attrezzature = new ArrayList<>();
    }

    /**
     * Overload del costruttore.
     * Imposta <code>idAula</code>, richiamando <code>setIdAula</code>.
     *
     * @param idAula id dell'aula.
     * @param nomeAula nome dell'aula.
     * @param capienzaMax capienza massima dell'aula.
     * @param capienzaMin capienza minima dell'aula.
     */
    public Aula (Integer idAula, String nomeAula, Integer capienzaMax, Integer capienzaMin) {
        this(nomeAula, capienzaMax, capienzaMin);
        setIdAula(idAula);
    }

    /**
     * Restituisce l'id dell'aula.
     * Richiama il metodo <code>getIdAula</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @return  id dell'aula.
     */
    @Override
    public Integer getPk() {
        return getIdAula();
    }

    /**
     * Imposta l'id dell'aula.
     * Richiama il metodo <code>setIdAula</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @param pk id dell'aula.
     */
    @Override
    public void setPk(Integer pk) {
        setIdAula(pk);
    }

    /**
     * Restituisce tutte le aule presenti nel database.
     * Richiama il metodo <code>cercaAula</code>.
     *
     * @return Collection delle aule nel database.
     */
    @Override
    public Collection<Aula> getAll() {
        return cercaAula(HibernateUtil.getCurrentSession(), null, null, null, false);
    }

    /**
     * Restituisce l'id dell'aula.
     *
     * @return idAttrezzatura: id dell'aula
     */
    public Integer getIdAula() {
        return idAula;
    }

    /**
     * Imposta l'id dell'aula.
     *
     * @param idAula id dell'aula.
     */
    public void setIdAula(Integer idAula) {
        this.idAula = idAula;
    }

    /**
     * Restituisce il nome dell'aula.
     *
     * @return il nome dell'aula.
     */
    public String getNomeAula() {
        return nomeAula;
    }

    /**
     * Imposta il nome dell'aula.
     * Lancia un' <code>IllegalArgumentException</code> se <code>nomeAula</code> è null.
     *
     * @param nomeAula nome dell'aula.
     */
    public void setNomeAula(String nomeAula) {
        if(nomeAula.length() > 0) {
            this.nomeAula = nomeAula;
        } else {
            throw new IllegalArgumentException("Inserita una stringa vuota");
        }
    }

    /**
     * Restituisce la capienza massima dell'aula.
     *
     * @return la capienza massima dell'aula.
     */
    public Integer getCapienzaMax() {
        return capienzaMax;
    }

    /**
     * Imposta la capienza massima dell'aula.
     *
     * @param capienzaMax capienza massima dell'aula.
     */
    public void setCapienzaMax(Integer capienzaMax) {
        if(checkCapienzaMax(capienzaMax)) {
            this.capienzaMax = capienzaMax;
        }
    }

    /**
     * Restituisce la capienza minima dell'aula.
     *
     * @return la capienza minima dell'aula.
     */
    public Integer getCapienzaMin() {
        return capienzaMin;
    }

    /**
     * Se <code>checkCapienzaMin</code> è vera, imposta la capienza minima dell'aula.
     * Altrimenti lancia un'<code>IllegalArgumentException</code>.
     *
     * @param capienzaMin capienza minima dell'aula.
     */
    public void setCapienzaMin(Integer capienzaMin) {
        if(checkCapienzaMin(capienzaMin, capienzaMax)) {
            this.capienzaMin = capienzaMin;
        }
    }

    /**
     * Restituisce la lista che contiene le attrezzature dell'aula.
     *
     * @return le attrezzature dell'aula.
     */
    public List<Attrezzatura> getAttrezzature() {
        return attrezzature;
    }

    /**
     * Imposta la lista che contiene le attrezzature dell'aula.
     *
     * @param attrezzature lista che contiene le attrezzature dell'aula.
     */
    public void setAttrezzature(List<Attrezzatura> attrezzature) {
        this.attrezzature = attrezzature;
    }

    /**
     * Ritorna la lista dei dispositivi associati all'Aula.
     *
     * @return la lista dei dispositivi associati all'Aula
     */
    public Set<Dispositivo> getDispositivi() {
        return dispositivi;
    }

    /**
     * Controlla che la capienza massima non sia inferiore a <code>MIN_CAPACITY</code>.
     * Se lo è, lancia un'<code>IllegalArgumentException</code>. Altrimenti restituisce true.
     *
     * @param capienzaMax capienza massima da controllare
     * @return true se <code>capienzaMax</code> è maggiore di <code>MIN_CAPACITY</code>
     */
    private boolean checkCapienzaMax(Integer capienzaMax) {
        if (capienzaMax < MIN_CAPACITY) {
            throw new IllegalArgumentException("Inserito un valore minore di " + MIN_CAPACITY +
                    ". La capienza massima non può essere minore di " +  MIN_CAPACITY);
        }
        return true;
    }

    /**
     * Controlla che la capienza minima non sia inferiore a <code>MIN_CAPACITY</code> e non sia
     * maggiore di <code>capienzaMax</code>.
     * Se lo è viene, lancia <code>IllegalArgumentException</code>.
     * Altrimenti restituisce true.
     *
     * @param capienzaMin capienza minima da controllare
     * @param capienzaMax capienza massima da confrontare
     * @return true se <code>capienzaMin</code> è compresa tra <code>MIN_CAPACITY</code> e <code>capienzaMax</code>
     */
    private boolean checkCapienzaMin(Integer capienzaMin, Integer capienzaMax) {
        if (capienzaMin < MIN_CAPACITY) {
            throw new IllegalArgumentException("Inserito un valore minore di 0." +
                    " La capienza minima non può essere minore di zero");
        }
        if(capienzaMin > capienzaMax) {
            throw new IllegalArgumentException("La capienza minima dell'aula, " +
                    "non può essere maggiore della capienza massima");
        }
        return true;
    }

    /**
     * Aggiunge l'attrezzatura passata come parametro all'aula.
     * Lancia <code>DaoException</code>, se si vuole inserire un'attrezzatura già presente.
     * Lancia <code>IllegalArgumentException</code> se <code>attrezzatura</code> è null.
     *
     * @param attrezzatura attrezzatura da aggiugere
     */
    public void aggiungiAttrezzatura(Attrezzatura attrezzatura) throws IllegalArgumentException, DaoException {
        if(attrezzatura != null) {
            if(attrezzature.contains(attrezzatura)) {
                throw new DaoException("ERRORE!: Inserita un'attrezzatura già presente");
            }
            attrezzature.add(attrezzatura);
        } else {
            throw new IllegalArgumentException("ERRORE!: Inserito un oggetto null");
        }
    }

    /**
     * Rimuove dall'aula l'attrezzatura passato come parametro.
     * Lancia <code>DaoException</code>, se si vuole rimuovere un'attrezzatura non presente.
     * Lancia <code>IllegalArgumentException</code> se <code>attrezzatura</code> è null.
     *
     * @param attrezzatura oggetto di tipo attrezzatura da rimuovere.
     */
    public void rimuoviAttrezzatura(Attrezzatura attrezzatura) throws IllegalArgumentException, DaoException {
        if(attrezzatura != null) {
            if(attrezzature.contains(attrezzatura)) {
                Iterator<Attrezzatura> i = attrezzature.iterator();
                Attrezzatura attr;
                while (i.hasNext()) {
                    attr = i.next();
                    if (attr.equals(attrezzatura)) {
                        i.remove();
                        break;
                    }
                }
            } else {
                throw new DaoException("ERRORE!: L'attrezzatura che si vuole rimuovere non è presente");
            }
        } else {
            throw new IllegalArgumentException("ERRORE!: Inserito un oggetto null");
        }
    }

    /**
     * Restituisce true se due oggetti di tipo aula sono uguali, altrimenti false.
     *
     * Due oggetti di tipo aula sono uguali se hanno lo stesso id.
     *
     * @param o oggetto con cui fare il confronto
     * @return true se i due oggetti sono uguali, altrimenti false
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Aula aula = (Aula) o;
        return Objects.equals(idAula, aula.idAula);
    }

    @Override
    public int hashCode()
    {
        return Objects.hash(idAula);
    }

    private boolean attrezzatureEquals(Set<Attrezzatura> attrezz) {
        return attrezz.equals(attrezzature);
    }

    /**
     * Restistuisce la lista delle aule presenti nel database in base ai parametri passati come input.
     * Restituisce una lista vuota se non viene trovato nulla.
     * Se tutti i parametri sono nulli, vengono restituiti tutte le aule presenti nel database.
     * Se no la ricerca viene effettuata solo per i valori non nulli.
     * Se <code>dupl</code> è true e <code>nomeAula</code> non è null, viene cercata un aula con il
     * nome uguale a <code>nomeAula</code>.
     * Se <code>dupl</code> è false e <code>nomeAula</code> non è null, vengono cercate le aule
     * che contengono nel nome <code>nomeAula</code>.
     *
     * @param nomeAula nome dell'aula da cercare
     * @param capienzaMax capienza massima da cercare
     * @param capienzaMin capienza minima da cercare
     * @param dupl true: le aule cercate devono avere il nome uguale a <code>nomeAula</code>
     *             false: le aule cercate devono avere il nome che contiene <code>nomeAula</code>
     * @return lista che contiene gli oggetti di tipo attrezzatura trovati
     */
    public static List<Aula> cercaAula(Session session, String nomeAula, Integer capienzaMax, Integer capienzaMin, boolean dupl) {
        List<Aula> list = null;
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Aula> query = builder.createQuery(Aula.class);
            Root<Aula> root = query.from(Aula.class);
            Predicate[] pr =
                    buildPredicate(builder, root, nomeAula, capienzaMax, capienzaMin, dupl);
            if(pr.length > 0) {
                query.select(root).where(pr);
            } else {
                query.select(root).where();
            }
            query.orderBy(builder.asc(root.get("idAula")));
            Query<Aula> q = session.createQuery(query);
            list = q.getResultList();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Permette di costruire in modo dinamico la query di ricerca
     * aula nel database.
     * Le stringhe nulle non vengono aggiunte alle query.
     * Se <code>dupl</code> è positivo la query di ricerca per il nome dell'aula
     * utilizza l'operatore AND, altrimenti LIKE.
     *
     * @param builder oggetto usato per costruire le query
     * @param root tipo di entità a cui fa riferimento la radice
     * @param nomeAula nome dell'aula
     * @param capienzaMax capienza massima dell'aula
     * @param capienzaMin capienza minima dell'aula
     * @param dupl indica se la ricerca del per il nome dell'aula deve utilizzare
     *       l'operatore AND, altrimenti LIKE.
     * @return oggetto predicate che indica con quali restrizioni fare la ricerca
     */
    private static Predicate[] buildPredicate(CriteriaBuilder builder, Root<Aula> root, String nomeAula,
                                       Integer capienzaMax, Integer capienzaMin, boolean dupl) {
        List<Predicate> predicates = new ArrayList<>();
        if(nomeAula != null) {
            Predicate aulaName;
            if(dupl) {
                aulaName = builder.equal(root.get("nomeAula"), nomeAula);
            } else {
                aulaName = builder.like(root.get("nomeAula"), "%" + nomeAula + "%");
            }
            predicates.add(aulaName);
        }
        if(capienzaMax != null) {
            Predicate capMax = builder.equal(root.get("capienzaMax"), capienzaMax);
            predicates.add(capMax);
        }
        if(capienzaMin != null) {
            Predicate capMin = builder.equal(root.get("capienzaMin"), capienzaMin);
            predicates.add(capMin);
        }
        Predicate [] pr = new Predicate[predicates.size()];
        return predicates.toArray(pr);
    }

    /**
     * Controlla se sono presenti duplicati nel database.
     * Se sono presenti restituisce true, altrimenti false.
     * Richiama il metodo <code>cercaAula</code>.
     *
     * @param nomeAula nome dell'aula da controllare
     * @return true, se sono presenti duplicati nel database, altrimenti false
     */
    public static boolean notContainsDuplicates (Session session, String nomeAula, int capienzaMax, int capienzaMin) {
        List<Aula> duplicati = cercaAula(session, nomeAula, capienzaMax,
                capienzaMin, true);

        return duplicati.size() == 0;
    }


}
