unit WiseUnit;

interface

uses Registry, SysUtils, Windows, dialogs, controls, inifiles, classes, Forms,
  DB, StdCtrls, StrUtils, ShellAPI, variants, DateUtils, IdRawBase, IdRawClient,
  IdIcmpClient, IdGlobal, ChkDgVer, IdHash, IdHashMessageDigest, Math;

type
  TTipoValor = (tvDate, tvTime);

var
  menu_BL: String;
  ThreadCount : integer;

function PathSemDelimitador(path: String): String;

function ExecDOSWait(const Parametros: string; WorkPath: string = '';
  ShowWindow: Word = SW_HIDE): Integer;

function LerReg(const Path, Variavel: string; const ValorDefault: string)
  : string; overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Integer)
  : Integer; overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Double)
  : Double; overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Boolean)
  : Boolean; overload;

procedure GravaReg(const Path, Variavel, Valor: string); overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Integer);
  overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Double); overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Boolean);
  overload;

function LerINI(const Chave, Item: string; Padrao: string = '';
  FileName: string = ''): string; overload;
function LerINI(const Chave, Item: string; Padrao: Integer = 0;
  FileName: string = ''): Integer; overload;
function LerINI(const Chave, Item: string; Padrao: Boolean;
  FileName: string = ''): Boolean; overload;

procedure GravaINI(const Chave, Item: string; valor : string; FileName: string = ''); overload;
procedure GravaINI(const Chave, Item: string; valor : integer; FileName: string = ''); overload;
procedure GravaINI(const Chave, Item: string; valor : boolean; FileName: string = ''); overload;

function Encrip(const S, Chave: string): string;
function Decrip(const S, Chave: string): string;

procedure msgAlerta(const Texto: string);
procedure msgInformacao(const Texto: string);
procedure msgErro(const Texto: string);
procedure msgInformaAbort(const Condicao: Boolean; const Texto: string;
  Foca: TWinControl = nil);
function msgConfirma(const Texto: string; FocoNao: Boolean = False): Boolean;
function msgConfirma2(const Texto: string; FocoNao: Boolean = False): Integer;

function QuebraLinha(S: String; tamanhoLinha: Integer): TStringList;
function SomenteNumeros(const Valor: string): string;
function Separa(const S: string; const Separador: Char; const Posicao: Integer)
  : string;
function TiraAcentos(const Texto: string): string;
function Extenso(const Valor: Double; IntSing: string = 'Real';
  IntPlural: string = 'Reais'; DecSing: string = 'Centavo';
  DecPlural: string = 'Centavos'): string;
