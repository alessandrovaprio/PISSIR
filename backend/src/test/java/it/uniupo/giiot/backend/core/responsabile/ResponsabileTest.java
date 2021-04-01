package it.uniupo.giiot.backend.core.responsabile;

import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.Session;
import org.junit.jupiter.api.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class ResponsabileTest {
    @Test
    @DisplayName("Test Responsabile: Crea Responsabile")
    public void testCrea() {
        try {
            Responsabile resposabile = new Responsabile (1, "Marco", "Rossi", "marco.rossi");
            assertEquals(1, resposabile.getIdResponsabile());
            assertEquals("Marco", resposabile.getNomeResponsabile());
            assertEquals("Rossi", resposabile.getCognomeResponsabile());
            assertEquals("marco.rossi", resposabile.getUsernameResponsabile());
        } catch (DaoException e) {
            fail(e.getMessage(), e);
        }
    }

    @Nested
    @DisplayName("Test Responsabile: Eccezioni Responsabile")
    class testEccezioniResponsabile {
        @Test
        @DisplayName("Test Responsabile: Eccezioni Nome Responsabile")
        void testEccezioniNome() {
            Throwable exception1 = assertThrows(IllegalArgumentException.class,
                    () -> new Responsabile(1, "Marco231", "Rossi", "marco.rossi"));

            String strTest1 = "ERRORE! Il nome del responsabile deve contenere solo lettere";
            assertEquals(strTest1, exception1.getMessage());

            Throwable exception2 = assertThrows(DaoException.class,
                    () -> new Responsabile(1, null, "Rossi", "marco.rossi"));

            String strTest2 = "ERRORE! Inserito un valore nullo";
            assertEquals(strTest2, exception2.getMessage());

            Throwable exception3 = assertThrows(DaoException.class,
                    () -> new Responsabile(1, "", "Rossi", "marco.rossi"));

            String strTest3 = "ERRORE! Inserita una stringa vuota";
            assertEquals(strTest3, exception3.getMessage());
        }

        @Test
        @DisplayName("Test Responsabile: Eccezioni Cognome Responsabile")
        void testEccezioniCognome() {
            Throwable exception1 = assertThrows(IllegalArgumentException.class,
                    () -> new Responsabile(1, "Marco", "Ros23si", "marco.rossi"));

            String strTest1 = "ERRORE! Il cognome del responsabile deve contenere solo lettere";
            assertEquals(strTest1, exception1.getMessage());

            Throwable exception2 = assertThrows(DaoException.class,
                    () -> new Responsabile(1, "Marco", null, "marco.rossi"));

            String strTest2 = "ERRORE! Inserito un valore nullo";
            assertEquals(strTest2, exception2.getMessage());

            Throwable exception3 = assertThrows(DaoException.class,
                    () -> new Responsabile(1, "Marco", "", "marco.rossi"));

            String strTest3 = "ERRORE! Inserita una stringa vuota";
            assertEquals(strTest3, exception3.getMessage());
        }
        @Test
        @DisplayName("Test Responsabile: Eccezioni Username Responsabile")
        void testEccezioniEmail() {
            Throwable exception4 = assertThrows(DaoException.class,
                    () -> new Responsabile(1, "Marco", "Rossi", null));

            String strTest4 = "ERRORE! Inserito un valore nullo";
            assertEquals(strTest4, exception4.getMessage());

            Throwable exception5 = assertThrows(DaoException.class,
                    () -> new Responsabile(1, "Marco", "Rossi", ""));

            String strTest5 = "ERRORE! Inserita una stringa vuota";
            assertEquals(strTest5, exception5.getMessage());
        }
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Test Responsabile: Ricerca Responsabile")
    class testCercaResp {
        Session session = HibernateUtil.getSessionFactory().openSession();
        //Resposabile 1
        Responsabile responsabile1;
        String nomeResp = "Marco";
        String cognomeResp = "Rossi";
        String usernameResp = "marco.rossi";
        //Resposabile 2
        Responsabile responsabile2;
        String nomeResp2 = "Giacomo";
        String cognomeResp2 = "Bianchi";
        String usernameResp2 = "giacomo.bianchi";
        //Responsabile 3
        Responsabile responsabile3;
        String nomeResp3 = "Daniele";
        String cognomeResp3 = "Bianchini";
        String usernameResp3 = "daniele.bianchini";
        //Responsabile4
        Responsabile responsabile4;
        String nomeResp4 = "Marco";
        String cognomeResp4 = "Balsamo";
        String usernameResp4 = "marco.balsamo";

        @BeforeAll
        public void init() {
            session.beginTransaction();
            try {
                int idResp = HibernateUtil.insertWithIntegerPk(session, new Responsabile(nomeResp, cognomeResp, usernameResp));
                this.responsabile1 = HibernateUtil.getWithIntegerPk(session, Responsabile.class, idResp);
                int idResp2 = HibernateUtil.insertWithIntegerPk(session, new Responsabile(nomeResp2, cognomeResp2, usernameResp2));
                this.responsabile2 = HibernateUtil.getWithIntegerPk(session, Responsabile.class, idResp2);
                int idResp3 = HibernateUtil.insertWithIntegerPk(session, new Responsabile(nomeResp3, cognomeResp3, usernameResp3));
                this.responsabile3 = HibernateUtil.getWithIntegerPk(session, Responsabile.class, idResp3);
                int idResp4 = HibernateUtil.insertWithIntegerPk(session, new Responsabile(nomeResp4, cognomeResp4, usernameResp4));
                this.responsabile4 = HibernateUtil.getWithIntegerPk(session, Responsabile.class, idResp4);
            }  catch (DaoException e) {
                fail(e.getMessage(), e);
            }
        }

        @Test
        @DisplayName("Test Responsabile: Ricerca Esatta")
        public void testRicercaEsattaResp() {
            List<Responsabile> risultati = Responsabile.cercaResponsabile(session, nomeResp2, cognomeResp2, usernameResp2, false);
            assertEquals(1, risultati.size());
            assertEquals(responsabile2, risultati.get(0));

            risultati = Responsabile.cercaResponsabile(session, nomeResp4, cognomeResp4, null, false);
            assertEquals(1, risultati.size());
            assertEquals(responsabile4, risultati.get(0));

            risultati = Responsabile.cercaResponsabile(session, nomeResp2, null, null, false);
            assertEquals(1, risultati.size());
            assertEquals(responsabile2, risultati.get(0));
        }

        @Test
        @DisplayName("Test Responsabile: Ricerca Parziale")
        public void testRicercaParzialeAula() {
            List<Responsabile> risultati =
                    Responsabile.cercaResponsabile(session, nomeResp4, null, null, false);
            assertEquals(2, risultati.size());

            risultati = Responsabile.cercaResponsabile(session,null, cognomeResp2, null, false);
            assertEquals(2, risultati.size());

            risultati = Responsabile.cercaResponsabile(session,null, null, usernameResp4, false);
            assertEquals(1, risultati.size());
        }

        @Test
        @DisplayName("Test Responsabile: Ricerca Tutti")
        public void testCercaTuttiAula() {
            List<Responsabile> risultati =
                    Responsabile.cercaResponsabile(session,null, null, null, false);

            assertTrue(risultati.contains(responsabile1));
            assertTrue(risultati.contains(responsabile2));
            assertTrue(risultati.contains(responsabile3));
            assertTrue(risultati.contains(responsabile4));
        }

        @Test
        @DisplayName("Test Responsabile: Ricerca Duplicati")
        public void testCercaDuplicati() {
            assertFalse(Responsabile.notContainsDuplicate(session, usernameResp));
            assertTrue(Responsabile.notContainsDuplicate(session, "noDuplicato@fasfd.it"));
        }

        @AfterAll
        public void cleanRecords() {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaDelete<Responsabile> criteriaDelete = builder.createCriteriaDelete(Responsabile.class);
            criteriaDelete.from(Responsabile.class);
            session.createQuery(criteriaDelete).executeUpdate();
            session.getTransaction().commit();
            session.close();
        }
    }
}
