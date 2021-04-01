package it.uniupo.giiot.backend.core.evento;

import it.uniupo.giiot.backend.core.aula.Aula;
import it.uniupo.giiot.backend.core.responsabile.Responsabile;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;
import org.hibernate.Session;
import org.junit.jupiter.api.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class EventoTest {
    //Responsabile
    private Responsabile resp;
    String nomeResp = "Alfredo";
    String cognomeResp = "Rossi";
    String emailResp = "alfredo.rossi@email.it";
    //Aula
    String nomeAula = "Aula 3B";
    int maxCp = 30;
    int minCp = 5;
    private final Aula aula = new Aula(1, nomeAula, maxCp, minCp);
    //Evento
    private final String nomeEvento = "Lezione Prova";
    private final String tipoEvento = "Lezione";
    private final LocalDate dataInizio = LocalDate.of(2020, 12, 1);
    private final LocalTime oraInizio = LocalTime.of(12,30,0);
    private final LocalDateTime dataOraInizio = LocalDateTime.of(dataInizio, oraInizio);
    private final LocalDate dataFine = LocalDate.of(2021, 1, 12);
    private final LocalTime oraFine = LocalTime.of(12, 40, 0);
    private final LocalDateTime dataOraFine = LocalDateTime.of(dataFine, oraFine);

    private LocalDateTime dataOra(LocalDate data, LocalTime ora) {
        return LocalDateTime.of(data, ora);
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Evento: Creazione")
    public class testCrea {
        @BeforeAll
        public void init() throws DaoException {
            resp = new Responsabile(1, "Marco", "Rossi", "marco.rossi@email.it");
        }

        @Test
        @DisplayName("Test Creazione: Max Partecipanti")
        public void testCostruttoreMaxPart() {
            Evento evento;
            try {
                evento = new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, dataOraFine);
                assertEquals(resp, evento.getRespEvento());
                assertEquals(aula, evento.getAulaEvento());
                assertEquals(nomeEvento, evento.getNomeEvento());
                assertEquals(tipoEvento, evento.getTipoEvento());
                assertEquals(evento.DEFAULT_INT_MIN, evento.getnPresenti());
                assertEquals(evento.GRAD_RIEMP_AULA_MAX, evento.getGradoRiempAula());
                assertEquals(evento.DEFAULT_INT_MIN, evento.getMaxPresenti());
                assertEquals(dataOraInizio, evento.getDataOraInizio());
                assertEquals(dataOraFine, evento.getDataOraFine());
            } catch (DaoException e) {
                fail(e.getMessage(), e);
            }
        }

        @Test
        @DisplayName("Test Creazione: Test Grado Riempimento Aula")
        public void testCostruttoreGradRiemp() {
            Evento evento;
            try {
                double gradRiempAula = 0.6;
                evento = new Evento(resp, aula, nomeEvento, tipoEvento, gradRiempAula, dataOraInizio, dataOraFine);
                assertEquals(resp, evento.getRespEvento());
                assertEquals(aula, evento.getAulaEvento());
                assertEquals(nomeEvento, evento.getNomeEvento());
                assertEquals(tipoEvento, evento.getTipoEvento());
                assertEquals((int)(gradRiempAula * aula.getCapienzaMax()), evento.getMaxPartecipanti());
                assertEquals(evento.DEFAULT_INT_MIN, evento.getnPresenti());
                assertEquals(gradRiempAula, evento.getGradoRiempAula());
                assertEquals(evento.DEFAULT_INT_MIN, evento.getMaxPresenti());
                assertEquals(dataOraInizio, evento.getDataOraInizio());
                assertEquals(dataOraFine, evento.getDataOraFine());
            } catch (DaoException e) {
                fail(e.getMessage(), e);
            }
        }
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Evento: Test Eccezioni")
    public class testEccezioni{

        @BeforeAll
        public void init() throws DaoException {
            resp = new Responsabile(1, "Marco", "Rossi", "marco.rossi@email.it");
        }

        @Test
        @DisplayName("Test Eccezioni: Responsabile Null")
        public void testEccezioneRespNull() {
            Throwable exception = assertThrows(DaoException.class,
                    () -> new Evento(null, aula, nomeEvento, tipoEvento, dataOraInizio, dataOraFine));

            String strTest = "EVENTO: Il responsabile inserito è null";
            assertEquals(strTest, exception.getMessage());
        }

        @Test
        @DisplayName("Test Eccezioni: Aula Null")
        public void testEccezioneAulaNull() {
            Throwable exception = assertThrows(DaoException.class,
                    () -> new Evento(resp, null, nomeEvento, tipoEvento, dataOraInizio, dataOraFine));

            String strTest = "EVENTO: L'aula inserita è null";
            assertEquals(strTest, exception.getMessage());
        }

        @Nested
        @DisplayName("Test Eccezioni: Eccezione Grado Riempimento Aula")
        public class testEccezioniGradoRiempAula {

            @Test
            @DisplayName("Eccezione Grado Riempimento Aula: Minimo")
            public void testEccGradoRiempAulaMin() {
                double gradRiempAulaMinEcc = -30;
                double GRAD_RIEMP_AULA_MIN = 0;
                String strTest = "GRADO RIEMPIMENTO AULA: inserito un valore minore di " + GRAD_RIEMP_AULA_MIN + ".";

                Throwable exception = assertThrows(DaoException.class,
                        () -> new Evento(resp, aula, nomeEvento, tipoEvento,gradRiempAulaMinEcc, dataOraInizio, dataOraFine));
                assertEquals(strTest, exception.getMessage());
            }

            @Test
            @DisplayName("Eccezione Grado Riempimento Aula: Massimo")
            public void testEccGradoRiempAulaMax() {
                double gradRiempAulaMaxEcc = 30;
                double GRAD_RIEMP_AULA_MAX = 1;
                String strTest = "GRADO RIEMPIMENTO AULA: inserito un valore maggiore di " + GRAD_RIEMP_AULA_MAX + ".";

                Throwable exception = assertThrows(DaoException.class,
                        () -> new Evento(resp, aula, nomeEvento, tipoEvento, gradRiempAulaMaxEcc, dataOraInizio, dataOraFine));
                assertEquals(strTest, exception.getMessage());
            }
        }

        @Test
        @DisplayName("Test Eccezioni: Eccezione N Presenti")
        public void testEccezioniNPresenti() throws DaoException {
            int nPresentiEcc = -30;

            Evento evento = new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, dataOraFine);

            Throwable exception = assertThrows(DaoException.class,
                    () -> evento.setNPresenti(nPresentiEcc));

            int N_PRESENTI_MIN = 0;

            String strTest = "NUMERO DI PRESENTI: inserito un valore minore di " + N_PRESENTI_MIN + ".";
            assertEquals(strTest, exception.getMessage());
        }

        @Nested
        @TestInstance(TestInstance.Lifecycle.PER_CLASS)
        @DisplayName("Test Eccezioni: Eccezione Data Ora")
        public class testEccezioniDataOra {

            @BeforeAll
            public void init() throws DaoException {
                resp = new Responsabile(1, "Marco", "Rossi", "marco.rossi@email.it");
            }

            @Test
            @DisplayName("Eccezione Data Ora: Creazione Evento con Data Fine Pre Inizio")
            public void testEccDataFinePre() {
                LocalDate dataFine = LocalDate.of(1994, 1, 12);
                LocalTime oraFine = LocalTime.of(12, 30, 0);
                LocalDateTime dataFineEcc = LocalDateTime.of(dataFine, oraFine);
                String strTest = "DATA ORA FINE: Inserita una data o ora di fine evento precedente alla data d'inizio";

                Throwable exception = assertThrows(DaoException.class,
                        () -> new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, dataFineEcc));
                assertEquals(strTest, exception.getMessage());
            }

            @Test
            @DisplayName("Eccezione Data Ora: Creazione Evento con Ora Fine Pre Inizio")
            public void testEccOraFine() {
                LocalDate dataFine = LocalDate.of(2020, 12, 1);
                LocalTime oraFine = LocalTime.of(11, 30, 0);
                LocalDateTime oraFineEcc = LocalDateTime.of(dataFine, oraFine);
                String strTest = "DATA ORA FINE: Inserita una data o ora di fine evento precedente alla data d'inizio";

                Throwable exception = assertThrows(DaoException.class,
                        () -> new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, oraFineEcc));
                assertEquals(strTest, exception.getMessage());
            }

            @Nested
            @DisplayName("Eccezione Data Ora: Modifica")
            public class testDataOraModifica {

                @Nested
                @DisplayName("Modifica Inizio Evento")
                @TestInstance(TestInstance.Lifecycle.PER_CLASS)
                public class modificaInizio {
                    LocalDate dataInizioT;
                    LocalTime oraInizioT;
                    LocalDateTime inizio;
                    Evento evento;

                    @BeforeAll
                    public void init() throws DaoException {
                        dataInizioT = dataFine;
                        oraInizioT = LocalTime.of(11, 30, 0);
                        inizio = LocalDateTime.of(dataInizioT, oraInizioT);
                        evento = new Evento(resp, aula, nomeEvento, tipoEvento, inizio, dataOraFine);
                    }

                    @Test
                    @DisplayName("Modifica Inizio Evento: Ora Inizio Dopo Fine")
                    public void testEccEditOraInizio() {
                        String strTest = "DATA ORA INIZIO: Inserita una data o ora d'inizio evento successiva alla data di fine";
                        LocalTime oraInizioEcc = LocalTime.of(23, 30, 0);
                        LocalDateTime inizioEcc = LocalDateTime.of(dataInizioT, oraInizioEcc);

                        Throwable exception = assertThrows(DaoException.class,
                                () -> evento.modificaDataOraInizio(inizioEcc));
                        assertEquals(strTest, exception.getMessage());
                    }

                    @Test
                    @DisplayName("Modifica Inizio Evento: Data Inizio Dopo Fine")
                    public void testEccEditDataInizio() {
                        LocalDate dataInizioEcc = LocalDate.of(2100, 12, 1);
                        LocalDateTime inizioEcc = LocalDateTime.of(dataInizioEcc, oraInizioT);
                        String strTest = "DATA ORA INIZIO: Inserita una data o ora d'inizio evento successiva alla data di fine";

                        Throwable exception = assertThrows(DaoException.class,
                                () -> evento.modificaDataOraInizio(inizioEcc));
                        assertEquals(strTest, exception.getMessage());
                    }
                }
            }
        }
    }

    @Test
    @DisplayName("Evento: Test Equals")
    void testEquals() throws DaoException {
        resp = new Responsabile(1, "Marco", "Rossi", "marco.rossi@email.it");
        Evento evento = new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, dataOraFine);
        Evento evento2 = new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, dataOraFine);
        Evento evento3 = new Evento(resp, aula, "aaaa", tipoEvento, dataOraInizio, dataOraFine);

        assertEquals(evento2, evento);
        assertEquals(evento3, evento);
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Evento Test: Modifica Evento")
    class testModificaEvento {
        //Evento
        Evento evento;

        @BeforeAll
        public void init() {
            try {
                //Responsabile
                resp = new Responsabile(nomeResp, cognomeResp, emailResp);
                //Evento
                this.evento = new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, dataOraFine);
            } catch (DaoException e) {
                fail(e.getMessage(), e);
            }
        }

        @Nested
        @DisplayName("Evento Test: Modifica Responsabile Evento")
        class modificaResponsabileEvento {
            @Test
            @DisplayName("Evento Test: Modifica Responsabile Evento")
            public void testModificaResponsabileEvento() throws DaoException {
                try {
                    Responsabile nuovoResp = new Responsabile("Gianmarco", "Bianchi", "gianmarco.bianchi@email.it");
                    evento.setRespEvento(nuovoResp);
                    assertEquals(nuovoResp, evento.getRespEvento());
                } catch (DaoException e) {
                    fail(e.getMessage(), e);
                }
            }
        }

        @Nested
        @DisplayName("Evento Test: Modifica Tipo Evento")
        class testEditTipoEvento {
            @Test
            @DisplayName("Evento Test: Modifica Tipo Evento")
            public void testModificaTipoEvento() throws DaoException {
                String nuovoTipoEvento = "Prova Nuovo Tipo";

                evento.setTipoEvento(nuovoTipoEvento);
                assertEquals(nuovoTipoEvento, evento.getTipoEvento());
            }
        }

        @Nested
        @DisplayName("Evento Test: Modifica Presenti Evento")
        class testEditNPartecipantiEvento {
            @Test
            @DisplayName("Evento Test: Modifica Presenti Evento")
            public void testModificaNPartecipantiEvento() throws DaoException {
                int nP = evento.getnPresenti();

                evento.modificaPresenti(1);
                assertEquals(nP + 1, evento.getnPresenti());
                evento.modificaPresenti(-1);
                assertEquals(nP, evento.getnPresenti());
            }

            @Test
            @DisplayName("Evento Test: Modifica Presenti Max Evento")
            public void testModificaNPMaxPresenti() throws DaoException {
                int nP = evento.getnPresenti();
                int maxNP = evento.getMaxPresenti();
                int increase = 5;
                for (int i = 0; i < increase; i++) {
                    evento.modificaPresenti(1);
                }
                assertEquals(nP + increase, evento.getnPresenti());
                if(maxNP < (nP + increase)) {
                    maxNP = nP + increase;
                }
                assertEquals(maxNP, evento.getMaxPresenti());
                int decrease = 2;
                for (int i = 0; i < decrease; i++) {
                    evento.modificaPresenti( -1);
                }
                assertEquals(nP + increase - decrease, evento.getnPresenti());
                assertEquals(maxNP, evento.getMaxPresenti());
            }
        }
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Evento Test: Ricerca Eventi")
    class testRicercaEvento {
        Session session;
        //Evento 1 (1/12/2020 12:30 - 12/1/2021 12:40)
        Evento evento;
        int idEvento;
        int idResp;
        int idAula;

        //Evento 2 (15/1/2020 12:30 - 20/1/2020 12:40)
        Evento evento2;
        int idEvento2;
        String nomeEvento2 = "Conferenza Matricole";
        String tipoEvento2 = "Riunione";
        LocalDate dataInizio2 = LocalDate.of(2020, 1, 15);
        LocalDate dataFine2 = LocalDate.of(2020, 1, 20);

        //Evento 3 (16/03/2020 12:30 - 30/3/2020 12:40)
        Evento evento3;
        int idEvento3;
        Responsabile resp3;
        int idResp3;
        String nomeResp3 = "Gianpiero";
        String cognomeResp3 = "Bianchi";
        String emailResp3 = "gianpiero.bianchi@email.it";
        Aula aula3;
        int idAula3;
        String nomeAula3 = "Aula 3C";
        int cpMax3 = 40;
        int cpMin3 = 2;
        String nomeEvento3 = "Conferenza Matricole";
        String tipoEvento3 = "Riunione";
        LocalDate dataInizio3 = LocalDate.of(2020, 3, 16);
        LocalDate dataFine3 = LocalDate.of(2020, 3, 30);

        //Evento 4 (20/6/2020 12:30 - 21/7/2020 12:40)
        Evento evento4;
        int idEvento4;
        Responsabile resp4;
        int idResp4;
        String nomeResp4 = "Gianluca";
        String cognomeResp4 = "Viola";
        String emailResp4 = "gianluca.viola@email.it";
        Aula aula4;
        int idAula4;
        String nomeAula4 = "Aula Magna";
        int cpMax4 = 50;
        int cpMin4 = 6;
        String nomeEvento4 = "Conferenza Biotecnologie";
        String tipoEvento4 = "Conferenza";
        LocalDate dataInizio4 = LocalDate.of(2020, 6, 20);
        LocalDate dataFine4 = LocalDate.of(2020, 7, 21);

        @BeforeAll
        public void init() {
            session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            try {
                //Evento 1
                this.idResp = HibernateUtil.insertWithIntegerPk(session, new Responsabile(nomeResp, cognomeResp, emailResp));
                resp = HibernateUtil.getWithIntegerPk(session, Responsabile.class, idResp);
                this.idAula = HibernateUtil.insertWithIntegerPk(session, aula);
                this.idEvento = HibernateUtil.insertWithIntegerPk(session,
                        new Evento(resp, aula, nomeEvento, tipoEvento, dataOraInizio, dataOraFine));
                this.evento = HibernateUtil.getWithIntegerPk(session, Evento.class, idEvento);
                //Evento 2
                this.idEvento2 = HibernateUtil.insertWithIntegerPk(session,
                        new Evento(resp, aula, nomeEvento2, tipoEvento2,
                                dataOra(dataInizio2, oraInizio), dataOra(dataFine2, oraFine)));
                this.evento2 = HibernateUtil.getWithIntegerPk(session, Evento.class, idEvento2);
                //Evento 3
                this.resp3 = new Responsabile(nomeResp3, cognomeResp3, emailResp3);
                HibernateUtil.insertWithIntegerPk(session, resp3);
                this.aula3 = new Aula(nomeAula3, cpMax3, cpMin3);
                HibernateUtil.insertWithIntegerPk(session, aula3);
                this.idEvento3 = HibernateUtil.insertWithIntegerPk(session, new Evento(resp3, aula3, nomeEvento3,
                        tipoEvento3, dataOra(dataInizio3, oraInizio), dataOra(dataFine3, oraFine)));
                this.evento3 = HibernateUtil.getWithIntegerPk(session, Evento.class, idEvento3);
                //Evento 4
                this.resp4 = new Responsabile(nomeResp4, cognomeResp4, emailResp4);
                HibernateUtil.insertWithIntegerPk(session, resp4);
                this.aula4 = new Aula(nomeAula4, cpMax4, cpMin4);
                HibernateUtil.insertWithIntegerPk(session, aula4);
                this.idEvento4 = HibernateUtil.insertWithIntegerPk(session, new Evento(resp4, aula4, nomeEvento4,
                        tipoEvento4, dataOra(dataInizio4, oraInizio), dataOra(dataFine4, oraFine)));
                this.evento4 = HibernateUtil.getWithIntegerPk(session, Evento.class, idEvento4);
            } catch (DaoException e) {
                session.close();
                fail(e.getMessage(), e);
            }
        }

        @Nested
        @DisplayName("Evento Test Ricerca: Ricerca Esatta")
        class testRicercaEsatta {
            @Test
            @DisplayName("Evento Test Ricerca: Ricerca Esatta 1")
            public void testRicercaEsatta1 () {
                List<Evento> risultati = Evento.cercaEvento(session, resp, aula, nomeEvento2, tipoEvento2, evento2.getDataOraInizio(),
                        evento2.getDataOraFine(), false);
                assertEquals(1, risultati.size());
                assertEquals(evento2, risultati.get(0));
            }

            @Test
            @DisplayName("Evento Test Ricerca: Ricerca Esatta 2")
            public void testRicercaEsatta2() {
                List<Evento> risultati = Evento.cercaEvento(session, resp3, null, null, null,
                        null, null, false);
                assertEquals(1, risultati.size());
                assertEquals(evento3, risultati.get(0));
            }

            @Test
            @DisplayName("Evento Test Ricerca: Ricerca Esatta 3")
            public void testRicercaEsatta3() {
                List<Evento> risultati = Evento.cercaEvento(session,null, aula4, null, null,
                        null, null, false);
                assertEquals(1, risultati.size());
                assertEquals(evento4, risultati.get(0));
            }

            @Test
            @DisplayName("Evento Test Ricerca: Ricerca Esatta 4")
            public void testRicercaEsatta4() {
                List<Evento> risultati = Evento.cercaEvento(session,null, null, nomeEvento, null,
                        null, null, false);
                assertEquals(1, risultati.size());
                assertEquals(evento, risultati.get(0));
            }

            @Test
            @DisplayName("Evento Test Ricerca: Ricerca Esatta 5")
            public void testRicercaEsatta5() {
                List<Evento> risultati = Evento.cercaEvento(session,null, null, null, tipoEvento4,
                        null, null, false);
                assertEquals(1, risultati.size());
                assertEquals(evento4, risultati.get(0));
            }

            @Test
            @DisplayName("Evento Test Ricerca: Ricerca Esatta 6")
            public void testRicercaEsatta6() {
                List<Evento> risultati = Evento.cercaEvento(session,null, null, null, null,
                        dataOraInizio, null, false);
                assertEquals(1, risultati.size());
                assertEquals(evento, risultati.get(0));
            }

            @Test
            @DisplayName("Evento Test Ricerca: Ricerca Esatta 7")
            public void testRicercaEsatta7() {
                List<Evento> risultati = Evento.cercaEvento(session,null, null, null, null,
                        null, evento3.getDataOraFine(), false);
                assertEquals(1, risultati.size());
                assertEquals(evento3, risultati.get(0));
            }
        }

        @Test
        @DisplayName("Evento Test Ricerca: Ricerca Parziale")
        public void testRicercaParziale() {
            List<Evento> risultati = Evento.cercaEvento(session, resp, null, null,
                    null, null, null, false);
            assertEquals(2, risultati.size());
            assertTrue(risultati.contains(evento));
            assertTrue(risultati.contains(evento2));
        }

        @Test
        @DisplayName("Evento Test Ricerca: Ricerca Tutti")
        public void testRicercaTutti() {
            List<Evento> risultati = Evento.cercaEvento(session,null, null, null, null,
                    null, null, false);

            assertEquals(4, risultati.size());
            assertTrue(risultati.contains(evento));
            assertTrue(risultati.contains(evento2));
            assertTrue(risultati.contains(evento3));
            assertTrue(risultati.contains(evento4));
        }

        @Nested
        @TestInstance(TestInstance.Lifecycle.PER_CLASS)
        @DisplayName("Evento Test Ricerca Range")
        class testRicercaRange {
            //Evento 5 (21/07/2020 12:50 - 21/7/2020 13:50)
            Evento evento5;
            LocalDate dataInizio5 = LocalDate.of(2020, 7, 21);
            LocalTime oraInizio5 = LocalTime.of(12, 50, 0);
            LocalDate dataFine5 = LocalDate.of(2020, 7, 21);
            LocalTime oraFine5 = LocalTime.of(13, 50, 0);

            @BeforeAll
            public void initRange() {
                try {
                    int idEvento5 = HibernateUtil.insertWithIntegerPk(session, new Evento(resp, aula4, nomeEvento, tipoEvento,
                            dataOra(dataInizio5, oraInizio5), dataOra(dataFine5, oraFine5)));
                    this.evento5 = HibernateUtil.getWithIntegerPk(session, Evento.class, idEvento5);
                }  catch (DaoException e) {
                    session.close();
                    fail(e.getMessage(), e);
                }
            }

            @AfterAll
            public void cleanRange() {
                session.delete(evento5);
                session.getTransaction().commit();
            }

            @Test
            @DisplayName("Evento Test Ricerca Range: Ricerca Range 1")
            public void testRange1 () {
                LocalDate data1 = LocalDate.of(2020, 3, 17);
                LocalDate data2 = LocalDate.of(2020, 8, 1);
                List<Evento> risultati = Evento.cercaEvento(session, null, null, null, null,
                        dataOra(data1, oraInizio), dataOra(data2, oraFine), true);

                assertEquals(3,risultati.size());
                assertTrue(risultati.contains(evento3));
                assertTrue(risultati.contains(evento4));
            }

            @Test
            @DisplayName("Evento Test Ricerca Range: Ricerca Range 2")
            public void testRange2() {
                LocalDate data1 =LocalDate.of(2020,7,21);
                LocalTime ora1 = LocalTime.of(0, 0, 0);
                LocalDate data2 = LocalDate.of(2020,7,21);
                LocalTime ora2 = LocalTime.of(23, 59, 59);

                List<Evento> risultati = Evento.cercaEvento(session,null,null,null,null,
                        dataOra(data1, ora1),dataOra(data2,ora2),true);

                assertEquals(2,risultati.size());
                assertTrue(risultati.contains(evento4));
                assertTrue(risultati.contains(evento5));
            }

            @Test
            @DisplayName("Evento Test Ricerca Range: Ricerca Range 3")
            public void testRange3() {
                LocalDate data1 =LocalDate.of(2020,7,21);
                LocalTime ora1 =LocalTime.of(14, 0, 0);
                LocalDate data2 = LocalDate.of(2020,7,21);
                LocalTime ora2 =LocalTime.of(15,59,59);

                List<Evento> risultati =Evento.cercaEvento(session,null,null,null,null,
                        dataOra(data1, ora1),dataOra(data2,ora2),true);
                assertEquals(0,risultati.size());
            }
        }
        @AfterAll
        public void cleanTable(){
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaDelete<Evento> criteriaDeleteEv = builder.createCriteriaDelete(Evento.class);
            criteriaDeleteEv.from(Evento.class);
            CriteriaDelete<Responsabile> criteriaDeleteResp = builder.createCriteriaDelete(Responsabile.class);
            criteriaDeleteResp.from(Responsabile.class);
            CriteriaDelete<Aula> criteriaDeleteAula = builder.createCriteriaDelete(Aula.class);
            criteriaDeleteAula.from(Aula.class);
            session.beginTransaction();
            session.createQuery(criteriaDeleteEv).executeUpdate();
            session.createQuery(criteriaDeleteResp).executeUpdate();
            session.createQuery(criteriaDeleteAula).executeUpdate();
            session.getTransaction().commit();
            session.close();
        }
    }

}