function Ordinal(numero: Integer; sexo: String = 'M'): String;
function FormataCPFCNPJ(const S: string): string;
function FormataCartao(const S: string): string;
function FormataIE(const S: string): string;
function FormataCEP(const Codigo: string): string;
function AlinhaEsq(const Palavra: string; Tamanho: Integer;
  Caracter: Char = #32): string;
function AlinhaDir(const Palavra: string; Tamanho: Integer;
  Caracter: Char = #32): string;
function AlinhaCentro(const Palavra: string; Tamanho: Integer;
  Caracter: Char = #32): string;

function AbreConsultaForm(const TipoForm: TComponentClass; Form: TCustomForm;
  const origem: array of string; const destino: array of TField;
  Criar: Boolean = True; cd_usuario: Integer = 0; menu: String = '';
  FreeForm: Boolean = True): Boolean;
function AbreConsultaFormEdit(const TipoForm: TComponentClass;  Form: TCustomForm;
  const origem: array of string; const destino: array of TEdit;
  Criar: Boolean = True;  cd_usuario: Integer = 0; menu: String = '';
  FreeForm: Boolean = True): Boolean;

function VisualizaBlob(NomeArquivo: String; const Arquivo: TBlobField;
  const Handle: HWND;pathBlob : string = ''): Boolean;
function SalvaBlob(NomeArquivo: String; const Arquivo: TBlobField; salvarDirTemp : boolean = True ): String;
function ValidaCNPJCPF(const Codigo: string): Boolean;
function ValidaIE(IE, UF: string): boolean;
function ValidaDataHora(Flag: TTipoValor; DataOuHora: String): Boolean;
function HoraParaMin(const Hora: String): Integer;
procedure ListaPasta(var Lista: TStringList; const Arquivos: string; IncluirPasta: Boolean = False; Detalhes: Boolean = False);
function DataExtenso(data: TDateTime; exibir_dia_semana: Boolean = False): String;
function SeNulo(Valor, Padrao: variant): variant;
function FormataFloatComPonto( valor : double; casas_decimais : integer  ) : string;
function DiaSemanaExtenso( data : TDateTime; forma : String = 'Completa' ) : String;
function retiraZerosEsquerda( texto : String; fg_retira : boolean = true ) : string;
function TiraAcentosLike(const Texto: string): string;
procedure CSVExport(  DataSet: TDataSet; AsciiFilePath: String; Delimiter, Separator: Char; TipoHeader : String = 'DisplayName' );
function ExecExterno(comando: string; const WindowState: Word; path_tmp : String ): boolean;
function isTextoInArquivoTxt( nm_arquivo_txt, texto : string ) : integer;
function IsFileLocked(FileName: TFileName): Boolean;
function IsValidEAN(EANCode: String): Boolean;
function IsValidEmail(const Email: string) : Boolean;
function ValidaNFE(nr_chave, uf, cnpj, modelo, serie, nota : string; emissao: TDate; var erro : String):boolean;
//function ping(const nr_ip: string; nr_tentativas: integer = 3; nr_ok: integer = 2): boolean;

function RTrim( Texto:String) : String;
function LTrim( Texto:String) : String;
function Seg_Hora( Seg:LongInt ):string;
function Alltrim( Texto:String) : String;
function Capitaliza(const s: string): string;
function UpperAcentos(texto: String): String;
function OcorreStr(C: Char; S: String): Integer;
function StrZero(Num:Real ; Zeros,Deci:integer): string;
function StringToMD5(const Value: string): string;
function TiraAcentuacao(texto: String): String;
function getDigModulo10(as_cd_barra: String): Integer;

var
  FG_CONSULTA_ABERTA: String;


implementation

uses ConsultaSimplesGenericaUnit;

function IsValidEmail(const Email: string) : Boolean;
const
  InvalidChar = 'àâêôûãõáéíóúçüñýÀÂÊÔÛÃÕÁÉÍÓÚÇÜÑÝ*;:⁄\|#$%&*§!()][{}<>˜ˆ´ªº+¹²³';
var
  I: Integer;
  C: Integer;
begin
  // Não existe email com menos de 8 caracteres.
  if Length(Email) < 8 then
  begin
    Result := False;
    Exit;
  end;

  // Verificando se há somente um @
  if ((Pos( '@', Email) = 0) or
  (PosEx( '@', Email, Pos('@', Email) + 1) > 0)) then
  begin
    Result := False;
    Exit;
  end;

  // Verificando se no mínimo há um ponto
  if (Pos('.', Email) = 0) then
  begin
    Result := False;
    Exit;
  end;

  // Não pode começar ou terminar com @ ou ponto
  if CharInSet(Email[1], ['@', '.']) or CharInSet(Email[Length(Email)], ['@', '.']) then
  begin
    Result := False;
    Exit;
  end;

  // O @ e o ponto não podem estar juntos
  if (Email[Pos( '@', Email) + 1] = '.') or
  (Email[Pos( '@', Email) - 1] = '.') then
  begin
    Result := False;
    Exit;
  end;

  // Testa se tem algum caracter inválido.
  for I := 1 to Length(Email) do
  begin
    for C := 0 to Length(InvalidChar) do
      if (Email[I] = InvalidChar[C]) then
      begin
        Result := False;
        Exit;
      end;
  end;

  // Se não encontrou problemas, retorna verdadeiro
  Result := True;
end;

Function IsValidEAN(EANCode: String): Boolean;
Var
  CheckSum1: String;
  Tmp, Tmp2: Integer;
  VerifyDigit: Integer;
  LectDigit: String;

Begin
  EANCode := Trim(EANCode);

  If ((Length(EANCode) <> 8) And (Length(EANCode) < 13)) Then
   EANCode := DupeString('0', 13 - length(EanCode))+EANCode;

  LectDigit := Copy(EANCode, Length(EanCode), 1);
  EANCode := Copy(EANCode, 1, Length(EanCode) - 1);

  // validação do ean 14
  {if length(EANCode) = 13 then
    EANCode := copy(EANCode, 2, length(EANCode));}

{  if (Length(EANCode) = 7 ) then
    CheckSum1 := '313131313131'
  else
    CheckSum1 := '131313131313';}

  case Length(EANCode) of
    7  : CheckSum1 := '313131313131';
    13 : CheckSum1 := '3131313131313';
  else
    CheckSum1 := '131313131313'
  end;

  Tmp2 := 0;

  For Tmp := 1 To Length(EANCode) do
    Tmp2 := Tmp2 + (StrToInt (Copy (EANCode, Tmp, 1)) * StrToInt (Copy(CheckSum1, Tmp, 1)));

  Tmp2 := Tmp2 mod 10;
  Tmp2 := 10 - Tmp2;
  Tmp := StrToInt (Copy (IntToStr(Tmp2), Length(IntToStr(Tmp2)),1));
  VerifyDigit := Tmp;

  If VerifyDigit <> StrToInt (LectDigit) Then
      IsValidEAN := False
  Else
      IsValidEAN := True;
End;


function IsFileLocked(FileName: TFileName): Boolean;
var
  h: THandle;
begin
  h := Windows.CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0,  nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result := (h = INVALID_HANDLE_VALUE);
  if not Result then
   CloseHandle(h);
end;


function isTextoInArquivoTxt( nm_arquivo_txt, texto : string ) : integer;
var
  S: string;
  P: Integer;
  Arq: TextFile;
begin
  result := 0;
  //pega a palavra/frase no edit, convertendo tudo para minúsculo
  AssignFile(Arq, nm_arquivo_txt );
  //abre o arquivo
  Reset(Arq);
  try
    //enquanto não alcançar o final do arquivo
    while not Eof(Arq) do
    begin
      //lê a linha
      Readln(Arq, S);
      //converte-a para minúsculo, para ficar igual ao Edit
      S := LowerCase(S);
      //executa o laço percorrendo a linha e contando as palavras/frases
      while S <> '' do
      begin
        P := Pos(texto, S);
        if P = 0 then
          Break;
        Inc(result);
        Delete(S, 1, P + Length(texto));
      end;
    end;
  finally
  //fecha o arquivo
    CloseFile(Arq);
  end;
end;

function ExecExterno(comando: string; const WindowState: Word; path_tmp : String ): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  { Coloca o nome do arquivo entre aspas. Isto é necessário devido aos espaços contidos em nomes longos }
  CmdLine := comando;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do
  begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
  CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar( path_tmp ), SUInfo, ProcInfo);
  { Aguarda até ser finalizado }
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    { Libera os Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;

end;


procedure GravaINI(const Chave, Item: string; valor : string; FileName: string = ''); overload;
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create( FileName );
  try
    ArqIni.WriteString( chave, item, valor);
  finally
    ArqIni.Free;
  end;
end;

procedure GravaINI(const Chave, Item: string; valor : integer; FileName: string = ''); overload;
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create( FileName );
  try
    ArqIni.WriteString( chave, item, IntToStr( valor ));
  finally
    ArqIni.Free;
  end;

end;

procedure GravaINI(const Chave, Item: string; valor : boolean; FileName: string = ''); overload;
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create( FileName );
  try
    ArqIni.WriteString( chave, item, BoolToStr( valor ));
  finally
    ArqIni.Free;
  end;

end;


procedure CSVExport(  DataSet: TDataSet; AsciiFilePath: String; Delimiter, Separator: Char; TipoHeader : String );
var
  AsciiFile:   System.Text;
  I:           Integer;
  LastField:   Integer;
begin
  Assign(AsciiFile, AsciiFilePath);
  Rewrite(AsciiFile);
  LastField := DataSet.FieldCount - 1;
  // header
  for I := 0 to LastField do
  begin
    if DataSet.Fields[I].Visible then
    begin
      Write(AsciiFile, Delimiter);
      if UpperCase( TipoHeader ) = 'FIELDNAME' then
        Write(AsciiFile, DataSet.Fields[I].FieldName)
      else
        Write(AsciiFile, DataSet.Fields[I].DisplayLabel);
      Write(AsciiFile, Delimiter);
      if I < LastField then
        Write(AsciiFile, Separator);
    end;
  end; {for}
  Writeln(AsciiFile, '');

  // fields
  while not DataSet.EOF do
  begin
    for I := 0 to LastField do
    begin
      if DataSet.Fields[I].Visible then
      begin
        {If the field is not numeric write the opening
         delimiter character.}
        if not (DataSet.Fields[I].DataType in [ftBCD, ftCurrency, ftFloat, ftInteger, ftSmallInt, ftWord]) then
          Write(AsciiFile, Delimiter);
        {Write the field value.}
        Write(AsciiFile, DataSet.Fields[I].AsString);
        {If the field type is not numeric write the
         closing delimiter character.}
        if not (DataSet.Fields[I].DataType in [ftBCD, ftCurrency, ftFloat, ftInteger, ftSmallInt, ftWord]) then
          Write(AsciiFile, Delimiter);
        {If this is not the last field write the
         separator character.}
        if I < LastField then
          Write(AsciiFile, Separator);
      end;
    end; {for}
    {Write the carriage/line feed at the end of
     this record.}
    Writeln(AsciiFile, '');
    DataSet.Next;
  end; {while}
  System.Close(AsciiFile);
end;

function retiraZerosEsquerda( texto : String; fg_retira : boolean ) : string;
var
  i : integer;
  fg_inclui : boolean;
begin
  if fg_retira then
  begin
    result := '';
    fg_inclui := false;
    for i := 1 to Length( texto ) do
    begin
      if fg_inclui then
        result := result + texto[i]
      else
        if texto[i] <> '0' then
        begin
          fg_inclui := true;
          result := result + texto[i]
        end;
    end;
  end
  else
    result := texto;
end;

function DiaSemanaExtenso( data : TDateTime; forma : String ) : String;
var
  nrdia: Integer;
  diasemana: array[1..7] of String;
begin
  if forma = 'Completa' then
  begin
    diasemana[1]:= 'Domingo';
    diasemana[2]:= 'Segunda-feira';
    diasemana[3]:= 'Terça-feira';
    diasemana[4]:= 'Quarta-feira';
    diasemana[5]:= 'Quinta-feira';
    diasemana[6]:= 'Sexta-feira';
    diasemana[7]:= 'Sábado';
  end;
  if forma = 'Resumida' then
  begin
    diasemana[1]:= 'Dom';
    diasemana[2]:= 'Seg';
    diasemana[3]:= 'Ter';
    diasemana[4]:= 'Qua';
    diasemana[5]:= 'Qui';
    diasemana[6]:= 'Sex';
    diasemana[7]:= 'Sáb';
  end;
  if forma = 'Letra' then
  begin
    diasemana[1]:= 'D';
    diasemana[2]:= 'S';
    diasemana[3]:= 'T';
    diasemana[4]:= 'Q';
    diasemana[5]:= 'Q';
    diasemana[6]:= 'S';
    diasemana[7]:= 'S';
  end;
  nrdia:= DayOfWeek(data);
  result := diasemana[nrdia];
end;


function FormataFloatComPonto( valor : double; casas_decimais : integer  ) : string;
var
  mascara : String;
begin
  mascara := '0.' + DupeString( '0', casas_decimais );
  result := AnsiReplaceStr( FormatFloat( mascara, valor ), ',', '.' );
end;

function ValidaDataHora(Flag: TTipoValor; DataOuHora: String): Boolean;
Var
  Ano, Mes, Dia: Integer;
  dOh: string;
Begin
  Result := False;
  dOh := StringReplace(DataOuHora,' ','',[rfReplaceAll, rfIgnoreCase]);
  case Flag of
    tvDate:
      Begin
        if Length(dOh) < 10 then
        Begin
          Result := False;
          Exit;
        End;

        Ano := StrToInt(dOh[7] + dOh[8] + dOh[9]
            + dOh[10]);
        Mes := StrToInt(dOh[4] + dOh[5]);
        Dia := StrToInt(dOh[1] + dOh[2]);
        Result := IsValidDate(Ano, Mes, Dia);
      End;

    tvTime:
      Begin
        if Length(dOh) < 8 then
        Begin
          Result := False;
          Exit;
        End;

        Ano := StrToInt(dOh[1] + dOh[2]);
        Mes := StrToInt(dOh[4] + dOh[5]);
        Dia := StrToInt(dOh[7] + dOh[8]);

        Result := IsValidTime(Ano, Mes, Dia, 0);
      End;
  end;
End;

function SeNulo(Valor, Padrao: variant): variant;
begin
  if VarIsNull(Valor) then
    Result := Padrao
  else
    Result := Valor;
end;

procedure ListaPasta(var Lista: TStringList; const Arquivos: string;
  IncluirPasta: Boolean = False; Detalhes: Boolean = False);
var
  Procura: TSearchRec;
  Found: Integer;
  S: string;

begin
  Lista.Clear;
  Screen.Cursor := -11;
  Found := FindFirst(Arquivos, {faArchive}32, Procura);
  while Found = 0 do
  begin
    if IncluirPasta then
      S := ExtractFilePath(Arquivos) + Procura.Name
    else
      S := Procura.Name;

    if Detalhes then
      S := S + ';' + FormatDateTime('DD/MM/YYYY HH:NN:SS', Procura.TimeStamp) + ';' + IntToStr(Procura.Size);

    Lista.Add(S);
    Found := FindNext(Procura);
  end;
  Screen.Cursor := 0;
  SysUtils.FindClose(Procura);
end;

function ExecDOSWait(const Parametros: string; WorkPath: string = '';
  ShowWindow: Word = SW_HIDE): Integer;
var
  R: DWORD;
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartUpInfo, SizeOf(StartUpInfo), #0);
  StartUpInfo.Cb := SizeOf(StartUpInfo);
  StartUpInfo.DwFlags := StartF_UsesHowWindow;
  // StartUpInfo.wShowWindow:= SW_SHOWNORMAL; // Mostra tela do DOS
  StartUpInfo.wShowWindow := ShowWindow; // Oculta a tela do DOS
  if not CreateProcess(nil, PChar(Parametros), nil, nil, False,
    Create_New_Console or Normal_Priority_Class, nil, PChar(WorkPath),
    StartUpInfo, ProcessInfo) then
    Result := -1
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, R);
    Result := R;
  end;
end;

function LerReg(const Path, Variavel: string; const ValorDefault: string)
  : string; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadString(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

function LerReg(const Path, Variavel: string; const ValorDefault: Integer)
  : Integer; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadInteger(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

function LerReg(const Path, Variavel: string; const ValorDefault: Double)
  : Double; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadFloat(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

function LerReg(const Path, Variavel: string; const ValorDefault: Boolean)
  : Boolean; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadBool(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel, Valor: string); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  // Reg.RootKey := HKEY_CURRENT_USER;
  // Reg.CreateKey(Path);
  Reg.OpenKey(Path, True);
  Reg.WriteString(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel: string; const Valor: Integer);
  overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteInteger(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel: string; const Valor: Double); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteFloat(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel: string; const Valor: Boolean);
  overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteBool(Variavel, Valor);
  FreeAndNil(Reg);
end;

function LerINI(const Chave, Item: string; Padrao: string = '';
  FileName: string = ''): string; overload;
begin
  Result := Padrao;
  if FileName = '' then
    FileName := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))
      + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  with TIniFile.Create(FileName) do
    try
      Result := ReadString(Chave, Item, Padrao);
    finally
      Free;
    end;
end;

function LerINI(const Chave, Item: string; Padrao: Integer = 0;
  FileName: string = ''): Integer; overload;
begin
  if FileName = '' then
    FileName := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))
      + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  with TIniFile.Create(FileName) do
    try
      Result := ReadInteger(Chave, Item, Padrao);
    finally
      Free;
    end;
end;

function LerINI(const Chave, Item: string; Padrao: Boolean;
  FileName: string = ''): Boolean; overload;
begin
  if FileName = '' then
    FileName := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))
      + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  with TIniFile.Create(FileName) do
    try
      Result := ReadBool(Chave, Item, Padrao);
    finally
      Free;
    end;
