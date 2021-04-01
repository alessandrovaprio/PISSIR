import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { UIModule } from 'src/app/ui/ui.module';
import { EventsIndexPageComponent } from './events-index-page/events-index-page.component';
import { EquipmentIndexPageComponent } from './equipment-index-page/equipment-index-page.component';
import { ClassroomIndexPageComponent } from './classroom-index-page/classroom-index-page.component';
import { SupervisorIndexPageComponent } from './supervisor-index-page/supervisor-index-page.component';
import { BookingIndexPageComponent } from './booking-index-page/booking-index-page.component';


@NgModule({
  imports: [
    CommonModule,
    UIModule,
    FormsModule,

  ],
  declarations: [
    EventsIndexPageComponent,
    EquipmentIndexPageComponent,
    ClassroomIndexPageComponent,
    SupervisorIndexPageComponent,
    BookingIndexPageComponent
  ],
  entryComponents: [
    EventsIndexPageComponent,
  ],
  exports: [
  ]
})
export class AppIndexesModule { }
