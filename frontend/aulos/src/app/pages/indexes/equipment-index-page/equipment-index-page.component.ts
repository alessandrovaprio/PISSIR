import { formatDate } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { NbDialogService } from '@nebular/theme';
import { LocalDataSource, Ng2SmartTableComponent } from 'ng2-smart-table';
import { Subscription } from 'rxjs';
import { Attrezzatura } from 'src/classes/Attrezzatura';
import { Helpers } from 'utils/helpers';
import { Paths } from 'utils/paths';
import { UniversalApi } from 'utils/universal-api';

@Component({
  selector: 'app-equipment-index-page',
  templateUrl: './equipment-index-page.component.html',
  styleUrls: ['./equipment-index-page.component.scss']
})
export class EquipmentIndexPageComponent implements OnInit {

  apiEventsSub: Subscription;
  data:Attrezzatura[] = [];
  modelDefinition: string;
  fieldsOrder: string[] = [];
  searchTerm: string;
  classrooms: Attrezzatura[] = [];
  universalApi: UniversalApi<Attrezzatura>;
  loading = false;
  constructor(
    private router: Router,
    private nbDialogSvc: NbDialogService,
    private injector: Injector,
    private http:HttpClient

  ) {   }

  async ngOnInit() {

    this.universalApi = new UniversalApi<Attrezzatura>(this.injector);
    this.universalApi.setEntity('Attrezzatura');


    //this.data = await this.searchDummy();
    //this.data = await this.search();
    this.loading = true;
    await this.search();
    this.loading = false;
    this.modelDefinition = 'Attrezzatura';
  }

  onCreate() {
    this.router.navigate([Paths.FORM(this.universalApi.entity, null)], { queryParams: {} });
  }
  ngOnDestroy() {
    //this.apiEventsSub.unsubscribe();
  }

  async search() {
    const rows = await this.universalApi.getRequest().toPromise();
    for (const d of (rows as any)) {
      this.data.push(d);
    }
  }
}
