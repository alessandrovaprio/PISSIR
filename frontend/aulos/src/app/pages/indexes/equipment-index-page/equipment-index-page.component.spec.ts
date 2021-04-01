import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EquipmentIndexPageComponent } from './equipment-index-page.component';

describe('EquipmentIndexPageComponent', () => {
  let component: EquipmentIndexPageComponent;
  let fixture: ComponentFixture<EquipmentIndexPageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EquipmentIndexPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EquipmentIndexPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
