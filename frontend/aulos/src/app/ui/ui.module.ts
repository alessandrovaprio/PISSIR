import { NgModule } from '@angular/core';
import { NbSidebarModule, NbButtonGroupModule, NbButtonModule, NbCardModule, NbInputModule, NbLayoutModule, NbListModule, NbMenuModule, NbActionsModule, NbDatepickerModule, NbDialogModule, NbWindowModule, NbToastrModule, NbThemeModule, NbIconModule, NbThemeService, NbSelectModule, NbUserModule, NbContextMenuModule, NbAccordionModule, NbBadgeModule, NbAlertModule, NbStepperModule, NbToggleModule, NbTabsetModule, NbSpinnerModule, NbPopoverModule, NbTreeGridModule, NbTooltipModule, NbCheckboxModule, NbFormFieldModule, NbDateTimePickerComponent, NB_TIME_PICKER_CONFIG } from '@nebular/theme';
import { NbEvaIconsModule } from '@nebular/eva-icons';
import { Ng2SmartTableModule } from 'ng2-smart-table';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Ng2CompleterModule } from 'ng2-completer';
import { UserMenuComponentModule } from 'src/app/ui/user-menu/user-menu-component-module';
import { TableModule } from 'ngx-easy-table';
import { IndexTableComponent } from './index-table/index-table.component';
import { ConfirmComponent } from './dialogs/confirm/confirm.component';
import { BelongsToComponent } from './belongs-to/belongs-to.component'
import { SelectListComponent } from './select-list/select-list.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ErrorDialogComponent } from './dialogs/error-dialog/error-dialog.component';
// import { UserMenuComponent } from './user-menu/user-menu.component';


@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    NbThemeModule.forRoot({ name: 'default' }),
    NbIconModule,
    NbEvaIconsModule,
    NbSidebarModule.forRoot(),
    NbMenuModule.forRoot(),
    NbDatepickerModule.forRoot(),
    NbDialogModule.forRoot(),
    NbWindowModule.forRoot(),
    NbToastrModule.forRoot(),
    NbWindowModule.forRoot(),
    Ng2SmartTableModule,
    NbEvaIconsModule,
    NbButtonModule,
    NbCardModule,
    NbInputModule,
    NbLayoutModule,
    NbListModule,
    NbActionsModule,
    NbSelectModule,
    NbUserModule,
    NbContextMenuModule,
    NbAccordionModule,
    NbBadgeModule,
    NbAlertModule,
    NbStepperModule,
    NbToggleModule,
    NbTabsetModule,
    NbSpinnerModule,
    NbPopoverModule,
    NbTreeGridModule,
    NbTooltipModule,
    NbCheckboxModule,
    NbButtonGroupModule,
    Ng2CompleterModule,
    NbFormFieldModule,
    ReactiveFormsModule,
    UserMenuComponentModule,
    TableModule,
    BrowserAnimationsModule

  ],
  exports: [
    NbThemeModule,
    NbIconModule,
    NbLayoutModule,
    NbSidebarModule,
    NbMenuModule,
    NbDatepickerModule,
    NbDateTimePickerComponent,
    NbDialogModule,
    NbWindowModule,
    NbToastrModule,
    Ng2SmartTableModule,
    NbEvaIconsModule,
    NbButtonModule,
    NbCardModule,
    NbInputModule,
    NbListModule,
    NbActionsModule,
    NbSelectModule,
    NbUserModule,
    NbContextMenuModule,
    NbAccordionModule,
    NbBadgeModule,
    NbAlertModule,
    NbStepperModule,
    NbToggleModule,
    NbTabsetModule,
    NbSpinnerModule,
    NbPopoverModule,
    NbTreeGridModule,
    NbTooltipModule,
    NbCheckboxModule,
    NbButtonGroupModule,
    NbWindowModule,
    NbFormFieldModule,
    Ng2CompleterModule,
    FormsModule,
    ReactiveFormsModule,
    UserMenuComponentModule,
    TableModule,
    IndexTableComponent,
    BelongsToComponent,
    SelectListComponent,

  ],
  providers: [
    NbThemeService,
    {
      provide:NB_TIME_PICKER_CONFIG,
      useValue:{}
    }
  ],
  declarations: [
    IndexTableComponent,
    ConfirmComponent,
    ErrorDialogComponent,
    BelongsToComponent,
    SelectListComponent
  ],
  entryComponents: [
    SelectListComponent
  ]
})
export class UIModule {}
