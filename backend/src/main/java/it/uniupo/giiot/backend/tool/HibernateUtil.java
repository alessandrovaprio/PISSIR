package it.uniupo.giiot.backend.tool;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

/**
 * Implementa metodi di utilità per la gestione delle sessioni di Hibernate.
 */
public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    /**
     * Costruisce la SessionFactory di Hibernate, dopo aver configurato i ServiceRegistry e il modello dei
     * metadata.
     *
     * @return la SessionFactory configurata.
     */
    private static SessionFactory buildSessionFactory() {
        try {
            StandardServiceRegistry standardRegistry = new StandardServiceRegistryBuilder()
                    .configure("hibernate.cfg.xml").build();
            Metadata metadata = new MetadataSources(standardRegistry).getMetadataBuilder().build();
            return metadata.getSessionFactoryBuilder().build();

        } catch (HibernateException he) {
            System.out.println("Session Factory creation failure");
            throw he;
        }
    }

    /**
     * Restituisce la SessionFactory di Hibernate.
     *
     * @return la SessionFactory di Hibernate
     */
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    /**
     * Restituisce sessione corrente della SessionFactory di Hibernate.
     * @return
     */
    public static Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Inserisce l'oggetto passato e ne ritorna la chiave primaria come <code>Integer</code>
     * @param session la sessione da utilizzare per l'inserimento
     * @param object l'oggetto da inserire
     * @return la chiave primaria dell'oggetto, se viene inserito; <code>null</code> altrimenti
     */
    public static Integer insertWithIntegerPk(Session session, Object object) throws DaoException {
        Integer pk;
        try {
            pk = (Integer) session.save(object);
        } catch (HibernateException | IllegalArgumentException e) {
            throw new DaoException(e.getMessage(), e);
        }
        return pk;
    }

    /**
     * Estrae l'oggetto con la chiave primaria passata
     * @param session la sessione da utilizzare per l'estrazione
     * @param clazz il tipo di oggetto
     * @param pk la chiave primaria
     * @return l'oggetto, se viene estratto con successo; <code>null</code> altrimenti
     */
    public static <T> T getWithIntegerPk(Session session, Class<T> clazz, int pk) throws DaoException {
        T o;
        try {
            o = session.get(clazz, pk);
        } catch (HibernateException e) {
            throw new DaoException(e.getMessage(), e);
        }
        return o;
    }
}
