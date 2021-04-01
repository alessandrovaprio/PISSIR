import { formatDate } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { CursorError } from '@angular/compiler/src/ml_parser/lexer';
import { Injector, ViewChild } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NbDialogService } from '@nebular/theme';
import { LocalDataSource, Ng2SmartTableComponent } from 'ng2-smart-table';
import { Observable, Subscription } from 'rxjs';
import { Evento } from 'src/classes';
import { Aula } from 'src/classes/Aula';
import { Prenotazione } from 'src/classes/Prenotazione';
import { Helpers } from 'utils/helpers';
import { Paths } from 'utils/paths';
import { UniversalApi } from 'utils/universal-api';
import { BaseFormComponent } from '../../forms/base/base-form/base.form.component';

@Component({
  selector: 'app-booking-index-page',
  templateUrl: './booking-index-page.component.html',
  styleUrls: ['./booking-index-page.component.scss']
})
export class BookingIndexPageComponent implements OnInit {

  apiEventsSub: Subscription;
  data:any[] = [];
  modelDefinition: string;
  fieldsOrder: string[] = [];
  searchTerm: string;
  classrooms: Aula[] = [];
  classroomApi: UniversalApi<Aula>;
  eventApi: UniversalApi<Evento>;
  //freeFilter: boolean = false;
  //busyFilter: boolean = false;
  allData: Prenotazione[];
  //startDate: Date;
  //endDate: Date;
  eventRows: Evento[];
  minStartDate: Date = Helpers.addDays(new Date(), -1);
  maxStartDate: Date;
  minEndDate: Date = Helpers.addDays(new Date(), -1);
  form: FormGroup;
  rangeOk: boolean = true;
  loading: boolean;
  universalApi: UniversalApi<Prenotazione>;
  isSupervisor: boolean;
  canMod: any;


  constructor(
    private router: Router,
    private nbDialogSvc: NbDialogService,
    private injector: Injector,
    private http:HttpClient

  ) {   }

  async ngOnInit() {
    // this.startDate = new Date();
    // this.endDate = Helpers.addDays(new Date(), 1);
    this.isSupervisor = Helpers.checkIfSupervisor();

    this.universalApi = new UniversalApi<Prenotazione>(this.injector);
    this.universalApi.setEntity('Prenotazione');
    this.classroomApi = new UniversalApi<Aula>(this.injector);
    this.classroomApi.setEntity('Aula');
    this.eventApi = new UniversalApi<Evento>(this.injector);
    this.eventApi.setEntity('Evento');
    this.form = new FormGroup({
      startDate: new FormControl(null, []),
      endDate: new FormControl(null, []),
      minCapacity: new FormControl(null, []),
      freeFilter: new FormControl(false, []),
      busyFilter: new FormControl(false, []),
      percRiemp: new FormControl(100, []),
    });
    //console.log('universal fields', this.universalApi.getEntityFields());

    //this.data = await this.searchDummy();
    //await this.search();
    this.allData = [...this.data];

    this.modelDefinition = 'Classroom';
    //this.initTable();
  }

  maxNumber(controlname: string, maxNum) {
    if (this.canMod) {
      this.canMod = false;
      if (this.form.get(controlname).value > maxNum) {
        this.form.get(controlname).patchValue(maxNum);
      }

    } else {
      this.canMod = true;
    }
  }
  onStartChange(newVal) {
    // const value = newVal;
    // if (value) {

    // } else {
    //   console.log('reset filter',value);
    //   this.data = [...this.allData];
    // }
    this.minEndDate = Helpers.addDays(newVal, -1);
    this.rangeOk = Helpers.checkDates(this.form, 'startDate', 'endDate');
  }

  onEndChange(newVal) {
    this.maxStartDate = newVal;
    this.rangeOk = Helpers.checkDates(this.form, 'startDate', 'endDate');
    //console.log('onEndChange', newVal, this.form.value.endDate, this.rangeOk);
  }

