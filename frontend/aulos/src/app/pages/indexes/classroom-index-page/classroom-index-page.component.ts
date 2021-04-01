import { formatDate } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Inject } from '@angular/core';
import { Injector, ViewChild } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NbDialogService } from '@nebular/theme';
import { LocalDataSource, Ng2SmartTableComponent } from 'ng2-smart-table';
import { Observable, Subscription } from 'rxjs';
import { Aula } from 'src/classes/Aula';
import { Helpers } from 'utils/helpers';
import { Paths } from 'utils/paths';
import { UniversalApi } from 'utils/universal-api';
import { BaseFormComponent } from '../../forms/base/base-form/base.form.component';

@Component({
  selector: 'app-classroom-index-page',
  templateUrl: './classroom-index-page.component.html',
  styleUrls: ['./classroom-index-page.component.scss']
})
export class ClassroomIndexPageComponent implements OnInit {

  apiEventsSub: Subscription;
  data:Aula[] = [];
  modelDefinition: string;
  fieldsOrder: string[] = [];
  searchTerm: string;
  classrooms: Aula[] = [];
  universalApi: UniversalApi<Aula>;
  constructor(
    private router: Router,
    private injector: Injector,

  ) {   }

  async ngOnInit() {
    this.universalApi = new UniversalApi<Aula>(this.injector);
    this.universalApi.setEntity('Aula');

    await this.search();
    this.modelDefinition = 'Classroom';
  }

  onCreate() {
    this.router.navigate([Paths.FORM(this.universalApi.entity, null)], { queryParams: {} });
  }
  ngOnDestroy() {
    //this.apiEventsSub.unsubscribe();
  }
  initTable() {

  }
  async searchDummy() {

    await Helpers.sleep(2500);
    return this.getDummyData();

  }

  async search() {


    // const tempUApi = new UniversalApi(this.injector);
    // tempUApi.setEntity('aula');

    const rows = await this.universalApi.getRequest().toPromise();
    for (const d of (rows as any)) {
      console.log('data beofre json', d.toString());
      //this.data.push(JSON.parse(d.toString()));
      this.data.push(d);

    }
    //this.data = [...this.classrooms];

    console.log('mydata',this.data);
    // for (const r of rows) {
    //   //this.data.push(new Aula(r));
    //   console.log('rrrrr', r);
    // }
    //this.data =  await tempUApi.getRequest().toPromise() || [];
    //console.log('search data', tmp);
    //return tmp;
  }

  getDummyData(): any[] {
    const arr = [];
    const tmp = {
      aula_id : 1,
      aula_nome: 'test1',
      aula_capienza_max: '150',
      aula_capienza_min: '1',

    };
    const tmp2 = {
      aula_id : 2,
      aula_nome: 'test2',
      aula_capienza_max: '250',
      aula_capienza_min: '1',

    };
    arr.push(tmp);
    arr.push(tmp2);
    return arr;
  }

}
