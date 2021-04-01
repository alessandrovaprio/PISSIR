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
import { Dispositivo } from 'src/classes';
import { NbToastrService } from '@nebular/theme';

@Component({
  selector: 'app-classroom-form-page',
  templateUrl: './classroom-form-page.component.html',
  styleUrls: ['./classroom-form-page.component.scss']
})
export class ClassroomFormPageComponent extends BaseFormComponent<Aula> implements OnInit {

  //public form: FormGroup;
  @Input()
  public options: any;

  public availableDevices: any[] = [];
  public assigneDevices: any[] = [];
  public toDelete: any[] = [];
  devicesApi: UniversalApi<unknown>;

  constructor(
    public router: Router,
    public activatedroute: ActivatedRoute,
    private injector: Injector,
    private uiSvc: UIService,
    public nbToastrSvc: NbToastrService)

    {
    super();
  }

  async ngOnInit() {
    this.paramsSub = this.activatedroute.params.subscribe(res => {
      this.entityId = res.entityId;
      //console.log('entity', this.entityId);
    });

    this.form = new FormGroup({
      idAula: new FormControl(this.entityId || null, [Validators.nullValidator]),
      nomeAula: new FormControl(this.entityData ? this.entityData.nomeAula : null, [Validators.nullValidator]),
      capienzaMax: new FormControl(this.entityData ? this.entityData.capienzaMax : null, [Validators.nullValidator]),
      capienzaMin: new FormControl(this.entityData ? this.entityData.capienzaMin : null, [Validators.nullValidator])
    });

    this.universalApi = new UniversalApi<Aula>(this.injector);
    this.universalApi.setEntity('Aula');
    this.devicesApi = new UniversalApi(this.injector);
    this.devicesApi.setEntity('Dispositivo');
    await this.getData();

  }

  async getData() {
    const aula = await this.universalApi.getSingle(this.entityId).toPromise();
    this.form.patchValue({
      idAula: aula.idAula,
      nomeAula: aula.nomeAula,
      capienzaMax: aula.capienzaMax,
      capienzaMin: aula.capienzaMin,
    });
    await this.getDevices();
  }
  async getDevices() {
    const res = await this.devicesApi.getRequest().toPromise().catch((err)=>this.universalApi.handleError(err) ) || [];
    if (res.length >0) {
      this.assigneDevices = res.filter(d=>
                 d['aulaDispositivo'] && d['aulaDispositivo']['idAula'] === (this.form.get('idAula').value ))

      this.availableDevices = [...res];
    }

    console.log('singledata', this.availableDevices);
  }

  async onAddAssign(dispositivo: Dispositivo) {
    this.assigneDevices.push(dispositivo);
    this.form.markAsDirty();
  }

  async onRemoveAssign(dispositivo: Dispositivo) {
    this.assigneDevices =
    this.assigneDevices.filter(i => i.idDispositivo !== dispositivo.idDispositivo);

    // if is not present I add it to array
    if(!this.toDelete.includes(dispositivo)) {
      this.toDelete.push(dispositivo);
    }
    this.form.markAsDirty();
    //this.entityAssigns.StoreGroupDef.touched = true;
  }
  isAssignable(dispositivo: Dispositivo) {
    //console.log('isAssignable', dispositivo['aulaDispositivo']['idAula'], this.form.value.idAula)
    if (dispositivo['aulaDispositivo'] && dispositivo['aulaDispositivo']['idAula'] !== this.form.value.idAula) {
      return false;
    }
    let found = this.assigneDevices.find(ass=> ass['idDispositivo'] === dispositivo.idDispositivo);

    return found ? false : true;
  }
  async onSave() {
    const formData = { ...this.form.value };
    const updatedEntity = await this.universalApi.putOrCreate(formData[this.universalApi.getEntityKey()],formData).toPromise().catch((err)=>this.universalApi.handleError(err));

    if (updatedEntity) {
      // this.universalApi.goToForm(updatedEntity[this.universalApi.modelPrimaryKey]);
      this.toDelete.map(async (ass)=> {
        const found = this.assigneDevices.find(a => a['idDispositivo'] === ass['idDispositivo']);
        if (!found) {
          await this.devicesApi.putOrCreate(ass.idDispositivo,
            {
              aulaDispositivo: null,
              idDispositivo: ass.idDispositivo,
              nomeDispositivo: ass.nomeDispositivo,
              marcaDispositivo: ass.marcaDispositivo,
              dataInstallazione: ass.dataInstallazione
            }
            ).toPromise().catch((err)=>this.universalApi.handleError(err));
        }
      })
      this.assigneDevices.map(async (ass)=> {
        console.log('fff', ass);
        await this.devicesApi.putOrCreate(ass.idDispositivo,
          {
            aulaDispositivo: formData.idAula,
            idDispositivo: ass.idDispositivo,
            nomeDispositivo: ass.nomeDispositivo,
            marcaDispositivo: ass.marcaDispositivo,
            dataInstallazione: ass.dataInstallazione
          }
          ).toPromise().catch((err)=>this.universalApi.handleError(err));
      })
      // for(const ass of this.assigneDevices) {
      //   await this.devicesApi.putOrCreate(ass.idDispositivo, {"idAula": updatedEntity});
      // }
      await this.afterSave();
      this.universalApi.goToIndex();

    }
  }


}
