import { HttpClient } from '@angular/common/http';
import { Component, OnInit, Injector } from '@angular/core';
//import { ConfigService } from 'src/app/services/config.service';
import { Router, RouterModule } from '@angular/router';
import { NgKeycloakService } from 'ng-keycloak';
import { KeycloakSecurityService } from 'src/app/services/keycloak-security.service';
import { Paths } from 'utils/paths';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrls: ['./login-page.component.scss']
})
export class LoginPageComponent implements OnInit {

  //webServiceAddress: string = this.configSvc.apiUrl;
  userData: { username?: string; password?: string } = {};

  keycloakConfig = {
    BASE_URL: 'http://localhost:8080/auth',
    realm: 'Aulos',
    'clientId': 'angular',
    'ssl-required': 'none',
    'resource': 'angular',
    'public-client': true,
    'confidential-port': 0,
    credentials: {
      secret: 'flflflfl'
    }
  };
  constructor(
    private router: Router,
    private keycloakSecurityService: KeycloakSecurityService,
    private http: HttpClient,
    private injector: Injector
  ) {
  }

  async ngOnInit() {
    //this.ngKeycloakService._setkeycloakConfig(this.keycloakConfig);
    //console.log('token', localStorage.getItem('token'));

    // const userinfo = await this.keycloakSecurityService.keycloak.loadUserInfo();
    // console.log('userinfo', userinfo);

    // localStorage.setItem('roles', this.keycloakSecurityService.keycloak.realmAccess.roles.toString())
    // localStorage.setItem('token', this.keycloakSecurityService.keycloak.token);
    // localStorage.setItem('username', userinfo['preferred_username'])

    // this.http = this.injector.get(HttpClient);
    // this.keycloakSecurityService.getTokenForRequest(this.http);
    this.router.navigate([Paths.INDEX('Evento')]);

  }

  async onLogin() {
    // this.ngKeycloakService.login(this.userData.username, this.userData.password).pipe().subscribe(loginSuccessResponse => {
    //   console.log('Login Success', loginSuccessResponse);
    // }, (loginErrorResponse) => {
    //   console.log('Login Error Response', loginErrorResponse);
    // });

    // this.ngKeycloakService.isLoggedIn().pipe().subscribe(loginStatusResponse => {
    //   console.log('Login Check Status', loginStatusResponse);
    // }, (loginStatusErrorResponse) => {
    //   console.log('Login Check Status Error', loginStatusErrorResponse);
    // });
  //   if (this.lbAuth.getCurrentUserId()) {
  //     this.router.navigate(['/mnt/home']);
  //   } else {
  //     const token = (await this.authSvc.onLogin( this.userData, this.webServiceAddress )) as SDKToken;

  //     if (token && token.askSystemUser) {
  //       const updatedToken = await this.authSvc.onAskSystemUser(token);
  //       if (updatedToken) {
  //         this.router.navigate([Paths.HOME]);
  //       }
  //     } else if (token && !token.askSystemUser) {
  //       this.router.navigate([Paths.HOME]);
  //     }
  //   }

  //this.router.navigate([Paths.INDEX('Evento')]);
  }
  async onLogout() {
    // this.ngKeycloakService.logout().pipe().subscribe(logoutSuccessResponse => {
    //   console.log('Logout Success Response', logoutSuccessResponse);
    // }, (logoutErrorResponse) => {
    //   console.log('Logout Error', logoutErrorResponse);
    // });
  }
}
