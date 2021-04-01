// libs
import { Injector } from '@angular/core';
import { Observable, Subject } from 'rxjs';

// elvispos
//import * as LoopbackSDK from '../sdk';
import { HttpClient, HttpHeaders } from '@angular/common/http';
//import { BaseLoopBackApi, LoopBackFilter } from '../sdk';
//import { ConfigService, CustomLoopBackApi } from '../app/services/config.service';
//import { IModelDefinition } from '../interfaces/model-definition.interface';
//import { AuthService } from 'src/app/auth/auth.service';
import { UIService } from 'src/app/ui/ui.service';
import { debounceTime, distinctUntilChanged, mergeMap } from 'rxjs/operators';
import { Router } from '@angular/router';
import { Paths } from './paths';
import { NbToastrConfig, NbGlobalLogicalPosition, NbToastrService } from '@nebular/theme';
import { ConfigService } from 'src/app/services/config.service';
import { KeycloakSecurityService } from 'src/app/services/keycloak-security.service';

export class UniversalApi<T> {

  http: HttpClient;
  router: Router;

  loading = false;
  enableLog: boolean = false;
  status: Subject<any> = new Subject();
  events: Subject<string> = new Subject();
  entities: string[] = ['aula', 'attrezzatura'];
  backendUrl = `http://localhost:15697`;
  data: {
    items: any[],
    count: number
  } = {
    items: [],
    count: 0
  };
  lastSearchTerm: string;
  searchTerm: string;
  orderByKey: string | string[];
  orderReverse: boolean = false;

  pageSize: number = 50;
  currentPage: number = 1;
  maxPages: number = 1;

  entity: string;
  entityFields: string[] = [];
  searchFilter: any = undefined;

  searchTermChanged = new Subject<string>();

  toastConfig: Partial<NbToastrConfig> = new NbToastrConfig({
    duration: 2500,
    status: 'success',
    position: NbGlobalLogicalPosition.BOTTOM_END
  });


  private uiSvc: UIService;

  private nbToastrSvc: NbToastrService;
  private configSvc: ConfigService;
  entityKey: string;
  keycloakSecurityService: KeycloakSecurityService;

  constructor( private injector: Injector ) {
    this.router = this.injector.get(Router);
    this.http = this.injector.get(HttpClient);
    this.configSvc = this.injector.get(ConfigService);
    // this.authSvc = this.injector.get(AuthService);
    this.uiSvc = this.injector.get(UIService);
    this.nbToastrSvc = this.injector.get(NbToastrService);
    this.enableLog = true;
    this.keycloakSecurityService = this.injector.get(KeycloakSecurityService);


  }

  handleError(error) {
    console.log('handleError', error);
  }
  async getKeycloak () {
    const resp = await this.keycloakSecurityService.getSupervisors(this.http);
  }

  getHeaders() {
    const tmpToken = localStorage.getItem('token');
    if ( tmpToken) {
      return {
        headers: new HttpHeaders({
          //'Content-Type': 'application/json',
          'Authorization': `Bearer ${tmpToken}`
        })
      }
    }
    this.router.navigate([('/login')]);
    return null;
  }
  getRequest() {
    const httpHeader = this.getHeaders();
    if (httpHeader) {
      const myurl = `${this.backendUrl}/${this.entity.toLowerCase()}`;
      //console.log('getRequest', this.http, myurl);
      return this.http.get<T[]>(myurl, httpHeader);
    }
    this.router.navigate([('/login')]);
    return null;
    //this.http
  }

  getSingle(id?: number) {
    //this.getAllModels();
    const httpHeader = this.getHeaders();
    if (httpHeader) {

      const myurl = `${this.backendUrl}/${this.entity.toLowerCase()}`+ (id ? `/${id}` : '') ;

      //console.log('getRequest', this.http, myurl);
      return this.http.get<T>(myurl);
    }
    this.router.navigate([('/login')]);
    return null;
  }

  putOrCreate(id: number, data: any) {
    const httpHeader = this.getHeaders();
    if (httpHeader) {
      if (id) {
        const myurl = `${this.backendUrl}/${this.entity.toLowerCase()}/${id}`;
        return this.http.put<T>(myurl, data);
      }
      const myurl = `${this.backendUrl}/${this.entity.toLowerCase()}`;
      return this.http.post<T>(myurl, data);

    }
    this.router.navigate([('/login')]);
    return null;
  }

  deleteById(id:number) {
    const httpHeader = this.getHeaders();
    if (httpHeader) {
      const myurl = `${this.backendUrl}/${this.entity.toLowerCase()}/${id}`;
      return this.http.delete<T>(myurl);
    }
    this.router.navigate([('/login')]);
    return null;
  }

  search() {
    return this.getRequest();
  }
  // nameOf(object: Object): string {
  //   return object.constructor.name;
  // }
  goToIndex(): void {
    this.router.navigate([Paths.INDEX(this.entity)]);
  }

  goToForm(entityId: string | number): void {
    this.router.navigate([Paths.FORM(this.entity, entityId)]);
  }

  getEntityFields(): string[] {
    if (this.entity) {
      return this.entityFields = this.configSvc.getFields(this.entity);
    }
    return [];
  }

  getEntityKey(): string {
    if (this.entity) {
      return this.entityKey = this.configSvc.getKey(this.entity);
    }
    return null;
  }



  setEntity(entity: string): void {
    this.entity = entity;

    if (this.enableLog) {
      console.log(`[UniveralAPI] setEntity`, this.entity);
    }
  }

}
