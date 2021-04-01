#### Gruppo Ingegneristico UPO-IoT
# Sottosistema IoT

Il *Sottosistema IoT* consiste in una piattaforma hardware ed un software, ed opera comunicando con il *Sottosistema backend*.

La piattaforma hardware consiste in un Single Board Computer con capacità di connettersi a reti IP e che supporti un sistema operativo GNU/Linux (come Raspberri Pi). Il software è scritto in Java e viene eseguito sulla piattaforma hardware.

#### Feedback

Il meccanismo di feedback, come da specifica, deve implementare le funzioni seguenti:
- Esposizione di un endpoint HTTP che ritorna la capacità totale e residua dell'aula;
- Produzione di un feedback luminoso tramite lampadine collegate ad un sistema "Philips Hue".

È inoltre richiesto che queste funzioni siano implementate tramite un sistema di plugin. A questo scopo, viene definita un'interfaccia *FeedbackProvider*, implementata dai sistemi di feedback attraverso la classe astratta *FeedbackProviderBase*.

##### Endpoint HTTP
L'endpoint HTTP utilizza Java Spark per esporre le informazioni sull'occupazione della stanza, ed un'interfaccia WebSocket per esporre gli eventi di cambiamento.

##### Feedback luminoso tramite Philips Hue
Viene utilizzata la libreria "Yet Another Hue API" per implementare il plugin per questa funzionalità.

#### Rilevazione

Il meccanismo di rilevazione è implementato anch'esso tramite un sistema di plug-in.

Inizialmente si prevedono per il sistema due plug-in:
- Esposizione di un endpoint HTTP che permette di segnalare un ingresso o un'uscita;
- Lettura di un pulsante su pin GPIO che segnala ingresso o uscita.

Analogamente al caso del Feedback, si prevedono un'interfaccia *DetectionAgent* ed una classe astratta *DetectionAgentBase*.

##### Endpoint HTTP
L'endpoint HTTP utilizza Java Spark per ricevere le segnalazioni degli eventi di ingresso e uscita da una stanza.

##### Pin GPIO
Viene utilizzata la libreria "Pi4J" per implementare la funzionalità del plugin.

#### Resilienza

Il software recupera lo stato necessario al funzionamento all'avvio dal *Sottosistema Backend*.

#### Comunicazione con il *Sottosistema Backend*

La comunicazione con il *Sottosistema Backend* avviene unicamente attravero un message broker MQTT.


