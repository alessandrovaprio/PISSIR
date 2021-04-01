import { formatDate } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injector, ViewChild } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NbDialogService } from '@nebular/theme';
import { LocalDataSource, Ng2SmartTableComponent } from 'ng2-smart-table';
import { Observable, Subscription } from 'rxjs';
import { KeycloakSecurityService } from 'src/app/services/keycloak-security.service';
import { Responsabile } from 'src/classes';
import { Aula } from 'src/classes/Aula';
import { Helpers } from 'utils/helpers';
import { Paths } from 'utils/paths';
import { UniversalApi } from 'utils/universal-api';
import { BaseFormComponent } from '../../forms/base/base-form/base.form.component';

@Component({
  selector: 'app-supervisor-index-page',
  templateUrl: './supervisor-index-page.component.html',
  styleUrls: ['./supervisor-index-page.component.scss']
})
export class SupervisorIndexPageComponent implements OnInit {

  apiEventsSub: Subscription;
  data:Responsabile[] = [];
  modelDefinition: string;
  fieldsOrder: string[] = [];
  searchTerm: string;
  classrooms: Responsabile[] = [];
  universalApi: UniversalApi<Responsabile>;
  http: HttpClient;
  constructor(
    private router: Router,
    private nbDialogSvc: NbDialogService,
    private injector: Injector,

    private keycloakSecurityService: KeycloakSecurityService,

  ) {   }

  async ngOnInit() {

    this.universalApi = new UniversalApi<Responsabile>(this.injector);
    this.universalApi.setEntity('Responsabile');

    // maybe in future
    //this.universalApi.getKeycloak();


    //this.data = await this.searchDummy();
    //this.data = await this.search();
    await this.search();
    console.log('data', this.data);
    this.modelDefinition = 'Supervisor';
    //this.fieldsOrder = ["idResp", "nomeResp", "cognomeResp", "emailResp"];
    //console.log('fieldsOrder', this.fieldsOrder);
    //this.initTable();
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
      console.log('data beofre json', d.toString());
      //this.data.push(JSON.parse(d.toString()));
      this.data.push(d);

    }
    console.log('mydata',this.data);

  }



}
