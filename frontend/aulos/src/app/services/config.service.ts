import { Injectable, Injector } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import * as Models from '../../classes/index';
// import { UserApi, LoopBackConfig, LoopBackAuth, SDKToken, SystemUser, MaintFuncNodeApi, MaintFuncNode, MaintFuncGroup, BaseLoopBackApi } from '../../sdk';
// import { environment } from 'src/environments/environment';
// import { NbMenuItem, NbSidebarService } from '@nebular/theme';
// import { Router } from '@angular/router';
// import { Helpers } from '../../utils/helpers';
// import { Paths } from '../../utils/paths';
// import { AuthService } from '../auth/auth.service';
// import { IModelDefinition } from 'src/interfaces/model-definition.interface';
import { Observable } from 'rxjs';
import { Aula } from '../../classes/index';

// export interface CustomLoopBackApi extends BaseLoopBackApi {
//   patchAttributes: (id: any, data: any, customHeaders?: { readonly name: string }) => Observable<any>;
//   patchOrCreate: (data: any, customHeaders?: { readonly name: string }) => Observable<any>;
// }

@Injectable({
  providedIn: 'root'
})
export class ConfigService {

  apiUrl: string;

  models: string[] = [];
  modelSettings: any = {};


  constructor(
    //private injector: Injector,
    // private lbAuth: LoopBackAuth,
    // private userApi: UserApi,
    // private authSvc: AuthService
  ) {
  }


  async init() {
    console.log('init configsvc');
    if (!this.apiUrl) {
      await this.loadModels();
      return true;
    } else {
      return false;
    }
  }


// load all model from files
  public loadModels() {
    console.log('loadModels', Models);

    for (const model in Models) {

      if (!this.models.includes(model)) {
        this.models.push(model);
      }
    }
  }
  // get fields of the models
  public getFields (modelName: string) {
    const obj = Object.create(Models[modelName]);
    return obj.prototype.getFields();;
    //return obj.prototype.getFields;
  }

  // get primary key of model
  public getKey (modelName: string): string {
    const obj = Object.create(Models[modelName]);
    return obj.prototype.getKey();
  }

  public getRelations(modelName: string): string[] {
    const obj = Object.create(Models[modelName]);
    return obj.prototype.getRelations();
  }
  // get field type for table
  public getFieldType(modelName: string, fieldName: string): string {
    const obj = Object.create(Models[modelName]).prototype;
    return obj.getFieldType(fieldName);
  }

}
