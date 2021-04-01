#### Gruppo Ingegneristico UPO-IoT
# Sistema *Aulos*

Il sistema *Aulos* è un sistema di gestione (inventariazione, prenotazione, e rilevamento degli accessi) di stanze.

È composto da tre componenti:
- **Frontend** - punto d'incontro con l'utente che inventaria, prenota, controlla e verifica
- **Sottosistema IoT** - soluzione tecnologica che permette il rilevamento e il feedback in tempo reale
- **Sottosistema backend** - soluzione tecnologica che rappresenta e mette a disposizione i dati con controllo degli accessi

## Metodologia di specifica e progettazione
Visti i tempi ristretti a disposizione per l'implementazione del sistema, si prevede di utilizzare una metodologia approcciata all'_agile_. Per cui, questo documento è da intendersi come una descrizione del sistema che pur essendo specifica potrà essere rivista ed integrata durante la progettazione e l'implementazione in caso di necessità.

## Frontend
Il frontend deve realizzare le maschere che implementano l'interfaccia tramite la quale gli utilizzatori attivi del sistema interagiscono con esso.

Il frontend è implementato come interfaccia grafica utente su web browser.

Sono forniti i diagrammi che rappresentano esaustivamente i processi ed i casi d'uso nella directory _workflows_, nonché i mock delle interfacce web in _mock.pdf_.

### Requisiti funzionali
- Il portale web deve poter essere fruito sia da computer che da smartphone/tablet
- Alla pagina iniziale verrà richiesto all'utente di autenticarsi (secondo i principi descritti nella sezione "Autenticazione" del backend)
- Ci dovrà essere un timeout di sessione per aumentare il grado di sicurezza in caso di dispositivo non presidiato, dopo il quale il frontend de-autentica automaticamente l'utente
- Sarà presente un menu con le seguenti voci: Eventi In Corso, Gestione Aule, Stato IoT, Report, Gestione Utenti.

### Pagine
I controlli e le informazioni descritte di seguito saranno presenti in maniera conforme al livello di autorizzazione di ciascun utente.

- Login con reset password
- Gestione stanze libere/prenotate. Lista, con un filtro con data, ora e libera/prenotata che aggiorna la lista delle stanze. L’ultima colonna ha un controllo per aggiungere/modificare la prenotazione sulla stanza scelta. È presente un tasto per creare una nuova stanza, che apre una nuova pagina per espletare l'azione.
- Pagina inserimento/modifica prenotazione, conservando eventualmente il range del filtro selezionato alla pagina precedente. Prevede la possibilità di eliminare la prenotazione laddove questa sia già salvata ed in fase di modifica.
- Visualizzazione prenotazioni in corso/concluse con ordinamento decrescente persone/capienza (report).
  - Visualizzazione di una singola prenotazione con grafico di utilizzo della stanza, e possibilità di cambiare il numero di persone presenti in quel momento nella stanza in caso di prenotazione in corso.
- Visualizzazione stato dispositivi IoT, con colonna con ultimo aggiornamento, e controlli per modifica dispositivo e riavvio dispositivo.
- Gestione utenti, per l'assegnazione dei ruoli.

## Backend

### Descrizione
Si vuole sviluppare un sottosistema che permette di prenotare le stanze di una struttura, tenere traccia delle prenotazioni e controllare il numero di persone nelle aule durante il loro corso.

### Requisiti Funzionali

#### Gestione delle stanze
Il sottosistema consente di aggiungere, visualizzare e modificare le stanze presenti. 
Ogni stanza ha un codice identificativo, un nome, la capienza, e le attrezzature presenti. È possibile visualizzare le aule libere e prenotate (in mutua esclusione) in un range di date, fascia oraria e capienza minima.

#### Gestioni delle prenotazioni
Il sottosistema consente di creare, visualizzare, modificare le prenotazioni delle stanze nella struttura. Ogni prenotazione ha un codice identificativo, un nome, un tipo, il codice identificativo dell'aula, il codice identificativo del responsabile, il numero massimo di partecipanti ammessi (minore o uguale alla capacità dell'aula), la data e l'orario di svolgimento. Per le prenotazioni in corso è possibile visualizzare e modificare i partecipanti presenti in quel momento nell'aula. Per tutte le prenotazioni è possibile visualizzare il numero massimo di partecipanti presenti. Le prenotazioni possono essere visualizzate secondo un ordine stabilito dalla criticità raggiunta dalla capienza dei partecipanti.
È possibile consultare le prenotazioni passate, con la storicizzazione del numero di partecipanti nell'aula.

#### Gestione ruoli
Il sottosistema consente di aggiungere, modificare ed eliminare i ruoli (Responsabile, Addetto alla Sicurezza, Amministratore) delle prenotazioni delle aule.
Ogni responsabile ha un codice identificativo, un nome, un cognome, un indirizzo e-mail, ed un token che lo associa al sistema di autenticazione.

#### Autenticazione
Il sottosistema prevede la possibilità di autenticarsi. In seguito all'autenticazione, il sistema prevede l'assegnazione di autorizzazioni a seconda del ruolo assegnato (identificato tramite il token di autenticazione):
- Amministratore: può visualizzare e modificare ogni entità del sistema
- Responsabile evento: può creare, visualizzare e modificare i propri eventi
- Responsabile della sicurezza: può visualizzare tutti gli eventi

### Requisiti non funzionali
Il sistema deve essere stabile, resiliente ed avere un grado di sicurezza informatica conforme ai casi d'uso previsti.

## Sottosistema IoT

### Descrizione

Il sottosistema IoT è connesso al sottosistema backend, e fornisce ad esso informazioni sui passaggi dagli ingressi in aula, nonché la loro direzione (se in entrata o in uscita).

Il sistema monitora gli effettivi passaggi con un sistema di _rilevazione_ (e.g. tramite sensori di presenza, un tornello
con encoder, o un azionamento manuale), e la loro direzione.

Inoltre, prima di ciascun passaggio in entrata, verifica la disponibilità di posti in aula, e fornisce un
_feedback_ in tempo reale. Questo feedback può essere di diversi tipi: una luce, una scritta su un display, un tornello bloccabile, o altro.

Questo feedback, concettualmente, è composto dalle stesse informazioni disponibili in maniera centralizzata al personale di monitoraggio.

#### Feedback

Il meccanismo di feedback viene configurato per produrre un effetto visibile all'utente. Esso deve essere estendibile tramite un sistema di plug-in, ciascuno dei quali implementa un diverso tipo di feedback.

Inizialmente si prevedono per il sistema due plug-in:
- Esposizione di un endpoint HTTP che ritorna la capacità totale e residua dell'aula;
- Produzione di un feedback luminoso tramite lampadine collegate ad un sistema "Philips Hue".


#### Rilevazione

Il meccanismo di rilevazione è implementato anch'esso tramite un sistema di plug-in.

Inizialmente si prevedono per il sistema due plug-in:
- Esposizione di un endpoint HTTP che permette di segnalare un ingresso o un'uscita;
- Lettura di un pulsante su pin GPIO che segnala ingresso o uscita.


#### Resilienza

Il sottosistema IoT deve tollerare situazioni di black-out temporanee. Dopo uno spegnimento, deve riprendere il
funzionamento senza necessità di riconfigurazione (e tollerare aggiustamenti manuali da parte di operatori effettuati
tramite altri sottosistemi).


### Tabella dei parametri

| Parametro | Descrizione |
|-----------|-------------|
| P-IoT-AvailPollT | Periodo di polling per la disponibilità dei posti in aula in ms; se assente, negativo, o 0, usa 1000



