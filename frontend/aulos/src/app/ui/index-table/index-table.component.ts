import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Router } from '@angular/router';
import { NbDialogService } from '@nebular/theme';
import { Columns, Config, DefaultConfig } from 'ngx-easy-table';
import { EventFormPageComponent } from 'src/app/pages/forms/event-form-page/event-form-page.component';
import { ConfigService } from 'src/app/services/config.service';
import { Prenotazione } from 'src/classes';
import { Paths } from 'utils/paths';
import { UniversalApi } from 'utils/universal-api';
import { UIService } from '../ui.service';


interface IndexColumns extends Columns {
  type: string;
  resolvers?: string[];
}

export interface IndexTableConfig {
  visible: boolean;
  config: Config;
  columns: IndexColumns[];
  canView: boolean;
  canEdit: boolean;
  canDelete: boolean;
  canClone: boolean;
  canCreate: boolean;
  canSelect: boolean;
  showDeleted: boolean;
}

interface EventObject {
  event: string;
  value: {
    limit: number;
    page: number;
  };
}

@Component({
  selector: 'app-index-table',
  templateUrl: './index-table.component.html',
  styleUrls: ['./index-table.component.scss']
})
export class IndexTableComponent implements OnInit {

  @Input()
  universalApi: UniversalApi<any>;

  @Input()
  modelDefinition: string

  @Input()
  fieldsOrder: string[] = []
  @Input()
  data: any

  @Input()
  limitForPage: number = 150;

  @Input()
  currentSelection: any;
  currentSelectionId: any;

  @Input()
  selectable: boolean = false;

  @Input()
  useModals: boolean = false;

  @Output()
  onSelect: EventEmitter<any> = new EventEmitter();

  @Input()
  dialog: boolean = false;

  @Input()
  useCustomFilter: boolean = false;

  @Input()
  canCreate = false;
  @Input()
  canEdit = false;
  @Input()
  canDelete = false;
  @Input()
  useLocalStorage = false;

  config: IndexTableConfig = {
    visible: false,
    columns: [],
    config: { ...DefaultConfig },
    canView: false,
    canEdit: false,
    canDelete: false,
    canClone: false,
    canCreate: false,
    canSelect: false,
    showDeleted: false,
  };

  tablePagination: any = {
    limit: 30,
    offset: 0,
    count: -1,
  };
  rows: any[];

  //events toggles
  onGoing = false;
  closed = false;
  booked = false;

  constructor(
    private router: Router,
    private configSvc: ConfigService,
    // private authSvc: AuthService,
    public uiSvc: UIService,
    private nbDialogSvc: NbDialogService,
  ) { }

  async ngOnInit() {
    // this.config.canCreate = this.authSvc.canCreate(this.universalApi.entity);
    console.log('currentSelect', this.currentSelection, this.currentSelectionId);
    this.config.config.searchEnabled = true;
    this.config.canEdit = true;
    this.config.canDelete = true;
    this.config.canCreate = this.canCreate;
    if (!this.data || this.data.length === 0) {
      this.data = await this.universalApi.getRequest().toPromise().catch((err)=>this.universalApi.handleError(err));
    }
    this.rows = [...this.data];

    // // if select mode
    if (this.selectable) {
      this.config.canSelect = true;
      this.config.canCreate = false;
      this.config.canEdit = false;
      this.config.canClone = false;
      this.config.canDelete = false;
      this.config.config.selectRow = true;

      if (this.currentSelection) {
        const entityId = this.currentSelection[this.universalApi.getEntityKey()];
        if (entityId) {
          this.currentSelectionId = entityId;
        }
      }
    }

    await this.initTable();
  }

  onTableEvent($event: { event: string; value: any }): void {
    if ($event.event !== 'onClick') {
      this.parseTableEvent($event);
    } else {
      if (this.config.config.selectRow) {
        this.onSelect.emit($event.value.row);
      }
    }
  }

  //only for event index
  onStatusToggle(newVal, status: string) {
    const value = newVal;
    // if true I filter otherwise recover data
    if (value) {
      console.log('filter',value, status);
      this.data = this.data.filter((evt) => {
                          console.log('evt', evt, evt.statoEvento.toString().toLowerCase(), status.toString().toLowerCase(), evt.statoEvento.toString().toLowerCase()===status.toString().toLowerCase());
                          return evt.statoEvento.toString().toLowerCase() === status.toString().toLowerCase();
                        });
    } else {
      console.log('reset filter',value);
      this.data = [...this.rows];
    }
  }

  selectRow(row: any) {
    this.onSelect.emit(row);
  }