  checkDatenow(controlname: string): boolean {
    if(this.form.get(controlname).value < new Date()) {
      return false;
    }
    return true;
  }
  getInputStatus(fieldName: string) {
    Helpers.getInputStatus(this.form, fieldName);
  }
  onStatusToggle(newVal, statusName: string) {
    // const value = newVal;
    // // if true I filter otherwise recover data
    // if (value) {
    //   console.log('filter',value, status);
    //   this.data = this.data.filter((clr) => {
    //                       console.log('evt', clr, clr.statoAula.toString().toLowerCase(), statusName.toString().toLowerCase(), clr.statoAula.toString().toLowerCase()===statusName.toString().toLowerCase());
    //                       return clr.statoAula.toString().toLowerCase() === statusName.toString().toLowerCase();
    //                     });
    // } else {
    //   console.log('reset filter',value);
    //   this.data = [...this.allData];
    // }
  }
  getFields() {
    return ['idAula','nomeAula','capienzaMax','statoAula','da', 'a', 'idEvento'];
  }
  onCreate() {
    this.router.navigate([Paths.FORM(this.classroomApi.entity, null)], { queryParams: {} });
  }
  ngOnDestroy() {
    //this.apiEventsSub.unsubscribe();
  }
  initTable() {

  }

  filterData(controlName: string, value: any) :Prenotazione[] {
    switch(controlName) {
      case 'freeFilter':
        return this.getFilteredBusyOrFree('Libera', value);
      case 'busyFilter':
        return this.getFilteredBusyOrFree('Occupata', value);
      case 'minCapacity':
        return this.getFilteredMinCapacity(value,this.form.get('percRiemp').value);
      default:
        return this.data;
    }
  }

  getFilteredByRange(name: string, value: Date): Prenotazione[] {
    // let filtered = this.eventRows.filter((evt=> {
    //   console.log(evt['aulaEvento']['idAula'], currentId, evt['aulaEvento']['idAula'] === currentId);
    //   return evt['aulaEvento']['idAula'] === currentId;
    // }));
    return this.data;
  }
  getFilteredBusyOrFree(statusName: string, value: any): Prenotazione[] {
    return this.data.filter((clr) => {
                            return clr.statoAula.toString().toLowerCase() === statusName.toString().toLowerCase();
                          });
  }
  getFilteredMinCapacity(value: any, perc?: number) {
    return this.data.filter((clr) => {
      if (!perc) {
        perc = 1;
      }
      return clr.capienzaMax * perc /100 >= value;
    });
  }
  async searchWithFilters() {
    //console.log('this.form', this.form);
    await this.search();
    // filter free or busy
    for (const control in this.form.controls) {
      if (this.form.get(control).value) {
        this.data = this.filterData(control, this.form.get(control).value);
      }
    }
  }
  clearFilters() {
    this.data = [];
    this.form.reset();
    this.rangeOk = true;
  }
  async search() {
    this.data = [];
    this.loading = true;
    //console.log('forms', this.startDate, this.endDate);
    // const tempUApi = new UniversalApi(this.injector);
    // tempUApi.setEntity('aula');
    this.eventRows = await this.eventApi.getRequest().toPromise();
    this.eventRows = this.eventRows.sort((a,b)=> {
      if(a.dataOraInizio > b.dataOraInizio) {
        return 1;
      }
      if (a.dataOraInizio < b.dataOraInizio) {
          return -1;
      }

      return 0;
    });
    //this.getFreeSlots(this.eventRows);
    let classroomRows = await this.classroomApi.getRequest().toPromise();
    if (this.eventRows.length > 0) {

      for (const event of this.eventRows) {
        const start = Helpers.convertDateFromApi(event.dataOraInizio);
        const end = Helpers.convertDateFromApi(event.dataOraFine);
        let rangeStart = new Date(this.form.value.startDate);
        //console.log('myevent', event, start, end, rangeStart);
        if (end > new Date()) {

          const d = {};
              d['idAula'] = event.aulaEvento['idAula'];
              d['nomeAula'] = event.aulaEvento['nomeAula'];
              d['capienzaMax'] = event.aulaEvento['capienzaMax'];
              d['statoAula'] = 'Occupata';
              d['da'] = start;
              d['a'] = end;
              d['idEvento'] = event.idEvento;
              if (this.isSupervisor ) {
                //console.log('issupervisor', event.respEvento, localStorage.getItem('username'))
                if (event.respEvento['usernameResp']==localStorage.getItem('username')){
                  this.data.push(d);
                }
              } else {
                this.data.push(d);

              }
        }

      }

      //find spaces between events
      for (let i =0;i<classroomRows.length;i++) {
        let tmpFilteredevent = this.eventRows.filter((d)=>{return d.aulaEvento['idAula'] === classroomRows[i].idAula && Helpers.convertDateFromApi(d.dataOraFine)>= new Date()});
        //console.log('filtered', tmpFilteredevent, this.eventRows);
        this.getFreeSlots(tmpFilteredevent,classroomRows[i].idAula);
        //console.log('this.classroom',classroomRows[i], tmpFilteredevent);

        let tmpRanges= [];


      }
    }
    for(const c of classroomRows) {
      const foundAula = this.eventRows.find((e)=> {return e.aulaEvento['idAula'] === c.idAula});
      if (!foundAula) {
        const tmpD = {};
        tmpD['idAula'] = c.idAula;
        tmpD['nomeAula'] = c.nomeAula;
        tmpD['capienzaMax'] = c.capienzaMax;
        tmpD['statoAula'] = 'Libera';
        tmpD['da'] = this.form.value.startDate;
        tmpD['a'] = this.form.value.endDate;
          //this.data.push(JSON.parse(d.toString()));
          this.data.push(tmpD);
      }


    }


    //console.log('mydata',this.data);
    this.loading = false;
  }

