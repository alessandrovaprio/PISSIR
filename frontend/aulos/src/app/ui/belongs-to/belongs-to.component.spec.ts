import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BelongsToComponent } from './belongs-to.component';

describe('BelongsToComponent', () => {
  let component: BelongsToComponent;
  let fixture: ComponentFixture<BelongsToComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ BelongsToComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BelongsToComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
