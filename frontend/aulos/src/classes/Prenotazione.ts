/* tslint:disable */

import { General } from "./general";

declare var Object: any;
export interface PrenotazioneInterface extends General{
  "idAula": number;
  "nomeAula": string;
  "capienzaMax"?: number;
  "capienzaMin"?: number;
  // "attrezzature"?: Attrezzatura;


}

export class Prenotazione implements PrenotazioneInterface{
  "idAula": number;
  "nomeAula": string;
  "statoAula": string;
  "capienzaMax"?: number;
  "capienzaMin"?: number;
  // "attrezzature"?: Attrezzatura;
  constructor(data?: PrenotazioneInterface) {
        Object.assign(this, data);
      }
  public getKey() {
    return "idEvento";
  }

  public getModelName() {
    return "Initiative";
  }
  public getFields() {
    return ["nomeAula","statoAula", "capienzaMax"];
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

// getFieldsAsArray() {
//   return ["idAula", "nomeAula", "capienzaMax", "capienzaMin"];
// }
// export class Event implements EventInterface {
//   "id": number;
//   "description": string;
//   "start_date"?: number;
//   "end_date"?: number;
//   "classroom"?: number;
//   constructor(data?: EventInterface) {
//     Object.assign(this, data);
//   }
//   /**
//    * The name of the model represented by this $resource,
//    * i.e. `Action`.
//    */
//   public static getModelName() {
//     return "Event";
//   }
//   /**
//   * @method factory
//   * @author Jonathan Casarrubias
//   * @license MIT
//   * This method creates an instance of Action for dynamic purposes.
//   **/
//   public static factory(data: EventInterface): Event{
//     return new Event(data);
//   }

//   public static getModelDefinition() {
//     return {
//       name: 'Action',
//       plural: 'Action',
//       path: 'Action',
//       idName: 'n0Id',
//       properties: {
//         "Id": {
//           name: 'n0Id',
//           type: 'number'
//         },
//         "description": {
//           name: 'description',
//           type: 'number'
//         },
//         "start_date": {
//           name: 'start_date',
//           type: 'number'
//         },
//         "end_date": {
//           name: 'end_date',
//           type: 'number'
//         },
//         "classroom": {
//           name: 'classroom',
//           type: 'number'
//         }
//       }
//     }
//   }
// }
