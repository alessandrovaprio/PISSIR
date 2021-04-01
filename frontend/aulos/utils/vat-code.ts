
// enums go from 1 to x
export class VATRegExp {

  // Austria
  public static AT = {
    regexp: new RegExp(/^(AT)(U\d{8}$)/i),
    istatCode: 'Z102'
  };

  // Belgium
  public static BE = {
    regexp: new RegExp(/^(BE)(\d{10}$)/i),
    istatCode: 'Z103'
  };

  // Bulgaria
  public static BG = {
    regexp: new RegExp(/^(BG)(\d{9,10}$)/i),
  };

  // Cyprus
  public static CY = {
    regexp: new RegExp(/^(CY)([0-5|9]\d{7}[A-Z]$)/i),
    istatCode: 'Z211'
  };

  // Czech Republic
  public static CZ = {
    regexp: new RegExp(/^(CZ)(\d{8,10})?$/i),
    istatCode: 'Z156'
  };

  // Germany
  public static DE = {
    regexp: new RegExp(/^(DE)([1-9]\d{8}$)/i),
    istatCode: 'Z112'
  };

  // Denmark
  public static DK = {
    regexp: new RegExp(/^(DK)(\d{8}$)/i),
    istatCode: ''
  };

  // Estonia
  public static EE = {
    regexp: new RegExp(/^(EE)(10\d{7}$)/i),
    istatCode: 'Z144'
  };

  // Greece
  public static EL = {
    regexp: new RegExp(/^(EL)(\d{9}$)/i),
    istatCode: 'Z115'
  };

  public static GR = {
    regexp: new RegExp(/^(GR)(\d{8,9}$)/i),
    istatCode: 'Z115'
  };

  // Spain
  public static ES = {
    regexp: new RegExp(/^(ES)([0-9A-Z][0-9]{7}[0-9A-Z]$)/i),
    istatCode: 'Z131'
  };

  // EU type
  public static EU = {
    regexp: new RegExp(/^(EU)(\d{9}$)/i),
  };

  // Finland
  public static FI = {
    regexp: new RegExp(/^(FI)(\d{8}$)/i),
    istatCode: 'Z109'
  };

  // France
  public static FR = {
    regexp: new RegExp(/^(FR)([0-9A-Z]{2}[0-9]{9}$)/i),
    istatCode: 'Z110'
  };

  // UK (Standard = 9 digits); (Branches = 12 digits); (Government = GD + 3 digits); (Health authority = HA + 3 digits)
  public static GB = {
    regexp: new RegExp(/^(GB)((?:[0-9]{12}|[0-9]{9}|(?:GD|HA)[0-9]{3})$)/i),
    istatCode: 'Z114'
  };

  // Croatia
  public static HR = {
    regexp: new RegExp(/^(HR)(\d{11}$)/i),
    istatCode: 'Z149'
  };

  // Hungary
  public static HU = {
    regexp: new RegExp(/^(HU)(\d{8}$)/i),
    istatCode: 'Z134'
  };

  // Ireland
  public static IE = {
    regexp: new RegExp(/^(IE)([0-9A-Z\*\+]{7}[A-Z]{1,2}$)/i),
    istatCode: 'Z116'
  };

  // Italy
  public static IT = {
    regexp: new RegExp(/^(IT)(\d{11}$)/i),
    istatCode: 'ITA'
  };

  // Latvia
  public static LV = {
    regexp: new RegExp(/^(LV)(\d{11}$)/i),
    istatCode: 'Z145'
  };

  // Lithuania
  public static LT = {
    regexp: new RegExp(/^(LT)(\d{9}$|\d{12}$)/i),
    istatCode: 'Z146'
  };

  // Luxembourg
  public static LU = {
    regexp: new RegExp(/^(LU)(\d{8}$)/i),
    istatCode: 'Z120'
  };

  // Malta
  public static MT = {
    regexp: new RegExp(/^(MT)([1-9]\d{7}$)/i),
    istatCode: 'Z121'
  };

  // Netherlands
  public static NL = {
    regexp: new RegExp(/^(NL)(\d{9}B\d{2}$)/i),
    istatCode: 'Z126'
  };

  // Norway (NOT EU)
  public static NO = {
    regexp: new RegExp(/^(NO)(\d{9}$)/i),
    istatCode: 'Z125'
  };

  // Poland
  public static PL = {
    regexp: new RegExp(/^(PL)(\d{10}$)/i),
    istatCode: 'Z127'
  };

  // Portugal
  public static PT = {
    regexp: new RegExp(/^(PT)(\d{9}$)/i),
    istatCode: 'Z128'
  };

  // Romania
  public static RO = {
    regexp: new RegExp(/^(RO)([1-9]\d{1,9}$)/i),
    istatCode: 'Z129'
  };

  // Russia
  public static RU = {
    regexp: new RegExp(/^(RU)(\d{10}$|\d{12}$)/i),
    istatCode: 'Z154'
  };

  // Serbia
  public static RS = {
    regexp: new RegExp(/^(RS)(\d{9}$)/i),
    istatCode: 'Z158'
  };

  // Slovenia
  public static SI = {
    regexp: new RegExp(/^(SI)([1-9]\d{7}$)/i),
    istatCode: 'Z150'
  };

  // Slovakia Republic
  public static SK = {
    regexp: new RegExp(/^(SK)([1-9]\d[(2-4)|(6-9)]\d{7}$)/i),
    istatCode: 'Z155'
  };

  // Sweden
  public static SE = {
    regexp: new RegExp(/^(SE)(\d{10}01$)/i),
    istatCode: 'Z132'
  };
}

export class VATCode {

  public code;

  constructor(code: string) {
    this.code = code;
  }

  public isValid() {
    const countryCode = this.getCountryCode();

    if (VATRegExp[countryCode]) {
      return VATRegExp[countryCode].regexp.test(this.code);
    } else {
      return false;
    }
  }

  public isItalian() {
    return this.isValid() && this.getIstatCode() === 'ITA';
  }

  public getCountryCode() {
    try {
      return this.code.substr(0, 2).toUpperCase();
    } catch (error) {
      return 'XX';
    }
  }

  public getIstatCode() {
    try {
      return VATRegExp[this.getCountryCode()].istatCode;
    } catch (error) {
      return undefined;
    }
  }
}