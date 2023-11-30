interface

uses DateUtils, SysUtils, Classes, DB, Windows, Dialogs, ShellAPI;

type
  // Classe  : xData
  // Objetivo: Funções para ajudar no uso de calculo de datas bem como sua formatacao
  // Exemplos: Caption := DateToStr( SetAjuste(Now, 0, 14) );  // incrementa 14 semanas a data de hoje

  TxData = class(TObject)
  public
    constructor Create(Owner: TComponent); 
    ////////////////////////////////////////////////////////////////////////////// AJUSTE DE DATAS
    function SetAjuste(const Data: TDateTime; const Dias: Integer; Meses: Integer = 0; Semanas: Integer = 0; Anos: Integer = 0): TDateTime;
    ////////////////////////////////////////////////////////////////////////////// DATA EM SI
    function GetAnsi(const Data: TDateTime; Aspas: Boolean = True; Formato: string = 'MM/DD/YYYY'): string;
    function GetExtenso(const Data: TDateTime)                : string;
    function GetDataSemana(const Data: TDateTime)             : string;  // retorna 01/01/2002 sex
    ////////////////////////////////////////////////////////////////////////////// DIA
    function GetDia(const Data: TDateTime): Integer;
    function SetDia(const Data: TDateTime; const Dia: Integer): TDateTime;
    ////////////////////////////////////////////////////////////////////////////// MES
    function GetMes(const Data: TDateTime)                    : Integer;
    function GetMesStr(const Data: TDateTime)                 : string;
    function GetNumeroDiasMes(const Data: TDateTime)          : Integer;
    function SetMes(const Data: TDateTime; const Mes: Integer): TDateTime;
    function SetInicioDoMes(const Data: TDateTime)            : TDateTime;
    function SetFimDoMes(const Data: TDateTime)               : TDateTime;
    ////////////////////////////////////////////////////////////////////////////// SEMANA
    function GetDiaSemanaStr(const Data: TDateTime)           : string;
    function SetInicioDaSemana(const Data: TDateTime)         : TDateTime;
    function SetFimDaSemana(const Data: TDateTime)            : TDateTime;
    ////////////////////////////////////////////////////////////////////////////// ANO
    function GetAno(const Data: TDateTime)                    : Integer;
    function GetSemanaDoAno(const Data: TDateTime)            : Integer;
    function SetAno(const Data: TDateTime; const Ano: Integer): TDateTime;
    function AnoBisexto(const Data: TDateTime)                : Boolean;
  end;
  ////////////////////////////////////////////////////////////////////////////// Campos Blob
  function VisualizaBlob(NomeArquivo: String; const Arquivo: TBlobField; const Handle: HWND): boolean;

var
  xData: TxData; // variável publica pronta para o uso

implementation

function VisualizaBlob(NomeArquivo: String; const Arquivo: TBlobField; const Handle: HWND): boolean;
var
  PathBuf: array[0..255] of char;
  TempPath: string;
begin
  GetTempPath(SizeOf(PathBuf), PathBuf);
  TempPath := StrPas(PathBuf) + '\Blobs';
  if not DirectoryExists(TempPath) then
    if not ForceDirectories(TempPath) then
    begin
      Messagedlg('Não foi possível criar o diretório temporário', mtError, [mbOk],0);
      SysUtils.Abort;
    end;
  TempPath := TempPath + '\' + NomeArquivo;
  Arquivo.SaveToFile(TempPath);
  ShellExecute(Handle, 'open', PChar(TempPath), nil, nil, SW_SHOWNORMAL);
  result := true;
end;

///////////////////////////////////////////////////////////////////////////////////// AJUSTE DE DATAS

function TxData.SetAjuste(const Data: TDateTime; const Dias: Integer; Meses: Integer = 0; Semanas: Integer = 0; Anos: Integer = 0): TDateTime;
begin
  Result := Data;
  if Dias    <> 0 then Result := Result + Dias;                // soma dias
  if Meses   <> 0 then Result := IncMonth(Result, Meses);      // soma meses
  if Semanas <> 0 then Result := Result + (Semanas * 7);       // soma semanas
  if Anos    <> 0 then Result := IncMonth(Result, Anos * 12);  // soma anos
end;