end;

function xCrypt(const A: Char; const Src, Key: string): string;
var
  KeyLen: Integer;
  KeyPos: Integer;
  offset: Integer;
  SrcPos: Integer;
  SrcAsc: Integer;
  TmpSrcAsc: Integer;
  Range: Integer;
begin
  Result := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  Range := 256;

  if A = 'E' then
    try
      Randomize;
      offset := Random(Range);
      Result := format('%1.2x', [offset]);
      for SrcPos := 1 to Length(Src) do
      begin
        SrcAsc := (Ord(Src[SrcPos]) + offset) MOD 255;
        if KeyPos < KeyLen then
          KeyPos := KeyPos + 1
        else
          KeyPos := 1;
        SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
        Result := Result + format('%1.2x', [SrcAsc]);
        offset := SrcAsc;
      end;
    except
      Result := 'Erro';
    end
  else
    try
      offset := StrToInt('$' + Copy(Src, 1, 2));
      SrcPos := 3;
      repeat
        SrcAsc := StrToInt('$' + Copy(Src, SrcPos, 2));
        if KeyPos < KeyLen Then
          KeyPos := KeyPos + 1
        else
          KeyPos := 1;
        TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
        if TmpSrcAsc <= offset then
          TmpSrcAsc := 255 + TmpSrcAsc - offset
        else
          TmpSrcAsc := TmpSrcAsc - offset;
        Result := Result + chr(TmpSrcAsc);
        offset := SrcAsc;
        SrcPos := SrcPos + 2;
      until SrcPos >= Length(Src);
    except
      Result := 'Erro';
    end;
end;

function Encrip(const S, Chave: string): string;
begin
  Result := xCrypt('E', S, Chave);
end;

function Decrip(const S, Chave: string): string;
begin
  Result := xCrypt('D', S, Chave);
end;

procedure msgAlerta(const texto: string);
begin
  MessageBeep(MB_ICONEXCLAMATION);
//  MessageBox(0, pchar( Texto ), 'Alerta', MB_ICONWARNING or MB_OK or MB_TOPMOST);
  MessageDlg(Texto, mtWarning, [mbOK], 0);
end;

procedure msgInformacao(const Texto: string);
begin
  MessageBeep(MB_ICONINFORMATION);
//  MessageBox(0, pchar( Texto ), 'Informação', MB_ICONINFORMATION or MB_OK or MB_TOPMOST);
  MessageDlg(Texto, mtInformation, [mbOK], 0);
end;

procedure msgErro(const Texto: string);
begin
  MessageBeep(MB_ICONERROR);
  //MessageBox(0, pchar( Texto ), 'Erro', MB_ICONERROR or MB_OK or MB_TOPMOST);
  MessageDlg(Texto, mtError, [mbOK], 0);
end;

procedure msgInformaAbort(const Condicao: Boolean; const Texto: string;
  Foca: TWinControl = nil);
begin
  if not Condicao then
    Exit;
  MessageBeep(MB_ICONQUESTION);
  if Texto <> '' Then
    msgAlerta(Texto);
  if Assigned(Foca) then
    TWinControl(Foca).SetFocus;
  SysUtils.Abort;
