import { async, ComponentFixture, TestBed } from '@angular/core/testing';
import { EventsIndexPageComponent } from '../events-index-page/events-index-page.component';

import { ClassroomIndexPageComponent } from './classroom-index-page.component';

describe('ClassroomPageComponent', () => {
  let component: ClassroomIndexPageComponent;
  let fixture: ComponentFixture<ClassroomIndexPageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ClassroomIndexPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClassroomIndexPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