  async onAction(action, row) {
    // const useDialog = this.universalApi.entity === 'Prenotazione' ? true : false;
    const useDialog = false;
    //const obj = Object.create(window[this.universalApi.entity].prototype)
    console.log('this.universalApi.entity', this.universalApi.entity);
    //const entityId = row[];
    //const entityId = row[this.configSvc.modelsKey[this.universalApi.entity]];
    const entityId = row[this.universalApi.getEntityKey()];

    switch (action) {
      case 'detail':
        this.router.navigate([Paths.DETAIL(this.universalApi.entity, entityId)]);
        break;
      case 'create':
        if(useDialog) {

        } else {
          if (this.useLocalStorage) {
            localStorage.setItem(this.universalApi.entity, JSON.stringify(row));
          }
          this.router.navigate([Paths.FORM(this.universalApi.entity)]);
        }
        break;
      case 'edit':

        console.log('edit', this.universalApi.entity, entityId);
        if(useDialog) {
          const options = {};
          options['isDialog'] = true;
          options['data'] = row;
          //const dialogRef = this.nbDialogSvc.open(SalesBridgeDetailFormComponent, { context: { options } });
          // const dialogRef = this.nbDialogSvc.open(EventFormPageComponent, { context: {options} });
          // const result = await dialogRef.onClose.toPromise();
          const res = await this.uiSvc.formDialog(EventFormPageComponent, options);
          console.log('after this.nbDialogSvc', this.nbDialogSvc);

        } else {

          this.router.navigate([Paths.FORM(this.universalApi.entity, entityId)]);
        }
        break;
      case 'clone':
        this.router.navigate([Paths.CLONE(this.universalApi.entity, entityId)]);
        break;
      case 'delete':
        if (await this.uiSvc.confirmDialog({
          title: `Procedere con l'eliminazione?`,
          message: `L'operazione non puo' essere annullata`
        })) {
          let previous = this.universalApi.entity;
          if(this.universalApi.entity === 'Prenotazione') {
            this.universalApi.setEntity('Evento');
          }
          await this.universalApi.deleteById(entityId).toPromise().catch((err)=>this.universalApi.handleError(err));

          this.data = this.data.filter((d)=>{return d[this.universalApi.getEntityKey()] !== entityId} );
          this.rows = this.rows.filter((d)=>{return d[this.universalApi.getEntityKey()] !== entityId} );
          this.universalApi.setEntity(previous);

        }
        break;
      default:
        console.log(action, row);
        break;
    }
  }
  public getIcon() {
    return this.universalApi.entity = 'Prenotazione' ? 'eye-outline' : 'edit-outline'
  }


  // private
  private async parseTableEvent(obj: EventObject): Promise<void> {
    // console.log(`parseEvent`, obj)

    // if (obj.event === 'onPagination') {
    //   this.universalApi.tablePagination.limit = obj.value.limit ? obj.value.limit : this.universalApi.tablePagination.limit;
    //   this.universalApi.tablePagination.offset = obj.value.page ? obj.value.page : this.universalApi.tablePagination.offset;
    //   this.config.config.isLoading = true;
    //   await this.universalApi.getIndex();
    //   this.config.config.isLoading = false;
    // }

    // if (obj.event === 'onOrder') {
    //   this.universalApi.tableSorting = obj.value;
    //   this.config.config.isLoading = true;
    //   await this.universalApi.getIndex();
    //   this.config.config.isLoading = false;
    // }
  }

  private async initTable() {
  //   const modelDefinition = this.universalApi.modelDefinition;
  //   const fieldsOrder = this.configSvc.getEntityFieldsOrder(this.universalApi.entity);
  //   const relationResolvers = this.configSvc.getEntityRelationResolvers(this.universalApi.entity);

  //   // set table config
  if (this.fieldsOrder.length === 0) {
    this.fieldsOrder = this.universalApi.getEntityFields();
  }
     this.config.config.isLoading = true;
  //   this.config.config.tableLayout.striped = true;
     this.config.config.rows = this.limitForPage;

     for(const prop of this.fieldsOrder) {
       const propRelation = this.configSvc.getFieldType(this.universalApi.entity, prop)=== 'relation' ?  prop : null;
       const colType = this.getColType(prop);
       const col: IndexColumns = {
                key: prop,
                title: this.normalizeTitle(prop),
                type: colType,
                orderEnabled: true,
              };

              this.config.columns.push(col);

     }
      // add actions col
      this.config.columns.push({
        key: `actions`,
        title: ``,
        type: `actions`,
        orderEnabled: false
      });
    this.config.visible = true;
    this.config.config.isLoading = false;
  }

  // remove camel case and put the first letter in UpperCase
  private normalizeTitle(propName: string) {
    const noCamel = propName.replace(/([a-z0-9])([A-Z])/g, '$1 $2');
    let arr = noCamel.split(' ');
    arr.map( word => {
      return word.charAt(0).toUpperCase() + word.slice(1);
    });
    return arr.join(' ');
  }
  //get Column type
  private getColType(propName: string) {
    return this.configSvc.getFieldType(this.universalApi.entity,propName);
  }
  //   await this.universalApi.getIndex(true);

  //   if (modelDefinition) {
  //     for (const prop of fieldsOrder) {
  //       const isPrimaryKey = modelDefinition.idName === prop;
  //       const propRelation = modelDefinition.relations[prop];
  //       const propDefinition = modelDefinition.properties[prop];

  //       let colType = 'string';
  //       let colResolvers;

  //       if (propDefinition) {
  //         colType = propDefinition.type.toLowerCase();
  //       }

  //       if (!propDefinition && propRelation) {
  //         colType = 'relation';

  //         // handle belongsTo relations
  //         if (propRelation.relationType === 'belongsTo') {
  //           if (relationResolvers[prop]) {
  //             colResolvers = relationResolvers[prop];
  //           }
  //         }
  //       }

  //       if (prop.substr(0, 2).toLowerCase() === 'dt') {
  //         colType = 'date';
  //       }

  //       const col: IndexColumns = {
  //         key: prop,
  //         title: this.uiSvc.translate(modelDefinition.name, prop),
  //         type: colType,
  //         orderEnabled: colType !== 'relation',
  //         resolvers: colResolvers
  //       };

  //       this.config.columns.push(col);
  //     }

  //     // add actions col
  //     this.config.columns.push({
  //       key: `actions`,
  //       title: ``,
  //       type: `actions`,
  //       orderEnabled: false
  //     });
  //   }

  //   this.config.visible = true;
  //   this.config.config.isLoading = false;
  // }
  printData(element, el2?, el3?) {

    console.log('printData', element, el2, el3);
    console.log('metto assieme', Object.keys(element));
  }
}