///////////////////////////////////////////////////////////////////////////////////// DATA EM SI

function TxData.GetAnsi(const Data: TDateTime; Aspas: Boolean = True; Formato: string = 'MM/DD/YYYY'): string;
begin
  if Aspas then
    Result := QuotedStr(FormatDateTime(Formato,Data))
  else
    Result := FormatDateTime(Formato,Data);
end;

function TxData.GetExtenso(const Data: TDateTime): string;
begin
  Result := FormatDateTime(LongDateFormat, Data);
end;

function TxData.GetDataSemana(const Data: TDateTime): string;
begin
  Result := LowerCase(FormatDateTime('DD/MM/YYYY DDD', Data));
end;

///////////////////////////////////////////////////////////////////////////////////// DIA

function TxData.GetDia(const Data: TDateTime): Integer;
begin
  Result := DayOf(Data);
end;

function TxData.SetDia(const Data: TDateTime; const Dia: Integer): TDateTime;
var
  LAno, LMes, LDia: Word; // variaveis para encode/decode
begin
  try
    DecodeDate(Data, LAno, LMes, LDia);
    Result := EncodeDate(LAno, LMes, Dia);
  except
    Result := 0;
  end;
end;

///////////////////////////////////////////////////////////////////////////////////// MES

function TxData.GetMes(const Data: TDateTime): Integer;
begin
  Result := MonthOf(Data);
end;

function TxData.GetMesStr(const Data: TDateTime): string;
begin
  Result := FormatDateTime('mmmm', Data);
end;

function TxData.GetNumeroDiasMes(const Data: TDateTime): Integer;
begin
  Result := DaysInMonth(Data);
end;

function TxData.SetMes(const Data: TDateTime; const Mes: Integer): TDateTime;
var
  LAno, LMes, LDia: Word; // variaveis para encode/decode
begin
  try
    DecodeDate(Data, LAno, LMes, LDia);
    Result := EncodeDate(LAno, Mes, LDia);
  except
    Result := 0;
  end;
end;

function TxData.SetInicioDoMes(const Data: TDateTime): TDateTime;
var
  LAno, LMes, LDia: Word; // variaveis para encode/decode
begin
  DecodeDate(Data, LAno, LMes, LDia);
  Result := EncodeDate(LAno, LMes, 1);
end;

function TxData.SetFimDoMes(const Data: TDateTime): TDateTime;
begin
  Result := Data;
  Result := SetAjuste(Result, 0, 1);
  Result := SetInicioDoMes(Result);
  Result := SetAjuste(Result, -1);
end;

///////////////////////////////////////////////////////////////////////////////////// SEMANA

function TxData.GetDiaSemanaStr(const Data: TDateTime): string;
begin
  Result := LongDayNames[DayOfWeek(Data)];
end;

function TxData.SetInicioDaSemana(const Data: TDateTime): TDateTime;
var
  FData: TDateTime;
begin
  FData := Data;
  while DayOfWeek(FData) <> 1 do FData := SetAjuste(FData, -1, 0, 0);
  Result := FData;
end;

function TxData.SetFimDaSemana(const Data: TDateTime): TDateTime;
var
  FData: TDateTime;
begin
  FData := Data;
  while DayOfWeek(FData) <> 7 do FData := SetAjuste(FData, 1, 0, 0);
  Result := FData;
end;

///////////////////////////////////////////////////////////////////////////////////// ANO

function TxData.GetAno(const Data: TDateTime): Integer;
begin
  Result := YearOf(Data);
end;

function TxData.GetSemanaDoAno(const Data: TDateTime): Integer;
begin
  Result := WeeksBetween(Data, StrToDate('01/01/' + IntToStr(GetAno(Data))));
end;

function TxData.SetAno(const Data: TDateTime; const Ano: Integer): TDateTime;
var
  LAno, LMes, LDia: Word; // variaveis para encode/decode
begin
  try
    DecodeDate(Data, LAno, LMes, LDia);
    Result := EncodeDate(Ano, LMes, LDia);
  except
    Result := 0;
  end;
end;

function TxData.AnoBisexto(const Data: TDateTime): Boolean;
begin
  Result := IsLeapYear(GetAno(Data));
end;

constructor TxData.Create(Owner: TComponent);
begin
  // None;
end;

end.
