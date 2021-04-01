import { Component, OnInit } from '@angular/core';
import {NbCardModule} from '@nebular/theme/';
@Component({
  selector: 'app-logout-page',
  templateUrl: './logout-page.component.html',
  styleUrls: ['./logout-page.component.scss']
})
export class LogoutPageComponent implements OnInit {

  constructor(
    //private authSvc: AuthService,
  ) {
  }

  ngOnInit() {
    //this.authSvc.onLogout();
  }

}
