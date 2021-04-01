import { Injectable, Injector } from '@angular/core';
import { NbMenuItem, NbSidebarService, NbDialogService, NbMenuService, NbDialogRef, NbGlobalLogicalPosition, NbToastrService, NbComponentStatus } from '@nebular/theme';
//import { MaintFuncGroup, MaintFuncNodeApi, MaintFuncNode, UserApi, SystemUser, SystemUserApi, LoopBackFilter, Device, Store, StoreApi, DeviceApi } from 'src/sdk';
import { SafeResourceUrl, DomSanitizer } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { ConfigService } from '../services/config.service';
import { ConfirmComponent } from './dialogs/confirm/confirm.component';
import { ErrorDialogComponent } from './dialogs/error-dialog/error-dialog.component';

@Injectable({
  providedIn: 'root'
})
export class UIService {



  menuItems: NbMenuItem[] = [];
  //maintFuncNodes: MaintFuncNode[] = [];
  modelTranslations: any = {};
  loaderDialog: NbDialogRef<any>;

  private getStatusFromMessage(type: string) {
    let retStatus: NbComponentStatus;
    switch (type) {
      case 'error':
        retStatus='danger';
        break;
      case 'warning':
        retStatus='warning';
        break;
      case 'success':
        retStatus = 'success';
        break;
      case 'info':
        retStatus = 'info';
        break;
      default:
        retStatus= 'info';
    }
    return retStatus;
  }
  // get logoImageUrl() {
  //   let url = 'assets/images/logos/elvispos.png';

  //   if (
  //     this.authSvc.currentUser &&
  //     this.authSvc.currentUser.company &&
  //     this.authSvc.currentUser.company.szTheme
  //   ) {
  //     url = `assets/images/logos/${this.authSvc.currentUser.company.szTheme}.png`;
  //   }

  //   return url;
  // }

  // get version() {
  //   return VERSION.version;
  // }

  // get userLanguage() {
  //   return this.authSvc.currentUser.n0Language;
  // }

  constructor(
    // private authSvc: AuthService,
    private configSvc: ConfigService,
    // private maintFuncNodeApi: MaintFuncNodeApi,
    private nbSidebarSvc: NbSidebarService,
    // private userApi: UserApi,
    private router: Router,
    private nbDialogSvc: NbDialogService,
    private nbToastrSvc: NbToastrService

  ) {
    //this.cloudPOSSvc.subscribeListeners();
    //this.subscribeListeners();
  }

  public showToast(message: string, title: string, typeOfMessage: string, duration: number= 5000, position:NbGlobalLogicalPosition = NbGlobalLogicalPosition.BOTTOM_END){
    const status = this.getStatusFromMessage(typeOfMessage);
    this.nbToastrSvc.show(
      message,
      title,
      { duration, status, position });
  }

  public async confirmDialog(options: any = {}) {
    const dialogRef = this.nbDialogSvc.open(ConfirmComponent, { context: { options } });
    const result = await dialogRef.onClose.toPromise();
    return result;
  }

  public async formDialog(formComponent: any, options: any = {}) {
    const dialogRef = this.nbDialogSvc.open(formComponent, { context: { options } });
    const result = await dialogRef.onClose.toPromise();
    return result;
  }

  public async handleError(options: any = {}) {
    const dialogRef = this.nbDialogSvc.open(ErrorDialogComponent, { context: { options } });
    const result = await dialogRef.onClose.toPromise();
    return result;
  }

  // public async receiptDetailDialog(options: any = {}) {
  //   const dialogRef = this.nbDialogSvc.open(ReceiptDetailDialogComponent, { context: { options } });
  //   const result = await dialogRef.onClose.toPromise();
  //   return result;
  // }

  // public async previewPDF(options: any = {}) {
  //   const dialogRef = this.nbDialogSvc.open(DetailDialogComponent, {
  //     context: { entity: 'PdfTemplate', options },
  //     closeOnBackdropClick: false,
  //     closeOnEsc: false
  //   });
  //   //const dialogRef = this.nbDialogSvc.open(PdfTemplateDetailComponent, { context: { options } });
  //   const result = await dialogRef.onClose.toPromise();
  //   return result;
  // }

