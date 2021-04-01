import { Component, OnInit, Input, ViewChild } from '@angular/core';
import { NbDialogRef, NbDialogService } from '@nebular/theme';
import { UniversalApi } from '../../../../utils/universal-api';
import { UIService } from '../ui.service';
import { IndexTableComponent } from '../index-table/index-table.component';
@Component({
  selector: 'app-select-list',
  templateUrl: './select-list.component.html',
  styleUrls: ['./select-list.component.scss']
})
export class SelectListComponent {

  @ViewChild(`indexTable`, { static: true })
  indexTable: IndexTableComponent;

  @Input()
  universalApi: UniversalApi<any>;

  @Input()
  currentSelection: any;

  // @Input()
  // searchFilter: IndexFilter[];

  @Input()
  showPreview: boolean = false;

  constructor(
    private dialogRef: NbDialogRef<any>,
    public uiSvc: UIService,
  ) { }

  onClose() {
    this.dialogRef.close();
  }

  onSelect(row) {
    setTimeout(()=> {
      this.dialogRef.close(row);
    }, 333)
  }
}
