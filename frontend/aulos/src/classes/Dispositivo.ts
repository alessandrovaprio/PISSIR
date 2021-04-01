/* tslint:disable */

import { Aula } from ".";
import { General } from "./general";

declare var Object: any;
export interface DispositivoInterface extends General{
  "idDispositivo"?: number;
  "nomeDispositivo"?: string;
  "marcaDispositivo"?: string;
  "aulaDispositivo"?: Aula;
  "dataInstallazione"?: Date;


}

export class Dispositivo implements DispositivoInterface{
  "idDispositivo"?: number;
  "nomeDispositivo"?: string;
  "marcaDispositivo"?: string;
  "aulaDispositivo"?: Aula;
  "dataInstallazione"?: Date;
  constructor(data?: DispositivoInterface) {
        Object.assign(this, data);
      }
  getKey() {
    return "idDispositivo";
  }

  getModelName() {
    return "Dispositivo";
  }

  getFields() : string[] {
    return ["idDispositivo", "nomeDispositivo", "marcaDispositivo", "aulaDispositivo", "dataInstallazione"];
  }
  getRelations(): string [] {
    return ['Aula'];
  }
  public getFieldType(field): string {
    switch(field) {
      case 'dataInstallazione':
       return 'date';
      default:
        return 'string';
    }
  }
}
