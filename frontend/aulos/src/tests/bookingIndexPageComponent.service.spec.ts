import { FormControl, FormGroup } from '@angular/forms';
import { Evento } from 'src/classes';
import { Helpers } from 'utils/helpers';
import {BookingIndexPageComponent} from '../app/pages/indexes/booking-index-page/booking-index-page.component';


describe('Config service', () => {
  let service: BookingIndexPageComponent;

  beforeEach(()=> {
    service = new BookingIndexPageComponent(null, null, null, null);
  });

  afterEach(()=> {
    service = null;

  })

  it('should filter Libera', () => {
    service.data = [{ 'statoAula': 'Libera' }, { 'statoAula': 'Occupata' }];
    const filtered = service.filterData('freeFilter', true);

    expect(filtered.length).toEqual(1);
  });
  it('should filter data Occupata', () => {
    service.data = [{ 'statoAula': 'Libera' }, { 'statoAula': 'Occupata' }];
    const filtered = service.filterData('busyFilter', true);

    expect(filtered.length).toEqual(1);
  });
  it('should getStatus Libera', () => {
    //service.getStatus([], 1);
    expect(service.getStatus([], 1)).toEqual('Libera');
  });
  it('should getStatus Occupata', () => {
    //service.getStatus([], 1);
    const currentDate = new Date();
    let events: any[] = [];
    service.form = new FormGroup({
      startDate: new FormControl(null, []),
      endDate: new FormControl(null, []),
    });
    service.form.get('startDate').patchValue(currentDate);
    service.form.get('endDate').patchValue(Helpers.addMinutes(currentDate,60));
    const arrEvents= [
      {
        'idEvento': 1,
        'aulaEvento':{
          'idAula': 1
        },
        'dataOraInizio': currentDate,
        'dataOraFine': Helpers.addMinutes(currentDate,60),

      }
    ]
    events.push(arrEvents[0]);
    expect(service.getStatus(events, 1)).toEqual('Occupata');
  });

})
