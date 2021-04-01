import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EquipmentFormPageComponent } from './equipment-form-page.component';

describe('EquipmentFormPageComponent', () => {
  let component: EquipmentFormPageComponent;
  let fixture: ComponentFixture<EquipmentFormPageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EquipmentFormPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EquipmentFormPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
