import {ConfigService} from '../app//services/config.service';


describe('Config service', () => {
  let service: ConfigService;

  beforeEach(()=> {
    service = new ConfigService();
  });

  afterEach(()=> {
    service = null;

  })

  it('should have loaded all models', () => {
    service.loadModels();
    expect(service.models.length).toEqual(6);
  })
  it('should have no models', () => {
    expect(service.models.length).toEqual(0);
  })
})
