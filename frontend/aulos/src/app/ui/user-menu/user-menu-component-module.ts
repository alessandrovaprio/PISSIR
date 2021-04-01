import { NgModule } from '@angular/core';
import { NbLayoutModule, NbSidebarModule, NbButtonModule, NbCardModule, NbActionsModule } from '@nebular/theme';
import { UserMenuComponent } from './user-menu.component';



@NgModule({
  entryComponents: [],
  declarations: [
    UserMenuComponent
  ],
  imports: [
    NbLayoutModule,
    NbActionsModule
  ],
  exports: [
    NbLayoutModule,
    NbActionsModule
  ]
})
export class UserMenuComponentModule {}