end;

function msgConfirma(const Texto: string; FocoNao: Boolean = False): Boolean;
begin
  MessageBeep(MB_ICONQUESTION);
  if FocoNao then
    Keybd_Event(Vk_Right, 0, 0, 0);
  Result := (MessageDlg(Texto, mtConfirmation, [mbYes, mbNo], 0) = mrYes);
end;

function msgConfirma2(const Texto: string; FocoNao: Boolean = False): Integer;
begin
  MessageBeep(MB_ICONQUESTION);

  if FocoNao then
    Keybd_Event(Vk_Right, 0, 0, 0);

  Result := MessageDlg(Texto, mtConfirmation, [mbYes, mbNo, mbCancel], 0);
end;

function QuebraLinha(S: String; tamanhoLinha: Integer): TStringList;
var
  Aux: TStringList;
  i, t, p: Integer;
begin
  Aux := TStringList.Create;
  Try
    While S <> '' do
    begin
      if Length(S) > tamanhoLinha then
      begin
        t := tamanhoLinha + 1;
        p := t;
        for i := t downto 1 do
          if CharInSet(S[i], [' ', ',', '.', ';', ':', '?', '!']) then
          begin
            if (i = t) and (S[i] <> ' ') then
              continue;
            p := i;
            break;
          end;
      end
      else
      begin
        t := Length(S);
        p := t;
      end;
      Aux.Add(Copy(S, 1, p));
      Delete(S, 1, p);
      while (Length(S) > 0) and (S[1] = ' ') do
        Delete(S, 1, 1);
    end
    finally
      Result := Aux;
    end
  end;

  function SomenteNumeros(const Valor: string): string;
  var
    S: string;
    i: Integer;
  begin
    S := Trim(Valor);
    for i := Length(S) downto 1 do
      if not CharInSet(S[i], ['0' .. '9', FormatSettings.DecimalSeparator]) then
        Delete(S, i, 1);
    Result := S;
  end;

  function Separa(const S: string; const Separador: Char;
    const Posicao: Integer): string;
  var
    i, Contador, p: Integer;
  begin
    Result := '';
    p := Posicao;
    if (p < 1) then
      p := 1;
    Contador := 1;
    for i := 1 to Length(S) do
      if S[i] = Separador then
      begin
        if Contador = p then
          break;
        Inc(Contador);
        Result := '';
      end
      else
        Result := Result + S[i];
    if p > Contador then
      Result := '';
  end;

  function TiraAcentosLike(const Texto: string): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := 1 to Length(Texto) do
      case Texto[i] of
        'á', 'à', 'ä', 'â', 'ã',
        'Á', 'À', 'Ä', 'Â', 'Ã',
        'é', 'è', 'ë', 'ê',
        'É', 'È', 'Ë', 'Ê',
        'í', 'ì', 'ï', 'î',
        'Í', 'Ì', 'Ï', 'Î',
        'ó', 'ò', 'ö', 'ô',
        'Ó', 'Ò', 'Ö', 'Ô', 'Õ',
        'ú', 'ù', 'ü', 'û',
        'Ú', 'Ù', 'Ü', 'Û',
        'Ç', 'ç', 'ñ', 'Ñ',
        'ª', 'º' : Result := Result + '_';
      else
        Result := Result + Texto[i];
      end;
  end;


  function TiraAcentos(const Texto: string): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := 1 to Length(Texto) do
      case Texto[i] of
        'á', 'à', 'ä', 'â', 'ã':
          Result := Result + 'a';
        'Á', 'À', 'Ä', 'Â', 'Ã':
          Result := Result + 'A';
        'é', 'è', 'ë', 'ê':
          Result := Result + 'e';
        'É', 'È', 'Ë', 'Ê':
          Result := Result + 'E';
        'í', 'ì', 'ï', 'î':
          Result := Result + 'i';
        'Í', 'Ì', 'Ï', 'Î':
          Result := Result + 'I';
        'ó', 'ò', 'ö', 'ô', 'õ':
          Result := Result + 'o';
        'Ó', 'Ò', 'Ö', 'Ô', 'Õ':
          Result := Result + 'O';
        'ú', 'ù', 'ü', 'û':
          Result := Result + 'u';
        'Ú', 'Ù', 'Ü', 'Û':
          Result := Result + 'U';
        'Ç':
          Result := Result + 'C';
        'ç':
          Result := Result + 'c';
        'ñ':
          Result := Result + 'n';
        'Ñ':
          Result := Result + 'N';
        'ª':
          Result := Result + 'a';
        'º':
          Result := Result + 'o';
      else
        Result := Result + Texto[i];
      end;
  end;

  function Extenso(const Valor: Double; IntSing: string = 'Real';
    IntPlural: string = 'Reais'; DecSing: string = 'Centavo';
    DecPlural: string = 'Centavos'): string;
  var
    Value, Part: String;
    Text: array [1 .. 5] of String;
    A: Integer;
  const
    Unity: array [1 .. 9] of string = ('Um', 'Dois', 'Três', 'Quatro', 'Cinco',
      'Seis', 'Sete', 'Oito', 'Nove');
    Tens: array [2 .. 9] of string = ('Vinte', 'Trinta', 'Quarenta',
      'Cinqüenta', 'Sessenta', 'Setenta', 'Oitenta', 'Noventa');
    Hundreds: array [1 .. 9] of string = ('Cento', 'Duzentos', 'Trezentos',
      'Quatrocentos', 'Quinhentos', 'Seiscentos', 'Setecentos', 'Oitocentos',
      'Novecentos');
    Until19: array [10 .. 19] of string = ('Dez', 'Onze', 'Doze', 'Treze',
      'Quatorze', 'Quinze', 'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');
    Singular: array [1 .. 5] of string =
      (' Bilhão', ' Milhão', ' Mil', '', ' !'); // ! = Centavo
    Plural: array [1 .. 5] of string = (' Bilhões', ' Milhões', ' Mil', '',
      ' ?'); // ? = Centavos
    Position: array [1 .. 5] of Word = (1, 4, 7, 10, 14);

    function RightStr(const AText: string; const ACount: Integer): string;
    begin
      Result := Copy(AText, Length(AText) + 1 - ACount, ACount);
    end;

  begin
    Value := format('%m', [Valor]);
    Value := Trim(AnsiReplaceStr(AnsiReplaceStr(Value, FormatSettings.CurrencyString, ''),
        FormatSettings.ThousandSeparator, ''));
    if FormatSettings.DecimalSeparator <> '.' then
      Value := AnsiReplaceStr(Value, FormatSettings.DecimalSeparator, '.');
    Value := IfThen(Pos('.', Value) = 0, Value + '.00', Value);
    Value := IfThen(RightStr(Value, 2) = ',0', Value + '0', Value);
    Value := DupeString('0', 15 - Length(Value)) + Value;
    for A := 1 to 5 do
    begin
      Part := IfThen(A = 5, '0' + Copy(Value, 14, 2), Copy
          (Value, Position[A], 3));
      if Part <> '000' then
      begin
        if Part = '100' then
          Text[A] := Text[A] + ' Cem '
        else
        begin
          if Part[1] <> '0' then
            Text[A] := Text[A] + Hundreds[StrToInt(Part[1])];
          if Part[2] = '1' then
          begin
            if Text[A] <> '' then
              Text[A] := Text[A] + ' e ';
            Text[A] := Text[A] + Until19[StrToInt(Part[2] + Part[3])];
          end;
          if not CharInSet(Part[2], ['1', '0']) then
          begin
            if Text[A] <> '' then
              Text[A] := Text[A] + ' e ';
            Text[A] := Text[A] + Tens[StrToInt(Part[2])];
          end;
          if (Part[3] <> '0') and (Part[2] <> '1') then
          begin
            if Text[A] <> '' then
              Text[A] := Text[A] + ' e ';
            Text[A] := Text[A] + Unity[StrToInt(Part[3])];
          end;
        end;
        if (A = 5) and (StrToInt(Part) > 0) and
          ((Text[1] <> '') or (Text[2] <> '') or (Text[3] <> '') or
            (Text[4] <> '')) then
          Text[5] := ' e ' + Text[5];
        if Text[A] <> '' then
          if Part = '001' then
            Text[A] := Text[A] + Singular[A]
          else
            Text[A] := Text[A] + Plural[A];
      end;
    end;
    if (Text[1] <> '') and ((Text[2] <> '') or (Text[3] <> '') or
        (Text[4] <> '')) then
      if Copy(Value, Position[2], 6) = '000000' then
        Text[1] := Text[1] + ' e '
      else
        Text[1] := Text[1] + ', ';
    if (Text[2] <> '') and ((Text[3] <> '') or (Text[4] <> '')) then
      if Copy(Value, Position[3], 3) = '000' then
        Text[2] := Text[2] + ' e '
      else
        Text[2] := Text[2] + ', ';
    if (Text[3] <> '') and (Text[4] <> '') then
      if Copy(Value, Position[4], 1) = '0' then
        Text[3] := Text[3] + ' e '
      else if Copy(Value, Position[4] + 1, 2) = '00' then
        Text[3] := Text[3] + ' e '
      else
        Text[3] := Text[3] + ', ';
    for A := 1 to 4 do
    begin
      if (Text[A] <> '') and (Text[A + 1] <> '') then
        Text[A] := Text[A] + ' ';
    end;
    if Valor = 0 then
      Text[1] := 'Zero'
    else if Valor < 1 then
      Text[5] := Text[5] + ' de ' + IntSing
    else if Valor < 2 then
      Text[4] := Text[4] + ' ' + IntSing + ' '
    else if (Valor > 1000000) and (Text[4] = '') then
      Text[4] := ' de ' + IntPlural + ' '
    else
      Text[4] := Text[4] + ' ' + IntPlural + ' ';
    Result := Text[1] + Text[2] + Text[3] + Text[4] + Text[5];
    if Pos('!', Result) > 0 then
      Result := AnsiReplaceStr(Result, '!', DecSing);
    if Pos('?', Result) > 0 then
      Result := AnsiReplaceStr(Result, '?', DecPlural);
    while (Pos('  ', Result) <> 0) do
      Result := AnsiReplaceStr(Result, '  ', ' ');
  end;

  function Ordinal(numero: Integer; sexo: String = 'M'): String;
  var
    numero_str: string;
    A, b, c: Integer;
  begin

    Result := '';

    numero_str := FormatFloat('####', numero);

    A := Length(numero_str);

    b := A;

    c := 1;

    if b = 4 then
      Result := 'milésimo'
    else
    begin
      repeat
        if b = 3 then
        begin
          if numero_str[c] = '1' then
            Result := Result + 'centésimo ';
          if numero_str[c] = '2' then
            Result := Result + 'ducentésimo ';
          if numero_str[c] = '3' then
            Result := Result + 'trecentésima ';
          if numero_str[c] = '4' then
            Result := Result + 'quadragésimo ';
          if numero_str[c] = '5' then
            Result := Result + 'qüingentésimo ';
          if numero_str[c] = '6' then
            Result := Result + 'sexcentésimo ';
          if numero_str[c] = '7' then
            Result := Result + 'septigentésimo ';
          if numero_str[c] = '8' then
            Result := Result + 'octingentésimo ';
          if numero_str[c] = '9' then
            Result := Result + 'noningentésimo ';
        end;
        if b = 2 then
        begin
          if numero_str[c] = '1' then
            Result := Result + 'décimo ';
          if numero_str[c] = '2' then
            Result := Result + 'vigésimo ';
          if numero_str[c] = '3' then
            Result := Result + 'trigésimo ';
          if numero_str[c] = '4' then
            Result := Result + 'quadragésimo ';
          if numero_str[c] = '5' then
            Result := Result + 'qüinquagésimo ';
          if numero_str[c] = '6' then
            Result := Result + 'sexagésimo ';
          if numero_str[c] = '7' then
            Result := Result + 'septuagésimo ';
          if numero_str[c] = '8' then
            Result := Result + 'octogésimo ';
          if numero_str[c] = '9' then
            Result := Result + 'nonagésimo ';
        end;
        if b = 1 then
        begin
          if numero_str[c] = '1' then
            Result := Result + 'primeiro';
          if numero_str[c] = '2' then
            Result := Result + 'segundo';
          if numero_str[c] = '3' then
            Result := Result + 'terceiro';
          if numero_str[c] = '4' then
            Result := Result + 'quarto';
          if numero_str[c] = '5' then
            Result := Result + 'quinto';
          if numero_str[c] = '6' then
            Result := Result + 'sexto';
          if numero_str[c] = '7' then
            Result := Result + 'sétimo';
          if numero_str[b] = '8' then
            Result := Result + 'oitavo';
          if numero_str[c] = '9' then
            Result := Result + 'nono';
          Result := Trim(Result);
          if sexo = 'F' then
            Result[Length(Result)] := 'a';
        end;
        Inc(c);
        dec(b);
      until c > A;
      if sexo = 'F' then
        Result := AnsiReplaceText(Result, 'eiro', 'eira');
      if sexo = 'F' then
        Result := AnsiReplaceText(Result, 'cimo', 'cima');
      if sexo = 'F' then
        Result := AnsiReplaceText(Result, 'simo', 'sima');
    end;
  end;

  function FormataCartao(const S: string): string;
  begin
    Result := S;
    Insert('-', Result, 13);
    Insert('.', Result, 10);
    Insert('.', Result, 7);
    Insert('.', Result, 4);
  end;

  function FormataCPFCNPJ(const S: string): string;
  begin
    Result := S;
    if Length(S) = 14 then
    begin
      Insert('-', Result, 13);
      Insert('/', Result, 9);
      Insert('.', Result, 6);
      Insert('.', Result, 3);
    end;
    if Length(S) = 11 then
    begin
      Insert('-', Result, 10);
      Insert('.', Result, 7);
      Insert('.', Result, 4);
    end;
  end;

  function FormataIE(const S: string): string;
  begin
    Result := S;
    if Length(Trim(S)) = 9 then
    begin
      Insert('.', Result, 4);
      Insert('.', Result, 8);
    end;
  end;

  function AlinhaEsq(const Palavra: string; Tamanho: Integer;
    Caracter: Char = #32): String;
  var
    S: String;
    i: Integer;
  begin
    S := Palavra;
    For i := 1 to (Tamanho - Length(Palavra)) do
      S := S + Caracter;
    If Length(Palavra) > Tamanho then
      Delete(S, Tamanho + 1, Length(Palavra) - Tamanho);
    Result := S;
  end;

  function AlinhaDir(const Palavra: string; Tamanho: Integer;
    Caracter: Char = #32): String;
  var
    S: String;
    i: Integer;
  begin
    S := Palavra;
    For i := 1 to (Tamanho - Length(Palavra)) do
      S := Caracter + S;
    If Length(Palavra) > Tamanho then
      Delete(S, Tamanho + 1, Length(Palavra) - Tamanho);
    Result := S;
  end;

  function AlinhaCentro(const Palavra: string; Tamanho: Integer;
    Caracter: Char = #32): String;
  var
    S: string;
    i: Integer;
  begin
    S := Palavra;
    i := 0;
    while Length(S) < Tamanho do
    begin
      Inc(i);
      if Odd(i) then
        S := S + Caracter
      else
        S := Caracter + S;
    end;
    while Length(S) > Tamanho do
    begin
      Inc(i);
      if Odd(i) then
        Delete(S, 1, 1)
      else
        Delete(S, Length(S), 1);
    end;
    Result := S;
  end;

  function AbreConsultaFormEdit(const TipoForm: TComponentClass;
    Form: TCustomForm; const origem: array of string;
    const destino: array of TEdit; Criar: Boolean = True;
    cd_usuario: Integer = 0; menu: String = '';
    FreeForm: Boolean = True): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    if Length(origem) <> Length(destino) then
      Exit;
    if Criar then
      Application.CreateForm(TipoForm, Form);
    if (Trim(menu) <> '') then
    begin
      if menu_BL = 'L' then
        TConsultaSimplesGenericaForm(Form).SetPermissao(cd_usuario, menu, 'L')
      else
        TConsultaSimplesGenericaForm(Form).SetPermissao(cd_usuario, menu, 'B')
    end;
    try
      with Form as TConsultaSimplesGenericaForm do
      begin
        SetSubConsulta(True);
        ShowModal;
        if Retornou then
        begin
          for i := 0 to High(origem) do
            destino[i].Text := CDSQy.FieldByName(origem[i]).AsString;
          Result := True;
        end
      end;
    finally
      if FreeForm then
        Form.Free;
    end;
  end;

  function AbreConsultaForm(const TipoForm: TComponentClass; Form: TCustomForm;
    const origem: array of string; const destino: array of TField;
    Criar: Boolean = True; cd_usuario: Integer = 0; menu: String = '';
    FreeForm: Boolean = True): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    if Length(origem) <> Length(destino) then
      Exit;
    if Criar then
      Application.CreateForm(TipoForm, Form);
    if (Trim(menu) <> '') then
    begin
      if menu_BL = 'L' then
        TConsultaSimplesGenericaForm(Form).SetPermissao(cd_usuario, menu, 'L')
      else
        TConsultaSimplesGenericaForm(Form).SetPermissao(cd_usuario, menu, 'B')
    end;
    try
      with Form as TConsultaSimplesGenericaForm do
      begin
        SetSubConsulta(True);
        ShowModal;
        if Retornou then
        begin
          if destino[0].DataSet.State = dsbrowse then
            destino[0].DataSet.Edit;
          for i := 0 to High(origem) do
            destino[i].Value := CDSQy.FieldByName(origem[i]).Value;
          Result := True;
        end
      end;
    finally
      if FreeForm then
        Form.Free;
    end;
  end;

  function VisualizaBlob(NomeArquivo: String; const Arquivo: TBlobField;
    const Handle: HWND; pathBlob : string ): Boolean;
  var
    PathBuf: array [0 .. 255] of Char;
    TempPath: string;
  begin
    if pathBlob = '' then
    begin
      GetTempPath(SizeOf(PathBuf), PathBuf);
      TempPath := StrPas(PathBuf) + '\Blobs';
      if not DirectoryExists(TempPath) then
        if not ForceDirectories(TempPath) then
        begin
          MessageDlg('Não foi possível criar o diretório temporário', mtError,
            [mbOK], 0);
          SysUtils.Abort;
        end;
        TempPath := IncludeTrailingPathDelimiter( TempPath ) + NomeArquivo;
    end
    else
      TempPath := IncludeTrailingPathDelimiter( pathBlob ) + NomeArquivo;
    Arquivo.SaveToFile(TempPath);
    ShellExecute(Handle, 'open', PChar(TempPath), nil, nil, SW_SHOWNORMAL);
    Result := True;
  end;

function SalvaBlob(NomeArquivo: String; const Arquivo: TBlobField; salvarDirTemp : boolean = True ): String;
var
  PathBuf: array[0..255] of char;
  TempPath: string;
begin
  if salvarDirTemp then
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
  end
  else
    TempPath := NomeArquivo;

  if FileExists( TempPath ) then
    DeleteFile( PChar( TempPath ) );

  if FileExists( TempPath ) then
  begin
    Messagedlg('Não foi possível criar o arquivo temporário', mtError, [mbOk],0);
    SysUtils.Abort;
  end;
  Arquivo.SaveToFile(TempPath);
  if FileExists( TempPath ) then
    result := TempPath
  else
    result := '';
end;

  function ValidaCNPJCPF(const Codigo: string): Boolean;
    function iTesteCPF(const Codigo: string): Boolean;
    var
      A, b, soma, inicio, fim, digito: Integer;
      controle: String;
    begin
      if Length(Codigo) < 11 then
      begin
        Result := False;
        Exit;
      end;
      inicio := 2;
      fim := 10;
      controle := '';
      digito := 0;
      for A := 1 to 2 do
      begin
        soma := 0;
        for b := inicio to fim do
          soma := soma + (StrToInt(Copy(Codigo, b - A, 1)) * (fim + 1 + A - b));
        if A = 2 then
          soma := soma + (2 * digito);
        digito := (soma * 10) mod 11;
        if digito = 10 then
          digito := 0;
        controle := controle + IntToStr(digito);
        inicio := 3;
        fim := 11;
      end;
      Result := ((controle = Copy(Codigo, 10, 2)) or (Codigo = ''));
    end;

    function iTesteCGC(const Codigo: string): Boolean;
    var
      d: array [1 .. 12] of Integer;
      A, teste1, teste3, resto1, resto2, pridig, segdig: Integer;
      teste2: Extended;
    begin
      if Length(Codigo) < 14 then
      begin
        Result := False;
        Exit;
      end;
      for A := 1 to 12 do
        d[A] := StrToIntDef(Copy(Codigo, A, 1), 0);
      teste1 := 5 * d[01] + 4 * d[02] + 3 * d[03] + 2 * d[04] + 9 * d[05]
        + 8 * d[06] + 7 * d[07] + 6 * d[08] + 5 * d[09] + 4 * d[10] + 3 * d[11]
        + 2 * d[12];
      teste2 := teste1 / 11;
      teste3 := Trunc(teste2) * 11;
      resto1 := teste1 - teste3;
      if ((resto1 = 0) or (resto1 = 1)) then
        pridig := 0
      else
        pridig := 11 - resto1;
      teste1 := 6 * d[01] + 5 * d[02] + 4 * d[03] + 3 * d[04] + 2 * d[05]
        + 9 * d[06] + 8 * d[07] + 7 * d[08] + 6 * d[09] + 5 * d[10] + 4 * d[11]
        + 3 * d[12] + 2 * pridig;
      teste2 := teste1 / 11;
      teste3 := Trunc(teste2) * 11;
      resto2 := teste1 - teste3;
      if ((resto2 = 0) or (resto2 = 1)) then
        segdig := 0
      else
        segdig := 11 - resto2;
      Result := (((pridig = StrToInt(Copy(Codigo, 13, 1))) and
            (segdig = StrToInt(Copy(Codigo, 14, 1)))) or (Codigo = ''));
    end;

  begin
    if Length(Codigo) = 11 then
      Result := iTesteCPF(Codigo)
    else
      Result := iTesteCGC(Codigo);
  end;

  function FormataCEP(const Codigo: string): string;
  begin
    Result := Codigo;
    Insert('.', Result, 3);
    Insert('-', Result, 7);
  end;

  function HoraParaMin(const Hora: String): Integer;
  var
    Sinal: string;
  begin
    if (Hora = '') or (Trim(Hora) = ':') then
    Begin
      Result := 0;
      Exit;
    end;
    if Copy(Hora, 1, 1) = '-' then
      Sinal := '-';
    try
      Result := (StrToInt(Separa(Hora, ':', 1)) * 60) + StrToInt
        (Sinal + Separa(Hora, ':', 2));
    except
      Result := 0;
    end;
  end;

  function DataExtenso(data: TDateTime; exibir_dia_semana: Boolean): String;
  var
    nrdia: Integer;
    diasemana: array [1 .. 7] of String;
    meses: array [1 .. 12] of String;
    Dia, Mes, Ano: Word;
  begin
    diasemana[1] := 'Domingo';
    diasemana[2] := 'Segunda-feira';
    diasemana[3] := 'Terça-feira';
    diasemana[4] := 'Quarta-feira';
    diasemana[5] := 'Quinta-feira';
    diasemana[6] := 'Sexta-feira';
    diasemana[7] := 'Sábado';
    meses[1] := 'Janeiro';
    meses[2] := 'Fevereiro';
    meses[3] := 'Março';
    meses[4] := 'Abril';
    meses[5] := 'Maio';
    meses[6] := 'Junho';
    meses[7] := 'Julho';
    meses[8] := 'Agosto';
    meses[9] := 'Setembro';
    meses[10] := 'Outubro';
    meses[11] := 'Novembro';
    meses[12] := 'Dezembro';
    DecodeDate(data, Ano, Mes, Dia);
    nrdia := DayOfWeek(DATA);
    if exibir_dia_semana then
      Result := diasemana[nrdia] + ', ' + IntToStr(Dia) + ' de ' + meses[Mes]
        + ' de ' + IntToStr(Ano)
    else
      Result := IntToStr(Dia) + ' de ' + meses[Mes] + ' de ' + IntToStr(Ano);
  end;

{function ping(const nr_ip: string; nr_tentativas: integer; nr_ok: integer): boolean;
var
  i, retorno_ok: integer;
  fIdIcmpClient: TIdIcmpClient;

begin
  retorno_ok := 0;

  for i := 1 to nr_tentativas do
  begin
    fIdIcmpClient := TIdIcmpClient.Create(nil);
    try
      fIdIcmpClient.ReceiveTimeout := 200;
      fIdIcmpClient.PacketSize := 24;
      fIdIcmpClient.Protocol := 1;
      fIdIcmpClient.IPVersion := Id_IPv4;
      fIdIcmpClient.Host := nr_ip;

      try
        fIdIcmpClient.Ping;
      except
      end;

  //    fIdIcmpClient.ReplyStatus.SequenceId
      if fIdIcmpClient.ReplyStatus.Msg.Length > 0 then
        retorno_ok := retorno_ok + 1;

      Sleep(800);

    finally
      fIdIcmpClient.Free;
    end;
  end;
  result := retorno_ok > nr_ok;
end;   }

function UpperAcentos(texto: String): String;
var
  x: integer;

begin
  result := '';

  for x:= 1 to Length(texto) do
  begin
    if texto[x] = 'á' then
      result := result + 'Á'
    else
    if texto[x] = 'ã' then
      result := result + 'Ã'
    else
    if texto[x] = 'à' then
      result := result + 'À'
    else
    if texto[x] = 'â' then
      result := result + 'Â'
    else
    if texto[x] = 'é' then
      result := result + 'É'
    else
    if texto[x] = 'è' then
      result := result + 'È'
    else
    if texto[x] = 'ê' then
      result := result + 'Ê'
    else
    if texto[x] = 'í' then
      result := result + 'Í'
    else
    if texto[x] = 'ì' then
      result := result + 'Ì'
    else
    if texto[x] = 'ó' then
      result := result + 'Ó'
    else
    if texto[x] = 'õ' then
      result := result + 'Õ'
    else
    if texto[x] = 'ò' then
      result := result + 'Ò'
    else
    if texto[x] = 'ô' then
      result := result + 'Ô'
    else
    if texto[x] = 'ú' then
      result := result + 'Ú'
    else
    if texto[x] = 'û' then
      result := result + 'Û'
    else
    if texto[x] = 'ù' then
      result := result + 'Ù'
    else
    if texto[x] = 'ç' then
      result := result + 'Ç'
    else
      result := result + texto[x];
  end;
end;

function OcorreStr(C: Char; S: String): Integer;
var
  N: Integer;

begin
  Result := 0;

  N := 0;
  repeat
    N := PosEx(C, S, N + 1);
    if N <> 0 then
      Inc(Result);
  until N = 0;
end;

function ValidaIE(IE, UF: string): boolean;
begin
  result := ChkInscEstadual(SomenteNumeros(IE), UF);
end;

function Seg_Hora( Seg:LongInt ):string;
var Hora,Min:LongInt;
    Tmp : Double;
begin
   Tmp    := Seg / 3600;
   Hora   := Round(Int(Tmp));
   Seg    := Round(Seg - (Hora*3600));
   Tmp    := Seg / 60;
   Min    := Round(Int(Tmp));
   Seg    := Round(Seg - (Min*60));
   Result := StrZero(Hora,2,0)+':'+StrZero(Min,2,0)+':'+StrZero(Seg,2,0);
end;

function StrZero(Num:Real ; Zeros, Deci:integer): string;
var
  Tam, Z: integer;
  Res: ShortString;
  Zer: String;

begin
   Str(Num:Zeros:Deci, Res);

   Res := ShortString(Alltrim(String(Res)));
   Tam := Length(Res);
   Zer := '';

   for z := 01 to (Zeros-Tam) do
      Zer := Zer + '0';

   Result := Zer + String(Res);
end;

function Alltrim( Texto:String) : String;
begin
  Texto  := RTrim( Texto );
  Texto  := LTrim( Texto );
  Result := Texto;
end;

function RTrim( Texto:String) : String;
var i,a,b : integer;
begin
  a := 01; b := 00;
  for i := Length( Texto ) DownTo 01 do
    if Texto[i] <> ' ' then
       begin
          b := i; BREAK;
       end;
  b := b - a+1;Result := Copy(Texto,a,b);
end;

function LTrim( Texto:String) : String;
var i,a,b : integer;
begin
  a := 00; b := Length( Texto );
  for i := 1 to Length( Texto ) do
    if Texto[i] <> ' ' then
       begin
          a := i; BREAK;
       end;
  b := b - a+1;Result := Copy(Texto,a,b);
end;

function StringToMD5(const Value: string): string;
var
  idmd5 : TIdHashMessageDigest5;

begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := idmd5.HashStringAsHex(Value);
  finally
    idmd5.Free;
  end;
end;

function ValidaNFE(nr_chave, uf, cnpj, modelo, serie, nota : string; emissao: TDate; var erro : String):boolean;
var
  i, p, soma, dig : integer;
begin
  result := true;
  try
    if length(nr_chave) <> 44 then
    begin
      result := false;
      erro := 'Chave Nfe deve possuir 44 digitos!';
      exit;
    end;
    if SomenteNumeros(nr_chave) <> nr_chave then
    begin
      result := false;
      erro := 'Chave Nfe deve possuir somente números!';
      exit;
    end;
    if AlinhaDir(uf,2,'0') <> Copy(nr_chave,1,2) then
    begin
      result := false;
      erro := 'Chave de Nfe inválida: Estado do fornecedor não corresponde a chave NFe!';
      exit;
    end;
    if formatDateTime('YYMM', emissao) <> Copy(nr_chave,3,4) then
    begin
      result := false;
      erro := 'Chave de Nfe inválida: Data de emissão não corresponde a chave NFe!';
      exit;
    end;
    if (cnpj <> Copy(nr_chave,7,14))and(cnpj <> Copy(nr_chave,10,11))and(StrToInt(Copy(nr_chave,23,3)) < 890) then
    begin
      result := false;
      erro := 'Chave de Nfe inválida: CNPJ/CPF não corresponde a chave NFe!';
      exit;
    end;
    if alinhaDir(modelo,2,'0') <> Copy(nr_chave,21,2) then
    begin
      result := false;
      erro := 'Chave de Nfe inválida: Modelo não corresponde a chave NFe!';
      exit;
    end;
    if AlinhaDir(trim(serie),3,'0') <> Copy(nr_chave,23,3) then
    begin
      result := false;
      erro := 'Chave de Nfe inválida: Série não corresponde a chave NFe!';
      exit;
    end;
    if AlinhaDir(nota,9,'0') <> Copy(nr_chave,26,9) then
    begin
      result := false;
      erro := 'Chave de Nfe inválida: Número de nota não corresponde a chave NFe!';
      exit;
    end;
    soma := 0;
    p := 2;
    for i := length(nr_chave)-1 downto 1 do
    begin
      soma := soma + StrToInt(nr_chave[i]) * p;
      inc(p);
      if p > 9 then
        p := 2;
    end;
    dig := 11 - (soma mod 11);
    if dig > 9 then
      dig := 0;
    if (dig <> StrToInt(nr_chave[length(nr_chave)])) then
    begin
      result := false;
      erro := 'Chave de Nfe inválida: Digito verificador não confere!';
      exit;
    end;
  except
    result := false;
  end
end;

function TiraAcentuacao(texto: String): String;
var
  x: integer;

begin
  result := '';

  texto := AnsiReplaceStr(texto, '\u00e3', 'a');
  texto := AnsiReplaceStr(texto, '\u00e7', 'c');
  texto := AnsiReplaceStr(texto, '\u00fa', 'u');
  texto := AnsiReplaceStr(texto, '\u00e1', 'a');
  texto := AnsiReplaceStr(texto, '\u00e0', 'a');
  texto := AnsiReplaceStr(texto, '\u00e2', 'a');
  texto := AnsiReplaceStr(texto, '\u00e4', 'a');
  texto := AnsiReplaceStr(texto, '\u00c1', 'A');
  texto := AnsiReplaceStr(texto, '\u00c0', 'A');
  texto := AnsiReplaceStr(texto, '\u00c2', 'A');
  texto := AnsiReplaceStr(texto, '\u00c3', 'A');
  texto := AnsiReplaceStr(texto, '\u00c4', 'A');
  texto := AnsiReplaceStr(texto, '\u00e9', 'e');
  texto := AnsiReplaceStr(texto, '\u00e8', 'e');
  texto := AnsiReplaceStr(texto, '\u00ea', 'e');
  texto := AnsiReplaceStr(texto, '\u00ea', 'e');
  texto := AnsiReplaceStr(texto, '\u00c9', 'E');
  texto := AnsiReplaceStr(texto, '\u00c8', 'E');
  texto := AnsiReplaceStr(texto, '\u00ca', 'E');
  texto := AnsiReplaceStr(texto, '\u00cb', 'E');
  texto := AnsiReplaceStr(texto, '\u00ed', 'i');
  texto := AnsiReplaceStr(texto, '\u00ec', 'i');
  texto := AnsiReplaceStr(texto, '\u00ee', 'i');
  texto := AnsiReplaceStr(texto, '\u00ef', 'i');
  texto := AnsiReplaceStr(texto, '\u00cd', 'I');
  texto := AnsiReplaceStr(texto, '\u00cc', 'I');
  texto := AnsiReplaceStr(texto, '\u00ce', 'I');
  texto := AnsiReplaceStr(texto, '\u00cf', 'I');
  texto := AnsiReplaceStr(texto, '\u00f3', 'o');
  texto := AnsiReplaceStr(texto, '\u00f2', 'o');
  texto := AnsiReplaceStr(texto, '\u00f4', 'o');
  texto := AnsiReplaceStr(texto, '\u00f5', 'o');
  texto := AnsiReplaceStr(texto, '\u00f6', 'o');
  texto := AnsiReplaceStr(texto, '\u00d3', 'O');
  texto := AnsiReplaceStr(texto, '\u00d2', 'O');
  texto := AnsiReplaceStr(texto, '\u00d4', 'O');
  texto := AnsiReplaceStr(texto, '\u00d5', 'O');
  texto := AnsiReplaceStr(texto, '\u00d6', 'O');
  texto := AnsiReplaceStr(texto, '\u00fa', 'u');
  texto := AnsiReplaceStr(texto, '\u00f9', 'u');
  texto := AnsiReplaceStr(texto, '\u00fb', 'u');
  texto := AnsiReplaceStr(texto, '\u00fc', 'u');
  texto := AnsiReplaceStr(texto, '\u00da', 'U');
  texto := AnsiReplaceStr(texto, '\u00d9', 'U');
  texto := AnsiReplaceStr(texto, '\u00db', 'U');
  texto := AnsiReplaceStr(texto, '\u00c7', 'C');
  texto := AnsiReplaceStr(texto, '\u00f1', 'n');
  texto := AnsiReplaceStr(texto, '\u00d1', 'N');

  for x:= 1 to Length(texto) do
  begin
    if texto[x] = 'á' then
      result := result + 'a'
    else
    if texto[x] = 'Á' then
      result := result + 'A'
    else
    if texto[x] = 'ã' then
      result := result + 'a'
    else
    if texto[x] = 'Ã' then
      result := result + 'A'
    else
    if texto[x] = 'à' then
      result := result + 'a'
    else
    if texto[x] = 'À' then
      result := result + 'A'
    else
    if texto[x] = 'â' then
      result := result + 'a'
    else
    if texto[x] = 'Â' then
      result := result + 'A'
    else
    if texto[x] = 'é' then
      result := result + 'e'
    else
    if texto[x] = 'É' then
      result := result + 'E'
    else
    if texto[x] = 'è' then
      result := result + 'e'
    else
    if texto[x] = 'È' then
      result := result + 'E'
    else
    if texto[x] = 'ê' then
      result := result + 'e'
    else
    if texto[x] = 'Ê' then
      result := result + 'E'
    else
    if texto[x] = 'í' then
      result := result + 'i'
    else
    if texto[x] = 'Í' then
      result := result + 'I'
    else
    if texto[x] = 'ì' then
      result := result + 'i'
    else
    if texto[x] = 'Ì' then
      result := result + 'I'
    else
    if texto[x] = 'ó' then
      result := result + 'o'
    else
    if texto[x] = 'Ó' then
      result := result + 'O'
    else
    if texto[x] = 'õ' then
      result := result + 'o'
    else
    if texto[x] = 'Õ' then
      result := result + 'O'
    else
    if texto[x] = 'ò' then
      result := result + 'o'
    else
    if texto[x] = 'Ò' then
      result := result + 'O'
    else
    if texto[x] = 'ô' then
      result := result + 'o'
    else
    if texto[x] = 'Ô' then
      result := result + 'O'
    else
    if texto[x] = 'ú' then
      result := result + 'u'
    else
    if texto[x] = 'Ú' then
      result := result + 'U'
    else
    if texto[x] = 'û' then
      result := result + 'u'
    else
    if texto[x] = 'Û' then
      result := result + 'U'
    else
    if texto[x] = 'ù' then
      result := result + 'u'
    else
    if texto[x] = 'Ù' then
      result := result + 'U'
    else
      result := result + texto[x];
  end;
end;

function PathSemDelimitador(path: String): String;
begin
  result := path;

  if copy(path, length(path), 1) = '\' then
    result := copy(path, 1, length(path) - 1);
end;

function getDigModulo10(as_cd_barra: String): Integer;
var
  li_vl_total,
  li_nr_multiplicador: integer;
  ld_nr_modulo10: double;

begin
  li_vl_total := 0;
  li_nr_multiplicador := 1;

  while (as_cd_barra <> '') do
  begin
    li_vl_total := li_vl_total + (li_nr_multiplicador * strToIntDef(copy(as_cd_barra, 1, 1), 0));

    as_cd_barra := copy(as_cd_barra, 2, Length(as_cd_barra));

    li_nr_multiplicador := li_nr_multiplicador + 1;
  end;

  ld_nr_modulo10 := 10 - (li_vl_total mod 10);

  if (ld_nr_modulo10 > 9) then
    ld_nr_modulo10 := 0;

  result := Trunc(ld_nr_modulo10);
end;

function Capitaliza(const s: string): string;
var
  flag: boolean;
  i : Byte;
  t : AnsiString;

BEGIN
  flag := TRUE;
  t := '';
  for i := 1 to LENGTH(s) do
  begin
    if flag then
      AppendStr(t, UpCase(s[i]))
    else
      AppendStr(t, LowerCase(s[i]));
    flag := (s[i] = ' ')
  end;

  Result := t
end ;


end.
