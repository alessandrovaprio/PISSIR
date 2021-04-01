import { Component, OnInit, Input } from '@angular/core';
import { NbDialogRef } from '@nebular/theme';
import { UIService } from '../../ui.service';

@Component({
  selector: 'app-confirm',
  templateUrl: './confirm.component.html',
  styleUrls: ['./confirm.component.scss']
})
export class ConfirmComponent implements OnInit {

  @Input()
  options: any;

  constructor(
    public dialogRef: NbDialogRef<any>,
    public uiSvc: UIService
  ) { }

  ngOnInit() {
    if (!this.options.title) {
      this.options.title = 'default title';
    }

    if (!this.options.message) {
      this.options.message = 'default message';
    }
  }

  onCallback(result: boolean = false) {
    this.dialogRef.close(result);
  }

}