  // public async detailView(univeralApi: UniversalApi<any>, options?: any) {
  //   if (univeralApi.entity === "PdfTemplate") {
  //     return this.previewPDF(options);
  //   } else {
  //     const dialogRef = this.nbDialogSvc.open(DetailDialogComponent, {
  //       context: { entity: univeralApi.entity},
  //       closeOnBackdropClick: false,
  //       closeOnEsc: false
  //     });
  //     //const dialogRef = this.nbDialogSvc.open(PdfTemplateDetailComponent, { context: { options } });
  //     const result = await dialogRef.onClose.toPromise();
  //     return result;
  //   }
  // }
  // public async toggleLoader(open: boolean, options: any = {}) {
  //   if ( open ) {
  //     this.loaderDialog = this.nbDialogSvc.open(LoaderComponent, {
  //                     context: { options }, closeOnBackdropClick: false,
  //                     closeOnEsc: false });

  //   } else {
  //     if ( this.loaderDialog ) {
  //       this.loaderDialog.close();
  //     }
  //   }
  // }

  // public async handleError(options: any = {}) {
  //   const dialogRef = this.nbDialogSvc.open(ErrorDialogComponent, { context: { options } });
  //   const result = await dialogRef.onClose.toPromise();
  //   return result;
  // }

  // public onToggleSidebar() {
  //   this.nbSidebarSvc.toggle(true, 'left');
  // }

  // async setUserMenus(currentFunctionGroup: MaintFuncGroup): Promise<void> {
  //   const maintFuncAssigns = currentFunctionGroup.maintFuncAssigns;
  //   this.maintFuncNodes = await this.maintFuncNodeApi.find().toPromise() as MaintFuncNode[];

  //   this.menuItems = [];
  //   this.menuItems.push({ title: this.translate('MenuNodes', 'home'), link: Paths.HOME, icon: 'home-outline' });

  //   if (maintFuncAssigns) {
  //     const hasVirtualPosAssign = maintFuncAssigns.find(mfa => mfa.szMaintFuncId === 'CloudPOS');
  //     if (hasVirtualPosAssign) {
  //       this.cloudPOSSvc.onSetState('closed')
  //       this.menuItems.push({ title: this.translate('MenuNodes', 'cloud_pos'), icon: 'shopping-cart-outline', target: `cloud-pos` });
  //     }

  //     const hasKioskAssign = maintFuncAssigns.find(mfa => mfa.szMaintFuncId === 'CloudKiosk');
  //     if (hasKioskAssign) {
  //       this.menuItems.push({ title: this.translate('MenuNodes', 'cloud_kiosk'), icon: 'monitor-outline', link: `/mnt/kiosk` });
  //     }

  //     const hasBalanceAssign = maintFuncAssigns.find(mfa => mfa.szMaintFuncId === 'BalanceCheck');
  //     if (hasBalanceAssign) {
  //       this.menuItems.push({ title: this.translate('MenuNodes', 'balance') , icon: 'bar-chart-outline', link: `/mnt/balance` });
  //     }
  //   }

  //   this.menuItems.push({ title: this.translate('MenuNodes', 'grafana_report'), icon: 'pie-chart-outline', link: `/mnt/grafana` });

  //   if (this.authSvc.currentUser) {
  //     if ( this.authSvc.isSysAdmin ) {
  //       this.menuItems.push({ title: this.translate('MenuNodes', 'php_pg_admin'), icon: 'hard-drive-outline', link: `/mnt/phppgadmin` });
  //     }
  //   }

  //   this.menuItems.push({ title: '' });

  //   if (maintFuncAssigns.length) {
  //     // map assigns to node
  //     const mappedAssigns = maintFuncAssigns.reduce((prev, next) => {
  //       const szNode = next.szNode || next.maintFunc.szNode;
  //       prev[szNode] = prev[szNode] || [];
  //       prev[szNode].push(next);
  //       return prev;
  //     }, Object.create(null));

