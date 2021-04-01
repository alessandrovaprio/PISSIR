import { HttpClient, HttpHandler, HttpHeaders } from '@angular/common/http';
import { Injectable, Injector } from '@angular/core';
import { KeycloakInstance } from 'keycloak-js';
declare var Keycloak: any;

@Injectable({
  providedIn: 'root'
})
export class KeycloakSecurityService {

  public keycloak: KeycloakInstance;
  http: HttpClient;
  // public keycloak: any;

  constructor() {

   }

  init() {
    return new Promise((resolve, reject) => {
      this.keycloak = new Keycloak({
        url: 'http://localhost:8080/auth',
        realm: 'Aulos',
        clientId: 'angular'

      });
      this.keycloak.init({
        onLoad: 'login-required'
        //onLoad: 'check-sso'
        // promiseType: 'native'

      }).then(async (authenticated) => {
        const userinfo = await this.keycloak.loadUserInfo();
        localStorage.setItem('roles', this.keycloak.realmAccess.roles.toString())
        localStorage.setItem('token', this.keycloak.token);
        localStorage.setItem('username', userinfo['preferred_username'])
        resolve({ authenticated, token: this.keycloak.token, roles: this.keycloak.realmAccess.roles });
      }).catch(err => {
        reject(err);
      });
    });


  }

  async getTokenForRequest(http: HttpClient) {
    //let body = new URLSearchParams();
    let body = '';
    const httpOptions = {
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    }
    body = 'grant_type=password&username=admin&password=admin&client_id=admin-cli';

    const resp = await http.post(`http://localhost:4200/auth/realms/master/protocol/openid-connect/token`, body, httpOptions).toPromise().catch(console.log);
    return resp;
  }
  async getSupervisors(http: HttpClient) {
    const auth_token = await this.getTokenForRequest(http);
    const myUrl = `${this.keycloak.authServerUrl.replace('8080', '4200')}/admin/realms/aulos/roles/responsabile`
    //let body = new URLSearchParams();
    let httpHandler: HttpHandler;

    const httpc = new HttpClient(httpHandler);
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${auth_token['access_token']}`
      })
    }


    const resp = await http.get(myUrl, httpOptions).toPromise().catch(console.log);
    return resp;
  }


}
