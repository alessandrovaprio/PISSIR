//import { Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { BaseFormComponent } from '../base/base-form/base.form.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { UIService } from 'src/app/ui/ui.service';
import { Aula } from 'src/classes/Aula';
import { Component, Inject, Injector, Input, OnInit } from '@angular/core';
import { getAllJSDocTags } from 'typescript';
import { UniversalApi } from 'utils/universal-api';
import { Subscription } from 'rxjs';
import { Evento, Prenotazione, Responsabile } from 'src/classes';
import { Helpers } from 'utils/helpers';
import { NbDialogRef, NbToastrService } from '@nebular/theme';

@Component({
  selector: 'app-event-form-page',
  templateUrl: './event-form-page.component.html',
  styleUrls: ['./event-form-page.component.scss']
})
export class EventFormPageComponent extends BaseFormComponent<Evento> implements OnInit {

  //public form: FormGroup;
  @Input()
  public options: any;

  optionsData: Evento;
  embedded: boolean = false;

  minStartDate: Date;
  maxStartDate: Date;
  maxEndDate: Date;
  maxAula = 999999;
  public classroomApi: UniversalApi<Aula>;
  startErr: string;
  endErr: string;
  canEndChange: boolean = false;
  canStartChange: boolean= false;
  inProgress: boolean;
  eventStatus: string;
  canMod: boolean;

  constructor(
    public router: Router,
    public activatedroute: ActivatedRoute,
    private injector: Injector,
    public nbToastrSvc: NbToastrService
    )

    {
    super();
  }

  async ngOnInit() {
    this.classroomApi = new UniversalApi(this.injector);
    this.classroomApi.setEntity('Aula');

    if (this.options ) {
      this.pageMode = this.options['isDialog'] ? 'dialog' : 'page';
      this.entityId= this.options['data'] ? this.options['data']['idEvento'] : null;
      this.entityData = {
        aulaEvento: this.options['entityData']['idAula'],
       // maxPartecipanti: this.options['entityData']['capienzaMax'],
        dataOraInizio: new Date(this.options['entityData']['da']),
        dataOraFine: new Date(this.options['entityData']['a'])
      };
      this.minStartDate = Helpers.addDays(this.options['entityData']['da'], -1);
      this.maxEndDate = new Date(this.options['entityData']['a']);
    }
    if (!this.isDialogMode) {
      this.paramsSub = this.activatedroute.params.subscribe(res => {
        this.entityId = res.entityId;
        //console.log('entity', this.entityId);
      });
    }

    this.form = new FormGroup({
      idEvento: new FormControl(this.entityId || null, [Validators.nullValidator]),
      nomeEvento: new FormControl(this.entityData ? this.entityData.nomeEvento : null, [Validators.required]),
      respEvento : new FormControl(this.entityData ? this.entityData.respEvento : null, [Validators.required]),
      aulaEvento: new FormControl(this.entityData ? this.entityData.aulaEvento : null, [Validators.required]),
      tipoEvento: new FormControl(this.entityData ? this.entityData.tipoEvento : null, [Validators.required]),
      //maxPartecipanti: new FormControl(this.entityData ? this.entityData.maxPartecipanti : null, [Validators.required, Validators.min(1), Validators.max(this.maxAula)]),
      nPresenti: new FormControl(this.entityData ? this.entityData.nPresenti : null, []),
      gradoRiempAula: new FormControl(this.entityData ? this.entityData.gradoRiempAula : null, []),
      dataOraInizio: new FormControl(this.entityData ? this.entityData.dataOraInizio : null, [Validators.required]),
      dataOraFine: new FormControl(this.entityData ? this.entityData.dataOraFine : null, [Validators.required]),
    });
    if (Helpers.checkIfSupervisor()) {
      const supervisorApi = new UniversalApi<Responsabile>(this.injector);
      supervisorApi.setEntity('Responsabile');
      const tmpSupervisors = await supervisorApi.getRequest().toPromise().catch((err)=>this.universalApi.handleError(err)) || [];
      if (tmpSupervisors.length > 0) {
        const found = tmpSupervisors.find((s)=> s.usernameResp === localStorage.getItem('username'));
        if (found) {
          this.form.get('respEvento').patchValue(found.idResp);
        }
      }
      this.form.get('respEvento').disable();
    }
    this.embedded = this.options && this.options['isEmbedded'] ? true : false;
    //this.onClassroomChange(this.form.get('aulaEvento').value);
    if (this.embedded) {
      this.form.get('aulaEvento').disable();
    }


    //console.log('embedded', this.embedded );
    this.universalApi = new UniversalApi<Evento>(this.injector);
    this.universalApi.setEntity('Evento');
    if (this.entityId) {
      await this.getData();
    }
    //console.log('form',this.form);
    //console.log('this', this, this.options, this.entityId);
    if (this.isInEdit('idEvento')) {
      this.getEventStatus(this.form.get('dataOraInizio').value,this.form.get('dataOraFine').value );
      this.form.get('aulaEvento').disable();
      this.form.get('dataOraInizio').disable();
      this.form.get('dataOraFine').disable();
      this.checkIfInProgress()
      if (this.eventStatus !== 'Pianificato') {
        this.form.disable();
        this.form.get('gradoRiempAula').enable();
        if (this.eventStatus === 'In Corso') {
          this.form.get('nPresenti').enable();
        }
      }

    }

    if(this.options && this.options['isView']) {
      this.form.disable();
    }

  }

  onMaxPartecipantChange(newVal) {
    //console.log('onMaxPartecipantChange', newVal, this.maxAula);
    if (newVal > this.maxAula) {
      this.form.get('nPresenti').patchValue(this.maxAula);
    }
  }

