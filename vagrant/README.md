## Vagrantfile

Il Vagrantfile genera un setup con tutte le componenti esterne richieste dal
progetto. Per utilizzarlo, bisogna aver installato Vagrant e VirtualBox.
Dopodiché è sufficiente dare:

`vagrant up  # curarsi di essere nella directory del Vagrantfile`

Al termine del proprio lavoro, si può cancellare la macchina virtuale (compresi
i dischi) con:

`vagrant destroy -f  # curarsi di essere nella directory del Vagrantfile`


### Nota importante

Il setup che si genera tramite il Vagrantfile non è adatto all'uso in
production, poiché volutamente non hardened: utilizza password semplici e
protocolli non sicuri.


#### MariaDB

Verrà avviata un'istanza di MariaDB con le credenziali ed i database per Aulos e
Keycloak preconfigurati, nonché riempita con un dataset di esempio, che
comprende delle credenziali per Keycloak da usare per provare il fuznionamento,
riportate nella relativa sezione di questo README.

È possibile collegarsi all'istanza tramite la porta predefinita 3306,
utilizzando le credenziali `admin`/`admin`, e ispezionare entrambi i database.


#### Mosquitto

Viene avviata un'istanza di Mosquitto con la configurazione di default sulla
porta predefinita, senza autenticazione.


#### Keycloak

Viene avviata un'istanza pre-configurata di Keycloak. Alcune credenziali utili:

Reame `master`:

- `admin`/`admin`: account con accesso completo

Reame `Aulos` (tutti gli account hanno `password` come password):

- `es_responsabile_1`, `es_responsabile_2`: account con accesso "responsabile"
  ad Aulos
- `es_supervisore_1`, `es_supervisore_2`: account con accesso "supervisore" ad
  Aulos
- `es_amministratore_1`, `es_amministratore_2`: account con accesso
  "amministratore" ad Aulos, nonché con accesso alla modifica degli utenti del
  reame di Keycloak


#### Pagina di login di esempio

Avviando lo script `test_login_flow.py` verrà avviato un webserver locale sulla
porta 8000 che permette di ispezionare il funzionamento del flusso di login
tramite Keycloak. Collegandosi con un browser a http://localhost:8000 si potrà
provare a fare il login al reame Aulos con le credenziali descritte sopra, ed
ispezionare i token JWT restituiti.


