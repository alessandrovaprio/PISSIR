import { Component, OnInit } from '@angular/core';

import { Router } from '@angular/router';
import { FormGroup, FormControl } from '@angular/forms';
import { Paths } from 'utils/paths';
import { KeycloakSecurityService } from 'src/app/services/keycloak-security.service';
import { RoleService } from 'src/app/services/role.service';
@Component({
  selector: 'app-layout-page',
  templateUrl: './layout-page.component.html',
  styleUrls: ['./layout-page.component.scss']
})
export class LayoutPageComponent implements OnInit {

  searchForm: FormGroup;
  menuItems: any = [];

  constructor(
    private router: Router,
    private keycloakSecurityService: KeycloakSecurityService,
    private roleSvc: RoleService
  ) {

  }

  ngOnInit() {
    // this.searchForm = new FormGroup({
    //   term: new FormControl()
    // });
    const findRoles = this.keycloakSecurityService.keycloak.realmAccess.roles;
    let found = null;
    console.log('findrole', findRoles);
    for(const f of findRoles) {
      console.log('f', f);
      for(const key of this.roleSvc.roles) {
        console.log('key', key, Object.keys(key), this.roleSvc.roles);
        if (Object.keys(key)[0] === f) {
          found = f;
          break;
        }
      }
    }
    const role = found ? this.roleSvc[found] : null;
    if (role) {
      console.log('pages', role, role[found]['pages']);
      for(const page of role[found]['pages']) {
        console.log('page', page, Object.keys(page)[0], found);
        this.pushMenuItem(Object.keys(page)[0]);
      }
    }
    // this.menuItems.push({ title: 'Eventi', link: Paths.INDEX('Evento'), icon: 'calendar-outline' });

    // this.menuItems.push({ title: 'Prenotazioni', link: Paths.INDEX('Prenotazione'), icon: 'clock-outline' });
    // this.menuItems.push({ title: 'Attrezzature', link: Paths.INDEX('Attrezzatura'), icon: 'pantone-outline' });
    // this.menuItems.push({ title: 'Aule', link: Paths.INDEX('Aula'), icon: 'square-outline' });
    // this.menuItems.push({ title: 'Responsabili', link: Paths.INDEX('Responsabile'), icon: 'person-outline' });
    console.log('items', this.menuItems);
  }
  pushMenuItem(title: string) {
    this.menuItems.push({ title: this.getIndex(title), link: Paths.INDEX(title), icon: this.getIcon(title) });
  }
  getIndex(title: string) {
    let ret = '';
    switch(title) {
      case 'Evento':
        return 'Eventi';
      case 'Prenotazione':
        return 'Prenotazioni';
      case 'Attrezzatura':
        return 'Attrezzature';
      case 'Responsabile':
        return 'Responsabili';
      case 'Aula':
        return 'Aule';
    }
  }
  getIcon(icon: string) {
    switch(icon) {
      case 'Evento':
        return 'calendar-outline';
      case 'Prenotazione':
        return 'clock-outline';
      case 'Attrezzatura':
        return 'pantone-outline';
      case 'Responsabile':
        return 'person-outline';
      case 'Aula':
        return 'square-outline';
    }
  }
  onSearch() {
    this.router.navigate([Paths.SEARCH(this.searchForm.get('term').value)]);
  }

  async onLogout() {
    const res = await this.keycloakSecurityService.keycloak.logout();
    localStorage.clear();
    this.router.navigate(['/logout']);
    console.log('logout', res);
  }
}
