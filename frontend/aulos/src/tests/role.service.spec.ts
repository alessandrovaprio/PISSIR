import {RoleService} from '../app/services/role.service';


describe('Config service', () => {
  let service: RoleService;

  beforeEach(()=> {
    service = new RoleService();
  });

  afterEach(()=> {
    service = null;

  })

  it('should access Classroom', () => {
    const myRole = 'amministratore';
    let find;
    for( const r of service.roles) {
      for(const key in r) {
        if (key === myRole) {

          find = r[key];
          break;
        }
      }
      if (find) {
        break;
      }
    }
    let foundPage = false;
    for(const page of find.pages) {
      if (Object.keys(page).includes('Aula') ) {
        foundPage = true;
      }
    }
    expect(foundPage).toBeTruthy();
  });
  it('should not access Classroom', () => {
    const myRole = 'responsabile';
    let find;
    for( const r of service.roles) {
      console.log('r', r);
      for(const key in r) {
        if (key === myRole) {

          find = r[key];
          break;
        }
      }
      if (find) {
        break;
      }
    }
    let foundPage = false;
    for(const page of find.pages) {
      if (Object.keys(page).includes('Aula') ) {
        foundPage = true;
      }
    }
    expect(foundPage).toBeFalsy();
  });
})
