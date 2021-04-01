import { Component, OnInit } from '@angular/core';
import { NbMenuItem, NbThemeService } from '@nebular/theme';
//import { ConfigService } from 'src/app/services/config.service';
import { SafeResourceUrl, DomSanitizer } from '@angular/platform-browser';
@Component({
  selector: 'app-user-menu',
  templateUrl: './user-menu.component.html',
  styleUrls: ['./user-menu.component.scss']
})
export class UserMenuComponent implements OnInit {

  userMenu: NbMenuItem[] = [
    {
      title: 'Logout',
      link: '/logout',
      icon: 'log-out-outline'
    },
    // {
    //   //title: `v${this.uiSvc.version}`,
    //   //link: '/mnt/version',
    // }
  ];

  get userName() {
    return 'Ale';
    //return this.authSvc.currentUser.szUserId;
  }

  // get userTitle() {
  //   let title = ``;
  //   title += `[C: ${this.authSvc.currentUser.n0CompanyId || '*'} `;
  //   title += ` L: ${this.authSvc.currentUser.n0LogoId || '*'} `;
  //   title += ` S: ${this.authSvc.currentUser.n0StoreId || '*'}] `;
  //   title += this.authSvc.currentFunctionGroup.szDefaultDescr;
  //   return title;
  // }

  get currentTheme() {
    return this.nbThemeSvc.currentTheme;
  }

  constructor(
    public nbThemeSvc: NbThemeService,
    //public uiSvc: UIService,
  ) { }

  onToggleTheme() {
    if (this.currentTheme === 'default') {
      this.nbThemeSvc.changeTheme('dark');
    } else {
      this.nbThemeSvc.changeTheme('default');
    }
  }

  ngOnInit() {
  }

}
