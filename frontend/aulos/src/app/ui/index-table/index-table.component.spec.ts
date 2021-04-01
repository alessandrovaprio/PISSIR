import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IndexTableComponent } from './index-table.component';

describe('IndexTableComponent', () => {
  let component: IndexTableComponent;
  let fixture: ComponentFixture<IndexTableComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IndexTableComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IndexTableComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
