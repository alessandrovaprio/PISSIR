import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ClassroomFormPageComponent } from './classroom-form-page.component';

describe('ClassroomFormPageComponent', () => {
  let component: ClassroomFormPageComponent;
  let fixture: ComponentFixture<ClassroomFormPageComponent>;

  // console.log('component', component);
  // console.log('fixture',fixture)
  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ClassroomFormPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClassroomFormPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    //expect(component).toBeTruthy();
  });
});



