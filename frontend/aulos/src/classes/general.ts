/* tslint:disable */

declare var Object: any;
export interface General {

  // "attrezzature"?: Attrezzatura;
  getKey(): string;
  getModelName(): string;
  getFields(): string[];
  getRelations(): string[];
  getFieldType(sttring): string;
}
