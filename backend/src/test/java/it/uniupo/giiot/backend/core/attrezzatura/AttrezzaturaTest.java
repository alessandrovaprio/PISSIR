package it.uniupo.giiot.backend.core.attrezzatura;

import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.junit.jupiter.api.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class AttrezzaturaTest {

    @Test
    @DisplayName("Test Attrezzatura: Crea")
    public void testCrea() {
        Attrezzatura attrezzatura = new Attrezzatura(1, "Lavagna");
        assertEquals(1, attrezzatura.getIdAttrezzatura());
        assertEquals("Lavagna", attrezzatura.getNomeAttrezzatura());
    }

    @Test
    @DisplayName("Test Attrezzatura: Crea con Eccezione")
    public void testCreaEccezione() {
        Assertions.assertThrows(IllegalArgumentException.class, () -> new Attrezzatura(1, ""));
    }

    @Test
    @DisplayName("Test Attrezzatura: Equals")
    void testEquals() {
        Attrezzatura attrezzatura1 = new Attrezzatura(1, "Lavagna");
        Attrezzatura attrezzatura2 = new Attrezzatura(1, "Lavagna");
        Attrezzatura attrezzatura3 = new Attrezzatura(3, "Lavagna");
        Attrezzatura attrezzatura4 = new Attrezzatura(1, "Proiettore");
        Attrezzatura attrezzatura5 = new Attrezzatura(5, "Computer");

        Assertions.assertEquals(attrezzatura2, attrezzatura1);
        assertNotEquals(attrezzatura3, attrezzatura1);
        assertEquals(attrezzatura4, attrezzatura1);
        assertNotEquals(attrezzatura5, attrezzatura1);
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Test Cerca Attrezzatura")
    class testCercaAttrezzatura {
        Session session = HibernateUtil.getSessionFactory().openSession();
        String check = "ProvaAERDDFRFGF";
        String check2 = "ProvaERTFG";
        String check3 = "Prova";
        String check4 = "TestASDFSF";
        List<Attrezzatura> risultati;
        int id1;
        int id2;
        int id4;

        @BeforeAll
        public void init() {
            session.beginTransaction();
            try {
                id1 = HibernateUtil.insertWithIntegerPk(session, new Attrezzatura(check));
                id2 = HibernateUtil.insertWithIntegerPk(session, new Attrezzatura(check2));
                id4 = HibernateUtil.insertWithIntegerPk(session, new Attrezzatura(check4));
            } catch (DaoException e) {
                session.close();
                fail(e.getMessage(), e);
            }

        }

        @AfterAll
        public void cleanTable(){
            session.close();
            Session session2 = HibernateUtil.getSessionFactory().openSession();
            CriteriaBuilder builder = session2.getCriteriaBuilder();
            CriteriaDelete<Attrezzatura> criteriaDelete = builder.createCriteriaDelete(Attrezzatura.class);
            criteriaDelete.from(Attrezzatura.class);
            Transaction tx = session2.beginTransaction();
            session2.createQuery(criteriaDelete).executeUpdate();
            tx.commit();
            session2.close();
        }

        @Test
        @DisplayName("Test Ricerca Esatta")
        public void testRicercaEsatta() {
            List<Attrezzatura> risultati = Attrezzatura.cercaAttrezzatura(session, check, false);
            assertEquals(1, risultati.size());
            assertEquals(check, risultati.get(0).getNomeAttrezzatura());
        }

        @Test
        @DisplayName("Test Ricerca Parziale")
        public void testRicercaParziale() {
            risultati = Attrezzatura.cercaAttrezzatura(session, check3, false);
            assertEquals(2, risultati.size());
        }

        @Test
        @DisplayName("Test Ricerca Tutti")
        public void testRicercaTutti() throws DaoException {
            risultati = Attrezzatura.cercaAttrezzatura(session,null, false);
            assertTrue(risultati.contains(HibernateUtil.getWithIntegerPk(session, Attrezzatura.class, id1)));
            assertTrue(risultati.contains(HibernateUtil.getWithIntegerPk(session, Attrezzatura.class, id2)));
            assertTrue(risultati.contains(HibernateUtil.getWithIntegerPk(session, Attrezzatura.class, id4)));
        }
    }
}