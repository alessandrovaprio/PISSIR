import { formatDate } from '@angular/common';
import { Injector, ViewChild } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NbDialogService } from '@nebular/theme';
import { LocalDataSource, Ng2SmartTableComponent } from 'ng2-smart-table';
import { Subscription } from 'rxjs';
import { Evento } from 'src/classes';
import { Helpers } from 'utils/helpers';
import { Paths } from 'utils/paths';
import { UniversalApi } from 'utils/universal-api';

@Component({
  selector: 'app-events-index-page',
  templateUrl: './events-index-page.component.html',
  styleUrls: ['./events-index-page.component.scss']
})
export class EventsIndexPageComponent implements OnInit {


  apiEventsSub: Subscription;
  data:Evento[] = [];

  searchTerm: any;
  loading: boolean = false;

  universalApi: UniversalApi<Evento>;
  isSupervisor: boolean;
  filterSupervisor: any;
  constructor(
    private router: Router,
    private nbDialogSvc: NbDialogService,
    private injector: Injector,
  ) { }

  async ngOnInit() {
    this.isSupervisor = Helpers.checkIfSupervisor();
    this.universalApi = new UniversalApi<Evento>(this.injector);
    this.universalApi.setEntity('Evento');
    this.loading = true;
    await this.search();
    this.data.map((event) => {
      const tmpResp = event.respEvento['cognomeResp'];
      event.respEvento = tmpResp;
      const tmpAula = event.aulaEvento['nomeAula'];
      const tmpAulaCapienzaMax = event.aulaEvento['capienzaMax'];
      event.aulaEvento = tmpAula;
      const tmpDataInizio = Helpers.convertDateFromApi(event.dataOraInizio);
      const tmpDataFine = Helpers.convertDateFromApi(event.dataOraFine);
      event.dataOraFine = tmpDataFine;
      event.dataOraInizio = tmpDataInizio;
      event.statoEvento = this.getEventStatus(tmpDataInizio, tmpDataFine);
      event.statoPresenti = this.getAttendantsStatus(event.maxPresenti, tmpAulaCapienzaMax, event.gradoRiempAula, event.nPresenti);
      return event;
    });
    this.data.sort((a,b)=> {
      if(this.getOrderAttendantStatus(a.statoPresenti) > this.getOrderAttendantStatus(b.statoPresenti)) {
        return 1;
      }
      if (this.getOrderAttendantStatus(a.statoPresenti) < this.getOrderAttendantStatus(b.statoPresenti)) {
          return -1;
      }

      return 0;
    })
    this.loading = false;
    //await this.searchDummy();
  }

  getOrderAttendantStatus(name: string) {
    const array = ['Critico', 'Picco Critico', 'Prudenza', 'Ok'];
    return array.indexOf(name);
  }
  onCreate() {
    this.router.navigate([Paths.FORM(this.universalApi.entity, null)], { queryParams: {} });
  }
  ngOnDestroy() {
    //this.apiEventsSub.unsubscribe();
  }

  getAttendantsStatus(maxPartecipants: number, aulaMaxCap: number, gradoRiempAula: number, nPresenti: number) {

    //console.log('getAttendantsStatus', maxPartecipants, (aulaMaxCap))
    if (maxPartecipants && aulaMaxCap) {
      const tmpAulaRiemp = aulaMaxCap * gradoRiempAula;
      const perc = (nPresenti/tmpAulaRiemp*100);
      if(maxPartecipants >= (tmpAulaRiemp)*(90/100) && perc < 90) {
        return 'Picco Critico'
      }
      if (tmpAulaRiemp) {
        //console.log('tmpAulaRiemp', nPresenti, (tmpAulaRiemp), perc);
        if ( perc>= 90) {
          return 'Critico'
        }
        if (perc >= 70) {
          return 'Prudenza'
        }
      }
    }
    return 'Ok'

  }

  getEventStatus(dateStart: Date, dateEnd: Date) {
    const currentDate = new Date();
    if (currentDate >= dateStart && currentDate <= dateEnd) {
      return 'In Corso';
    }
    if (currentDate >= dateEnd) {
      return 'Concluso';
    }
    return 'Pianificato';
  }
  async search() {
    let rows = await this.universalApi.getRequest().toPromise();
    if (this.isSupervisor) {
      console.log('isSupervisor', localStorage.getItem('username'));
      rows = rows.filter((r)=> {
        console.log('resp', r['respEvento']['usernameResp'], localStorage.getItem('username'));
        return r['respEvento']['usernameResp'] === localStorage.getItem('username')});
    }
    for (const d of (rows as any)) {
      this.data.push(d);

    }

  }
}
