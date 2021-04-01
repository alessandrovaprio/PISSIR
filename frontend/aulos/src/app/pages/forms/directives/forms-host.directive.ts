import { Directive, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[appFormsHost]'
})
export class FormsHostDirective {

  constructor(
    public viewContainerRef: ViewContainerRef
  ) { }

}
