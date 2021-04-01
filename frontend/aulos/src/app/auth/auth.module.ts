import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import { UIModule } from '../ui/ui.module';
import { LoginPageComponent } from '../pages/login-page/login-page.component';
import { LogoutPageComponent } from '../pages/logout-page/logout-page.component';

@NgModule({
  imports: [
    CommonModule,
    UIModule,
    FormsModule,
    RouterModule,
  ],
  declarations: [
    LoginPageComponent,
    LogoutPageComponent
  ],
  entryComponents: [
    LoginPageComponent,
    LogoutPageComponent
  ]
})
export class AuthModule { }
