import { Dispositivo } from 'src/classes';
import {ClassroomFormPageComponent} from '../app/pages/forms/classroom-form-page/classroom-form-page.component';


describe('Config service', () => {
  let service: ClassroomFormPageComponent;

  beforeEach(()=> {
    service = new ClassroomFormPageComponent(null, null,null,null,null);
  });

  afterEach(()=> {
    service = null;

  })

  it('should add a device to classroom', () => {
    let device: any = {};
    service.assigneDevices = [];
    service.onAddAssign(device);
    expect(service.assigneDevices.length).toEqual(1);
  });
  it('should add a device to classroom', () => {
    let device: any = {idDispositivo: 1};
    service.assigneDevices = [{idDispositivo: 1}, {idDispositivo: 2}];
    service.toDelete = [];
    service.onRemoveAssign(device);
    expect(service.assigneDevices.length).toEqual(1);
    expect(service.assigneDevices[0]['idDispositivo']).toEqual(2);
  });
})
