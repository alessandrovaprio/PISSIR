
export class Paths {
  public static HOME = '/aulos/home';

  public static DASHBOARD = (entity: string) => {
    return `/aulos/dashboard/${entity}`;
  }

  public static SEARCH = (term: string) => {
    return `/aulos/search/${term}`;
  }

  public static INDEX = (entity: string) => {
    return `/aulos/${entity}`;
  }

  public static FORM = (entity: string, entityId?: string | number) => {
    if (entityId) {
      return `/aulos/${entity}/edit/${entityId}`;
    } else {
      return `/aulos/${entity}/create`;
    }
  }

  public static CLONE = (entity: string, entityId?: string | number) => {
    return `/aulos/${entity}/create/${entityId}`;
  }

  public static DETAIL = (entity: string, entityId?: string | number) => {
    return `/aulos/${entity}/view/${entityId}`;
  }

  public static LOGOUT = () => {
    return `/logout`;
  }
}
