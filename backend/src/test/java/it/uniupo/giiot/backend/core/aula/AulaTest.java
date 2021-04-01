package it.uniupo.giiot.backend.core.aula;

import it.uniupo.giiot.backend.core.attrezzatura.Attrezzatura;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.Session;
import org.junit.jupiter.api.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class AulaTest {

    @Test
    @DisplayName("Test Aula: Crea Aula")
    public void testCrea() {
        Aula aula = new Aula(1, "Prova", 50, 4);
        assertEquals(1, aula.getIdAula());
        assertEquals("Prova", aula.getNomeAula());
        assertEquals(50, aula.getCapienzaMax());
        assertEquals(4, aula.getCapienzaMin());
    }

    @Nested
    @DisplayName("Test Aula: Attrezzature Aule")
    class testAttrezzatura {
        Aula aula = new Aula(1, "Prova", 50, 4);
        Attrezzatura attrezzatura1 = new Attrezzatura(1,"Lavagna");
        Attrezzatura attrezzatura2 = new Attrezzatura(2,"Proiettore");
        Attrezzatura attrezzatura3 = new Attrezzatura(3,"Computer");

        @Test
        @DisplayName("Test Aula: Aggiungi Attrezzature Aule")
        public void testAggiungiAttrezzatura() {
            try {
                aula.aggiungiAttrezzatura(attrezzatura1);
                aula.aggiungiAttrezzatura(attrezzatura2);
                aula.aggiungiAttrezzatura(attrezzatura3);
            } catch (DaoException | IllegalArgumentException e) {
                fail(e.getMessage(), e);
            }

            assertEquals(3, aula.getAttrezzature().size());
            assertEquals(attrezzatura1, aula.getAttrezzature().get(0));
            assertEquals(attrezzatura2, aula.getAttrezzature().get(1));
            assertEquals(attrezzatura3, aula.getAttrezzature().get(2));
        }

        @Test
        @DisplayName("Test Aula: Rimuovi Attrezzature Aule")
        public void testRimuoviAttrezzatura() {
            try {
                aula.aggiungiAttrezzatura(attrezzatura1);
                aula.aggiungiAttrezzatura(attrezzatura2);
                aula.aggiungiAttrezzatura(attrezzatura3);
                aula.rimuoviAttrezzatura(attrezzatura2);
            } catch (DaoException | IllegalArgumentException e) {
                fail(e.getMessage(), e);
            }
            assertEquals(2, aula.getAttrezzature().size());
            assertEquals(attrezzatura1, aula.getAttrezzature().get(0));
            assertEquals(attrezzatura3, aula.getAttrezzature().get(1));
        }

        @Test
        @DisplayName("Test Aula: Attrezzature Multiple Aule")
        public void testAggiungiAttrezzaturaMultiple() {
            assertEquals(0, aula.getAttrezzature().size());
            ArrayList<Attrezzatura> attrezzature = new ArrayList<>();
            attrezzature.add(attrezzatura1);
            attrezzature.add(attrezzatura2);
            attrezzature.add(attrezzatura3);

            aula.setAttrezzature(attrezzature);
            assertEquals(3, aula.getAttrezzature().size());
            assertEquals(attrezzatura1, aula.getAttrezzature().get(0));
            assertEquals(attrezzatura2, aula.getAttrezzature().get(1));
            assertEquals(attrezzatura3, aula.getAttrezzature().get(2));
        }

        @Nested
        @DisplayName("Test Aula: Eccezioni Attrezzature Aule")
        class testEccezioniAttrezzatura {
            @Test
            @DisplayName("Test Aula: Eccezioni Aggiungi Attrezzature Aule")
            public void testEccezioniAddAttrezzature() {
                assertThrows(IllegalArgumentException.class,
                        () -> aula.aggiungiAttrezzatura(null));
                try {
                    aula.aggiungiAttrezzatura(attrezzatura1);
                } catch (DaoException | IllegalArgumentException e) {
                    fail(e.getMessage(), e);
                }
                assertThrows(DaoException.class, () -> aula.aggiungiAttrezzatura(attrezzatura1));
            }

            @Test
            @DisplayName("Test Aula: Eccezioni Rimuovi Attrezzature Aule")
            public void testEccezioniRimuoviAttrezzature() {
                assertThrows(IllegalArgumentException.class, () -> aula.rimuoviAttrezzatura(null));
                assertThrows(DaoException.class, () -> aula.rimuoviAttrezzatura(attrezzatura1));
            }
        }
    }

    @Test
    @DisplayName("Test Aula: Eccezioni Capienza Minima Aula")
    void testEccezioniCapienzaMinima() {
        Throwable exception1 = assertThrows(IllegalArgumentException.class,
                () -> new Aula(1, "Prova", 50, -4));

        String strTest1 = "Inserito un valore minore di 0. La capienza minima non può essere minore di zero";
        assertEquals(strTest1, exception1.getMessage());

        Throwable exception2 = assertThrows(IllegalArgumentException.class, () -> new Aula(1, "Prova", 50, 60));

        String strTest2 = "La capienza minima dell'aula, non può essere maggiore della capienza massima";
        assertEquals(strTest2, exception2.getMessage());
    }

    @Test
    @DisplayName("Test Aula: Eccezioni Capienza Massima Aula")
    void testEccezioniCapienzaMax() {
        Throwable exception1 = assertThrows(IllegalArgumentException.class,
                () -> new Aula(1, "Prova", -50, 5));

        Aula aula = new Aula(1, "Prova", 50, 4);

        String strTest1 = "Inserito un valore minore di " + aula.MIN_CAPACITY +
                ". La capienza massima non può essere minore di " +  aula.MIN_CAPACITY;
        assertEquals(strTest1, exception1.getMessage());
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Test Aula: Ricerca Aule")
    class testCercaAula {
        Session session = HibernateUtil.getSessionFactory().openSession();
        //Aula 1
        Aula aulaTest1;
        String nomeAula1 = "Laboratorio Informatica";
        int capMax1 = 120;
        int capMin1 = 20;
        //Aula 2
        Aula aulaTest2;
        String nomeAula2 = "Aula 3B";
        int capMax2 = 120;
        int capMin2 = 10;
        //Aula 3
        Aula aulaTest3;
        String nomeAula3 = "Aula Magna";
        int capMax3 = 20;
        int capMin3 = 5;

        @BeforeAll
        public void init() {
            session.beginTransaction();
            try {
                int idAula1 = HibernateUtil.insertWithIntegerPk(session, new Aula(nomeAula1, capMax1, capMin1));
                this.aulaTest1 = HibernateUtil.getWithIntegerPk(session, Aula.class, idAula1);
                int idAula2 = HibernateUtil.insertWithIntegerPk(session, new Aula(nomeAula2, capMax2, capMin2));
                this.aulaTest2 = HibernateUtil.getWithIntegerPk(session, Aula.class, idAula2);
                int idAula3 = HibernateUtil.insertWithIntegerPk(session, new Aula(nomeAula3, capMax3, capMin3));
                this.aulaTest3 = HibernateUtil.getWithIntegerPk(session, Aula.class, idAula3);
            } catch (DaoException e) {
                fail(e.getMessage(), e);
            }
        }

        @Test
        @DisplayName("Test Aula: Ricerca Esatta")
        public void testRicercaEsattaAula() {
            List<Aula> risultati = Aula.cercaAula(session, nomeAula2, capMax2, capMin2, false);
            assertEquals(1, risultati.size());
            assertEquals(aulaTest2, risultati.get(0));

            risultati = Aula.cercaAula(session, nomeAula2, capMax2, null, false);
            assertEquals(1, risultati.size());
            assertEquals(aulaTest2, risultati.get(0));

            risultati = Aula.cercaAula(session, nomeAula2, null, null, false);
            assertEquals(1, risultati.size());
            assertEquals(aulaTest2, risultati.get(0));
        }

        @Test
        @DisplayName("Test Aula: Ricerca Parziale")
        public void testRicercaParzialeAula() {
            String check = "Aula";
            List<Aula> risultati = Aula.cercaAula(session, check, null, null, false);
            assertEquals(2, risultati.size());
            assertFalse(risultati.contains(aulaTest1));
            assertTrue(risultati.contains(aulaTest2));
            assertTrue(risultati.contains(aulaTest3));

            risultati = Aula.cercaAula(session,null, capMax1, null, false);
            assertEquals(2, risultati.size());
            assertTrue(risultati.contains(aulaTest1));
            assertTrue(risultati.contains(aulaTest2));
            assertFalse(risultati.contains(aulaTest3));

            risultati = Aula.cercaAula(session,null, null, capMin3, false);
            assertEquals(1, risultati.size());
            assertFalse(risultati.contains(aulaTest1));
            assertFalse(risultati.contains(aulaTest2));
            assertTrue(risultati.contains(aulaTest3));
        }

        @Test
        @DisplayName("Test Aula: Ricerca Tutti")
        public void testCercaTuttiAula() {
            List<Aula> risultati = Aula.cercaAula(session, null, null, null, false);

            assertTrue(risultati.contains(aulaTest1));
            assertTrue(risultati.contains(aulaTest2));
            assertTrue(risultati.contains(aulaTest3));
        }

        @Test
        @DisplayName("Test Aula: Ricerca Duplicati")
        public void testCercaDuplicati() {
            assertFalse(Aula.notContainsDuplicates(session, nomeAula1, capMax1, capMin1));
            assertTrue(Aula.notContainsDuplicates(session, "duplicato", capMax1, capMin1));
        }

        @AfterAll
        public void cleanRecords() {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaDelete<Aula> criteriaDelete = builder.createCriteriaDelete(Aula.class);
            criteriaDelete.from(Aula.class);
            session.createQuery(criteriaDelete).executeUpdate();
            session.getTransaction().commit();
            session.close();
        }
    }
}