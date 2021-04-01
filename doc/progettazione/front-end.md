#### Gruppo ingegneristico UPO-IoT
## Pregettazione: Sistema di Gestione Eventi, Aule e Responsabili
### Sottosistema di front-end

#### Sottosistemi e moduli
Il sottosistema front-end si preocupera' di fare le richieste al sottosistema back-end per le operazioni di recupero dati e CRUD (create,remove,update,delete).
Questa parte sara' sviluppata con l'utilizzo di typescript, angular, bootstrap e il pacchetto grafico Nebular.
Sono state scelte queste componenti perche' molto attuali, testate e di rapido apprendimento.

Il portale avra' le seguenti pagine:<br>
- login;
- indice eventi;
- inserimento/modifica evento;
- indice aule;
- inserimento/modifica aula;
- gestione prenotazione aula;
- indice responsabili;
- inserimento/modifica responsabili;
- indice attrezzature;
- inserimento/modifica attrezzature;
  
Per la relativa bozza delle pagine si rimanda al mock prodotto in fase di specifica.

Il modello utilizzato sara' a componenti (components) questo puo' essere simile a MVC ma angular e i nuovi framework hanno superato quel concetto. 

## Composizione 
Per gestire le richieste verso le API, verranno definite delle classi/interfacce che corrisponderanno al modello definito nel backend.
Questa scelta dara' consistenza all'intero progetto.

Ogni pagina da visualizzare avra':
- file.ts (che assumera' il ruolo di controller) che si preoccupera' di gestire la logica, il comportamento e le funzioni. 
- file.html (vista), descrivera' come la pagina deve essere renderizzata in base ai tag usati. 
- file.css per descrivere l'aspetto dei componenti html.

 

## UniversalApi
Per gestire le richieste, sara' creata una classe generica che potra' essere istanziata da tutte le pagine collegate alle diverse entita'. Questa prendera' il nome di UniversalApi. In questo modo potremo prendere come riferimento questa classe cambiando solo l'istanza relativa all'entita' a cui si fa riferimento.

Richieste:<br>
- Search: una richiesta in GET che richiede dati, con la possibilita' di    aggiungere filtri;
- Create: richiesta in POST per creare una nuova entita' nel database;
- Update: richiesta in POST per aggiornare una entita' esistente;
- Delete: richiesta in POST per eliminare un'entita' esistente.

Per entita' si intende la classe e quindi la relativa tabella nel database (evento, aula, attrezzatura, ecc).

Il passaggio di dati tra Front-end e Back-end dovra' essere fatto utilizzando il formato JSON.

## Pagine di indice
Sono pagine che avranno una parte tabellare comune e avranno il compito, in base alla loro entita' di riferimento, reperire i dati e visualizzarli a video. Le azioni disponibili saranno in fondo ad ogni singola riga (modifica, eliminazione, ecc).

## Pagine Form  
Andranno a visualizzare i campi valorizzati dati dalla riga selezionata, oppure vuoti in caso di un nuovo inserimento.
Per gestire i form verra' utilizzata la classe Form fornita da Angular, in questa maniera sara' piu' facile gestire i campi e le loro validazioni. 







