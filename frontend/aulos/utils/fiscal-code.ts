
// enums go from 1 to x
export enum FiscalCodeMonths { A, B, C, D, E, H, L, M, P, R, S, T, }

export class FiscalCode {

  public code;

  constructor(code: string) {
    this.code = code;
  }

  public isValid() {
    const fcRegExp = new RegExp(/^(?:[A-Z][AEIOU][AEIOUX]|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]$/i);
    return fcRegExp.test(this.code);
  }

  public getDate() {
    try {
      let monthNumber;
      let yearNumber = parseInt(this.code.substr(6, 2), 10);
      let dayNumber = parseInt(this.code.substr(9, 2), 10);
      const monthLetter = this.code.substr(8, 1).toUpperCase();

      if (dayNumber > 31) {
        dayNumber -= 40;
      }

      if (yearNumber < 13) {
        yearNumber = 2000 + yearNumber;
      } else {
        yearNumber = 1900 + yearNumber;
      }

      monthNumber = FiscalCodeMonths[monthLetter];
      return new Date(yearNumber, monthNumber, dayNumber);
    } catch (error) {
      console.log(error)
    }
  }

  public getSex() {
    try {
      const dayNumber = parseInt(this.code.substr(9, 2), 10);

      if (dayNumber > 31) {
        return 'F';
      } else {
        return 'M';
      }
    } catch (error) {
    }
  }

  public getCityCode() {
    return this.code.substr(11, 4).toUpperCase();
  }

  public getIstatCode() {
    if (this.getCityCode().substr(0, 1) !== 'Z') {
      return 'ITA';
    } else {
      return this.getCityCode();
    }
  }

  public isItalian() {
    return this.isValid() && this.getIstatCode() === 'ITA';
  }
}