  getFreeSlots(events: any[], classId:number) {
    let startRange = new Date(this.form.get('startDate').value);
    const endRange = new Date(this.form.get('endDate').value);
    let index = 0;
    while(index < events.length) {
      const tmpInizio = Helpers.convertDateFromApi(events[index].dataOraInizio);
      const tmpFine = Helpers.convertDateFromApi(events[index].dataOraFine);
      //console.log('while', startRange, endRange, tmpInizio)
      //console.log('event', events[index]);
      if(startRange < tmpInizio && index === 0 ) {
        this.pushData(events[index]['aulaEvento'],
                      new Date(startRange), tmpInizio );
      }

      if (index === events.length-1) {
        this.pushData(events[index]['aulaEvento'],
        tmpFine, endRange );
      }
      else {
        this.pushData(events[index]['aulaEvento'],
        tmpFine, Helpers.convertDateFromApi(events[index+1]['dataOraInizio']) );
      }
      index++;


    }
  }
  pushData(classroom: any, tmpStart: Date, tmpEnd: Date) {
    const d = {};
            d['idAula'] = classroom['idAula'];
            d['nomeAula'] = classroom['nomeAula'];
            d['capienzaMax'] = classroom['capienzaMax'];
            d['statoAula'] = 'Libera';
            d['da'] = tmpStart;
            d['a'] = tmpEnd;
            this.data.push(d);
  }
  getStatus(events: Evento[], currentId: number) {
    let insideRangeStart = false;
    let insideRangeEnd = false;
    //console.log('events', events);
    let filtered = events.filter((evt=> {
      //console.log(evt['aulaEvento']['idAula'], currentId, evt['aulaEvento']['idAula'] === currentId);
      return evt['aulaEvento']['idAula'] === currentId;
    }));

    //console.log('filtered',filtered );
    for(const evt of filtered) {
      //console.log('filterDate', Helpers.convertDateFromApi(evt.dataOraInizio), this.form.value.startDate, (Helpers.convertDateFromApi(evt.dataOraInizio) >= this.form.value.startDate));
      if (this.form.value.startDate) {
        if (Helpers.convertDateFromApi(evt.dataOraInizio) >= this.form.value.startDate)
          insideRangeStart = true;
      }
      if (this.form.value.endDate) {
        if (Helpers.convertDateFromApi(evt.dataOraFine) <= this.form.value.endDate)
          insideRangeEnd = true;
      }
    }
    return insideRangeStart || insideRangeEnd ? 'Occupata' : 'Libera';



  }

}
