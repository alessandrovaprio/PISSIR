import { environment } from 'src/environments/environment';
import { FormGroup, FormControl, Validators } from '@angular/forms';


export class Helpers {

  public static hash(length = 8) {
    let text = '';
    const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let i = 0;
    while (i < length) {
      text += possible.charAt(Math.floor(Math.random() * possible.length));
      i++;
    }
    return text;
  }

  public static unique(array) {
    return array.filter((value, index, self) => {
      return self.indexOf(value) === index;
    });
  }

  public static addDays(input: Date, noDays: number) {
    const date = new Date(input);
    return new Date(date.setDate(date.getDate()+noDays));
  }

  public static addMinutes(input: Date, noMinutes: number) {
    const date = new Date(input);
    return new Date(date.getTime()+(noMinutes*60000));
  }
  public static checkDates(form: FormGroup, fieldDateStart, fieldDateEnd, isNew?: boolean): boolean {
    let ok = true;
    const startDate = form.get(fieldDateStart).value;
    const endDate = form.get(fieldDateEnd).value;
    const newD = new Date(new Date().setDate(new Date().getDate() -1));
    if (startDate && endDate ) {
      if (startDate > endDate) {
        form.get(fieldDateStart).setErrors({valid: false} );
        form.get(fieldDateEnd).setErrors({valid: false} );
        ok = false;
      } else {
        if (isNew) {
          if (startDate <= newD) {
            form.get(fieldDateStart).setErrors({valid: false} );
            form.get(fieldDateEnd).setErrors({valid: false} );
            ok = false;
          } else {
            form.get(fieldDateStart).setErrors(undefined);
            form.get(fieldDateEnd).setErrors(undefined);
          }
        } else {
          form.get(fieldDateStart).setErrors(undefined);
          form.get(fieldDateEnd).setErrors(undefined);
        }
      }
    }
    return ok;
  }
  public static checkIfSupervisor() {
    const roles = localStorage.getItem('roles');
    if (roles.toLowerCase().includes('responsabile')) {
      return true;
    }
    return false;
  }
  public static convertDateForApi(date) {
    //var newDate = new Date(date.getTime()+date.getTimezoneOffset()*60*1000);
    var newDate = new Date(date);

    return Math.floor(newDate.getTime()/1000);
  }

  public static convertDateFromApi(date) {
    //var newDate = new Date(date.getTime()+date.getTimezoneOffset()*60*1000);
    var newDate = new Date(date*1000);

    return newDate;
  }
  public static toDateTime(input, useMilliSec?: boolean, onlyDate?: boolean) {
    const date = new Date(input);

    const twoDigits = (d) => {
      if (0 <= d && d < 10) {
        return '0' + d.toString();
      }
      if (-10 < d && d < 0) {
        return '-0' + (-1 * d).toString();
      }

      return d.toString();
    };

    let returnDate = date.getFullYear() + '-' + twoDigits(1 + date.getMonth()) + '-' + twoDigits(date.getDate()) ;
    if (!onlyDate) {
      returnDate += ' ' + twoDigits(date.getHours()) + ':' + twoDigits(date.getMinutes()) + ':' + twoDigits(date.getSeconds());
    }
    if (useMilliSec) {
      returnDate = returnDate + '.' + date.getMilliseconds();
    }
    return returnDate;
  }

  public static getInputStatus(form: FormGroup, key: string): string {

    if (!form) {
      return 'basic';
    }

    try {
      if(!form.get(key).validator) {
        return 'basic';
      }

      if (form.get(key).valid) {
        return 'success';
      } else {
        if (form.get(key).touched) {
          return 'danger';
        } else {
          return 'primary';
        }
      }
    } catch (error) {
      return 'basic';
    }
  }
  public static sleep(amt: number) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve();
      }, amt);
    });
  }

  public static sortByKey(array, key) {
    return array.sort((a, b) => {
      const x = a[key]; const y = b[key];
      return ((x < y) ? -1 : ((x > y) ? 1 : 0));
    });
  }

  public static flatten(data) {
    const result = {};
    function recurse(cur, prop) {
      if (Object(cur) !== cur) {
        result[prop] = cur;
      } else if (Array.isArray(cur)) {
        const l = cur.length;
        for (let i = 0; i < l; i++) {
          recurse(cur[i], prop + '[' + i + ']');
        }
        if (l === 0) {
          result[prop] = [];
        }
      } else {
        let isEmpty = true;
        for (const p in cur) {
          if (cur[p]) {
            isEmpty = false;
            recurse(cur[p], prop ? prop + '.' + p : p);
          }
        }
        if (isEmpty && prop) {
          result[prop] = {};
        }
      }
    }
    recurse(data, '');
    return result;
  }

  public static isVATCode(code: string) {
    const vatRegExp = new RegExp(/^[0-9]{11}$/);
    return vatRegExp.test(code);
  }

  public static parseDate(date: any) {
    const parsedDate = new Date(date);
    if (parsedDate.getTime() > 0) {
      return parsedDate;
    } else {
      const actualDate = new Date();
      // check if the date is before 1970
      const diff = (actualDate.getTime() - parsedDate.getTime());
      if ( diff > 0 ) {
        return parsedDate;
      }
      return undefined;
    }
  }

  public static stripGoogleAddress(googleAddress: any) {
    const jGoogleAddress: any = {
      place_id: googleAddress.place_id,
      formatted: googleAddress.formatted_address,
      components: {}
    }

    for (const comp of googleAddress.address_components) {
      if (comp.types.indexOf('street_number') > -1) {
        jGoogleAddress.components.street_number = { long: comp.long_name, short: comp.short_name }
      }
      if (comp.types.indexOf('route') > -1) {
        jGoogleAddress.components.route = { long: comp.long_name, short: comp.short_name }
      }
      if (comp.types.indexOf('locality') > -1) {
        jGoogleAddress.components.locality = { long: comp.long_name, short: comp.short_name }
      }
      if (comp.types.indexOf('administrative_area_level_3') > -1) {
        jGoogleAddress.components.administrative_area_level_3 = { long: comp.long_name, short: comp.short_name, }
      }
      if (comp.types.indexOf('administrative_area_level_2') > -1) {
        jGoogleAddress.components.administrative_area_level_2 = { long: comp.long_name, short: comp.short_name, }
      }
      if (comp.types.indexOf('administrative_area_level_1') > -1) {
        jGoogleAddress.components.administrative_area_level_1 = { long: comp.long_name, short: comp.short_name, }
      }
      if (comp.types.indexOf('postal_code') > -1) {
        jGoogleAddress.components.postal_code = { long: comp.long_name, short: comp.short_name, }
      }
      if (comp.types.indexOf('country') > -1) {
        jGoogleAddress.components.country = { long: comp.long_name, short: comp.short_name, }
      }
    }

    return jGoogleAddress;
  }

  public static checkCheckDigit(code: string) {
    let tot = 0;
    if ( code.length === 8 || code.length === 13) {
      for (let i = 0; i < code.length - 1; i++) {
        if (isNaN(Number(code[i]))) {
          return false;
        }
        tot = tot + (Number(code[i]) * (i % 2 === 0 ? 1 : 3));
      }
      const check = tot % 10 === 0 ? 0 : (10 - (tot % 10));
      if ( check === Number(code[code.length - 1])) {
        return true;
      }
      return false;
    } else {
      return true;
    }
  }


}
