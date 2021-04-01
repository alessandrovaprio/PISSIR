import { FormGroup, FormControl } from '@angular/forms';
import { Directive, Input, OnInit } from '@angular/core';
import { NbDialogRef, NbGlobalLogicalPosition, NbToastrService } from '@nebular/theme';
import { Paths } from 'utils/paths';
import { ActivatedRoute, Router } from '@angular/router';
import { UniversalApi } from 'utils/universal-api';
import { Subscription } from 'rxjs';
import { UIService } from 'src/app/ui/ui.service';
import { Helpers } from 'utils/helpers';

@Directive()
export class BaseFormComponent<T> {




  public pageMode: 'dialog' | 'page' = 'page';
  public dialogRef: NbDialogRef<any>;

  public loading: boolean = false;
  public loaders: any = {};
  public clonedId: number;
  public form: FormGroup;
  public paramsSub: Subscription;
  public nbToastrSvc: NbToastrService
  public subs: {
    [key: string]: Subscription
  } = {

  }
  @Input()
  public universalApi: UniversalApi<T>;


  public entityData: any;

  // private activatedroute: ActivatedRoute = new ActivatedRoute();
  entityId: number;
  // public entityAssigns: EntityAssign;

  get isDialogMode() {
    return this.pageMode === 'dialog';
  }

  // get isPageMode() {
  //   return this.pageMode === 'page';
  // }


  onSetLoader(key: string, value: boolean) {
    this.loaders[key] = value;
  }

  /**
   * Check if Entity was saved in DB (PrimaryKey exists)
   *
   * @memberof BaseFormComponent
   */
  // isEntityPersisted() {
  //   const primaryKey = this.universalApi.modelDefinition.idName;
  //   return this.form.get(primaryKey) && this.form.get(primaryKey).value;
  // }

  // isAssignable(entityKey: string, item: any, itemKey?: string) {
  //   const { tempItems, compareKey } = this.entityAssigns[entityKey];
  //   return tempItems.find(mf => mf[compareKey] === item[itemKey || compareKey]) ? false : true;
  // }

  // hasAssigns(entityKey: string) {
  //   try {
  //     return this.entityAssigns[entityKey].assignedItems.length > 0;
  //   } catch (error) {
  //     return false;
  //   }
  // }
  // hasTempItems (entityKey: string) {
  //   //console.log('hasTempItems', this.entityAssigns[entityKey]);
  //   try {
  //     return this.entityAssigns[entityKey].tempItems.length > 0;
  //   } catch (error) {
  //     return false;
  //   }
  // }
  // isEntityAssignTouched (entityKey: string) {
  //   //console.log('istouched',this.entityAssigns[entityKey], this.entityAssigns[entityKey]['touched']);
  //   try {
  //     return this.entityAssigns[entityKey]['touched'];
  //   } catch (error) {
  //     return false;
  //   }
  // }
  // getAvailableAssigns(entity: string) {
  //   try {
  //     return this.entityAssigns[entity].availableItems;
  //   } catch (error) {
  //     return [];
  //   }
  // }

  // getAppliedAssigns(entity: string) {
  //   try {
  //     return this.entityAssigns[entity].assignedItems;
  //   } catch (error) {
  //     return [];
  //   }
  // }

  // getTemporaryAssigns(entity: string) {
  //   try {
  //     return this.entityAssigns[entity].tempItems;
  //   } catch (error) {
  //     return [];
  //   }
  // }
  onGoBack(router: Router,page: string) {
    router.navigate([Paths.INDEX(page)]);
  }
  clearValues(clearFields: string[] = []) {
    for (const field of clearFields) {
      if (this.form.value[field]) {
        const newVal = {};
        newVal[field] = null;
        this.form.patchValue(newVal);
      }
    }
  }

  getSearchFilter(searchOfFields: string[] = []) {
    const filter = { where: {and: []}};
    if (this.form) {
      for (const field of searchOfFields) {
        if (this.form.get(field) && (this.form.get(field).value !== null && this.form.get(field).value !== undefined )) {
          const tmpObj = {};
          const tmpNull = {};

          tmpObj[field] = this.form.get(field).value;
          tmpNull[field] = null;
          const orFilter = {or: []};
          orFilter.or.push(tmpObj);
          orFilter.or.push(tmpNull);
            //filter.where[field] = this.form.get(field).value;
          filter.where.and.push(orFilter);
        }
      }
    }
    if (filter.where.and.length === 0) {
      return {};
    }
    return filter;
  }

