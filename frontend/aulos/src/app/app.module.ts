import { BrowserModule } from '@angular/platform-browser';
import { APP_INITIALIZER, DoBootstrap, NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { EventsIndexPageComponent } from './pages/indexes/events-index-page/events-index-page.component';
import { Ng2SmartTableModule } from 'ng2-smart-table/lib/ng2-smart-table.module';
import { NbAccordionModule, NbActionsModule, NbAlertModule, NbBadgeModule, NbButtonModule, NbCardModule, NbCheckboxModule, NbContextMenuModule, NbDatepickerModule, NbDialogModule, NbFormFieldModule, NbIconModule, NbInputModule, NbLayoutModule, NbListModule, NbMenuModule, NbPopoverModule, NbSelectModule, NbSidebarModule, NbSidebarService, NbSpinnerModule, NbStepperModule, NbTabsetModule, NbThemeModule, NbToastrModule, NbToggleModule, NbTooltipModule, NbTreeGridModule, NbUserModule, NbWindowModule } from '@nebular/theme';
import { NbEvaIconsModule } from '@nebular/eva-icons/eva-icons.module';
import { UIModule } from './ui/ui.module';
import { AppIndexesModule } from 'src/app/pages/indexes/indexes.module';
import { AuthModule } from './auth/auth.module';
import { LayoutPageModule } from './pages/layout-page/layout-page.module';
import localeIt from '@angular/common/locales/it';
import { registerLocaleData } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AppFormsModule } from './pages/forms/forms.module';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { NgKeycloakModule } from 'ng-keycloak';
import { KeycloakSecurityService } from './services/keycloak-security.service';
import { RequestInterceptorService } from './services/request-interceptor.service';

export function keycloakFactory(keycloakSecurityService: KeycloakSecurityService) {
  return () => keycloakSecurityService.init();
}
const keycloakSecurityService = new KeycloakSecurityService();
//import {AppFormsModule} from 'src/app/pages/forms/forms.module'



registerLocaleData(localeIt, 'it');

@NgModule({
  declarations: [
    AppComponent,
  ],
  imports: [
    BrowserModule,
    AuthModule,
    LayoutPageModule,
    AppRoutingModule,
    AppFormsModule,
    AppIndexesModule,
    NbLayoutModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgKeycloakModule
  ],

  providers: [
    { provide: APP_INITIALIZER, deps: [KeycloakSecurityService], useFactory: keycloakFactory, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: RequestInterceptorService, multi: true }
  ],
  bootstrap: [AppComponent]
})
export class AppModule implements DoBootstrap {
  ngDoBootstrap(appRef: import("@angular/core").ApplicationRef): void {
    keycloakSecurityService.init().then(data => {
      localStorage.setItem('token', JSON.stringify(data));
      appRef.bootstrap(AppComponent);

    }).catch(err => {
      console.error('err', err);
    });
  }
 }
