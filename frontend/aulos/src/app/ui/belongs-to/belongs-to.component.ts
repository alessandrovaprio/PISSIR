import { Component, OnInit, Input, forwardRef, Output, EventEmitter, Injector, ViewChild, Renderer2, ElementRef } from '@angular/core';
import { UIService } from '../ui.service';
import { NG_VALUE_ACCESSOR, ControlValueAccessor, FormGroup } from '@angular/forms';
import { NbDialogService } from '@nebular/theme';
import { coerceBooleanProperty } from '@angular/cdk/coercion';
import { ConfigService } from '../../services/config.service';
import {UniversalApi} from '../../../../utils/universal-api'
import { SelectListComponent } from '../select-list/select-list.component';

@Component({
  selector: 'app-belongs-to',
  templateUrl: './belongs-to.component.html',
  styleUrls: ['./belongs-to.component.scss'],
  providers: [{
    provide: NG_VALUE_ACCESSOR,
    useExisting: forwardRef(() => BelongsToComponent),
    multi: true
  }]
})
export class BelongsToComponent implements ControlValueAccessor {


  @Input()
  entity: string;

  @Input()
  relation: string;

  @Input()
  descrField: string;

  @Input()
  universalApi: UniversalApi<any>;

  @Input()
  disabled: boolean = false;

  @Input()
  mode = 'default';

  @Input()
  useLabel: boolean = true;

  @Input()
  readonly: boolean = false;

  @Input()
  disableField: string;

  @Input()
  customPrimaryKey: string;

  @Input()
  showPreview: boolean;

  @Input()
  nullValueInOptions: boolean = false;

  @Input()
  required: boolean = false;

  @Input()
  placeholder: string;

  @Input()
  maxDescriptionLength: number = 20;

  value: any;
  relationData: any;
  availableItems: any = [];
  loading: boolean = true;

  onChange: (_: any) => void = (_: any) => { };
  onTouched: () => void = () => { };

  get modelRelation() {
    const allRelations = this.configSvc.getRelations(this.entity);
    console.log('allRelations.includes(this.relation)', allRelations.includes(this.relation), this.relation);
    return allRelations.includes(this.relation) ? this.relation : null;
  }
  get buttonColor () {
    if (this.value) {
      if (this.relationData && this.relationData.dtDeleted) {
        return 'warning';
      }
      return 'primary'
    } else {
      return 'info';
    }
  }
  get descrFieldString() {
    let resp = '';

    try {
      const keys = this.descrField.split(',');

      for (const key of keys) {
        if (this.relationData[key]) {
          resp = `${resp} ${this.relationData[key]}`;
        }
      }

      return resp;
    } catch (err) {
      return '';
    }
  }

  @Input()
  pageForm: FormGroup;

  @Input()
  clearFields: string;

  constructor(
    public uiSvc: UIService,
    //private authSvc: AuthService,
    private configSvc: ConfigService,
    private dialogSvc: NbDialogService,
    private injector: Injector,
    private renderer : Renderer2
  ) {
    this.universalApi = new UniversalApi(this.injector);
  }

  clearValues() {
    if (this.clearFields) {
      const newVal = {};
      for (const field of this.clearFields.split(',')) {
        if (this.pageForm.value[field]) {
          newVal[field] = null;
        }
      }
      this.pageForm.patchValue(newVal);
    }
  }

  isNumericValue() {
    return /^\d+$/.test(this.value);
  }

  ngOnInit() {
    console.log('entity', this.entity);
    console.log('descr', this.descrField, this.relation);
    //console.log('uselabellll', this.useLabel,this.entity,this.value, this.relation, this.descrField, this.relationData);
    //console.log('thisss', this);

    // if (this.searchFilter && !this.searchFilter.length && !this.searchFilter[0]) {
    //   console.warn(`[${this.entity}] searchFilter: invalid format!`)
    //   this.searchFilter = undefined;
    // }

    //  if (!DetailsIndex[this.universalApi.entity] && this.configSvc.isProduction) {
    //    this.showPreview = false;
    //  }
  }

  async writeValue(value: any): Promise<void> {
    this.value = value;

    if (this.modelRelation) {
      const model = this.modelRelation;
      //const currentUser = this.authSvc.currentUser;

      this.universalApi.setEntity(model);

      if (this.value) {

      this.relationData = await this.universalApi.getSingle(value).toPromise().catch((err)=>this.universalApi.handleError(err));
      } else {
        delete this.relationData;
      }

    }

    this.loading = false;
  }

  registerOnChange(fn: any): void {
    this.onChange = fn;
  }

  registerOnTouched(fn: any): void {
    this.onTouched = fn;
  }

  setDisabledState( isDisabled : boolean ) : void {
    this.disabled = isDisabled;
  }
  onSelectChange(newValue) {
    //console.log('onSelectChange', this.value, newValue)
    this.value = newValue;
    this.onChange(this.value);
    this.onTouched();
  }

  async onSelectRelation() {
    if (this.readonly) {
      return;
    }

    if (!await this.askConsent()) {
      return;
    }

    const dialogRef = this.dialogSvc.open(SelectListComponent, { context: { universalApi: this.universalApi, showPreview: this.showPreview, currentSelection: this.relationData } });

    dialogRef.onClose.subscribe((res) => {
      if (res) {
        this.value = res[this.customPrimaryKey || this.universalApi.getEntityKey()];
        this.relationData = res;
        this.onChange(this.value);
        this.onTouched();
      }
    });
  }

  async onClearRelation() {
    if (this.readonly) {
      return;
    }

    if (!await this.askConsent()) {
      return;
    }

    delete this.relationData;
    this.value = null;
    this.onChange(this.value);
    this.onTouched();
  }

  checkDisable(element: any) {
    if ( element[this.disableField] !== undefined && element[this.disableField] !== null && typeof element[this.disableField] === 'boolean') {
      return !element[this.disableField];
    }
    return false;
  }

  private async askConsent() {
    if (
      this.clearFields
    ) {
      if (await this.uiSvc.confirmDialog({ title: 'Attenzione!', message: 'I campi del form che dipendono da questo verranno azzerati. Continuare?'})) {
        return true;
      } else {
        return false;
      }
    }

    return true;
  }

  getStringAbbreviated(value: string) {
    if (this.maxDescriptionLength) {
      return `${value.substr(0, this.maxDescriptionLength)}..`;
    }
  }
  printData(val) {
    console.log("printData", val);
  }
}
