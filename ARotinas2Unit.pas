unit arotinas2unit;
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses Registry, Windows, Graphics, SysUtils, Classes, WinSock, Forms, ARotinasUnit, Math,
     IniFiles, FileCtrl, ShlObj, StdCtrls;

// arquivos e pastas
function DirBarra(const Pasta: string): string;
function DirExe                       : string;
function PastaPai(const Pasta:string) : string;
function PastaWindows                 : string;
function PastaWindowsDesktop          : string;
function PastaWindowsSystem           : string;
function PastaWindowsTemp             : string;
function FileDateTime(const NomeArquivo: string): TDateTime;
function FileSize(const arquivo: string): LongInt;
function GetPasta: string;
function GetPastaDef(const PastaDef: string): string;
function GetFileDataHora(const NomeArquivo: string): TDateTime;
function CopiarArquivo(const Origem, PastaDestino: string): Boolean;
function CopiarArquivos(const Origem, PastaDestino: string): Boolean;
function MoverArquivo(const Origem, PastaDestino: string): Boolean;
function MoverArquivos(const Origem, PastaDestino: string): Boolean;
procedure DeletarArquivos(const Pasta_Mascara: string); // Deleta multiplos arquivos
procedure ListaPasta(var Lista: TStringList; const Arquivos: string; IncluirPasta: Boolean = False; Detalhes: Boolean = False);
procedure SetFileDataHora(const Arquivo: string; const NovaData: TDateTime);
procedure GerenciaBackup(const Pasta, Arquivo: string; MaxBackups: Integer = 9);
function WinExec32(Parametros: string = ''): Boolean;
function ExecDOSWait(const Parametros: string; WorkPath: string = ''; ShowWindow: Word = SW_HIDE): Integer;
// codigo de barras
function GeraCodBarra(const Valor: string)  : string;
function GeraCodBarra14(const Valor: string): string;
function CodBarraValido(const valor: string): Boolean;
function CodBarraValido14(const valor: string): Boolean;
function CodBarraDigito(const Valor: string)  : string;
function CodBarraDigito14(const Valor: string): string;
// calculos com horas
function HoraParaMin(const Hora:string)    : Integer;
function MinParaHora(const Minutos:Integer): string;
// funções para strings
function Extenso(const Valor: Double; IntSing: string = 'Real';    IntPlural: string = 'Reais';
                                      DecSing: string = 'Centavo'; DecPlural: string = 'Centavos'): string;
function LikeCombinado(const Campo, LikeStr: string; Separador: string = '+'; OperadorLogico: string = 'and'): string;
function MontaConsultaSQL(const CamposSelect, Tabela, CampoInteger, CampoString, ConsultaSQL: string;
                          Ordem: string = ''; RestricaoWhere: string = ''): string;
// função para filtro do modo velho DOS:
function AceitaFilterRecord(const ConteudoCampo, Filtro: string): Boolean;
function PreencheHora(const Hora: string)  : string;
function TiraEspacosDuplos(const S: string): string;
function Capitaliza(const S: string)       : string;
function TiraAcentos(const Texto: string)  : string;
function QuebraLinha(S: String; tamanhoLinha : integer) : TStringList;
function CPFCGCValido(const Codigo: string): Boolean;
function EstadoValido(const Estado: string): Boolean;
function FormataPonto(const Valor: Double; const Tamanho: Integer; Alinhado:Boolean = True;
                      Formato: string = '#,##0.00'; NumInteiro: Boolean = False;
                      MilhaoSemPonto: Boolean = False): String;
function FormataPonto2(const Valor: Double; const Tamanho: Integer;
                      Formato: string = '#,##0.00'): String;
// funcoes para datatime
function Data2Ansi(const Data: TDateTime; Formato: string = 'MM/DD/YYYY'; ComAspas: Boolean = True): string;
function DiasMes(const Data: TDateTime): Integer;
function DataDetalhe(const Data: TDateTime): string;
// registro do windows
function LerReg(const Path, Variavel: string; const ValorDefault: string)   : string;    overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Integer)  : Integer;   overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Double)   : Double;    overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Boolean)  : Boolean;   overload;
//function LerReg(const Path, Variavel: string; const ValorDefault: TDateTime): TDateTime; overload;

procedure GravaReg(const Path, Variavel, Valor: string);                  overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Integer);   overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Double);    overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Boolean);   overload;
//procedure GravaReg(const Path, Variavel: string; const Valor: TDateTime); overload;
procedure DeleteReg(const Path, Variavel: string); overload;
// arquivos INI
function LerINI(const Chave, Item: string; Padrao: string = ''; FileName: string = ''): string;  overload;
function LerINI(const Chave, Item: string; Padrao: Integer = 0; FileName: string = ''): Integer; overload;
function LerINI(const Chave, Item: string; Padrao: Boolean;     FileName: string = ''): Boolean; overload;
procedure GravaINI(const Chave, Item, Valor: string; FileName: string = '');                     overload;
procedure GravaINI(const Chave, Item: string; const Valor: Integer; FileName: string = '');      overload;
procedure GravaINI(const Chave, Item: string; const Valor: Boolean; FileName: string = ''); overload;
procedure LerSecoesINI(Lista: TStringList; FileName: string = '');
// misc
procedure CriaForm(const TAForm: TComponentClass; AForm: TCustomForm);
function Criptografa(const Palavra, Chave: string): string;
function Encrip(const S, Chave: string): string;
function Decrip(const S, Chave: string): string;
// rotinas graficas
procedure DrawTransparent(const X, Y: Integer; const Bitmap : TBitmap; const xCanvas: TCanvas; const CorDeFundo: TColor );
// hardware/rede
function LocalIP                    : string;  // retorna o ip da maquina local
function NomeComputador             : string;  // retorna o nome da maquina local
function NomeWindowsUser            : string;  // nome do login do windows
function MudarPara800x600           : Boolean; // força uma mudança para 800x600 16bit de cor, se possível
function Reboot                     : Boolean; // adivinha o que faz
function KeyPressed(const Vk: DWord): Boolean; // retorna TRUE se a tecla passada estiver press
function NumeroCoresWindows         : Integer; // Resolucao do Windows 16000, 256 cores...
function NumeroBitsResolucao        : Integer; // 8 bit, 16 bit ...
function HDLivreMb                  : Integer; // Megas livres no HD
// controle de teclado (simula o pressionamento de teclas)
procedure PressKey(const Key: Word);
procedure ReleaseKey(const Key: Word);
procedure SendKeys(const Keys: string);
// Salva/Restaura informações sobre o form
procedure RestauraForm(Form: TCustomForm; RestPos: Boolean = True; RestSize: Boolean = True; RestState: Boolean = True; DefX: Integer = 0; DefY: Integer = 0);
procedure SalvaForm(const Form: TCustomForm; SalvaPos: Boolean = True; SalvaSize: Boolean = True; SalvaState: Boolean = True);
// limpa edits e passa o foco para editfoco e se ja esta focada fecha o form
procedure VerificaEsc(var Key: Word; EditFoco: TCustomEdit; EditsClear: array of TComponent);
function LevelBDEOK: Boolean;

implementation

  ///////  //  //      ///////   //////        ///////   //////   //      ///////   ///////  ///////    //////
  //       //  //      //       //             //       //    //  //      //    //  //       //    //  //
  ////     //  //      /////     /////         ////     //    //  //      //    //  /////    ///////    /////
  //       //  //      //            //        //       //    //  //      //    //  //       //    //       //
  //       //  //////  ///////  //////         //        //////   //////  ///////   ///////  //    //  //////

function DirBarra(const Pasta: string): string;
begin
  Result := IncludeTrailingPathDelimiter(Pasta);
end;

function DirExe: string;
begin
  Result := DirBarra(ExtractFilePath(ParamStr(0)));
end;

function PastaPai(const Pasta:string): string;
var
  S : string;
  I : Integer;
