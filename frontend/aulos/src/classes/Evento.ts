/* tslint:disable */

import { stringify } from "@angular/compiler/src/util";
import { General } from "./general";
import { Responsabile } from "./Responsabile";

declare var Object: any;
export interface EventoInterface extends General{
  "idEvento": number;
  "respEvento": number;
  "aulaEvento"?: number;
  "maxPartecipanti"?: number;
  "nPresenti"?: number;
  "gradoRiempAula"?: number;
  //"maxPresenti"?: number;
  "nomeEvento"?: string;
  "tipoEvento"?: string;
  "dataOraInizio"?: Date;
  "dataOraFine"?: Date;
  // "attrezzature"?: Attrezzatura;


}

export class Evento implements EventoInterface{
  "idEvento": number;
  "respEvento": number;
  "aulaEvento"?: number;
  //"maxPartecipanti"?: number;
  "nPresenti"?: number;
  "gradoRiempAula"?: number;
  "maxPresenti"?: number;
  "nomeEvento"?: string;
  "tipoEvento"?: string;
  "dataOraInizio"?: Date;
  "dataOraFine"?: Date;
  "statoEvento"?: string;
  "statoPresenti"?: string;
  // "attrezzature"?: Attrezzatura;
  constructor(data?: EventoInterface) {
        Object.assign(this, data);
      }
  public getKey() {
    return "idEvento";
  }

  public getModelName() {
    return "Evento";
  }
  getRelations(): string [] {
    return ['Responsabile', 'Aula'];
  }
  public getFields() {

    return [  "idEvento",
              "nomeEvento",
              "aulaEvento",
              "statoEvento",
              "dataOraInizio",
              "dataOraFine",
              "respEvento",
              "nPresenti",
              "statoPresenti",
              //"maxPartecipanti",
              "gradoRiempAula",
              "maxPresenti",
              "tipoEvento"
    ];
  }
  public getFieldType(field): string {
    //return typeof(this[field])
    switch(field) {
      case 'dataOraInizio':
      case 'dataOraFine':
       return 'date';
      // case 'respEvento':
      // case 'aulaEvento':
      //  return 'relation';
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
