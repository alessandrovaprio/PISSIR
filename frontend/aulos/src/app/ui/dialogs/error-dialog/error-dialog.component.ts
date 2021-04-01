import { Component, OnInit, Input } from '@angular/core';
import { NbDialogRef } from '@nebular/theme';
import { ConfigService } from 'src/app/services/config.service';
import { UIService } from '../../ui.service';

const camelToSnakeCase = str => str.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);

@Component({
  selector: 'app-error-dialog',
  templateUrl: './error-dialog.component.html',
  styleUrls: ['./error-dialog.component.scss']
})
export class ErrorDialogComponent implements OnInit {

  @Input()
  options: any;

  error: any = {
    title: 'Error',
    code: '007',
    message: '',
    details: {}
  };

  title: string;
  errorMessages: string[] = [];

  constructor(
    public configSvc: ConfigService,
    public dialogRef: NbDialogRef<any>,
    public uiSvc: UIService
  ) { }

  ngOnInit() {
    this.processError(this.options);
    this.buildErrorMessages();
  }

  onCallback(result: boolean = false) {
    this.dialogRef.close(result);
  }

  // private

  private buildErrorMessages() {
    const details = this.error.details;
    let entityName;

    if (details) {
      // custom error
      if (details.context === 'System') {
        for (const k of Object.keys(details.codes)) {
          for (const errType of details.codes[k]) {
            switch (errType) {
              case 'unauthorized':
                this.errorMessages.push(`<b>Non sei autorizzato a fare questa azione</b>.`);
                break;
            }
          }
        }
        return;
      }

      //  error
      if (details.context) {
        entityName = this.uiSvc.modelTranslations[details.context].modelName;
        this.title = `Entità '${entityName}' non valida.`;
      }



    }
  }

  private processError(error) {
    if (typeof error === 'object') {
      this.error = {
        title: error.name || error.title,
        code: error.statusCode,
        message: error.message,
        details: error.details,
      };
    } else {
      this.error.message = error;
    }
  }
}