begin
  S := Pasta;
  if S[ Length(Pasta) ] = '\' then Delete(S,Length(S),1);
  if Pos('\',S) > 0 then
    for I := Length(S) downto 1 do
    begin
      if S[I] = '\' then Break;
      Delete(S,I,1);
    end;
  Result := DirBarra(S);
end;

function PastaWindows: string;
var
  A: array[0..256] of char;
begin
  GetWindowsDirectory(A, 256);
  Result := DirBarra(StrPas(A));
end;

function PastaWindowsSystem: string;
var
  A: array[0..256] of char;
begin
  GetSystemDirectory(A, 256);
  Result := DirBarra(StrPas(A));
end;

function PastaWindowsTemp: string;
var
  A: array[0..256] of char;
begin
  GetTempPath(256, A);
  Result := DirBarra(StrPas(A));
end;

function PastaWindowsDesktop: string;
var
  ItemIDList: PItemIDList;
begin
  SetLength(Result,MAX_PATH);
  SHGetSpecialFolderLocation(Application.Handle, CSIDL_DESKTOP, ItemIDList);
  SHGetPathFromIDList(ItemIdList,PChar(Result));
  Result := DirBarra(StrPas(PChar(Result)));  // Tira sujeira do PCHAR
end;

// Devolve a data de um arquivo em formato TDatetime sem precisar abrir o mesmo
// Caso o arquivo não exista, devolve 0
function FileDateTime(const NomeArquivo: string): TDateTime;
begin
  Result := 0;
  if FileExists(NomeArquivo) then
    Result := FileDateToDateTime(FileAge(NomeArquivo));
end;

// Esta função retorna o tamanho do arquivo sem precisar abri-lo. Se o mesmo não for encontrado ela retorna -1.
function FileSize(const arquivo: string): LongInt;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(ExpandFileName(StrTran(arquivo, '/', '\')), faAnyFile, SearchRec) = 0 then
    Result := SearchRec.Size
  else
    Result := -1;
  FindClose(SearchRec);
end;

function GetPasta: string;
var
  T  : array [0..MAX_PATH] of Char;
  Bi : TBrowseInfo;
begin
  with BI do
  begin
    lpszTitle     := 'Selecione uma pasta';
    hwndOwner     := Application.Handle;
    pidlRoot      := nil;
    lpfn          := nil;
    pszDisplayName:= @T;
    iImage        := 0;
    ulFlags       := BIF_RETURNONLYFSDIRS;
  end;
  SHGetPathFromIDList(SHBrowseForFolder(BI), @T);
  Result := string(T);
end;

// usada como callback pela GetFolderDef
function BrowseCallbackProc(Wnd: HWnd; Msg: UINT; lParam: LPARAM; lData: LPARAM): Integer; stdcall;
var
  wht,hgt: Integer;
  winrect: TRect;
begin
  Result := 0;
  // upon startup, set the selection to the intial directory desired
  if Msg = BFFM_INITIALIZED then
  begin
    windows.GetClientRect(wnd,winrect);
    wht := winrect.Right  - winrect.left;
    hgt := winrect.Bottom - winrect.top;
    SetWindowpos(wnd,HWND_TOP,(screen.width-wht) div 2,(screen.height-hgt) div 2,wht,hgt,SWP_NOSIZE);
    SendMessage(Wnd, BFFM_SETSELECTION, WPARAM(False), lData);
  end;
end;

function GetPastaDef(const PastaDef: string): string;
var
  lpItemID, DeskItemIDList, SelItemId: PItemIDList;
  BrowseInfo   : TBrowseInfo;
  DisplayName  : array[0..MAX_PATH] of char;
  TempPath     : array[0..MAX_PATH] of char;
  ppshf        : IShellFolder;
  Eaten, Flags : cardinal;
  OldFolderName: string;
  PastaDefault : string;
begin
  Result        := '';
  SelItemId     := nil;
  PastaDefault  := PastaDef;
  OldFolderName := PastaDefault;
  SHGetSpecialFolderLocation(Application.Handle, CSIDL_DESKTOP, DeskItemIDList);
  if PastaDefault <> '' then
  begin
    if PastaDefault[Length(PastaDefault)] = '\' then Delete(PastaDefault,Length(PastaDefault),1);
    if SHGetDesktopFolder(ppshf)=0 then
      ppshf.ParseDisplayName(Application.handle, nil, StringToOleStr(PastaDefault), Eaten, SelItemId, Flags);
  end;

  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  with BrowseInfo do
  begin
    hwndOwner     := Application.handle;
    pszDisplayName:= DisplayName;
    lpszTitle     := PChar('Selecione uma pasta');
    ulFlags       := BIF_RETURNONLYFSDIRS;
    pidlRoot      := DeskItemIDList;
    lpfn          := BrowseCallbackProc;
    lparam        := Integer(SelItemId);
  end;

  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    PastaDefault := IncludeTrailingPathDelimiter(TempPath);
    GlobalFreePtr(lpItemID);
 end;
 Result := PastaDefault;
end;

function GetFileDataHora(const NomeArquivo: string): TDateTime;
begin
  Result := 0;
  if FileExists(NomeArquivo) then
    Result := FileDateToDateTime(FileAge(NomeArquivo));
end;

function MoverArquivo(const Origem, PastaDestino: string): Boolean;
var
  P: string;
begin
  P := DirBarra(PastaDestino) + ExtractFileName(Origem);
  Result := CopyFile( PChar(Origem), PChar(P), False );
  if Result then Result := DeleteFile( Origem );
end;

function CopiarArquivo(const Origem, PastaDestino: string): Boolean;
var
  P: string;
begin
  Result := False;
  if (not FileExists(Origem)) or (not DirectoryExists(PastaDestino)) then Exit;
  P := DirBarra(PastaDestino) + ExtractFileName(Origem);
  Result := CopyFile( PChar(Origem), PChar(P), False );
end;

function CopiarArquivos(const Origem, PastaDestino: string): Boolean;
var
  Arquivos: TSearchRec;
  Found   : Integer;
  Target  : string;
begin
  Result := False;
  Target := DirBarra( PastaDestino );
  try
    Screen.Cursor:= -11;
    Found := FindFirst(Origem,faArchive,Arquivos);
    while Found = 0 do
    begin
      Result:= CopiarArquivo(ExtractFilePath(Origem) + Arquivos.Name, Target {+ ExtractFileName(Arquivos.Name)});
      if not Result then Break;
      Found := FindNext(Arquivos);
    end;
    FindClose(Arquivos);
  finally
    Screen.Cursor := 0;
  end;
end;

function MoverArquivos(const Origem, PastaDestino: string): Boolean;
var
  Arquivos: TSearchRec;
  Found   : Integer;
  Target  : string;
begin
  Result := False;
  Target := DirBarra( PastaDestino );
  try
    Screen.Cursor:= -11;
    Found := FindFirst(Origem,faArchive,Arquivos);
    while Found = 0 do
    begin
      Result := CopiarArquivo(ExtractFilePath(Origem) + Arquivos.Name, Target);
      if Result then Result := DeleteFile(ExtractFilePath(Origem) + Arquivos.Name);
      if not Result then Break;
      Found := FindNext(Arquivos);
    end;
    FindClose(Arquivos);
  finally
    Screen.Cursor := 0;
  end;
end;

// Exemplo: DeletarArquivos('c:\*.txt') - apaga todos os txt do raiz
procedure DeletarArquivos(const Pasta_Mascara: string); // Deleta multiplos arquivos
var
  L : TStringList;
  I : Integer;
begin
  L := TStringList.Create;
  ListaPasta(L,Pasta_Mascara, True);
  for I := 0 to L.Count - 1 do DeleteFile( L[I] );
  L.Free;
end;

procedure SetFileDataHora(const Arquivo: string; const NovaData: TDateTime);
var
  HFile : Integer;
begin
  HFile := FileOpen(Arquivo, fmOpenWrite);
  if HFile > 0 then
  begin
    FileSetDate(HFile, DateTimeToFileDate(NovaData));
    FileClose(HFile);
  end;
end;

// retorna na stringlist um "DIR"
procedure ListaPasta(var Lista: TStringList; const Arquivos: string; IncluirPasta: Boolean = False; Detalhes: Boolean = False);
var
  Procura: TSearchRec;
  Found  : Integer;
  S      : string;
begin
  Lista.Clear;
  Screen.Cursor := -11;
  Found := FindFirst(Arquivos, faArchive, Procura);
  while Found = 0 do
  begin
    if IncluirPasta then
      S := ExtractFilePath(Arquivos) + Procura.Name
    else
      S := Procura.Name;

    if Detalhes then
      S := S + ';' + FormatDateTime('DD/MM/YYYY HH:NN:SS', FileDateToDateTime(Procura.Time)) + ';' + IntToStr(Procura.Size);

    Lista.Add(S);
    Found := FindNext(Procura);
  end;
  Screen.Cursor := 0;
  FindClose(Procura);
end;

// Faz backup em cascata deletando o ultimo.
// Exemplo de uso: desejando fazer o backup de CLIENTES.DBF:
// GerenciaBackup('C:\DADOS','CLIENTES.DBF', 20) -> o programa pega o CLIENTES.DBF
// renomeia para CLIENTES.000 e caso este mesmo já exista ele renomeia para
// CLIENTES.001, assim até 020, sendo este último deletado.
// Exemplo:  GerenciaBackup('C:\temp1', 'Planilha.zip');
procedure GerenciaBackup(const Pasta, Arquivo: string; MaxBackups: Integer = 9);
var
  P: string;
  I: Integer;
begin
  P := DirBarra(Pasta);
  // Gerencia o backup em cascata
  for I:= MaxBackups downto 0 do
    if FileExists(P + ChangeFileExt(Arquivo,'.' + Format('%.3d',[I]))) then
      if I = MaxBackups then
        DeleteFile(PChar(P + ChangeFileExt(Arquivo,'.' + Format('%.3d', [MaxBackups]))))
      else
        RenameFile(P + ChangeFileExt(Arquivo, '.' + Format('%.3d',[I  ]) ),
                   P + ChangeFileExt(Arquivo, '.' + Format('%.3d',[I+1]) ));
  // Renomeia o arquivo
  RenameFile(P + Arquivo, P + ChangeFileExt(Arquivo, '.000'));
end;

//funcao para executar um comando windows
function WinExec32( Parametros: string = ''): Boolean;
var
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartUpInfo,SizeOf(StartUpInfo),#0);
  StartUpInfo.Cb         := SizeOf(StartUpInfo);
  StartUpInfo.DwFlags    := StartF_UsesHowWindow;
  StartUpInfo.wShowWindow:= SW_SHOWNORMAL;
  //PChar(Linha_de_Comando)
  Result := CreateProcess(nil, PChar(Parametros), nil, nil, False,
                          Create_New_Console or Normal_Priority_Class, nil, nil, StartUpInfo, ProcessInfo);
end;

// Funcao para executar um programa DOS e aguardar ate que o mesmo termine
// Que merda
function ExecDOSWait(const Parametros: string; WorkPath: string = ''; ShowWindow: Word = SW_HIDE): Integer;
var
  R          : DWORD;
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartUpInfo,SizeOf(StartUpInfo),#0);
  StartUpInfo.Cb      := SizeOf(StartUpInfo);
  StartUpInfo.DwFlags := StartF_UsesHowWindow;
  //StartUpInfo.wShowWindow:= SW_SHOWNORMAL; // Mostra tela do DOS
  StartUpInfo.wShowWindow := ShowWindow; // Oculta a tela do DOS
  if not CreateProcess(nil, PChar(Parametros), nil, nil, false,
                       Create_New_Console or Normal_Priority_Class, nil, Pchar(WorkPath), StartUpInfo, ProcessInfo) then Result:= -1
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess,INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess,R);
    Result := R;
  end;
end;

   //////   //////   ///////         ///////    //////   ///////   ///////    //////    //////
  //       //    //  //    //        //    //  //    //  //    //  //    //  //    //  //
  //       //    //  //    //        ///////   ////////  ///////   ///////   ////////   /////
  //       //    //  //    //        //    //  //    //  //    //  //    //  //    //       //
   //////   //////   ///////         ///////   //    //  //    //  //    //  //    //  //////

// Gera um código de barras a partir de qualquer valor (apresentado na forma de string) com
// até 12 digitos. Entra 1 sai 17, entra 78 sai 789, entra 198 sai 1984...
function GeraCodBarra(const Valor: string): string;
begin
  Result := Valor + CodBarraDigito(valor);
end;

function GeraCodBarra14(const Valor: string): string;
begin
  Result := Valor + CodBarraDigito14(valor);
end;

// Verifica se o código de barras está ok.
function CodBarraValido(const valor: string): Boolean;
begin
  Result := (Valor = GeraCodBarra(Copy(Valor, 1, Length(Valor)-1)));
  if StrToInt64Def(Valor, 0) = 0 then Result := False;
end;

// Verifica se o código de barras está ok.
function CodBarraValido14(const valor: string): Boolean;
begin
  Result := (Valor = GeraCodBarra14(Copy(Valor, 1, Length(Valor)-1)));
  if StrToInt64Def(Valor, 0) = 0 then Result := False;
end;

// Calcula o dígito do código de barras recebido. Retorna somente o dígito
function CodBarraDigito(const Valor: string): string;
var
  codigo           : string;
  A, Pares, Impares: Integer;
begin
  Codigo  := RepeteStr('0', 12 - Length(valor)) + Valor;
  Pares   := 0;
  Impares := 0;
  // soma os valores pares e ímpares separadamente
  for A := 1 to 12 do
    if Odd(a) then Impares := Impares + StrToInt(Codigo[A])
    else           Pares   := Pares   + StrToInt(Codigo[A]);
  // extrai o dígito
  Result := IntToStr(Impares + (Pares * 3));
  Result := Copy(Result, Length(Result), 1);
  Result := IntToStr(10 - StrToInt(Result));
  if Result = '10' then Result := '0';
end;

function CodBarraDigito14(const Valor: string): string;
var
  codigo           : string;
  A, Pares, Impares: Integer;
begin
  Codigo  := RepeteStr('0', 13 - Length(valor)) + Valor;
  Pares   := 0;
  Impares := 0;
  // soma os valores pares e ímpares separadamente
  for A := 1 to 13 do
    if Odd(a) then Impares := Impares + StrToInt(Codigo[A])
    else           Pares   := Pares   + StrToInt(Codigo[A]);
  // extrai o dígito
  Result := IntToStr(Pares + (Impares * 3));
  Result := Copy(Result, Length(Result), 1);
  Result := IntToStr(10 - StrToInt(Result));
  if Result = '10' then Result := '0';
end;

  //   //   //////   ///////    //////    //////
  //   //  //    //  //    //  //    //  //
  ///////  //    //  ///////   ////////   /////
  //   //  //    //  //    //  //    //       //
  //   //   //////   //    //  //    //  //////

function HoraParaMin(const Hora:String):Integer;
var
  Sinal : string;
begin
  if (Hora = '') or (Trim(Hora) = ':') then
  Begin
    Result := 0;
    Exit;
  end;
  // Para calculo com numeros negativos
  if Copy(Hora,1,1) = '-' then Sinal := '-';
  try
    Result := (StrToInt(Separa(Hora,':',1)) * 60) + StrToInt(Sinal + Separa(Hora,':',2));
  except
    Result := 0;
  end;
end;

function MinParaHora(const Minutos:Integer):String;
var
  V : Integer;
begin
  V := Minutos div 60;
  if V < 0 then
  begin
    if V < -99 then
      Result := StrZero2(V,4) + ':' + StrZero(Minutos mod 60,2) //!! antes estava **:**
    else
      Result := StrZero2(V,3) + ':' + StrZero(Minutos mod 60,2);
  end
  else  // Resultado é positivo?
  begin
    if (V = 0) and (Minutos < 0) then // Só tem minutos e alem disso é negativo
      Result := '-00:' + StrZero(Minutos mod 60,2)
    else // Valores normais...
      Result := StrZero(V,2) + ':' + StrZero(Minutos mod 60,2);
  end;
end;

   //////  ////////  ///////   //  ///   //   //////
  //          //     //    //  //  ////  //  //
   /////      //     ///////   //  // // //  //  ////
       //     //     //    //  //  //  ////  //    //
  //////      //     //    //  //  //   ///   ///////

function Extenso(const Valor: Double; IntSing: string = 'Real';    IntPlural: string = 'Reais';
                                      DecSing: string = 'Centavo'; DecPlural: string = 'Centavos'): string;
var
  Value, Part: String;
  Text: array[1..5] of String;
  a: Integer;
const
  Unity:    array[1..9]   of string = ('Um', 'Dois', 'Três', 'Quatro', 'Cinco', 'Seis',
                                       'Sete', 'Oito', 'Nove');
  Tens:     array[2..9]   of string = ('Vinte', 'Trinta', 'Quarenta', 'Cinqüenta',
                                       'Sessenta', 'Setenta', 'Oitenta', 'Noventa');
  Hundreds: array[1..9]   of string = ('Cento', 'Duzentos', 'Trezentos', 'Quatrocentos',
                                       'Quinhentos', 'Seiscentos', 'Setecentos',
                                       'Oitocentos', 'Novecentos');
  Until19:  array[10..19] of string = ('Dez', 'Onze', 'Doze', 'Treze', 'Quatorze', 'Quinze',
                                       'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');
  Singular: array[1..5]   of string = (' Bilhão', ' Milhão', ' Mil', '', ' !');   //! = Centavo
  Plural:   array[1..5]   of string = (' Bilhões', ' Milhões', ' Mil', '', ' ?'); //? = Centavos
  Position: array[1..5]   of Word   = (1, 4, 7, 10, 14);

  function RightStr(const AText: string; const ACount: Integer): string;
  begin
    Result := Copy(AText, Length(AText) + 1 - ACount, ACount);
  end;

begin
  // formats the value as a string looking "999999999999.99"
  Value := Format('%m', [Valor]);
  Value := Trim(StrTran(StrTran(Value, CurrencyString, ''), ThousandSeparator, ''));
  if DecimalSeparator <> '.' then
    Value := StrTran(Value, DecimalSeparator, '.');
  Value := IfThen(Pos('.', Value) = 0, Value + '.00', Value);
  Value := IfThen(RightStr(Value, 2) = ',0', Value + '0', Value);
  Value := RepeteStr('0', 15 - Length(Value)) + Value;
  // evaluate each section of the value
  for a := 1 to 5 do
  begin
    Part    := IfThen(a = 5, '0' + Copy(Value, 14, 2), Copy(Value, Position[a], 3));
    if Part <> '000' then
    begin
      if Part = '100' then
        Text[a] := Text[a] + ' Cem '
      else
      begin
        if Part[1] <> '0' then Text[a] := Text[a] + Hundreds[StrToInt(Part[1])];
        if Part[2] = '1'  then
        begin
          if Text[a] <> '' then Text[a] := Text[a] + ' e ';
          Text[a] := Text[a] + Until19[StrToInt(Part[2] + Part[3])];
        end;
        if not (Part[2] in ['1','0']) then
        begin
          if Text[a] <> '' then Text[a] := Text[a] + ' e ';
          Text[a] := Text[a] + Tens[StrToInt(Part[2])];
        end;
        if (Part[3] <> '0') and (Part[2] <> '1') then
        begin
          if Text[a] <> '' then Text[a] := Text[a] + ' e ';
          Text[a] := Text[a] + Unity[StrToInt(Part[3])];
        end;
      end;
      if (a = 5) and (StrToInt(Part) > 0) and ((Text[1] <> '') or (Text[2] <> '') or
                                               (Text[3] <> '') or (Text[4] <> '')) then
        Text[5] := ' e ' + Text[5];
      if Text[a] <> '' then
        if Part = '001' then Text[a] := Text[a] + Singular[a]
        else                 Text[a] := Text[a] + Plural[a];
    end;
  end;
  // put and's, commas and spaces between sections
  if (Text[1] <> '') and ((Text[2] <> '') or (Text[3] <> '') or (Text[4] <> '')) then
    if Copy(Value, Position[2], 6) = '000000' then Text[1] := Text[1] + ' e '
    else                                           Text[1] := Text[1] + ', ';
  if (Text[2] <> '') and ((Text[3] <> '') or (Text[4] <> '')) then
    if Copy(Value, Position[3], 3) = '000' then Text[2] := Text[2] + ' e '
    else                                        Text[2] := Text[2] + ', ';
  if (Text[3] <> '') and (Text[4] <> '') then
    if Copy(Value, Position[4], 1) = '0' then Text[3] := Text[3] + ' e '
    else
      if Copy(Value, Position[4] +1, 2) = '00' then Text[3] := Text[3] + ' e '
      else                                          Text[3] := Text[3] + ', ';
  for a := 1 to 4 do
  begin
    if (Text[a] <> '') and (Text[a + 1] <> '') then Text[a] := Text[a] + ' ';
  end;
  // put the currency in the proper position is it's money
       if Valor = 0 then Text[1] := 'Zero'
  else if Valor < 1 then Text[5] := Text[5] + ' de ' + IntSing
  else if Valor < 2 then Text[4] := Text[4] + ' ' + IntSing + ' '
  else if (Valor > 1000000) and (Text[4] = '') then Text[4] := ' de ' + IntPlural + ' '
  else Text[4] := Text[4] + ' ' + IntPlural + ' ';
  // join the parts to form a final string
  Result := Text[1] + Text[2] + Text[3] + Text[4] + Text[5];
  if Pos('!', Result) > 0 then Result := StrTran(Result, '!', DecSing);
  if Pos('?', Result) > 0 then Result := StrTran(Result, '?', DecPlural  );
  while (Pos('  ', Result) <> 0) do Result := StrTran(Result, '  ', ' ');
end;

function LikeCombinado(const Campo,LikeStr:string; Separador:string = '+'; OperadorLogico:string = 'and'): string;
var
  S, L, R: string;
  I: Integer;
begin
  if LikeStr = '' then Exit;

  L := LikeStr;
  if L[1] = Separador then Delete(L,1,1);

  for I := 1 to Length(L) do
  begin
    if L[I] = Separador then
    begin
      R := R + OperadorLogico + #32 + Campo + ' like ' + #39 + '%' + S + '%' + #39 + ' ';
      S := '';
    end
    else
      S := S + L[I];
  end;
  // O Ultimo vai manualmente
  Delete(R,1,3); // tira o 1º "OR "
  if R = '' then
    Result := '(' + Campo + ' like ' + #39 + '%' + S + '%' + #39 + ')'
  else
    Result := '(' + R + OperadorLogico + #32 + Campo + ' like ' + #39 + '%' + S + '%' + #39 + ')';
end;

// exemplo: MontaConsultaSQL( 'codigo,nome', 'clientes', 'nome', 'codigo', Edit1.Text, 'nome');
// onde a Edit1.Text pode conter
//   JOA+       --> todos que o campostring iniciam com JOA
//   JOA        --> pesquisa o campostring com JOA exato
//   +JOA       --> todos que o campostring possuem JOA
//   JOA+GUI    --> todos que o campostring começam com JOA e possuem GUI
//   10         --> codigointeger = 10
//   10/10/2002 --> o campostring será comparada com esta data (campostring = "10/10/2002")
// o parametro opcional RestricaoWere é uma restricao adicional como exemplo cod_forne = 10
function MontaConsultaSQL(const CamposSelect, Tabela, CampoInteger, CampoString, ConsultaSQL: string;
                          Ordem: string = ''; RestricaoWhere: string = ''): string;
var
  Where, Where2, OrderBy, S, S2: string;
begin
  S := ConsultaSQL;

  Where   := StrTran(RestricaoWhere, ':', ' and ');  if Where   <> '' then Where   := ' where '    + Where;
  OrderBy := StrTran(Ordem         , ':', ','    );  if OrderBy <> '' then OrderBy := ' order by ' + OrderBy;

  if StrToInt64Def(S, 0) <> 0 then // se for numerico procura no primeiro campo
    Where2 := '(' + CampoInteger + '=' + S + ')'
  else
    if (Length(S) = 10) and (Copy(S, 3, 1) = '/') and (Copy(S, 3, 1) = '/') then // é data?
      Where2 := '(' + CampoInteger + '=' + QuotedStr(Copy(S,4,3) + Copy(S,1,3) + Copy(S,7,4)) + ')' // tem que invertes MES/DIA
    else    // é string?
      if (S <> '') and (Pos('+', S) = 0) then
        Where2 := '(' + CampoString + '=' + QuotedStr(S) + ')';

  // o Where2 é definido quando o usuário colocou um valor na Edit... QUE não é * nem +
  if Where2 <> '' then
    Where := Where + IfThen(Where = '', ' where ' + Where2, ' and ' + Where2);

  // se tem "+" na edit usa like combinado no campo string
  if Pos('+', S) > 0 then
  begin
    // para procurar alguma cujo conteúdo é "+" use ++
    if Copy(S,1,2) = '++' then
    begin
      if Where <> '' then Where := Where + ' and ' else Where := ' where ';
      Where := Where + '(' + CampoString + ' like ' + QuotedStr('%+%') + ')';
    end
    else  // possui ... e possui ... e possui ...
    if Copy(S,1,1) = '+' then
    begin
      if Where <> '' then Where := Where + ' and ' else Where := ' where ';
      Where := Where + LikeCombinado(CampoString, S);
    end
    else  // começa com ...
    if Copy(S, Length(S), 1) = '+' then
    begin
      if Where <> '' then Where := Where + ' and ' else Where := ' where ';
      Where := Where + '(' + CampoString + ' like ' + QuotedStr(StrTran(S, '+', '%')) + ')';
    end
    else // começa com ... e possui ... possui ...
    begin
      if Where <> '' then Where := Where + ' and ' else Where := ' where ';
      S2    := Separa(S,'+',1); // S2 é o primeiro
      Where := Where + '(' + CampoString + ' like ' + QuotedStr(S2 + '%') + ')';
      Delete(S, 1, Pos('+', S));
      Where := Where + ' and ' + LikeCombinado(CampoString, S);
    end;
  end;
  Result := CamposSelect + ' from ' + Tabela + Where + OrderBy;
end;

// função inédita: funciona igual ao SQL acima, porém é pra usar com Table (!!!)
// coloque a tabela como Filtered := True  e no OnFilterRecord coloque assim:
// Accept := AceitaFilterRecord(TbProdNOME.AsString, FiltroNome);
// o FiltroNome é o text da edit que contem "+JOAO", "JOAO+SILVA"...
function AceitaFilterRecord(const ConteudoCampo, Filtro: string): Boolean;
var
  I, O : Integer;
  S, S2: string;
begin
  Result := True;
  if Filtro = '' then Exit;

  // tem "+" no nome?
  if Pos('+', Filtro) = 0 then
  begin
    Result := (Pos(Filtro, ConteudoCampo) > 0);
    Exit;
  end;

  // começa com... "X+"
  if Copy(Filtro, Length(Filtro), 1) = '+' then
  begin
    Result := Copy(ConteudoCampo, 1, Length(Filtro)-1) = Copy(Filtro, 1, Length(Filtro)-1);
    Exit;
  end;

  // possui ... e possui ... e possui ...
  if Copy(Filtro,1,1) = '+' then
  begin
    O := Ocorre(Filtro, '+');
    S2 := Filtro;
    Delete(S2,1,1);
    for I := 1 to O do
    begin
      S := Separa(S2, '+', I);
      Result := (Pos(S, ConteudoCampo) > 0);
      if not Result then Break;
    end;
    Exit;
  end;

  // para procurar alguma cujo conteúdo é "+" use ++
  if Copy(Filtro,1,2) = '++' then
  begin
    Result := (Pos('+', ConteudoCampo) > 0);
    Exit;
  end;

  // começa com
  S      := Separa(Filtro, '+', 1);
  Result := Copy(ConteudoCampo, 1, Length(S)) = S;
  if not Result then Exit;
  // ... e possui ... possui ...
  O  := Ocorre(Filtro, '+');
  S2 := Filtro;
  Delete(S2,1, Pos('+', Filtro));
  for I := 1 to O do
  begin
    S := Separa(S2, '+', I);
    Result := (Pos(S, ConteudoCampo) > 0);
    if not Result then Break;
  end;
end;

function PreencheHora(const Hora: string) : String;
var
 i : integer;
begin
  Result := Hora;
  if Result = '' then Result := '00:00' else Result := AlinhaEsq(Result, 5);
  for i := 1 to 5 do
    if i <> 3 then
      if Result[i] = #32 then
        Result[i] := '0';
end;

// Remove todos os espaços duplicados, triplicados ... por um espaço
function TiraEspacosDuplos(const S: string): string;
begin
  Result := S;
  while Pos(#32#32, Result) > 0 do
    Result := StrTran( Result, #32#32, #32)
end;

function Capitaliza(const S: string): string;
var
   X,I,I2,Te : Integer;
   Sub,Resp  : string;
   NaoCap    : Boolean;
const
  Words: array[1..14] of string = ('DE','DA','DAS','DO','DOS','NA','NAS','NO','NOS','A','E','O','EM','COM');
begin
  Resp   := '';
  If Length(S) < 1 then Exit;

  Te:= Ocorre(S,#32);
  If Te < 1 then
  begin
    For I:=1 to Length(S) do
    if I=1 then
      Resp := AnsiUpperCase(S[I])
    else
      Resp := Resp + AnsiLowerCase(S[I]);
  end
  else
  For I := 1 to (Te + 1) do
  Begin
    Sub     := Separa(S,#32,I);
    NaoCap  := False;
    For X := 1 To 14 do
      If (UpperCase(Sub) = Words[X]) then
      Begin
        NaoCap := True;
        Break;
      end;

      If NaoCap then
        Resp := Resp + AnsiLowerCase(Sub)
      else
        For I2:=1 to Length(Sub) do
          If I2=1 then
            Resp := Resp + AnsiUpperCase(Sub[I2])
          else
            Resp := Resp + AnsiLowerCase(Sub[I2]);
    If I <> (Te + 1) then Resp := Resp + #32;
  end;
  Result := Resp;
end;

// Esta function remove toda a acentuação de uma string substituindo os caracteres acentuados
// por eles mesmos sem acentos. Esta função é especialmente útil durante a impressão.
function TiraAcentos(const Texto: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Texto) do
    case Texto[I] of
      'á', 'à', 'ä', 'â', 'ã': Result := Result + 'a';
      'Á', 'À', 'Ä', 'Â', 'Ã': Result := Result + 'A';
      'é', 'è', 'ë', 'ê'     : Result := Result + 'e';
      'É', 'È', 'Ë', 'Ê'     : Result := Result + 'E';
      'í', 'ì', 'ï', 'î'     : Result := Result + 'i';
      'Í', 'Ì', 'Ï', 'Î'     : Result := Result + 'I';
      'ó', 'ò', 'ö', 'ô', 'õ': Result := Result + 'o';
      'Ó', 'Ò', 'Ö', 'Ô', 'Õ': Result := Result + 'O';
      'ú', 'ù', 'ü', 'û'     : Result := Result + 'u';
      'Ú', 'Ù', 'Ü', 'Û'     : Result := Result + 'U';
      'Ç'                    : Result := Result + 'C';
      'ç'                    : Result := Result + 'c';
      'ñ'                    : Result := Result + 'n';
      'Ñ'                    : Result := Result + 'N';
      'ª'                    : Result := Result + 'a';
      'º'                    : Result := Result + 'o';
      else Result := Result + Texto[I];
    end;
end;


function QuebraLinha(S: String; tamanhoLinha : integer) : TStringList;
var
  Aux : TStringList;
  i, t, p : integer;
begin
  Aux := TStringList.Create;
  Try
    While S <> '' do
    begin
      if Length(s) > tamanhoLinha then
      begin
        t := tamanhoLinha+1;
        p := t;
        for i:=t downto 1 do
        if s[i] in [' ',',','.',';',':','?','!'] then
        begin
          if (i=t) and (s[i]<>' ') then
            continue;
          p:=i;
          break;
        end;
      end
      else
      begin
        t := Length(s);
        p := t;
      end;
      Aux.Add(Copy(S,1,p));
      Delete(S,1,p);
      while (length(s) > 0)and(s[1]=' ') do
        delete(S,1,1);
    end
  finally
    Result := Aux;
  end
end;


// Funcao pra verificacao de CPF/CNPJ
// Obs: os CPFs do tipo '11111111111', '22222222222' e assim por diante sao validos.
function CPFCGCValido(const Codigo: string): Boolean;
  function iTesteCPF(const Codigo: string): Boolean;
  var
    a, b, soma, inicio, fim, digito: Integer;
    controle: String;
  begin
    if Length(Codigo) < 11 then
    begin
      Result := False;
      Exit;
    end;
    inicio   := 2;
    fim      := 10;
    controle := '';
    digito   := 0;
    for a := 1 to 2 do
    begin
      soma := 0;
      for b := inicio to fim do
        soma := soma + (StrToInt(Copy(Codigo, b - a, 1)) * (fim + 1 + a - b));
      if a = 2 then soma := soma + (2 * digito);
      digito := (soma * 10) mod 11;
      if digito = 10 then digito := 0;
      controle := controle + IntToStr(digito);
      inicio   := 3;
      fim      := 11;
    end;
    Result := ((controle = Copy(Codigo, 10, 2)) or (Codigo = ''));
  end;

  function iTesteCGC(const Codigo: string): Boolean;
  var
    d: array [1..12] of Integer;
    a, teste1, teste3, resto1, resto2, pridig, segdig: Integer;
    teste2: Extended;
  begin
    if Length(Codigo) < 14 then
    begin
      Result := False;
      Exit;
    end;
    for a := 1 to 12 do
      d[a] := StrToIntDef(Copy(Codigo, a, 1),0);
    teste1 := 5 * d[01] + 4 * d[02] + 3 * d[03] + 2 * d[04] + 9 * d[05] + 8 * d[06] +
              7 * d[07] + 6 * d[08] + 5 * d[09] + 4 * d[10] + 3 * d[11] + 2 * d[12];
    teste2 := teste1 / 11;
    teste3 := Trunc(teste2) * 11;
    resto1 := teste1 - teste3;
    if ((resto1 = 0) or (resto1 = 1)) then
      pridig := 0
    else
      pridig := 11 - resto1;
    teste1 := 6 * d[01] + 5 * d[02] + 4 * d[03] + 3 * d[04] + 2 * d[05] + 9 * d[06] +
              8 * d[07] + 7 * d[08] + 6 * d[09] + 5 * d[10] + 4 * d[11] + 3 * d[12] +
              2 * pridig;
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
  if Length(Codigo) = 11 then Result := iTesteCPF(Codigo)
  else                        Result := iTesteCGC(Codigo);
end;

function EstadoValido(const Estado: string): Boolean;
const
  Estados = 'SPMGRJRSSCPRESDFMTMSGOTOBASEALPBPEMARNCEPIPAAMAPFNACRRRO';
var
  Posicao: Integer;
begin
  Result := False;
  if Length(Estado) <> 2 then Exit;
  Posicao := Pos(UpperCase(Estado),Estados);
  Result  := (Posicao = 0) or ((Posicao mod 2) = 0);
  Result  := not Result;
end;

//  X := 1234567.89; // Double;
//  FormataPonto( X, 14, True, '#,##0.00', False, True); ==> "   1234.567,89"  se X = 0 ==> "           .  "
//  FormataPonto( X, 14, False);                         ==> "  1.234.567,89"  se X = 0 ==> "             ."
//  FormataPonto( X, 14, True, '#,##', True);            ==> "     1.234.568"  se X = 0 ==> "             ."
//  FormataPonto( X, 14, False, '#,##', True);           ==> "     1.234.568"  se X = 0 ==> "             ."
function FormataPonto(const Valor: Double; const Tamanho: Integer; Alinhado:Boolean = True;
                      Formato: string = '#,##0.00'; NumInteiro: Boolean = False;
                      MilhaoSemPonto: Boolean = False): String;
var
  S, TrocaSt: string;
begin
  S := AlinhaDir( FormatFloat(Formato, Valor), Tamanho);
  if Alinhado then TrocaSt := ' .  ' else TrocaSt := '   .';
  if (MilhaoSemPonto) and (Valor > 1000000) then
  begin
    Delete(S,Pos('.',S),1);
    S := #32 + S;
  end;
  if NumInteiro then
    Result := StrTran(S, RepeteStr(#32,Tamanho), RepeteStr(#32, Tamanho - 1) + '.')
  else
  begin
    if Pos('0,00',S) > 0 then
    Begin
      if Trim(Copy(S, Pos('0,00',S)-1, 1)) = '' then
        Result := StrTran(S,'0,00',TrocaSt)
      else
        Result := S;
    end
    else
      Result := S;
    if Trim(S) = '0' then
      if Alinhado then Result := ' .  ' else Result := '   .';
  end;
end;

//provisoria ate arrumar a Funcao FormataPonto
function FormataPonto2(const Valor: Double; const Tamanho: Integer;
                      Formato: string = '#,##0.00'): String;
var
  S, F    : string;
  Inteiro : Boolean;
  fracio  : integer;
begin
  Inteiro :=  not (pos('.',Formato)>0);
  F := FloatToStr(frac(valor));
  Fracio := length(F)-ARotinasUnit.ifThen(pos('.',F)=0,1,pos('.',F));
  if Valor = 0 then
    S := ' .'+ RepeteStr(' ', Length(Formato) - ARotinasUnit.IfThen(not Inteiro,Pos('.',Formato),Length(Formato)))
  else
    S := FormatFloat(Formato+ARotinasUnit.IfThen(Inteiro,'.','')+repeteStr('0',Fracio), Valor);
  if (valor<>0) and not(Fracio=0)then
    S := copy(S,1,length(s)-ARotinasUnit.IfThen(Inteiro,Fracio+1,Fracio));
  S := RepeteStr(' ', Tamanho - Length(S)) + S;
  if length(s) > tamanho then
    copy(s,1,tamanho);
  Result := S;
end;

  ///////    //////   ////////   //////
  //    //  //    //     //     //    //
  //    //  ////////     //     ////////
  //    //  //    //     //     //    //
  ///////   //    //     //     //    //

function Data2Ansi(const Data: TDateTime; Formato: string = 'MM/DD/YYYY'; ComAspas: Boolean = True): string;
begin
  Result := FormatDateTime(Formato, Data);
  if ComAspas then Result := QuotedStr(Result);
end;

function DiasMes(const Data: TDateTime): Integer;
var
  D: TDateTime;
begin
  D := StrToDate('01/' + FormatDateTime('MM/YYYY', Data));
  D := IncMonth(D,1) - 1;
  Result := StrToIntDef( FormatDateTime('DD', D), 0 );
end;

// Retora detalhe da Data
function DataDetalhe(const Data: TDateTime): string;
begin
  Result := DateToStr(Data) + ' ' + TiraAcentos(AnsiLowerCase(ShortdayNames[DayofWeek(Data)]));
end;

  ///////   ///////   //////   //   //////  ////////  ///////    //////
  //    //  //       //        //  //          //     //    //  //    //
  ///////   /////    //  ////  //   /////      //     ///////   //    //
  //    //  //       //    //  //       //     //     //    //  //    //
  //    //  ///////   ///////  //  //////      //     //    //   //////

// Le do Registro do Windows no Path especifivado
// Exemplo:  Edit1.Text := LerReg('Market\Programa1','PastaDefault');
function LerReg(const Path, Variavel: string; const ValorDefault: string): string; overload;
var
  Reg: TRegistry;
Begin
  Reg         := TRegistry.Create;
//  Reg.RootKey := HKEY_CURRENT_USER;
//  Reg.CreateKey(Path);
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadString(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;


function LerReg(const Path, Variavel: string; const ValorDefault: Integer): Integer; overload;
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

function LerReg(const Path, Variavel: string; const ValorDefault: Double): Double; overload;
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

function LerReg(const Path, Variavel: string; const ValorDefault: Boolean): Boolean; overload;
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
{
function LerReg(const Path, Variavel: string; const ValorDefault: TDateTime): TDateTime; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadDateTime(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;
}
// Grava no Registro do Windows o Valor especificado
// Exemplo GravaReg('Market\Programa1','PastaDefault', Edit1.Text );
procedure GravaReg(const Path, Variavel, Valor: string); overload;
var
  Reg: TRegistry;
Begin
  Reg         := TRegistry.Create;
//  Reg.RootKey := HKEY_CURRENT_USER;
//  Reg.CreateKey(Path);
  Reg.OpenKey(Path, True);
  Reg.WriteString(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel: string; const Valor: Integer); overload;
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

procedure GravaReg(const Path, Variavel: string; const Valor: Boolean); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteBool(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure DeleteReg(const Path, Variavel: string); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.DeleteValue(variavel);
  FreeAndNil(Reg);
end;
{
procedure GravaReg(const Path, Variavel: string; const Valor: TDateTime); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteDateTime(Variavel, Valor);
  FreeAndNil(Reg);
end;
}
// Esta function é usada para ler valores do arquivo .INI de forma padronizada.
function LerINI(const Chave, Item: string; Padrao: string = ''; FileName: string = ''): string; overload;
begin
  Result := Padrao;
  if FileName = '' then
    FileName := DirExe + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  with TIniFile.Create(FileName) do
  try
    Result := ReadString(Chave, Item, Padrao);
  finally
    Free;
  end;
end;

function LerINI(const Chave, Item: string; Padrao: Integer = 0; FileName: string = ''): Integer; overload;
begin
  if FileName = '' then
    FileName := DirExe + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  with TIniFile.Create(FileName) do
  try
    Result := ReadInteger(Chave, Item, Padrao);
  finally
    Free;
  end;
end;

function LerINI(const Chave, Item: string; Padrao: Boolean; FileName: string = ''): Boolean; overload;
begin
  if FileName = '' then
    FileName := DirExe + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  with TIniFile.Create(FileName) do
  try
    Result := ReadBool(Chave, Item, Padrao);
  finally
    Free;
  end;
end;

// Esta function é usada para gravar valores do arquivo .INI de forma padronizada (veja LeINI).
procedure GravaINI(const Chave, Item, Valor: string; FileName: string = ''); overload;
begin
  if FileName = '' then
    FileName := ChangeFileExt(Application.ExeName, '.ini');

  with TIniFile.Create(FileName) do
  try
    WriteString(Chave, Item, Valor);
  finally
    Free;
  end;
end;

// Esta function é usada para gravar valores do arquivo .INI de forma padronizada (veja LeINI).
procedure GravaINI(const Chave, Item: string; const Valor: Integer; FileName: string = ''); overload;
begin
  if FileName = '' then
    FileName := ChangeFileExt(Application.ExeName, '.ini');

  with TIniFile.Create(FileName) do
  try
    WriteInteger(Chave, Item, Valor);
  finally
    Free;
  end;
end;

// Esta function é usada para gravar valores do arquivo .INI de forma padronizada (veja LeINI).
procedure GravaINI(const Chave, Item: string; const Valor: Boolean; FileName: string = ''); overload;
begin
  if FileName = '' then
    FileName := ChangeFileExt(Application.ExeName, '.ini');

  with TIniFile.Create(FileName) do
  try
    WriteBool(Chave, Item, Valor);
  finally
    Free;
  end;
end;

// esta function é usada para ler valores do arquivo .INI de forma padronizada.
procedure LerSecoesINI(Lista: TStringList; FileName: string = '');
begin
  if FileName = '' then
    FileName := ChangeFileExt(Application.ExeName, '.ini');

  with TIniFile.Create(FileName) do
  try
    ReadSections(Lista);
  finally
    Free;
  end;
end;

  //     ///  //   //////   //////
  ////  ////  //  //       //
  //////////  //   /////   //
  // //// //  //       //  //
  //  //  //  //  //////    //////

procedure CriaForm(const TAForm: TComponentClass; AForm: TCustomForm);
begin
  Application.CreateForm(TAForm, AForm);
  try AForm.ShowModal; finally AForm.Free; end;
end;

// Mistura o parametro "Palavra" através de XOR a nível de bit com a "Chave"
function Criptografa(const Palavra, Chave: string): string;
var
  I, J: Integer;
begin
  I  :=  1;
  J  :=  1;
  Result := '';
  while I < Length( Palavra ) + 1 do
  begin
    Result := Result + Chr(not Ord( Palavra[I] ) xor Ord( Chave[J]));
    Inc(I); Inc(J);
    if J > Length( Chave ) then J := 1;
  end;
end;

////////////////// criptografia animal

function xCrypt(const A: Char; const Src, Key: string): string;
var
  KeyLen    : Integer;
  KeyPos    : Integer;
  offset    : Integer;
  SrcPos    : Integer;
  SrcAsc    : Integer;
  TmpSrcAsc : Integer;
  Range     : Integer;
begin
  Result := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  Range  := 256;

  if A = 'E' then
  try
    Randomize;
    offset := Random(Range);
    Result := format('%1.2x',[offset]);
    for SrcPos := 1 to Length(Src) do
    begin
      SrcAsc := (Ord(Src[SrcPos]) + offset) MOD 255;
      if KeyPos < KeyLen then KeyPos:= KeyPos + 1 else KeyPos:=1;
      SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      Result := Result + Format('%1.2x',[SrcAsc]);
      offset := SrcAsc;
    end;
  except
    Result := 'Erro';
  end
  else
  try
    offset := StrToInt('$'+ copy(src,1,2));
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$'+ copy(src,SrcPos,2));
      if KeyPos < KeyLen Then KeyPos := KeyPos + 1 else KeyPos := 1;
      TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= offset then
        TmpSrcAsc := 255 + TmpSrcAsc - offset
      else
        TmpSrcAsc := TmpSrcAsc - offset;
      Result := Result + chr(TmpSrcAsc);
      offset := srcAsc;
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

   //////   ///////    //////   ///////  //   //////   //////
  //        //    //  //    //  //       //  //       //    //
  //  ////  ///////   ////////  ////     //  //       //    //
  //    //  //    //  //    //  //       //  //       //    //
   ///////  //    //  //    //  //       //   //////   //////

procedure DrawTransparent(const X, Y: Integer; const Bitmap : TBitmap; const xCanvas: TCanvas; const CorDeFundo: TColor );
begin
  xCanvas.Brush.Color := CorDeFundo;
  xCanvas.BrushCopy(Rect(X, Y, Bitmap.Width + X, Bitmap.Height + Y), Bitmap,
                    Rect(0, 0, Bitmap.Width    , Bitmap.Height)    , Bitmap.Canvas.Pixels[0,0]);
end;

  //   //   //////   ///////   ///////   //  //  //   //////   ///////   ///////
  //   //  //    //  //    //  //    //  // //// //  //    //  //    //  //
  ///////  ////////  ///////   //    //  //////////  ////////  ///////   /////
  //   //  //    //  //    //  //    //  ////  ////  //    //  //    //  //
  //   //  //    //  //    //  ///////   //      //  //    //  //    //  ///////

function LocalIP: string;
var
  wsaData: TWSAData;
begin
  WSAStartup( 257, wsaData );
  Result := iNet_ntoa( PInAddr( GetHostByName( nil )^.h_addr_list^ )^ );
  WSACleanup;
end;

function NomeComputador: string;
var
  wsaData: TWSAData;
begin
  WSAStartup( 257, wsaData );
  Result := GetHostByName( nil )^.h_name;
  WSACleanup;
end;

function NomeWindowsUser: string;
var
  nTam: Cardinal;
begin
  nTam := 256;
  SetLength( Result, nTam );
  GetUserName( PChar( Result ), nTam );
  SetLength( Result, nTam );
end;

function MudarPara800x600: Boolean;
var
  I      : Integer;
  DevMode: TDevMode;
begin
  I      := 0;
  Result := False;
  while EnumDisplaySettings(nil, I, DevMode) do
    with DevMode do
    begin
      if (dmPelsWidth = 800) and (dmPelsHeight = 600) and (dmBitsPerPel > 15) then
      begin
        ChangeDisplaySettings(DevMode,CDS_UPDATEREGISTRY);
        Result := True;
        Break;
      end;
      Inc(I);
    end;
end;

// Faz um REBOOT - Windows9x e NT
function Reboot: Boolean;
var
  pid, hToken: THandle;
  tmpLUID    : TLUIDAndAttributes;
  Tkp, NewTkn: TTokenPrivileges;
  BufLen     : DWORD;
begin
  Result := True;
  // Para 9x basta isto:
  if  Win32Platform <> VER_PLATFORM_WIN32_NT then
  begin
    ExitWindowsEx(EWX_REBOOT, 0);
    Exit;
  end;
  // Obtem o handle do processo atual
  pid := GetCurrentProcess;
  // Abre o token associado ao processo
  OpenProcessToken(pid, TOKEN_ADJUST_PRIVILEGES + TOKEN_QUERY, hToken);
  // Obter o identificador LUID que representa o privilegio
  LookupPrivilegeValue(nil, 'SeShutdownPrivilege', tmpLUID.LUID);
  with Tkp do
  begin
    PrivilegeCount           := 1;
    Privileges[0].LUID       := tmpLUID.LUID;
    Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  end;
  // Agora ajusta o privilegio para conseguir o reboot
  AdjustTokenPrivileges(hToken, False, Tkp, SizeOf(NewTkn), NewTkn, BufLen);
  // Aguarda 1 segundo para refresh
  Sleep(1000);
  if ExitWindowsEx(EWX_FORCE + EWX_REBOOT, 0) then Exit;
  Result := False;
end;

// A funcao abaixo devolve TRUE se a tecla passada com parametro estiver pressionada
// EX: if KeyPressed(VK_ALT) and KeyPressed(VK_CONTROL) then
// teclas control e alt pressionadas
function KeyPressed(const Vk: DWord): Boolean;
begin
  try
     Result := HiWord(GetKeyState(vk)) <> 0;
  except
    try
      Result := GetKeyState(vk) <> 0;
    except
      Result := False;
    end;
  end;
end;

function NumeroCoresWindows: Integer;
var
  h : hDC;
begin
  h := 0;
  try
    Result := 0;
    h      := GetDC( 0 );
    Result := 1 shl (GetDeviceCaps( h, PLANES ) * GetDeviceCaps( h, BITSPIXEL ) );
  finally
    ReleaseDC( 0, h );
  end;
  if Result = 1 then result := 32767;
end;

// 8 - 256, 16 = 16bit...
function NumeroBitsResolucao: Integer;
begin
  Result := GetDeviceCaps(getDC(0), BITSPIXEL);
end;

// Quanto tem de espaço livre no "C:" em MEGA. se tem menos que isso ou C: não existe volta 0
function HDLivreMb: Integer;
begin
  Result := (DiskFree(3) div 1000 div 1000);
end;

  //   //  ///////  //    //  ///////
  //  //   //        //  //   //    //
  /////    /////      ////    ///////
  //  //   //          //     //    //
  //   //  ///////     //     ///////

const
  KeyEventF_KeyDown = 0;

procedure PostVirtualKeyEvent(const Vk: Word; const fUp: Boolean);
var
  ScanCode: Byte;
const
  ButtonUp: array[Boolean] of Byte = (KeyEventF_KeyDown, KeyEventF_KeyUp);
begin
  ScanCode := MapVirtualKey(vk, 0);
  Keybd_Event(vk, ScanCode, ButtonUp[fUp], 0);
end;

// pressiona uma tecla e a mantém pressionada
procedure PressKey(const Key: Word);
begin
  PostVirtualKeyEvent(Key, False)
end;

// libera uma tecla pressionada
procedure ReleaseKey(const Key: Word);
begin
  PostVirtualKeyEvent(Key, True)
end;

{ Exemplo de ALT+ENTER:
  PressKey(Vk_Menu);
  SendKeys(#13);
  ReleaseKey(Vk_Menu);}
// envia uma sequencia de teclas
procedure SendKeys(const Keys: string);
var
  Loop: Byte;
begin
  for Loop := 1 to Length(Keys) do
  begin
    PostVirtualKeyEvent(Ord(Keys[Loop]), False);
    PostVirtualKeyEvent(Ord(Keys[Loop]), True);
  end;
  Application.ProcessMessages;
end;

  ///////   //////   ///////   //     ///   //////
  //       //    //  //    //  ////  ////  //
  ////     //    //  ///////   //////////   /////
  //       //    //  //    //  // //// //       //
  //        //////   //    //  //  //  //  //////

procedure SalvaForm(const Form: TCustomForm; SalvaPos: Boolean = True; SalvaSize: Boolean = True; SalvaState: Boolean = True);
var
  Chave: string;
begin
  Chave := 'SOFTWARE\Forms\' + Form.Name;
  if SalvaPos then
  begin
    GravaReg(Chave, 'Top'   , Form.Top );
    GravaReg(Chave, 'Left'  , Form.Left);
  end;

  if SalvaSize then
  begin
    GravaReg(Chave, 'Width' , Form.Width );
    GravaReg(Chave, 'Height', Form.Height);
  end;

  if SalvaState then
  begin
    case Form.WindowState of
      //wsMinimized: GravaReg(Chave, 'State', 'Min' ); .. não permite salvar mini...
      wsMaximized: GravaReg(Chave, 'State', 'Max' );
      wsNormal   : GravaReg(Chave, 'State', 'Nor' );
    end;
  end;
end;

procedure RestauraForm(Form: TCustomForm; RestPos: Boolean = True; RestSize: Boolean = True; RestState: Boolean = True; DefX: Integer = 0; DefY: Integer = 0);
var
  Chave: string;
  T, L : Integer;
  Stat : string;
begin
  Chave := 'SOFTWARE\Forms\' + Form.Name;
  if RestSize then
  begin
    Form.Width  := LerReg(Chave, 'Width' , Form.Width );
    Form.Height := LerReg(Chave, 'Height', Form.Height);
  end;

  if RestPos then
  begin
    if DefY = 0 then
      T := (Screen.Height div 2) - (Form.Height div 2)
    else
      T := DefY;

    if DefX = 0 then
      L := (Screen.Width  div 2) - (Form.Width  div 2)
    else
      L := DefX;
       
    Form.Top := LerReg(Chave, 'Top' , T);
    Form.Left:= LerReg(Chave, 'Left', L);
    // saiu da tela, default centro
    if (Form.Top + Form.Height > Screen.Height) or (Form.Left + Form.Width > Screen.Width) then
    begin
      Form.Top := T;
      Form.Left:= L;
    end;
  end;

  if RestState then
  begin
    Stat := LerReg(Chave, 'State', 'Nor' );
    if Stat = 'Max' then
      Form.WindowState := wsMaximized;
  end;
end;

// esta função deve ser coloca no keydown da form. faz o seguinte:
// caso pressionado ESC e o EditFoco estiver focado fecha a form. Caso
// contrário limpa todos as edits do array EditsClear e passa o foco para EditFoco.
// very simple, ah?
procedure VerificaEsc(var Key: Word; EditFoco: TCustomEdit; EditsClear: array of TComponent);
var
  I: Integer;
begin
  if Key <> 27 then Exit;
  Key := 0;
  if EditFoco.Focused then
    GetParentForm(EditFoco).Close
  else
  begin
    for I := Low( EditsClear ) to High( EditsClear ) do
      if (TComponent(EditsClear[I]) is TCustomEdit) then
        TCustomEdit(EditsClear[I]).Clear
      else
        if (TComponent(EditsClear[I]) is TCustomLabel) then
          TCustomLabel(EditsClear[I]).Caption := '';

    EditFoco.SetFocus;
  end;
end;

function LevelBDEOK: Boolean;
const
  Chave = 'SOFTWARE\Borland\Database Engine\Settings\DRIVERS\DBASE\TABLE CREATE';
var
  Reg: TRegistry;
  Lvl: Integer;
begin
  Lvl         := 0;
  Reg         := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey(Chave, True);

  if Reg.ValueExists('LEVEL') then
    Lvl := StrToIntDef(Reg.ReadString('LEVEL'), 0); // nao coloque READINTEGER aqui... Dá pau
  FreeAndNil(Reg);

  if Lvl = 0 then
    msgInforma('É necessário o BDE para a execução deste sistema!!')
  else
    if Lvl <> 5 then msgInforma('O Level do BDE está incorreto!');
  Result := (Lvl = 5);
end;

end.
