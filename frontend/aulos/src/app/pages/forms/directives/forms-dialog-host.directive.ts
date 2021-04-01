import { Directive, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[appFormsDialogHost]'
})
export class FormsDialogHostDirective {

  constructor(
    public viewContainerRef: ViewContainerRef
  ) { }

}
