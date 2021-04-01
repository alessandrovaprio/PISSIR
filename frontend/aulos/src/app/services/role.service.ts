import { Injectable, Injector } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import * as Models from '../../classes/index';

@Injectable({
  providedIn: 'root'
})
export class RoleService {

  apiUrl: string;

  models: string[] = [];
  modelSettings: any = {};
  arrayRole = ['amministratore', 'supervisore', 'responsabile'];
  // set amministratore definition role permissions
  amministratore = {
    amministratore: {
      pages: [
        {
          Evento: {
          canCreate: true,
          canDelete:true,
          canEdit: true
          }
        },
        {
          Prenotazione: {
          canCreate: true,
          canDelete:true,
          canEdit: true
          }
        },
        {
          Attrezzatura: {
          canCreate: true,
          canDelete:true,
          canEdit: true
          }
        },
        {
          Responsabile: {
          canCreate: true,
          canDelete:true,
          canEdit: true
          }
        },
        {
          Aula: {
          canCreate: true,
          canDelete:true,
          canEdit: true
          }
        }
      ]}
    };
    // set responsabile definition role permissions
    responsabile = {
      responsabile: {
        onlyTheirOwn: true,
        pages: [
          {
            Evento: {
            canCreate: true,
            canDelete:true,
            canEdit: true
            }
          },
          {
            Prenotazione: {
            canCreate: true,
            canDelete:true,
            canEdit: true
            }
          }
        ]}
      };

      // set supervisore definition role permissions
    supervisore = {
      supervisore: {
        pages: [
          {
            Evento: {
            canCreate: true,
            canDelete:true,
            canEdit: true
            }
          },
          {
            Prenotazione: {
            canCreate: true,
            canDelete:true,
            canEdit: true
            }
          }
        ]}
      };
  roles = [
    this.amministratore,
    this.responsabile,
    this.supervisore
  ]
  constructor() {
  }



  async init() {

  }


}
