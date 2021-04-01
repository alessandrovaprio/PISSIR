import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Paths } from '../../utils/paths';
import { ConfigService } from './services/config.service';
import { KeycloakSecurityService } from './services/keycloak-security.service';
import { RoleService } from './services/role.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(
    private router: Router,
    private configSvc: ConfigService,
    private roleSvc: RoleService,
    private keycloakSecurityService: KeycloakSecurityService
  ) {}

  async canActivate(next: ActivatedRouteSnapshot, state: RouterStateSnapshot): Promise<boolean> {
    await this.configSvc.init();
    this.roleSvc.init();
    if (state.url.includes('login')) {
      this.router.navigate([('/login')]);
      return true;
    }
    if (!this.keycloakSecurityService.keycloak.token) {
      this.router.navigate([('/login')]);
      return false;
    }
    if (state.url === '/aulos') {
      this.router.navigate([Paths.HOME]);
    }
    const tmpUrl = state.url.replace('/aulos/','');

    const canActivate = this.checkRoleForPage(tmpUrl.split('/')[0]);
    if (!canActivate) {
      this.router.navigate([Paths.INDEX('Evento')]);
      return false;
    }
    return true;
  //   const validationResult = await this.authSvc.onValidate();

  //   try {
  //     if (state.url === '/login') {
  //       if (validationResult) {
  //         this.router.navigate([Paths.HOME]);
  //         return false;
  //       } else {
  //         return true;
  //       }
  //     } else {
  //       if (!validationResult) {
  //         this.router.navigate(['/login']);
  //       }

  //       return validationResult;
  //     }
  //   } catch (error) {
  //     return false;
  //   }
    return true;
  }


  checkRoleForPage(page: string) {
    const findRoles = this.keycloakSecurityService.keycloak.realmAccess.roles;
    let found = null;
    for(const f of findRoles) {
      for(const key of this.roleSvc.roles) {
        if (Object.keys(key)[0] === f) {
          found = f;
          break;
        }
      }
    }
    const role = found ? this.roleSvc[found] : null;

    if (role) {
      let foundPage=false;
      for ( const p of role[found]['pages']) {
        //console.log('pagesss', p, Object.keys(p).toString(), page)
        foundPage = (Object.keys(p).toString() === page);
        if (foundPage)
          break;
      }
      return foundPage;

    }
    return false
  }
}
