/* tslint:disable */

import { General } from "./general";

declare var Object: any;
export interface ResponsabileInterface extends General{
  "idResp": number;
  "nomeResp": string;
  "cognomeResp": string;
  "emailResp"?: string;
  "usernameResp": string;
  // "attrezzature"?: Attrezzatura;


}

export class Responsabile implements ResponsabileInterface{
  "idResp": number;
  "nomeResp": string;
  "cognomeResp": string;
  "emailResp": string;
  "usernameResp": string;
  // "attrezzature"?: Attrezzatura;
  constructor(data?: ResponsabileInterface) {
        Object.assign(this, data);
      }
  public getKey() {
    return "idResp";
  }

  public getModelName() {
    return "Responsabile";
  }
  public getFields() {
    return ["idResp","nomeResp","cognomeResp","usernameResp"];
  }
  getRelations(): string [] {
    return [];
  }
  public getFieldType(field): string {
    //return typeof(this[field])
    switch(field) {
      default:
        return 'string';
    }
  }
}

