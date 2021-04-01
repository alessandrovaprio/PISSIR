import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UIModule } from 'src/app/ui/ui.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
//import { EquipmentFormPageComponent } from './equipment-form-page/equipment-form-page.component';
import { EquipmentFormPageComponent } from 'src/app/pages/forms/equipment-form-page/equipment-form-page.component'
import { ClassroomFormPageComponent } from './classroom-form-page/classroom-form-page.component';
import { SupervisorFormPageComponent } from './supervisor-form-page/supervisor-form-page.component';
import { EventFormPageComponent } from './event-form-page/event-form-page.component';
import { BookingFormPageComponent } from './booking-form-page/booking-form-page.component';



@NgModule({
  imports: [
    CommonModule,
    UIModule,
    FormsModule,


    //ReactiveFormsModule
  ],
  exports: [EventFormPageComponent],
  declarations: [
    EquipmentFormPageComponent,
    ClassroomFormPageComponent,
    SupervisorFormPageComponent,
    EventFormPageComponent,
    BookingFormPageComponent
  ],
  entryComponents: [
    EquipmentFormPageComponent,
    ClassroomFormPageComponent,
    SupervisorFormPageComponent,
    EventFormPageComponent,
    BookingFormPageComponent

  ]
})
export class AppFormsModule { }