  //     const tempMenuItems = [];

  //     for (const nodeKey in mappedAssigns) {
  //       if (mappedAssigns[nodeKey]) {
  //         const currentNode = this.maintFuncNodes.find((n) => n.szId === nodeKey);

  //         if (currentNode) {
  //           const nodeItems = [];
  //           let expandItem = false;

  //           if (DashboardsIndex[currentNode.szId] || !this.configSvc.isProduction) {
  //             nodeItems.push({
  //               title: this.translate('General', 'dashboard'),
  //               icon: 'activity-outline', // add szImage
  //               link: Paths.DASHBOARD(currentNode.szId),
  //               selected: this.router.routerState.snapshot.url.indexOf(currentNode.szId) > -1
  //             });
  //           }

  //           for (const maintFuncAssign of mappedAssigns[nodeKey]) {
  //             const modelTranslation = this.modelTranslations[maintFuncAssign.szMaintFuncId];

  //             if (this.router.routerState.snapshot.url.indexOf(maintFuncAssign.szMaintFuncId) > -1) {
  //               expandItem = true;
  //             }

  //             nodeItems.push({
  //               title: modelTranslation ? this.translate(maintFuncAssign.szMaintFuncId, '_menu') : maintFuncAssign.szMaintFuncId,
  //               icon: maintFuncAssign.maintFunc.szImage || 'arrow-right-outline', // add szImage
  //               link: Paths.INDEX(maintFuncAssign.szMaintFuncId),
  //               order: maintFuncAssign.n0Order,
  //               selected: this.router.routerState.snapshot.url.indexOf(`${maintFuncAssign.szMaintFuncId}`) > -1
  //             });
  //           }

  //           if (this.router.routerState.snapshot.url.indexOf(currentNode.szId) > -1) {
  //             expandItem = true;
  //           }

  //           Helpers.sortByKey(nodeItems, 'order');

  //           tempMenuItems.push({
  //             title: this.translate('MenuNodes', nodeKey) || currentNode.szDefaultDescr,
  //             icon: currentNode.szImage,
  //             children: nodeItems,
  //             order: currentNode.n0Order,
  //             expanded: expandItem
  //           });
  //         }
  //       }
  //     }

  //     // sort by order key
  //     Helpers.sortByKey(tempMenuItems, 'order');

  //     // cast tempMenuItems to NbMenuItem[] (order key was invalid but it's ok)
  //     this.menuItems = [...this.menuItems, ...tempMenuItems as NbMenuItem[]];
  //   }
  // }

  // public translate(entity: string, field: string) {
  //   try {
  //     switch (field) {
  //       case '_menu':
  //         return this.modelTranslations[entity].modelMenuLabel || `${entity}.${field}`;
  //       case '_single':
  //         return this.modelTranslations[entity].modelName || `${entity}.${field}`;
  //       case '_plural':
  //         return this.modelTranslations[entity].modelNamePlural || `${entity}.${field}`;
  //       default:
  //         return this.modelTranslations[entity].modelProperties[field] || `${entity}.${field}`;
  //     }
  //   } catch (error) {
  //     return `${entity}.${field}`;
  //   }
  // }

  // async loadRemoteTranslations() {
  //   const resp = await this.userApi.getTranslation().toPromise().catch(console.error);

  //   if (resp) {
  //     this.modelTranslations = resp;
  //     console.log('this.modelTranslations', this.modelTranslations)
  //     return resp;
  //   }

  //   return null;
  // }

  // // private

  // private subscribeListeners() {
  //   this.authSvc.events.subscribe(async (message) => {
  //     const { event, data } = message;
  //     switch (event) {
  //       case 'login':
  //       case 'validated':
  //         await this.loadRemoteTranslations();
  //         this.setUserMenus(data.currentFunctionGroup);
  //         break;
  //     }
  //   });
  // }
}
