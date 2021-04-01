import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NbLayoutModule, NbSidebarModule, NbButtonModule, NbCardModule } from '@nebular/theme';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { UIModule } from 'src/app/ui/ui.module';
import { LayoutPageComponent } from './layout-page.component';
import { RouterModule } from '@angular/router';



@NgModule({
  entryComponents: [],
  declarations: [
    LayoutPageComponent
  ],
  imports: [
    CommonModule,
    UIModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
  ]
})
export class LayoutPageModule {}
