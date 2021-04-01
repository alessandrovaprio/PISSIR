package it.uniupo.giiot.backend.core.dispositivo;

import it.uniupo.giiot.backend.core.aula.Aula;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.Session;
import org.junit.jupiter.api.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class DispositivoTest {
    private final Aula aula = new Aula(1, "Prova", 50, 4);
    private final String nomeDispositivo = "Pico";
    private final String marcaDispositivo = "Raspberry Pi";
    private final LocalDate dataInstallazione = LocalDate.of(2020, 12, 1);


    @Test
    @DisplayName("Test Dispositivo: Crea Dispositivo")
    public void testCrea() {
        try{
            Dispositivo dispositivo = new Dispositivo(1, aula, "Pico",
                    "Raspberry Pi", dataInstallazione );
            assertEquals(1, dispositivo.getIdDispositivo());
            assertEquals(aula, dispositivo.getAulaDispositivo());
            assertEquals("Pico", dispositivo.getNomeDispositivo());
            assertEquals("Raspberry Pi", dispositivo.getMarcaDispositivo());
            assertEquals(dataInstallazione, dispositivo.getDataInstallazione());
        } catch (DaoException e) {
            fail(e.getMessage(), e);
        }

    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Evento: Test Eccezioni")
    public class testEccezioni {
        @Test
        @DisplayName("Test Dispositivo: Eccezione Nome")
        void testEccezioneNome() {
            Throwable exception = assertThrows(DaoException.class,
                    () -> new Dispositivo(aula, null, marcaDispositivo, dataInstallazione));

            String strTest = "DISPOSITIVO: il nome del dispositivo inserito è null";
            assertEquals(strTest, exception.getMessage());
        }

        @Test
        @DisplayName("Test Dispositivo: Eccezione Data")
        void testEccezioneData() {
            Throwable exception = assertThrows(DaoException.class,
                    () -> new Dispositivo(aula, nomeDispositivo, marcaDispositivo, null));

            String strTest = "DISPOSITIVO: la data d'installazione del dispositivo inserito è null";
            assertEquals(strTest, exception.getMessage());
        }
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Test Dispositivo: Ricerca Dispositivo")
    class testCercaAula {
        Session session;
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
        //Dispositivo 1
        int idDispositivo1;
        Dispositivo dispositivoTest1;
        //Dispositivo 2
        int idDispositivo2;
        Dispositivo dispositivoTest2;
        String nomeDispositivo2 = "4";
        LocalDate dataInstallazione2 = LocalDate.of(2021, 3, 12);
        //Dispositivo 3
        int idDispositivo3;
        Dispositivo dispositivoTest3;
        String nomeDispositivo3 = "Prime";
        String marcaDispositivo3 = "Orange";
        LocalDate dataInstallazione3 = LocalDate.of(2021, 4, 1);

        @BeforeAll
        public void init() {
            this.session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            try {
                int idAula1 = HibernateUtil.insertWithIntegerPk(session, new Aula(nomeAula1, capMax1, capMin1));
                this.aulaTest1 = HibernateUtil.getWithIntegerPk(session, Aula.class, idAula1);
                int idAula2 = HibernateUtil.insertWithIntegerPk(session, new Aula(nomeAula2, capMax2, capMin2));
                this.aulaTest2 = HibernateUtil.getWithIntegerPk(session, Aula.class, idAula2);
                int idAula3 = HibernateUtil.insertWithIntegerPk(session, new Aula(nomeAula3, capMax3, capMin3));
                this.aulaTest3 = HibernateUtil.getWithIntegerPk(session, Aula.class, idAula3);

                this.idDispositivo1 = HibernateUtil.insertWithIntegerPk(session, new Dispositivo(
                        HibernateUtil.getWithIntegerPk(session, Aula.class, idAula1), nomeDispositivo, marcaDispositivo, dataInstallazione));
                this.dispositivoTest1 = HibernateUtil.getWithIntegerPk(session, Dispositivo.class, idDispositivo1);
                this.idDispositivo2 = HibernateUtil.insertWithIntegerPk(session, new Dispositivo(
                        aulaTest2, nomeDispositivo2, marcaDispositivo, dataInstallazione2));
                this.dispositivoTest2 = HibernateUtil.getWithIntegerPk(session, Dispositivo.class, idDispositivo2);
                this.idDispositivo3 = HibernateUtil.insertWithIntegerPk(session, new Dispositivo(
                        aulaTest3, nomeDispositivo3, marcaDispositivo3, dataInstallazione3));
                this.dispositivoTest3 = HibernateUtil.getWithIntegerPk(session, Dispositivo.class, idDispositivo3);
            } catch (DaoException e) {
                fail(e.getMessage(), e);
            }
        }

        @Test
        @DisplayName("Test Dispositivo: Ricerca Esatta")
        public void testRicercaEsattaDispositivo() {
            List<Dispositivo> risultati = Dispositivo.cercaDispositivo(session, aulaTest2, nomeDispositivo2, marcaDispositivo, dataInstallazione2);
            assertEquals(1, risultati.size());
            assertEquals(dispositivoTest2, risultati.get(0));
        }

        @Test
        @DisplayName("Test Dispositivo: Ricerca Parziale")
        public void testRicercaParzialeDispositivo() {
            String check = "Raspberry Pi";
            List<Dispositivo> risultati = Dispositivo.cercaDispositivo(session, null, null, check, null);
            assertEquals(2, risultati.size());
            assertTrue(risultati.contains(dispositivoTest1));
            assertTrue(risultati.contains(dispositivoTest2));
        }

        @Test
        @DisplayName("Test Dispositivo: Ricerca Tutti")
        public void testCercaTuttiDispositivo() {
            List<Dispositivo> risultati = Dispositivo.cercaDispositivo(session, null, null, null, null);

            assertTrue(risultati.contains(dispositivoTest1));
            assertTrue(risultati.contains(dispositivoTest2));
            assertTrue(risultati.contains(dispositivoTest3));
        }

        @AfterAll
        public void cleanRecords() {
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaDelete<Dispositivo> criteriaDeleteDisp = builder.createCriteriaDelete(Dispositivo.class);
            criteriaDeleteDisp.from(Dispositivo.class);
            CriteriaDelete<Aula> criteriaDeleteAula = builder.createCriteriaDelete(Aula.class);
            criteriaDeleteAula.from(Aula.class);
            session.createQuery(criteriaDeleteDisp).executeUpdate();
            session.createQuery(criteriaDeleteAula).executeUpdate();
            session.getTransaction().commit();
            session.close();
        }
    }



}