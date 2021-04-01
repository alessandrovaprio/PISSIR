import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EventsIndexPageComponent } from './events-index-page.component';

describe('EventsIndexPageComponent', () => {
  let component: EventsIndexPageComponent;
  let fixture: ComponentFixture<EventsIndexPageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EventsIndexPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EventsIndexPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
