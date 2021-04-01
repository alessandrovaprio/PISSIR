import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SupervisorIndexPageComponent } from './supervisor-index-page.component';

describe('SupervisorIndexPageComponent', () => {
  let component: SupervisorIndexPageComponent;
  let fixture: ComponentFixture<SupervisorIndexPageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SupervisorIndexPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SupervisorIndexPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
