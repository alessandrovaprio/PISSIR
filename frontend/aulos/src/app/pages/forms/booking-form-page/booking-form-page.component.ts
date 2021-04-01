//import { Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { BaseFormComponent } from '../base/base-form/base.form.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router, ActivatedRoute, Data } from '@angular/router';
import { UIService } from 'src/app/ui/ui.service';
import { Aula } from 'src/classes/Aula';
import { Component, Inject, Injector, Input, OnInit } from '@angular/core';
import { getAllJSDocTags, NumberLiteralType } from 'typescript';
import { UniversalApi } from 'utils/universal-api';
import { Subscription } from 'rxjs';
import { Evento, Prenotazione, Responsabile } from 'src/classes';
import { Helpers } from 'utils/helpers';
import { NbDialogRef, NbToastrService } from '@nebular/theme';

@Component({
  selector: 'app-booking-form-page',
  templateUrl: './booking-form-page.component.html',
  styleUrls: ['./booking-form-page.component.scss']
})
export class BookingFormPageComponent extends BaseFormComponent<Prenotazione> implements OnInit {

  //public form: FormGroup;
  @Input()
  public options: any;

  optionsData: Evento;
  eventId: number;
  constructor(
    public router: Router,
    public activatedroute: ActivatedRoute,
    private injector: Injector,
    public uiSvc: UIService,
    public nbToastrSvc: NbToastrService
    )

    {
    super();
  }

  async ngOnDestroy() {
    localStorage.removeItem(this.universalApi.entity);
  }
  async ngOnInit() {

    this.universalApi = new UniversalApi<Prenotazione>(this.injector);
    this.universalApi.setEntity('Prenotazione');
    this.options = {};
    this.options['isEmbedded'] = true;
    this.options['isView'] = false;
    if (localStorage.getItem(this.universalApi.entity)) {
      this.options['entityData'] = JSON.parse(localStorage.getItem(this.universalApi.entity));
    }
  }



  onClose(result: boolean = false) {
    this.dialogRef.close(result);
  }
  async onSave() {
    const formData = { ...this.form.value };
    formData.dataOraInizio = Helpers.convertDateForApi(formData.dataOraInizio);
    formData.dataOraFine = Helpers.convertDateForApi(formData.dataOraFine);
    const updatedEntity = await this.universalApi.putOrCreate(formData[this.universalApi.getEntityKey()],formData).toPromise().catch((err)=>this.universalApi.handleError(err));

    if (updatedEntity) {
      // this.universalApi.goToForm(updatedEntity[this.universalApi.modelPrimaryKey]);

      await this.afterSave();
      this.universalApi.goToIndex();

    }
  }


}
