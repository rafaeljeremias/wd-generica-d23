unit EnumUtilsUnit;

interface

uses
classes,Generics.Collections;

Type
TGenerico = 0..255;

TConvert<T:record> = class
  private
  public
  class procedure PopulateListEnum(AList: TStrings);
  class function StrConvertEnum(const AStr: string):T;
  class function EnumConvertStr(const eEnum:T):string;
end;

implementation

uses
  Variants,SysUtils,TypInfo;

{ TConvert }

class procedure TConvert<T>.PopulateListEnum(AList: TStrings);
var
  i:integer;
  StrTexto:String;
  Enum:Integer;
begin
  i:=0;
  try
    repeat
      StrTexto:=trim(GetEnumName(TypeInfo(T), i));
      Enum:=GetEnumValue(TypeInfo(T),StrTexto);
      AList.Add(StrTexto);
      inc(i);
    until Enum < 0 ;
    AList.Delete(pred(AList.Count));
  except;
    raise EConvertError.Create('O Parâmetro passado não corresponde a um Tipo ENUM');
  end;
end;

{*******************************************************************************}

class function TConvert<T>.StrConvertEnum(const AStr: string):T;
var
  P:^T;
  num:Integer;
begin
try
  num:=GetEnumValue(TypeInfo(T),Astr);
  if num = -1 then
    abort;
    P:=@num;
    result:=P^;
  except
    raise EConvertError.Create('O Parâmetro "'+Astr+'" passado não '+sLineBreak+ ' corresponde a um Tipo Enumerado');
  end;
end;

{******************************************************************************}

class function TConvert<T>.EnumConvertStr(const eEnum:T): String;
var
  P:PInteger;
  Num:integer;
begin
  try
    P:=@eEnum;
    Num:=integer(TGenerico((P^)));
    Result := GetEnumName(TypeInfo(T),Num);
  except
    raise EConvertError.Create('O Parâmetro passado não corresponde a '+sLineBreak+ 'Ou a um Tipo Enumerado');
  end;
end;

end.
