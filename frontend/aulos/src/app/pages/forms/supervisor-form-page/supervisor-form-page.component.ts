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
import { Responsabile } from 'src/classes';
import { NbToastrService } from '@nebular/theme';

@Component({
  selector: 'app-supervisor-form-page',
  templateUrl: './supervisor-form-page.component.html',
  styleUrls: ['./supervisor-form-page.component.scss']
})
export class SupervisorFormPageComponent extends BaseFormComponent<Responsabile> implements OnInit {

  //public form: FormGroup;
  @Input()
  public options: any;


  constructor(
    public router: Router,
    public activatedroute: ActivatedRoute,
    private injector: Injector,
    public uiSvc: UIService,
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
      idResp: new FormControl(this.entityId || null, [Validators.nullValidator]),
      nomeResp: new FormControl(this.entityData ? this.entityData.nomeResp : null, [Validators.required]),
      cognomeResp : new FormControl(this.entityData ? this.entityData.cognomeResp : null, [Validators.required]),
      usernameResp : new FormControl(this.entityData ? this.entityData.cognomeResp : null, [Validators.required]),
      // emailResp: new FormControl(this.entityData ? this.entityData.emailResp : null, [Validators.required, Validators.pattern("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$")])
    });

    this.universalApi = new UniversalApi<Responsabile>(this.injector);
    this.universalApi.setEntity('Responsabile');
    await this.getData();
  }

  async getData() {
    const resp = await this.universalApi.getSingle(this.entityId).toPromise();
    this.form.patchValue({
      idResp: resp.idResp,
      nomeResp: resp.nomeResp,
      cognomeResp: resp.cognomeResp,
      usernameResp: resp.usernameResp
      // emailResp: resp.emailResp,
    });
  }
  // onSave() {
  //   //check if it has saved sucessfully
  //   this.uiSvc.showToast('salvataggio eseguito', 'esecuzione completata', 'success');

  // }


}
