#### Gruppo-Ingegneristico-UPO-IoT
Gruppo8-2020

# Sistema *Aulos*
Il sistema *Aulos* è un sistema di gestione (inventariazione, prenotazione, e rilevamento degli
accessi) di stanze.

## Documentazione
La documentazione progettuale può essere individuata nella directory `doc` del repository.

## Quick start
Per avviare un'istanza completa del sistema, è necessario:

- Compilare il backend
- Compilare il sottosistema IoT
- Installare le dipendenze ed avviare il frontend
- Avviare gli applicativi di supporto tramite il Vagrantfile

### Compilare il backend

```
cd backend
./gradlew clean shadowJar
```

L'artefatto si potrà individuare in `build/libs`.

### Compilare il sottosistema IoT

```
cd iot
./gradlew clean shadowJar
```

L'artefatto si potrà individuare in `build/libs`.

### Installare le dipendenze ed avviare il frontend

Installare Node.js 10 ed npm. Riferirsi al README.md nella directory `frontend` per installare le
dipendenze ed avviare il frontend.

### Avviare gli applicativi di supporto tramite il Vagrantfile

Assicurarsi che le porte locali 3306, 1883, e 8080 siano libere.

```
cd vagrant
vagrant up
```

### Il sistema

Dopo aver avviato il frontend, il backend, e la macchina virtuale Vagrant, sarà possibile avviare
un'istanza del sottosistema IoT. Questa effettuerà automaticamente il binding al backend.

Collegarsi a http://localhost:4200. Si aprirà il frontend. Sarà possibile sperimentare con i dati
di esempio.

Per prima cosa, è consigliabile selezionare un'Aula ed abbinarvi il sottosistema IoT appena
avviato.

Dopodiché, creando un evento ed attendendone l'inizio, sarà possibile simulare dei passaggi in
entrata e in uscita dalle aule tramite gli endpoint HTTP del sottosistema backend. Questi eventi
si rifletteranno nei dati mostrati nel frontend.


