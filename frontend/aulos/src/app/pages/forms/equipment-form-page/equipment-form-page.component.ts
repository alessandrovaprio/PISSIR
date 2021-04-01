import { Component, Injector, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { BaseFormComponent } from '../base/base-form/base.form.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { UIService } from 'src/app/ui/ui.service';
import { UniversalApi } from 'utils/universal-api';
import { Attrezzatura } from 'src/classes/Attrezzatura';
import { NbToastrService } from '@nebular/theme';
@Component({
  selector: 'app-equipment-form-page',
  templateUrl: './equipment-form-page.component.html',
  styleUrls: ['./equipment-form-page.component.scss']
})
export class EquipmentFormPageComponent extends BaseFormComponent<Attrezzatura> implements OnInit {

  //public form: FormGroup;
  @Input()
  public options: any;

  constructor(
    public router: Router,
    public activatedroute: ActivatedRoute,
    private injector: Injector,
    public uiSvc: UIService,
    public nbToastrSvc: NbToastrService
    ) {
    super();
  }

  async ngOnInit() {
    this.paramsSub = this.activatedroute.params.subscribe(res => {
      this.entityId = res.entityId;
      //this.entity = "Attrezzatura";
      //console.log('entity', this.entityId);
    });
    this.form = new FormGroup({
      idAttrezzatura: new FormControl(this.entityData ? this.entityData.idAttrezzatura : null, [Validators.nullValidator]),
      nomeAttrezzatura: new FormControl(this.entityData ? this.entityData.nomeAttrezzatura : null, [Validators.nullValidator])
    });

    this.universalApi = new UniversalApi<Attrezzatura>(this.injector);
    this.universalApi.setEntity('Attrezzatura');
    await this.getData();
  }

  async getData() {
    const attrezzatura = await this.universalApi.getSingle(this.entityId).toPromise();
    this.form.patchValue({
      idAttrezzatura: attrezzatura.idAttrezzatura,
      nomeAttrezzatura: attrezzatura.nomeAttrezzatura
    });
  }
  // onSave() {
  //   //check if it has saved sucessfully
  //   this.uiSvc.showToast('salvataggio eseguito', 'esecuzione completata', 'success');

  // }


}
