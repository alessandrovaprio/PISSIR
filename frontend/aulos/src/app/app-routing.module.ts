import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from './auth.guard';
import { BookingFormPageComponent } from './pages/forms/booking-form-page/booking-form-page.component';
import { ClassroomFormPageComponent } from './pages/forms/classroom-form-page/classroom-form-page.component';
import { EquipmentFormPageComponent } from './pages/forms/equipment-form-page/equipment-form-page.component';
import { EventFormPageComponent } from './pages/forms/event-form-page/event-form-page.component';
import { SupervisorFormPageComponent } from './pages/forms/supervisor-form-page/supervisor-form-page.component';
import { BookingIndexPageComponent } from './pages/indexes/booking-index-page/booking-index-page.component';
import { ClassroomIndexPageComponent } from './pages/indexes/classroom-index-page/classroom-index-page.component';
import { EquipmentIndexPageComponent } from './pages/indexes/equipment-index-page/equipment-index-page.component';
import { EventsIndexPageComponent } from './pages/indexes/events-index-page/events-index-page.component';
import { SupervisorIndexPageComponent } from './pages/indexes/supervisor-index-page/supervisor-index-page.component';
import { LayoutPageComponent } from './pages/layout-page/layout-page.component';
import { LoginPageComponent } from './pages/login-page/login-page.component';
import { LogoutPageComponent } from './pages/logout-page/logout-page.component';


const routes: Routes = [ { path: '', redirectTo: '/login', pathMatch: 'full' },
{ path: 'login', component: LoginPageComponent },
{ path: 'logout', component: LogoutPageComponent },
{
  path: 'aulos',
  component: LayoutPageComponent,
  canActivate: [AuthGuard],
  children: [
  { path: 'Evento', canActivate: [AuthGuard],
    children: [
      { path: '', component: EventsIndexPageComponent, canActivate: [AuthGuard] },
      { path: 'edit/:entityId', component: EventFormPageComponent, canActivate: [AuthGuard] },
      { path: 'create', component: EventFormPageComponent, canActivate: [AuthGuard] }
    ]
  },
  { path: 'Attrezzatura', canActivate: [AuthGuard],
    children: [
      { path: '', component: EquipmentIndexPageComponent, canActivate: [AuthGuard] },
      { path: 'edit/:entityId', component: EquipmentFormPageComponent, canActivate: [AuthGuard] },
      { path: 'create', component: EquipmentFormPageComponent, canActivate: [AuthGuard] }
    ]
  },
  { path: 'Aula', canActivate: [AuthGuard],
   children: [
    { path: '', component: ClassroomIndexPageComponent, canActivate: [AuthGuard] },
    { path: 'edit/:entityId', component: ClassroomFormPageComponent, canActivate: [AuthGuard] },
    { path: 'create', component: ClassroomFormPageComponent, canActivate: [AuthGuard] }
   ]
  },
  { path: 'Prenotazione', canActivate: [AuthGuard],
   children: [
    { path: '', component: BookingIndexPageComponent, canActivate: [AuthGuard] },
    { path: 'edit/:entityId', component: BookingFormPageComponent, canActivate: [AuthGuard] },
    { path: 'create', component: BookingFormPageComponent,data : {}, canActivate: [AuthGuard] }
   ]
  },
  { path: 'Responsabile', canActivate: [AuthGuard],
   children: [
    { path: '', component: SupervisorIndexPageComponent, canActivate: [AuthGuard] },
    { path: 'edit/:entityId', component: SupervisorFormPageComponent, canActivate: [AuthGuard] },
    { path: 'create', component: SupervisorFormPageComponent, canActivate: [AuthGuard] }
   ]
  }

  //{ path: ':equipments/edit/:entityId', component: EquipmentFormPageComponent, canActivate: [AuthGuard] },
  //{ path: ':classrooms/edit/:entityId', component: ClassroomFormPageComponent, canActivate: [AuthGuard] },

  ]
},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
