import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NbLayoutModule, NbSidebarModule, NbButtonModule, NbCardModule } from '@nebular/theme';
import { FormsModule } from '@angular/forms';
import { UIModule } from 'src/app/ui/ui.module';



@NgModule({
  entryComponents: [],
  declarations: [],
  imports: [
    CommonModule,
    UIModule,
    NbCardModule
  ]
})
export class LoginPageModule {}