  getInputStatus(key: string, form?: FormGroup): string {
    if (!form) {
      form = this.form;
    }

    if (!form) {
      return;
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

  getInputTouched(key: string): boolean {
    try {
      return this.form.get(key).touched;
    } catch (error) {
      return false;
    }
  }

  getInputError(key: string, form?: FormGroup) {
    if (!form) {
      form = this.form;
    }

    try {
      const errors = form.controls[key].errors;

      if (!errors) {
        return null;
      }

      if (errors.required) {
        return `Campo richiesto!`;
      }

      if (errors.minlength) {
        return `Lunghezza minima ${errors.minlength.requiredLength}&times; caratteri!`;
      }

      if (errors.maxlength) {
        return `Lunghezza massima ${errors.maxlength.requiredLength}&times; caratteri!`;
      }

      if (errors.email) {
        return `Formato email non valido!`;
      }
    } catch (error) {
      return null;
    }
  }

  ngOnDestroy() {
    // clear subs
    for (const subKey of Object.keys(this.subs)) {
      if (this.subs[subKey]) {
        this.subs[subKey].unsubscribe();
      }
    }
  }
  async onSave() {
    this.form.enable();
    const formData = { ...this.form.value };

    const updatedEntity = await this.universalApi.putOrCreate(formData[this.universalApi.getEntityKey()],formData).toPromise().catch((error ) => this.showError(error));

    if (updatedEntity) {
      // this.universalApi.goToForm(updatedEntity[this.universalApi.modelPrimaryKey]);

      await this.afterSave();
      this.universalApi.goToIndex();


      // if (this.isPageMode) {
        //   this.universalApi.goToIndex();
      // } else {
      //   this.dialogRef.close(updatedEntity);
      // }
    }
  }

  async afterSave(): Promise<any> {
    this.nbToastrSvc.show(
      'Riuscito',
      'Salvataggio',
      { duration: 3000, status: 'success', position: NbGlobalLogicalPosition.BOTTOM_END });
    await Helpers.sleep(1000);
    return true;
  }

  public showError(error) {
    const {statusText, status} = error;
    let errorMsg = '';
    switch (status) {
      case 500:
        errorMsg = 'Errore Server, Inserimento di valori non validi o duplicati';
        break;
      case 401:
      case 402:
      case 403:
        errorMsg = 'Errore Server, Non Autorizzato';
        break;
      case 404:
        errorMsg = 'Errore Server, Non Trovato';
        break;
      default:
        errorMsg = 'Errore Server Generico';
    }
    let message = errorMsg;
    let title = 'statusText';
    console.log('show error', error);
    this.nbToastrSvc.show(
      title,
      message,
      { duration: 8000, status: 'danger', position: NbGlobalLogicalPosition.BOTTOM_END });
    return null;
  }
  public checkDates(fieldDateStart, fieldDateEnd, isNew?: boolean) {
    const startDate = this.form.get(fieldDateStart).value;
    const endDate = this.form.get(fieldDateEnd).value;
    const newD = new Date(new Date().setDate(new Date().getDate() -1));
    if (startDate && endDate ) {
      if (startDate > endDate) {
        this.form.get(fieldDateStart).setErrors({valid: false} );
        this.form.get(fieldDateEnd).setErrors({valid: false} );
      } else {
        if (isNew) {
          if (startDate <= newD) {
            this.form.get(fieldDateStart).setErrors({valid: false} );
            this.form.get(fieldDateEnd).setErrors({valid: false} );
          } else {
            this.form.get(fieldDateStart).setErrors(undefined);
            this.form.get(fieldDateEnd).setErrors(undefined);
          }
        } else {
          this.form.get(fieldDateStart).setErrors(undefined);
          this.form.get(fieldDateEnd).setErrors(undefined);
        }
      }
    }
  }

  setFormLoading(isLoading: boolean) {
    this.loading = isLoading;
  }

  getField(fieldname: String) {
    return this.form.get(fieldname.toString()).value;
  }
  patchField(fieldname: String, value: any, eventEmit?: boolean) {
    if ( eventEmit ) {
      this.form.get(fieldname.toString()).patchValue(value, {emitEvent: true});
    } else {
      this.form.get(fieldname.toString()).patchValue(value, {emitEvent: false});
    }
  }

  isInEdit(primaryKeyfield: string) {
    if (this.form.get(primaryKeyfield).value !== null && this.form.get(primaryKeyfield).value !== undefined) {
      return true;
    }
    return false;
  }

 checkIfHasValidation(formGroup: any, controlName: string, validationType: string , isFormArray?:boolean) {

   let ret= false;
   if (isFormArray) {
      const controls = formGroup.controls.map((f)=> {return f.controls});
      //const controls = [];
      for( const c of controls) {
        if (c[controlName]) {
          const { validator } = c[controlName];
          ret = this.validateField(validator, validationType)
        }
      }
    } else {
      const { controls } = formGroup;
      const control = controls[controlName]
      const { validator } = control;
      ret = this.validateField(validator, validationType)
    }
    return ret;
  }

  private validateField(validator, validationType) {
    if (validator) {
      const validation = validator(new FormControl());
      return validation !== null && validation[validationType] === true;
    }
    return false;
  }
}
