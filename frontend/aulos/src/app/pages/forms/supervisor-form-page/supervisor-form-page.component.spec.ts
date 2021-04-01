import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SupervisorFormPageComponent } from './supervisor-form-page.component';

describe('SupervisorFormPageComponent', () => {
  let component: SupervisorFormPageComponent;
  let fixture: ComponentFixture<SupervisorFormPageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SupervisorFormPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SupervisorFormPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
