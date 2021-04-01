package it.uniupo.giiot.backend.core.responsabile;

import com.google.gson.annotations.Expose;
import it.uniupo.giiot.backend.core.IntegerPkEntity;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.annotations.NaturalId;
import org.hibernate.query.Query;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * Rappresenta un oggetto di tipo Responsabile.
 *
 * Un oggetto di tipo Responsabile ha un id, un nome, un cognome e un indirizzo email.
 */
@Entity
@Table(name = "Responsabile")
public class Responsabile implements IntegerPkEntity<Responsabile> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "responsabile_id")
    @Expose
    private Integer idResp;

    @Column(name = "responsabile_nome")
    @Expose
    private String nomeResp;

    @Column(name = "responsabile_cognome")
    @Expose
    private String cognomeResp;

    @Column(name = "responsabile_username")
    @NaturalId(mutable = true)
    @Expose
    private String usernameResp;

    public Responsabile() {

    }

    /**
     * Crea un oggetto di tipo resposabile non è ancora inserito nel database.
     * Richiama i metodi <code>setNomeResponsabile</code>, <code>setCognomeResponsabile</code>,
     * <code>setUsernameResponsabile</code>.
     *
     * @param nomeResp nome del resposabile
     * @param cognomeResp cognome del resposabile
     * @param usernameResp email del responsabile
     */
    public Responsabile(String nomeResp, String cognomeResp, String usernameResp) throws DaoException {
        setNomeResponsabile(nomeResp);
        setCognomeResponsabile(cognomeResp);
        setUsernameResponsabile(usernameResp);
    }

    /**
     * Overload del costruttore.
     * Richiama <code>setIdResponsabile</code>.
     *
     * @param idResp id del resposabile
     * @param nomeResp nome del resposabile
     * @param cognomeResp cognome del resposabile
     * @param usernameResp username del responsabile
     * @throws DaoException
     */
    public Responsabile (int idResp, String nomeResp, String cognomeResp, String usernameResp) throws DaoException {
        this(nomeResp, cognomeResp, usernameResp);
        setIdResponsabile(idResp);
    }

    /**
     * Restituisce l'id del resposabile.
     * Richiama il metodo <code>getIdResponsabile</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @return  id del resposabile.
     */
    @Override
    public Integer getPk() {
        return getIdResponsabile();
    }

    /**
     * Imposta l'id del resposabile.
     * Richiama il metodo <code>setIdResponsabile</code>.
     * Interfaccia comune su tutte le entità con chiave primaria di tipo intero,
     *
     * @param pk id del resposabile.
     */
    @Override
    public void setPk(Integer pk) {
        setIdResponsabile(pk);
    }

    /**
     * Restituisce tutti i responsabili presenti nel database.
     * Richiama il metodo <code>cercaResponsabili</code>.
     *
     * @return Collection dei responsabili nel database.
     */
    @Override
    public Collection<Responsabile> getAll() {
        return cercaResponsabile(HibernateUtil.getCurrentSession(), null, null, null, false);
    }

    /**
     * Restituisce l'id del resposabile
     *
     * @return idResp: id del responsabile
     */
    public Integer getIdResponsabile() {
        return idResp;
    }

    /**
     * Imposta l'id del responsabile
     *
     * @param idResp id del resposabile
     */
    public void setIdResponsabile(Integer idResp) {
        this.idResp = idResp;
    }

    /**
     * Restituisce il nome del responsabile
     *
     * @return il nome del responsabile
     */
    public String getNomeResponsabile() {
        return nomeResp;
    }

    /**
     * Imposta il nome del responsabile
     * Viene controllato che contenga solo lettere, se no viene lanciata un eccezione.
     *
     * @param nomeResp nome del responsabile
     * @throws DaoException se <code>nomeResp</code> è null, oppure non contiene solo lettere
     */
    public void setNomeResponsabile(String nomeResp) throws DaoException {
        if(nomeResp != null) {
            if(nomeResp.length() > 0) {
                if(checkOnlyLetter(nomeResp)) {
                    this.nomeResp = nomeResp;
                } else {
                    throw new IllegalArgumentException("ERRORE! Il nome del responsabile deve contenere solo lettere");
                }
            } else {
                throw new DaoException("ERRORE! Inserita una stringa vuota");
            }
        } else {
            throw new DaoException("ERRORE! Inserito un valore nullo");
        }
    }

    /**
     * Restituisce il cognome del responsabile
     *
     * @return il cognome del responsabile
     */
    public String getCognomeResponsabile() {
        return cognomeResp;
    }

    /**
     * Imposta il cognome del responsabile.
     * Viene controllato che contenga solo lettere.
     *
     * @param cognomeResp cognome del responsabile
     * @throws DaoException se <code>cognomeResp</code> è null, oppure non contiene solo lettere
     */
    public void setCognomeResponsabile(String cognomeResp) throws DaoException {
        if(cognomeResp != null) {
            if(cognomeResp.length() > 0) {
                if(checkOnlyLetter(cognomeResp)) {
                    this.cognomeResp= cognomeResp;
                } else {
                    throw new IllegalArgumentException("ERRORE! Il cognome del responsabile deve contenere solo lettere");
                }
            }else {
                throw new DaoException("ERRORE! Inserita una stringa vuota");
            }
        } else {
            throw new DaoException("ERRORE! Inserito un valore nullo");
        }

    }
    /**
     * Imposta l'email del responsabile.
     * Viene controllato che il formato dell'email sia corretto: user@domain.com.
     * Se non lo rispetta, lancia un'eccezione.
     *
     * @param usernameResp email del responsabile
     * @throws DaoException se <code>usernameResp</code> è null, oppure non rispetta il pattern user@domain.com
     */
    public void setUsernameResponsabile(String usernameResp) throws DaoException {
        if (usernameResp != null) {
            if (usernameResp.length() > 0) {
                this.usernameResp = usernameResp;
            } else {
                throw new DaoException("ERRORE! Inserita una stringa vuota");
            }
        } else {
            throw new DaoException("ERRORE! Inserito un valore nullo");
        }

    }

    /**
     * Restituisce l'email del responsabile.
     *
     * @return l'email del responsabile
     */
    public String getUsernameResponsabile() {
        return usernameResp;
    }

    /**
     * Controlla che la stringa passata come parametro contenga solo lettere.
     * Se sì, restitusce true, altrimenti false
     *
     * @param parola stringa da controllare
     * @return true se contiene solo lettere, altrimenti false
     */
    private boolean checkOnlyLetter(String parola) {
        parola = parola.toLowerCase();
        char[] charArray = parola.toCharArray();
        for (char ch : charArray) {
            if (!(ch >= 'a' && ch <= 'z')) {
                return false;
            }
        }
        return true;
    }

    /**
     * Questo metodo restituisce true se due oggetti di tipo responsabile sono
     * uguali, altrimenti false.
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
        Responsabile that = (Responsabile) o;
        return Objects.equals(idResp, that.idResp);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idResp);
    }

    /**
     * Restituisce la lista dei responsabili
     * presenti nel database in base ai parametri passati come input.
     * Restituisce una lista vuota se non viene trovato nulla.
     * Se tutte le stringe passate come parametro sono nulle, vengono restituiti tutti gli
     * oggetti di tipo resposabile presenti nel database.
     * La ricerca viene effettuata solo per i valori non nulli.
     * Se il parametro in input <code>dupl</code> è true, viene effettuata una ricerca con l'username del responsabile
     * uguale a <code>usernameResponsabile</code>. Se invece è false, vengono cercate le email
     * che contengono <code>usernameResponsabile</code>.
     *
     * @param nomeResp nome del responsabile da cercare
     * @param cognomeResp cognome del responsabile da cercare
     * @param usernameResp email del responsabile da cercare
     * @param dupl true: gli username cercati devono essere uguali a <code>usernameResponsabile</code></code>
     *             false: gli username cercati devono contenere <code>usernameResponsabile</code>
     * @return lista che contiene i responsabili trovati
     */
    public static List<Responsabile> cercaResponsabile(Session session, String nomeResp,
                                                       String cognomeResp, String usernameResp, boolean dupl) {
        List<Responsabile> list = null;
        try {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Responsabile> query = builder.createQuery(Responsabile.class);
            Root<Responsabile> root = query.from(Responsabile.class);
            Predicate[] pr = buildPredicate(builder, root, nomeResp, cognomeResp, usernameResp, dupl);
            if(pr.length > 0) {
                query.select(root).where(pr);
            } else {
                query.select(root).where();
            }
            query.orderBy(builder.asc(root.get("idResp")));
            Query<Responsabile> q = session.createQuery(query);
            list = q.getResultList();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Costruisce in modo dinamico la query di ricerca per i responsabili nel database.
     * Le stringhe non nulle non vengono aggiunte alle query.
     * Se <code>dupl</code> è positivo la query di ricerca per il nome dell'aula
     * utilizza l'operatore AND, altrimenti LIKE.
     *
     * @param builder oggetto usato per costruire le query
     * @param root tipo di entità a cui fa riferimento la radice
     * @param nomeResp nome del responsabile
     * @param cognomeResp cognome del responsabile
     * @param usernameResp username del responsabile
     * @param dupl indica se la ricerca del per il email del responsabile deve utilizzare
     *       l'operatore AND oppure LIKE.
     * @return oggetto predicate che indica con quali restrizioni fare la ricerca
     */
    private static Predicate[] buildPredicate(CriteriaBuilder builder, Root<Responsabile> root, String nomeResp,
                                       String cognomeResp, String usernameResp, boolean dupl) {
        List<Predicate> predicates = new ArrayList<>();
        if(nomeResp != null) {
            Predicate nome;
            nome = builder.like(root.get("nomeResp"), "%" + nomeResp + "%");
            predicates.add(nome);
        }
        if(cognomeResp != null) {
            Predicate cognome;
            cognome = builder.like(root.get("cognomeResp"), "%" + cognomeResp + "%");
            predicates.add(cognome);
        }
        if (usernameResp != null) {
            Predicate username;
            if (dupl) {
                username = builder.equal(root.get("usernameResp"), usernameResp);
            } else {
                username = builder.like(root.get("usernameResp"), "%" + usernameResp + "%");
            }
            predicates.add(username);
        }
        Predicate [] pr = new Predicate[predicates.size()];
        return predicates.toArray(pr);
    }

    /**
     * Controlla se nel database sono già presenti dei responsabili con l'email passata come
     * parametro. Restituisce true se non sono presenti, altrimenti false.
     *
     * @param usernameResp username del responsabile da controllare
     * @return true se non sono già presenti dei responsabili con quella email, altrimenti false.
     */
    public static boolean notContainsDuplicate(Session session, String usernameResp) {
        List<Responsabile> dupEmail = cercaResponsabile(session, null, null, usernameResp, true);

        return dupEmail.size() == 0;
    }
}