  getEventStatus(dateStart: Date, dateEnd: Date) {
    const currentDate = new Date();
    if (currentDate >= dateStart && currentDate <= dateEnd) {
      this.eventStatus = 'In Corso';
      return this.eventStatus;
    }
    if (currentDate >= dateEnd) {
      this.eventStatus = 'Concluso';
      return this.eventStatus;
    }
    this.eventStatus = 'Pianificato';
    return this.eventStatus;
  }

  getStatusInput(eventStatus: string) {
    switch (eventStatus) {
      case 'Concluso':
        return 'primary';
      case 'Pianificato':
        return 'warning';
      case 'In Corso':
        return 'success';
      default:
        return 'info';
    }
  }
  // async onClassroomChange(newVal) {
  //   if(newVal) {
  //     const resp = await this.classroomApi.getSingle(newVal).toPromise().catch((error)=> this.showError(error));
  //     if(resp) {
  //       this.maxAula = resp['capienzaMax'];
  //       if (this.form.get('maxPartecipanti').value > this.maxAula) {
  //         this.form.get('maxPartecipanti').patchValue(this.maxAula);
  //       }
  //     }
  //   }
  // }
  async getData() {

    const resp = await this.universalApi.getSingle(this.entityId).toPromise();

    this.form.patchValue({
      idEvento: resp['idEvento'],
      nomeEvento: resp['nomeEvento'],
      aulaEvento: resp['aulaEvento']['idAula'],
      respEvento: resp['respEvento']['idResp'],
      dataOraInizio: Helpers.convertDateFromApi(resp['dataOraInizio']),
      dataOraFine: Helpers.convertDateFromApi(resp['dataOraFine']),
      //maxPartecipanti: resp['maxPartecipanti'],
      tipoEvento: resp['tipoEvento'],
      nPresenti: resp['nPresenti'],
      gradoRiempAula: resp['gradoRiempAula']
    });
      // dataOraFine: Helpers.convertDateFromApi(resp['dataOraFine']),
    //console.log('singledata', resp);
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
  async onSave() {

    this.form.enable();
    const formData = { ...this.form.value };
    formData.gradoRiempAula = formData.gradoRiempAula ? formData.gradoRiempAula / 100 : 1;
    formData.dataOraInizio = Helpers.convertDateForApi(formData.dataOraInizio);
    formData.dataOraFine = Helpers.convertDateForApi(formData.dataOraFine);
    const updatedEntity = await this.universalApi.putOrCreate(formData[this.universalApi.getEntityKey()],formData).toPromise().catch((err)=>this.universalApi.handleError(err));

    if (updatedEntity) {
      // this.universalApi.goToForm(updatedEntity[this.universalApi.modelPrimaryKey]);

      await this.afterSave();
      if(this.embedded) {
        const bookingApi = new UniversalApi<Prenotazione>(this.injector);
        bookingApi.setEntity('Prenotazione');
        bookingApi.goToIndex();
      }
      this.universalApi.goToIndex();

    }
  }

  checkIfInProgress() {
    if(this.form.get('dataOraInizio').value && this.form.get('dataOraInizio').value < new Date()) {
      this.inProgress = true;
      // if(this.form.get('dataOraFine').value && this.form.get('dataOraFine').value > new Date()) {
      // }
    }
  }
  onStartChange(newVal, skipDelete = true) {
    if (!skipDelete) {
      if (this.canStartChange ) {
        this.canStartChange = false;
        if(newVal) {
          if (this.minStartDate && newVal < this.minStartDate) {
            this.form.get('dataOraInizio').patchValue(this.minStartDate);
            this.startErr = 'inserita data/ora precedente, riportata al minimo disponibile';
          } else if (this.form.get('dataOraFine').value && newVal > this.form.get('dataOraFine').value) {
            this.form.get('dataOraInizio').patchValue(Helpers.addMinutes(this.form.get('dataOraFine').value, -60));
            this.startErr = 'inserita data/ora successiva alla fine, riportata ad un ora antecedente';
          }else if (newVal < new Date()){
            this.form.get('dataOraInizio').patchValue(Helpers.addMinutes(new Date(), 10));
            this.startErr = 'inserita data/ora precedente a quella attuale, riportata ad un ora successiva';
          }
           else {
            this.startErr = null;
          }
          this.minStartDate = new Date(this.form.get('dataOraInizio').value);
        }
      } else {
        this.canStartChange = true;
      }
    }
  }
  onEndChange(newVal) {
    //console.log('onStartChange', newVal, this.maxEndDate, newVal > this.maxEndDate);
    if (this.canEndChange ) {
      this.canEndChange = false;
      if(newVal) {
        if (this.maxEndDate && newVal > this.maxEndDate) {
          this.form.get('dataOraFine').patchValue(this.maxEndDate);
          this.endErr = 'inserita data/ora oltre il range, riportata alla massima disponibile';
        } else if (this.form.get('dataOraInizio').value && newVal < this.form.get('dataOraInizio').value) {
          this.form.get('dataOraFine').patchValue(Helpers.addMinutes(this.form.get('dataOraInizio').value, 60));
          this.endErr = 'inserita data/ora precedente a data inizio, riportata ad un ora successiva';
        }else if (newVal < new Date()){
          this.form.get('dataOraFine').patchValue(Helpers.addMinutes(new Date(), 60));
          this.endErr = 'inserita data/ora precedente a quella attuale, riportata ad un ora successiva';
        }
        else {
          this.endErr = null;
        }
        this.maxStartDate = new Date(this.form.get('dataOraFine').value);
      }
    } else {
      this.canEndChange = true;
    }
  }


}

