UNIT AROTINASUNIT;
{$WARN SYMBOL_PLATFORM OFF}

interface

uses Windows, Graphics, Controls, Menus, Dialogs, Messages, SysUtils, StdCtrls, Classes, Math, Forms, DB, strUtils;

const
  clCinzaClaro    = $00E6E6E6;
  clAzulClaro     = $00FFE6E6;
  clVerdeClaro    = $00D9FFD9;
  clVermelhoClaro = $00E6E6FF;
  clAmareloClaro  = $00EEFFFF;
  clCorFoco       = clWindow;
  FontePadrao     = 'Courier New';
  // Teclas
  Vk_PgUp         = 33;
  Vk_PgDn         = 34;

  // Estas são os nomes das classes usadas internamente pelos proprios componentes
//  NomeClasseData  = 'TmlAData';       //!! Obsoleto
//  NomeClasseEdit  = 'TmlAEdit';       //!! Obsoleto
//  NomeClasseValor = 'TmlAValor';      //!! Obsoleto

type
  // Estes tipos são usados pelos componentes da Lib2000
  // Tipos
  TInputType    = (itNumeros, itDinheiro, itNormal, itLetras);  // Tipos de entrada: Numero = 0..9  |  Dinheiro = Numero + . e  |
  TCampoTipo    = (ctString, ctInteger, ctDouble, ctDate);      // Tipo de campo de vinculo    //!! Obsoleto
  TLabelVincPos = (lvTop, lvLeft);                              // Posicao da Label vinculada  //!! Obsoleto
  // Eventos
  THelpEvent    = procedure(Sender: TObject; const heTag, heHelpContext: Integer) of object;   //!! Obsoleto
  // Este evento é chamado ANTES de todo e qualquer alteração do campo lookup (DBEdit, LEdit)
  TLookupChange = procedure(Sender: TObject; var Text: string) of object;

  // usada pelo menuopcoes
  TSubMenu = record
    Name : string;
    Size : Integer;
    Style: TFontStyles;
    Color: TColor;
  end;

  // usado pelo DesenhaMenuItem
  TMenuOpcoes = record
    ItemAltura       : Integer;
    DegradeVisible   : Boolean;
    DegradeCorInicial: TColor;
    DegradeCorFinal  : TColor;
    DegradeTam       : Integer;
    DeslocaTextoX    : Integer;
    VertTextDeslocaX : Integer;
    VertText         : string;
    ItemFont         : TSubMenu;
    HotKeyFont       : TSubMenu;
    VertFont         : TSubMenu;
    SelecaoFont      : TSubMenu;
    SelecaoCor       : TColor;
    SelecaoHotKeyFont: TSubMenu;
  end;

var
  Vk_LastKey  : Word;  // contém a ultima tecla pressionada na tela de cadastro
  Vk_TabStatus: Word;  // (ControlPanel/Edit) controla o pressionamento de TAB e SHIFT-TAB
  MenuOpcoes  : TMenuOpcoes;

// rotinas para retorno condicionais
function IfThen(const Condicao: Boolean; const RTrue, RFalse: Double) : Double ; overload;
function IfThen(const Condicao: Boolean; const RTrue, RFalse: string) : string ; overload;
function IfThen(const Condicao: Boolean; const RTrue, RFalse: Integer): Integer; overload;
// rotinas para alinhamentos de string
function FormataCPFCNPJ(const s:string): string;
function AlinhaEsq(const Palavra:string; Tamanho: Integer; Caracter: char = #32)   : string;
function AlinhaDir(const Palavra:string; Tamanho: Integer; Caracter: char = #32)   : string;
function AlinhaCentro(const Palavra:string; Tamanho: Integer; Caracter: char = #32): string;
function RepeteStr(const expressao: string; const quantidade: Integer): string;
function Ocorre(const Palavra, Separador: string): Integer;
function NPos(const C: string; Texto: string; NPosicao: Integer): Integer;
function Separa(const S: string; const Separador: Char; const Posicao: Integer): string;
function StrTran(const Texto, Esta, PorEsta: string): string; // Troca no texto todas as ocorrencias de "Esta" por "Esta"
function StrZero(const valor: Double; const tamanho:Integer; decimais: Integer=0): String;
function StrZero2(const valor: Double; const tamanho:Integer; decimais: Integer=0; RemoveNegativo : Boolean = False): String;
function Formata(const Valor:Double; Formato: string = '#,##0.00'): string;
function FormataCEP(const Codigo: string): string;
function FormataCodigoBarrasPonto(const Codigo: string): string;
// para calculos
function Str2Float(const Valor: string)    : Double;
function Str2FloatAnsi(const Valor: string): string;
function SomenteNumeros(const Valor: string): string;
function FloatToAnsi(const Valor: Double): string;
function Trunca(const Valor:Double; Decimais:Integer = 2): Double;
function Arredonda(const Valor: Double; const Precisao: Word): Double;
function CompletaData(const Data: string)  : string;
function SetAjuste(const Data: TDateTime; const Dias: Integer; Meses: Integer = 0; Semanas: Integer = 0; Anos: Integer = 0): TDateTime;
// mensagens
procedure msgAlerta(const Texto: string);
procedure msgInforma(const texto: string);
procedure msgInformaAbort(const Condicao: Boolean; const Texto: string; Foca : TWinControl = nil);
procedure msgErro(const texto: String);
function msgConfirma(const Texto: string; FocoNao: Boolean = False): Boolean;
function Mensagem(Botoes: array of string; const Mensagem: string; BtnPadrao: Integer = 1;
                  Titulo: string = 'Confirmação'; TipoDlg: TMsgDlgType = mtConfirmation;
                  X: Integer = 0; Y: Integer = 0 ): Integer;
// hardware (tempo, processmessages)
function DoEvents: Boolean;
procedure Delay(const MSecs: Cardinal);
procedure BipErro(Velocidade: Integer = 50);
// rotinas para som speaker
procedure PlaySound(Freq: Word; const MSecs: Cardinal);
procedure Bip;
procedure SomOK;
procedure NoSound;
// rotinas graficas
function TamanhoIniciar: Integer;
procedure DesenhaDegrade(ACanvas: TCanvas; const X1, Y1, X2, Y2: Integer; CorInicial: TColor = clBlack; CorFinal: TColor = clBlue; Vertical: Boolean = False);
procedure DesenhaItemMenu(MenuItem: TMenuItem; ACanvas: TCanvas; ARect: TRect; const Selected: Boolean; const Op: TMenuOpcoes);
procedure ConverterTonsCinza(var Bitmap: TBitmap);
procedure EscreveDiagonal(const Texto: string; const X, Y: Integer; Angulo: Integer; Superficie: TCanvas;
                            Fonte: string = 'Tahoma'; Tamanho: Integer = 10);
// se retorna TRUE está ativado vários recursos para o programador
function FlagProgramador: Boolean;
// separa colunas para relatorio
procedure FormataColunas(Original, Resultado: TStrings; const Linhas, Colunas, TamanhoCol: Integer; Ajustar: Boolean = True);
// Consulta foreign keys
function AbreConsultaForm(const TipoForm: TComponentClass; Form: TCustomForm; const origem: array of string; const destino: array of TField; Criar : Boolean = True; cd_usuario : integer =0; menu : String = ''): boolean;
function AbreConsultaFormEdit(const TipoForm: TComponentClass; Form: TCustomForm; const origem: array of string; const destino: array of TEdit; Criar : boolean = True; cd_usuario : integer =0; menu : String = ''): boolean;
function numeroOrdinal( numero : Integer; sexo : String = 'M' ) : String;

implementation

uses ConsultaSimplesGenericaUnit;

// Edit
function AbreConsultaFormEdit(const TipoForm: TComponentClass; Form: TCustomForm; const origem: array of string; const destino: array of TEdit; Criar : boolean = True; cd_usuario : integer =0; menu : String = ''): boolean;
var
  i: integer;
begin
  result := false;
  if Length(origem) <> Length(destino) then exit;
  if Criar then
    Application.CreateForm(TipoForm, Form);
  if (Trim(menu)<> '') then
    TConsultaSimplesGenericaForm(TForm).SetPermissao(cd_usuario,menu);
  try
    with Form as TConsultaSimplesGenericaForm do
    begin
      SetSubConsulta(True);
      ShowModal;
      if Retornou then
      begin
        for i := 0 to High(origem) do
          destino[i].Text := CDSQy.FieldByName(origem[i]).AsString;
        result := true;
      end
    end;
  finally
    Form.Free;
  end;
end;

// Field
function AbreConsultaForm(const TipoForm: TComponentClass; Form: TCustomForm; const origem: array of string; const destino: array of TField; Criar : boolean = True; cd_usuario : integer =0; menu : String = ''): boolean;
var
  i: integer;
begin
  result := false;
  if Length(origem) <> Length(destino) then exit;
  if Criar then
    Application.CreateForm(TipoForm, Form);
  if (Trim(menu)<> '') then
    TConsultaSimplesGenericaForm(Form).SetPermissao(cd_usuario,menu);
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
        result := true;
      end
    end;
  finally
    Form.Free;
  end;
end;




   //////  ////////  ///////   //  ///   //   //////
  //          //     //    //  //  ////  //  //
   /////      //     ///////   //  // // //  //  ////
       //     //     //    //  //  //  ////  //    //
  //////      //     //    //  //  //   ///   ///////


function IfThen(const Condicao: Boolean; const RTrue, RFalse: string): string; overload;
begin
  if Condicao then Result := RTrue else Result := RFalse;
end;

function IfThen(const Condicao: Boolean; const RTrue, RFalse: Integer): Integer; overload;
begin
  if Condicao then Result := RTrue else Result := RFalse;
end;

function IfThen(const Condicao: Boolean; const RTrue, RFalse: Double): Double; overload;
begin
  if Condicao then Result := RTrue else Result := RFalse;
end;

{ O nome da função já diz tudo caso você se pergunte cade o comentário}
function FormataCPFCNPJ(const s:string): string;
begin
  result := s;
  if Length(s) = 14 then
  begin
    Insert('-',result,13);
    Insert('/',result,9);
    Insert('.',result,6);
    Insert('.',result,3);
  end;
  if Length(s) = 11 then
  begin
    Insert('-',result,10);
    Insert('.',result,7);
    Insert('.',result,4);
  end;
end;

function FormataCEP(const Codigo: string): string;
begin
  result := Codigo;
  Insert('.', result, 3);
  Insert('-', result, 7);
end;
{
Estas tres funcoes abaixo tem grande utilitade ao usar texto mono-espacado.
Ex:       S := AlinhaEsq('GRUPO',30,'.');
Devolve:  S = 'GRUPO.......................'; //25 pontos
Ex2:      s := AlinhaDir('1.345,40,10,' ');
Devolve:  S = '  1.345,40'; // Poe espacos em branco na frente
Ex3:      S := AlinhaCentro('1234567890',30,'-');
Devolve   S = '----------1234567890----------'; // Centraliza
}
function AlinhaEsq(const Palavra:string; Tamanho: Integer; Caracter: char = #32):String;
var
  S:String;
  I:Integer;
begin
  S := Palavra;
  For I:=1 to (Tamanho-Length(Palavra)) do S := S + Caracter;
  // Se a palavra for maior que tamanho corta
  If Length(Palavra) > Tamanho then Delete(S,Tamanho+1,Length(Palavra)-Tamanho);
  Result := S;
end;

function AlinhaDir(const Palavra:string; Tamanho: Integer; Caracter: char = #32):String;
var
  S:String;
  I:Integer;
begin
  S := Palavra;
  For I:=1 to (Tamanho-Length(Palavra)) do S := Caracter + S;
  // Se a palavra for maior que tamanho corta
  If Length(Palavra) > Tamanho then Delete(S,Tamanho+1,Length(Palavra)-Tamanho);
  Result := S;
end;

function AlinhaCentro(const Palavra:string; Tamanho: Integer; Caracter: char = #32):String;
var
  S: string;
  I: Integer;
begin
  S := Palavra;
  I := 0;
  // Coloca o caracter na frente e atrás
  while Length(S) < Tamanho do
  begin
    Inc(I);
    if Odd(I) then S := S + Caracter else S := Caracter + S;
  end;
  // Se a Palavra for maior tira na frente e atras
  while Length(S) > Tamanho do
  begin
    Inc(I);
    if Odd(I) then Delete(S,1,1) else Delete(S,Length(S),1);
  end;
  Result := S;
end;

function RepeteStr(const expressao: string; const quantidade: Integer): string;
var
  a: Integer;
begin
  Result := '';
  for a := 1 to quantidade do Result := Result + expressao;
end;

function Ocorre(const Palavra, Separador: string): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(Palavra) do If Copy(Palavra,I,Length(Separador))=Separador then Inc(Result);
end;

// igual ao POS, porém pode-se escolher qual ocorrencia da string...
function NPos(const C: string; Texto: string; NPosicao: Integer): Integer;
var
  I, P, K: Integer;
begin
  Result := 0;
  K := 0;
  for I := 1 to NPosicao do
  begin
    P := Pos(C, Texto);
    Inc(K, P);
    if (I = NPosicao) and (P > 0) then
    begin
      Result := K;
      Exit;
    end;
    if P > 0 then Delete(Texto, 1, P) else Exit;
  end;
end;


function Separa(const S: string; const Separador: Char; const Posicao: Integer): string;
var
  I, Contador, P: Integer;
begin
  Result := '';
  P      := Posicao;
  if (P < 1) then P := 1;
  Contador := 1;
  for I := 1 to Length(S) do
    if S[I] = Separador then
    begin
      if Contador = P then Break;
      Inc(Contador);
      Result := '';
    end
    else Result := Result + S[I];
  if P > Contador then Result := '';
end;

function StrTran(const Texto, Esta, PorEsta: string): string;
var
  I     : Integer;
  Source: string;
begin
  Source := Texto;
  Result := '';
  repeat
    I := Pos(Esta, Source);
    if I > 0 then begin
      Result := Result + Copy(Source, 1, I - 1) + PorEsta;
      Source := Copy(Source, I + Length(Esta), MaxInt);
    end
    else Result := Result + Source;
  until I <= 0;
end;

function StrZero(const valor: Double; const tamanho:Integer; decimais: Integer=0): String;
begin
  // Para números inteiros: Format('%.' + Tamanho + 'd', [Valor])  (é quase a mesma performance, pois o FORMAT é lento tambem)
  Result := StrTran(Format('%.' + IntToStr(decimais) + 'f', [valor]), '-', '');
  Result := RepeteStr('0', tamanho - Length(Result)) + Result;
end;

function StrZero2(const valor: Double; const tamanho:Integer; decimais: Integer=0; RemoveNegativo : Boolean = False): String;
begin
  Result := StrTran(Format('%.' + IntToStr(decimais) + 'f', [valor]), '-', '');
  Result := RepeteStr('0', Tamanho - Length(Result)) + Result;

  if (not RemoveNegativo) and (Valor < 0) then
    Result := '-' + Copy(Result,2,Length(Result));
end;

function Formata(const Valor:Double; Formato: string = '#,##0.00'): string;
begin
  Result := FormatFloat(Formato, Valor);
end;

// entra:     7894561231023
// sai  : 789.456.123.102.3
function FormataCodigoBarrasPonto(const Codigo: string): string;
var
  X, I: Integer;
begin
  X := 0;
  Result := '.' + Copy(Codigo, Length(Codigo), 1);
  for I := Length(Codigo)-1 downto 1 do
  begin
    Result := Codigo[I] + Result;
    Inc(X);
    if X = 3 then
    begin
      Result := '.' + Result;
      X := 0;
    end;
  end;
  if Copy(Result,1,1) = '.' then Delete(Result,1,1);
end;

   //////   //////   //       //////  //    //  //       //////    //////
  //       //    //  //      //       //    //  //      //    //  //
  //       ////////  //      //       //    //  //      //    //   /////
  //       //    //  //      //       //    //  //      //    //       //
   //////  //    //  //////   //////   //////   //////   //////   //////

// soma dias, meses, semanas e anos a uma data
function SetAjuste(const Data: TDateTime; const Dias: Integer; Meses: Integer = 0; Semanas: Integer = 0; Anos: Integer = 0): TDateTime;
begin
  if Data = 0 then Result := Date else Result := Data;
  Result := Result + Dias;               // soma dias
  Result := IncMonth(Result, Meses);     // soma meses
  Result := Result + (Semanas * 7);      // soma semanas
  Result := IncMonth(Result, Anos * 12); // soma anos
end;

// entra "01/  /" --> sai "01/[mes atual]/[ano atual]"
// entra "01/04/" --> sai "01/05/[ano atual]"
function CompletaData(const Data: string): string;
var
  AnoAtual, MesAtual: string;
  Ano               : integer;
begin
  if (Length(Data) < 10) or (Trim(Data) = '/  /') then
  begin
    Result := DateToStr(Date);
    Exit;
  end;

  Result := Data;
  // a data está incompleta? preenche com valores padrão.
  if StrToIntDef( Copy( Data, 1, 2 ), 0 ) <> 0 then
  begin
    AnoAtual := FormatDateTime('YYYY', Now);
    if StrToIntDef( Copy( Data, 4, 2 ), 0 ) = 0 then // não tem mes?
    begin
      MesAtual := FormatDateTime('MM', Now);
      Result := Copy(Data,1,3) + MesAtual + DateSeparator + AnoAtual;  // seta mes e ano atual
    end
    else
    begin
      Ano := StrToIntDef( trim(Copy( Data, 7, 4 )), 0 );
      if (Ano = 0) and (Pos('00',Copy(Data,7,4)) = 0) then // não tem ano E não tem digitado "00" no ano?
        Result := Copy(Data,1,6) + AnoAtual // seta ano atual.
      else
        if Ano < 999 then
          Result := Copy(Data,1,6) + IntToStr(ARotinasUnit.IfThen(Ano < 50,Ano + 2000,Ano + 1900));
    end;
  end;
end;

function Str2Float(const Valor: string): Double;
var
  S       : string;
  Negativo: Boolean;
  I       : Integer;
begin
  Result   := 0;
  Negativo := ((Pos('(',Valor) > 0) and (Pos(')',Valor) > 0)) or (Pos('-',Valor) > 0);
  S := Trim(Valor); // tira brancos

  for I := Length(S) downto 1 do
    if not (S[I] in ['0'..'9', DecimalSeparator]) then Delete(S,I,1); // se não for um destes, limpa!
  // se aqui já estiver vazio, cai fora...
  if S = '' then Exit;
  if Negativo then S := '-' + S;
  TryStrToFloat(S, Result);
end;

// Esta tras result para usar em SQL:
function Str2FloatAnsi(const Valor: string): string;
begin
  Result := StrTran( FloatToStr(Str2Float(Valor)), DecimalSeparator, '.'); // Retorna para o SQL
end;

function FloatToAnsi(const Valor: Double): string;
begin
  Result := StrTran(FloatToStr(Valor), ThousandSeparator, '');
  if DecimalSeparator <> '.' then
    Result := StrTran(Result, DecimalSeparator, '.');
end;

// remove todos os caracteres da string deixando só numeros
function SomenteNumeros(const Valor: string): string;
var
  S : string;
  I : Integer;
begin
  S := Trim(Valor); // tira brancos
  for I := Length(S) downto 1 do
    if not (S[I] in ['0'..'9', DecimalSeparator]) then Delete(S,I,1); // se não for um destes, limpa!
  Result := S;
end;

// Literalmente trunca o valor double.
// Exemplo:  Trunca( 12.596   ) ===>  12.59
//           Trunca( -3.09945 ) ===>  -3.09
//           Trunca( 6.1      ) ===>  6.1
function Trunca(const Valor:Double; Decimais:Integer = 2): Double;
var
  I, C  : Integer;
  S, S2 : string;
  V     : Boolean;
begin
  S := FloatToStr(Valor);
  C := 0; V := False;
  for I := 1 to Length(S) do
  begin
    if not V then V := S[I] = ',';
    S2 := S2 + S[I];
    if V then Inc(C);
    if C > Decimais then Break;
  end;
  Result := StrToFloat(S2);
end;

// A função Arredonda permite ajustar o valor de um Float para a precisão desejada.
// Por exemplo: Arredonda(14.4563, 2)    = 14.46
//              Arredonda(123.324156, 2) = 123.32
// Atenção! O argumento Precisão deve ser um número maior ou igual a zero ou será ignorado.
function Arredonda(const Valor: Double; const Precisao: Word): Double;
var
  Atual, M: Double;
begin
  if Precisao > 0 then M := Precisao else M := 0;
  Atual  := Valor - Int(Valor);
  Atual  := Round(Atual * Power(10, M)) / Power(10, M);
  Result := Atual + Int(Valor);
end;

  //     ///  ///////  ///   //   //////   //////    //////   ///////  ///   //   //////
  ////  ////  //       ////  //  //       //    //  //        //       ////  //  //
  //////////  /////    // // //   /////   ////////  //  ////  /////    // // //   /////
  // //// //  //       //  ////       //  //    //  //    //  //       //  ////       //
  //  //  //  ///////  //   ///  //////   //    //   ///////  ///////  //   ///  //////

// Esta procedure exibe uma mensagem (alerta) para o usuário.
procedure msgAlerta(const texto: string);
begin
  MessageBeep(MB_ICONEXCLAMATION);
  MessageDlg(Texto, mtWarning, [mbOK], 0);
//  Application.MessageBox( texto,  'Alerta', MB_YESNO + MB_ICONINFORMATION );
end;

procedure msgInforma(const texto: string);
begin
  MessageBeep(MB_ICONASTERISK);
  MessageDlg(Texto, mtInformation, [mbOK], 0);
//  Application.MessageBox( texto,  'Informação', MB_YESNO + MB_ICONASTERISK );
end;

procedure msgInformaAbort(const Condicao: Boolean; const Texto: string; Foca : TWinControl = nil);
begin
  if not Condicao then Exit;
  MessageBeep(MB_ICONQUESTION);
  if Texto <> '' Then msgAlerta(Texto);
  if Assigned(Foca) then TWinControl(Foca).SetFocus;
  SysUtils.Abort;
end;

// Esta procedure exibe uma mensagem de erro para o usuário.
procedure msgErro(const texto: String);
begin
  MessageBeep(MB_ICONHAND);
  MessageDlg(texto, mtError, [mbOK], 0);
//  Application.MessageBox( texto,  'Erro', MB_OK + MB_ICONHAND );
end;

function msgConfirma(const Texto: string; FocoNao: Boolean = False): Boolean;
begin
  MessageBeep(MB_ICONQUESTION);
  if FocoNao then Keybd_Event(Vk_Right, 0, 0, 0);
  Result := (MessageDlg(texto, mtConfirmation, [mbYes, mbNo], 0) = mrYes);
//  Result := ( Application.MessageBox( texto, 'Confirmação', mbYesNo + MB_ICONQUESTION ) = mrYes);

end;

// Função utilizada para criar mensagens personalizadas.
// Ex.:   Mensagem(['Ok'],'Esta é uma janela de testes');
//        Mensagem(['Não copiar','Copiar'],'Copiar arquivo?', 'Atenção!',2);
// Retorna
// 1 - 1º botão. 2 - 2º botao ... 0 - ALT+F4 ou X
// O ESC não fecha porque eu não uso mrCancel - sem ele NEM a MessageDlg não fecha.
// Todos os parametros, exceto os botões são default.
function Mensagem(Botoes        : array of string;
                  const Mensagem: string;
                  BtnPadrao     : Integer     = 1;
                  Titulo        : string      = 'Confirmação';
                  TipoDlg       : TMsgDlgType = mtConfirmation;
                  X             : Integer = 0;
                  Y             : Integer = 0 ): Integer;
var
  Bt  : TMsgDlgButtons;
  Btxt: array[3..8] of ShortString; // Nao foi usado de 1..4 pois o "X" ou ALT+F4 = 2
  I, C: Integer;
begin
  if Length(Botoes) > 6 then
  begin
    Result := 0;
    msgErro('Máximo 6 botões!');
    Exit;
  end;
  for I := 3 to 8 do Btxt[I] := '';                                 // Zera var interna
  for I := Low(Botoes) to High(Botoes) do Btxt[I + 3] := Botoes[I]; // Adiciona captions na var
  Bt := [];
  for I := 3 to 5 do
    if Btxt[I] <> '' then Bt := Bt + [TMsgDlgBtn(I + 1)]; // Coloca na BT os botões do tipo mb...
  // estes foram usados devido ao retorno do botão (que a partir do 6º nao segue a sequencia)
  if BTxt[6] <> '' then Bt := Bt + [mbAll     ];
  if BTxt[7] <> '' then Bt := Bt + [mbNoToAll ];
  if BTxt[8] <> '' then Bt := Bt + [mbYesToAll];

  with CreateMessageDialog(Mensagem, TipoDlg, Bt) do // Cria MessageDlg
  try
    if X > 0 then Top := X;
    if Y > 0 then Left:= Y;
    Caption := Titulo; // Define o caption
    for I := 0 to ComponentCount - 1 do // Corre todos os seus componentes.
      if Components[I] is TButton then // Se for botão...
      begin // Caso o modal result dele é o mesmo do que foi criado, muda o caption
        C := TButton(Components[I]).ModalResult;
        if C = mrAll      then C := 6;
        if C = mrNoToAll  then C := 7;
        if C = mrYesToAll then C := 8;
        TButton(Components[I]).Caption := BTxt[ C ];
        // Seta o botão padrão
        if (BtnPadrao + 2) = TButton(Components[I]).ModalResult then ActiveControl := TButton(Components[I]);
      end;

    Result := ShowModal;
    // Caso pressionado ESC ou X ou ALT+F4 então devolve "0" senão devolve 1 para 1ª botão, 2 para 2ª...
         if Result = 2          then Result := 0
    else if Result = mrAll      then Result := 4 // Se foi mrAll   =  6 fica sendo 4
    else if Result = mrNoToAll  then Result := 5 // Se foi mrNoAll =  9 fica sendo 5
    else if Result = mrYesToAll then Result := 6 // Se foi mrNoAll = 10 fica sendo 6
    else Result := Result - 2;
  finally
    Free;
  end;
end;

  //   //   //////   ///////   ///////   //  //  //   //////   ///////   ///////
  //   //  //    //  //    //  //    //  // //// //  //    //  //    //  //
  ///////  ////////  ///////   //    //  //////////  ////////  ///////   /////
  //   //  //    //  //    //  //    //  ////  ////  //    //  //    //  //
  //   //  //    //  //    //  ///////   //      //  //    //  //    //  ///////

// Esta rotina substitui o Application.ProcessMessages...
function DoEvents: Boolean;
var
  msg: TMsg;
begin
  while PeekMessage(msg, 0, 0, 0, PM_REMOVE) do
    if msg.message = WM_QUIT then
    begin
      PostQuitMessage(msg.wParam);
      Result := True;
      Exit;
    end
    else
    begin
      TranslateMessage(msg);
      DispatchMessage(msg);
    end;
  Result := false;
end;

   //////   //////   //     ///
  //       //    //  ////  ////
   /////   //    //  //////////
       //  //    //  // //// //
  //////    //////   //  //  //

// Inicio PlaySound
// Rotina usada pela PlaySound
procedure SetPort(address, value: Word);
var
  bValue: Byte;
begin
  bValue := trunc(value and 255);
  asm
    mov DX, address
    mov AL, bValue
    out DX, AL
  end;
end;

// Rotina usada pela PlaySound
function GetPort(address: Word): Word;
var
  bValue: Byte;
begin
  asm
    mov DX, address
    in  AL, DX
    mov bValue, AL
  end;
  result := bValue;
end;

// Toca um som no speaker
procedure PlaySound(Freq: Word; const MSecs: Cardinal);
var
  B, wValue : Word;
  F         : Cardinal;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
     // No windows 2000 da bug
    Windows.Beep(Freq,MSecs);
    Exit;
  end;

   if Freq > 18 then
   begin
     Freq := Word(1193181 div LongInt(Freq));
     B    := GetPort($61);
     if (B and 3) = 0 then
     begin
       SetPort($61, B or 3);
       SetPort($43, $B6);
     end;
     SetPort($42, Freq);
     SetPort($42, (Freq SHR 8));
   end;

   F := GetTickCount;
   repeat
     DoEvents;
   until (GetTickCount-F >= MSecs);

   wValue := GetPort($61);
   wValue := wValue and $FC;
   SetPort($61, wValue);
end;

procedure Bip;
begin
  PlaySound(2000,100);
end;

procedure SomOK;
begin
  PlaySound(2000,85);
  Delay(50);
  PlaySound(2000,85);
end;

// Interrompe um som emitido pela PlaySound
procedure NoSound;
var
  wValue: Word;
begin
  wValue := GetPort($61);
  wValue := wValue and $FC;
  SetPort($61, wValue);
end;

procedure Delay(const MSecs: Cardinal);
var
  FirstTickCount: Cardinal;
begin
  FirstTickCount := GetTickCount;
  repeat
    DoEvents;
  until ((GetTickCount - FirstTickCount) >= MSecs);
end;

procedure BipErro(Velocidade: Integer = 50);
begin
  if FlagProgramador then
  begin
    MessageBeep(16);
    Exit;
  end;
  PlaySound(1000,220); Delay(Velocidade);
  PlaySound(1000,220); Delay(Velocidade);
  PlaySound(1000,220);
end;

// Final PlaySound

   //////   ///////    //////   ///////  //   //////   //////
  //        //    //  //    //  //       //  //       //    //
  //  ////  ///////   ////////  ////     //  //       //    //
  //    //  //    //  //    //  //       //  //       //    //
   ///////  //    //  //    //  //       //   //////   //////

// tamanho da barra do iniciar
function TamanhoIniciar: Integer;
var
  Rc : TRect;
begin
  GetWindowRect( FindWindow( 'Shell_TrayWnd', nil ), Rc );
  Result := Rc.Bottom - Rc.Top;
end;

// Função GradientFill usada pelo DesenhaDegrade
function GradientFill(Handle: HDC; pVertex: Pointer; dwNumVertex: DWORD; pMesh: Pointer;  dwNumMesh: DWORD;
                      dwMode: DWORD): DWORD; stdcall; external 'msimg32.dll';

procedure DesenhaDegrade(ACanvas: TCanvas; const X1, Y1, X2, Y2: Integer; CorInicial: TColor = clBlack; CorFinal: TColor = clBlue; Vertical: Boolean = False);
type
  _TRIVERTEX = packed record
    X, Y : DWord;
    Red, Green, Blue, Alpha: Word;
  end;
var
  udtVertex   : array [0..1] of _TRIVERTEX;
  RectGradient: TGradientRect;
begin
  with udtVertex[0] do
  begin
    X     := X1;
    Y     := Y1;
    Red   := GetRValue( CorInicial ) * $100;
    Green := GetGValue( CorInicial ) * $100;
    Blue  := GetBValue( CorInicial ) * $100;
    Alpha := 0;
  end;

  with udtVertex[1] do
  begin
    X     := X2;
    Y     := Y2;
    Red   := GetRValue( CorFinal ) * $100;
    Green := GetGValue( CorFinal ) * $100;
    Blue  := GetBValue( CorFinal ) * $100;
    Alpha := $0000;
  end;

  RectGradient.UpperLeft  := 0;
  RectGradient.LowerRight := 1;

  if Vertical then
    GradientFill(ACanvas.Handle, @udtVertex, 2, @RectGradient, 1, GRADIENT_FILL_RECT_V)
  else
    GradientFill(ACanvas.Handle, @udtVertex, 2, @RectGradient, 1, GRADIENT_FILL_RECT_H);
end;

procedure EscreveDiagonal(const Texto: string; const X, Y: Integer; Angulo: Integer; Superficie: TCanvas;
                          Fonte: string = 'Tahoma'; Tamanho: Integer = 10);
var
  lf        : TLogFont;
  tf        : TFont;
  OldBkMode : integer;
begin
  with Superficie do
  begin
    Font.Name := Fonte;
    Font.Size := Tamanho;
    tf := TFont.Create;
    tf.Assign(Font);
    GetObject(tf.Handle, sizeof(lf), @lf);
    lf.lfEscapement  := Angulo * 10;
    lf.lfOrientation := Angulo * 10;
    tf.Handle := CreateFontIndirect(lf);
    Font.Assign(tf);
    tf.Free;
    OldBkMode := SetBkMode(Handle, TRANSPARENT);  // <------ isto faz ficar transparente o text
    TextOut(X, Y, Texto);
    SetBkMode(Handle, OldBkMode);                 // <------ isto faz o texto voltar ao normal
  end;
end;

procedure ConverterTonsCinza(var Bitmap: TBitmap);
var
  P      : ^TRGBTriple;
  C, X, Y: Integer;
begin
  Bitmap.PixelFormat := pf24Bit;
  for y := 0 to Bitmap.Height-1 do
  begin
    P := Bitmap.ScanLine[y];
    for x := 0 to Bitmap.Width-1 do
    begin
      C := Round((0.30 * P.rgbtRed) + (0.59 * P.rgbtGreen) + (0.11 * P.rgbtBlue));
      P.rgbtRed   := C;
      P.rgbtGreen := C;
      P.rgbtBlue  := C;
      Inc(p);
    end;
  end;
end;

procedure DesenhaItemMenu(MenuItem: TMenuItem; ACanvas: TCanvas; ARect: TRect; const Selected: Boolean; const Op: TMenuOpcoes); // estes é passado conforme recebido no OnDrawItem
var
  Text                 : string;
  Posicao, Altura, X, Y: Integer;
  Bitm                 : TBitmap;
begin
  // desloca o ARect 20 pixels para direita (por causa do degrade)
  if Op.DegradeVisible then OffsetRect(ARect, Op.DegradeTam + 1, 0);

  // tira do caption o "&"
  Text    := MenuItem.Caption;
  Posicao := Pos('&', Text);
  Text    := StrTran(Text, '&', '');

  // cores padrão
  ACanvas.Brush.Color := clMenu;
  ACanvas.Font.Name   := Op.ItemFont.Name;
  ACanvas.Font.Size   := Op.ItemFont.Size;
  ACanvas.Font.Color  := Op.ItemFont.Color;
  ACanvas.Font.Style  := Op.ItemFont.Style;

  X := MenuItem.Bitmap.Width; // largura do bitmap

  if Selected then  // cores selecionado
  begin
    ACanvas.Font.Name   := Op.SelecaoFont.Name;
    ACanvas.Font.Size   := Op.SelecaoFont.Size;
    ACanvas.Font.Color  := Op.SelecaoFont.Color;
    ACanvas.Font.Style  := Op.SelecaoFont.Style;
    ACanvas.Brush.Color := Op.SelecaoCor;
  end;
  ACanvas.FillRect(ARect); // Preenche o fundo

  {if (MenuItem.Count > 0) and (Selected) then  // desenha triangulo caso tenha sub-itens
  begin
    ACanvas.Brush.Color := clBlack;
    ACanvas.Pen.Color   := clBlack;
    Y := ARect.Top + ((Op.ItemAltura div 2) - (ACanvas.TextHeight( 'X' ) div 2));
    X := ARect.Left + X + Op.DeslocaTextoX + ACanvas.TextWidth(Text) + 4;

    ACanvas.MoveTo(X, Y - 2);
    ACanvas.LineTo(X + 4, Y + 7);
    ACanvas.LineTo(X, Y + 12);

    ACanvas.Brush.Color := Op.SelecaoCor;
  end; }

  // Calcula posicao vertical do caption (no meio)
  Y := ARect.Top + ((Op.ItemAltura div 2) - (ACanvas.TextHeight( Text ) div 2));
  if not MenuItem.Enabled then
  begin
    ACanvas.Font.Color  := clWhite;
    ACanvas.Brush.Style := bsClear;
    ACanvas.TextRect(ARect, ARect.Left + X + Op.DeslocaTextoX + 1, Y + 1, Text);
    ACanvas.Font.Color  := clGray;
  end;

  ACanvas.TextRect(ARect, ARect.Left + X + Op.DeslocaTextoX, Y, Text);

  // Desenha letra em destaque
  if MenuItem.Enabled then
    if Selected then
    begin
      ACanvas.Font.Name  := Op.SelecaoHotKeyFont.Name;
      ACanvas.Font.Size  := Op.SelecaoHotKeyFont.Size;
      ACanvas.Font.Color := Op.SelecaoHotKeyFont.Color;
      ACanvas.Font.Style := Op.SelecaoHotKeyFont.Style;
    end
    else
    begin
      ACanvas.Font.Name  := Op.HotKeyFont.Name;
      ACanvas.Font.Size  := Op.HotKeyFont.Size;
      ACanvas.Font.Color := Op.HotKeyFont.Color;
      ACanvas.Font.Style := Op.HotKeyFont.Style;
    end;

  ACanvas.TextOut(ARect.Left + X + Op.DeslocaTextoX + ACanvas.TextWidth(Copy(Text, 1, Length(Copy(Text,1, Posicao)) - 1)),
                  Y, Copy(Text, Posicao, 1));

  // desenha bitmap
  if MenuItem.Bitmap <> nil then
    if MenuItem.Enabled then
      ACanvas.Draw(ARect.Left + 2, ARect.Top + 1, MenuItem.Bitmap)
    else
    begin
      Bitm := TBitmap.Create;
      Bitm.Assign(MenuItem.Bitmap);
      ConverterTonsCinza(Bitm);
      ACanvas.Draw(ARect.Left + 2, ARect.Top + 1, Bitm);
      Bitm.Free;
    end;

  // Se o degrade estiver habilitado e for o ultimo item desenha degrade.
  if (Op.DegradeVisible) and (MenuItem.MenuIndex = MenuItem.Parent.Count-1) then
  begin
    Altura := 0;
    // Calcula a altura do menu
    for Y := 0 to MenuItem.Parent.Count - 1 do
      if (MenuItem.Parent.Items[Y].Visible) then
        if (MenuItem.Parent.Items[Y].Caption = '-') then Inc(Altura, 8) else Inc(Altura, Op.ItemAltura);

    DesenhaDegrade(ACanvas, 0, 0, Op.DegradeTam, Altura, Op.DegradeCorInicial, Op.DegradeCorFinal, True);
    // escreve sobre o degrade
    ACanvas.Font.Name := Op.VertFont.Name;
    ACanvas.Font.Size := Op.VertFont.Size;
    ACanvas.Font.Color:= Op.VertFont.Color;
    ACanvas.Font.Style:= Op.VertFont.Style;
    EscreveDiagonal(Op.VertText, (Op.DegradeTam div 2) - (ACanvas.TextHeight( Op.VertText ) div 2) - 1 + Op.VertTextDeslocaX,
                                    Altura - 6, 90, ACanvas, Op.VertFont.Name, Op.VertFont.Size);
  end;
end;

function FlagProgramador: Boolean;
begin
  Result := FileExists('C:\FLAG.TXT');
end;

function numeroOrdinal( numero : Integer; sexo : String = 'M' ) : String;
var numero_str : string;
    a, b, c : integer;
begin

  result := '';

  numero_str := FormatFloat( '####', numero  );

  a := length( numero_str );

  b := a;

  c := 1;

  if b = 4 then
    result := 'milésimo'
  else
  begin
    repeat
      if b = 3 then
      begin
        if numero_str[c] = '1' then result := result + 'centésimo ';
        if numero_str[c] = '2' then result := result + 'ducentésimo ';
        if numero_str[c] = '3' then result := result + 'trecentésima ';
        if numero_str[c] = '4' then result := result + 'quadragésimo ';
        if numero_str[c] = '5' then result := result + 'qüingentésimo ';
        if numero_str[c] = '6' then result := result + 'sexcentésimo ';
        if numero_str[c] = '7' then result := result + 'septigentésimo ';
        if numero_str[c] = '8' then result := result + 'octingentésimo ';
        if numero_str[c] = '9' then result := result + 'noningentésimo ';
      end;
      if b = 2 then
      begin
        if numero_str[c] = '1' then result := result + 'décimo ';
        if numero_str[c] = '2' then result := result + 'vigésimo ';
        if numero_str[c] = '3' then result := result + 'trigésimo ';
        if numero_str[c] = '4' then result := result + 'quadragésimo ';
        if numero_str[c] = '5' then result := result + 'qüinquagésimo ';
        if numero_str[c] = '6' then result := result + 'sexagésimo ';
        if numero_str[c] = '7' then result := result + 'septuagésimo ';
        if numero_str[c] = '8' then result := result + 'octogésimo ';
        if numero_str[c] = '9' then result := result + 'nonagésimo ';
      end;
      if b = 1 then
      begin
        if numero_str[c] = '1' then result := result + 'primeiro';
        if numero_str[c] = '2' then result := result + 'segundo';
        if numero_str[c] = '3' then result := result + 'terceiro';
        if numero_str[c] = '4' then result := result + 'quarto';
        if numero_str[c] = '5' then result := result + 'quinto';
        if numero_str[c] = '6' then result := result + 'sexto';
        if numero_str[c] = '7' then result := result + 'sétimo';
        if numero_str[b] = '8' then result := result + 'oitavo';
        if numero_str[c] = '9' then result := result + 'nono';
        result := trim( result );
        if sexo = 'F' then result[length(result)] := 'a';
      end;
      inc( c );
      dec( b );
    until c > a;
    if sexo = 'F' then result := AnsiReplaceText( result, 'eiro', 'eira' );
    if sexo = 'F' then result := AnsiReplaceText( result, 'cimo', 'cima' );
    if sexo = 'F' then result := AnsiReplaceText( result, 'simo', 'sima' );
  end;
end;


// Recebe um StringList com valores sequenciais e separa nas Colunas pedidas pelo usuario com o determinado
// número de linhas. O Ajustar, se for FALSE ele repeita em primazia as linhas, senão ele respeita primeiro as colunas
procedure FormataColunas(Original, Resultado: TStrings; const Linhas, Colunas, TamanhoCol: Integer; Ajustar: Boolean = True);
var
  LimitCol, LimitLin, I, LinAtual, ColAtual, Offset, Itens_Restantes, Itens_Pagina: Integer;
  Original2: TStringList;
begin
  Original2 := TStringList.Create;
  // arruma os tamanhos da original
  for I := 0 to Original.Count-1 do
    Original2.Add( AlinhaEsq( Original[I], TamanhoCol ) );
  // só pra matar ratão...
  LimitCol := Colunas; if Colunas < 1 then LimitCol := 1;
  LimitLin := linhas;  if linhas  < 1 then LimitLin := 1;
  // então posso limpar a lista Resultado caso tenha algum lixo:
  Resultado.Clear;
  // inicializar umas variáveis...
  Offset       := 0;  // Numero da pagina
  LinAtual     := 0;
  ColAtual     := 0;
  Itens_Pagina := (LimitLin * LimitCol);
  // aí é só carregar a lista:
  for I := 0 to Original2.Count-1 do
  begin
    // Caso o numero de itens da ultima pagina for menor que o total de itens por pagina
    // ajusta o total de linhas para que os itens sejam alocados nas primeiras linhas da pagina
    if Ajustar then
    begin
      Itens_Restantes := (Original2.Count - (Offset * LimitCol));
      if Itens_Restantes < Itens_Pagina then
        LimitLin := Ceil(Itens_Restantes / LimitCol);
    end;
    // Caso ultrapasse o limite de linhas
    if LinAtual >= LimitLin then
      // Caso ultrapasse o limite de colunas
      if ColAtual = (LimitCol -1) then
      begin
        Offset := Offset + LimitLin;
        LinAtual := 0;
        ColAtual := 0;
      end
      else
      begin
        Inc(ColAtual);
        LinAtual := 0;
      end;

    if ColAtual = 0 then
    begin
      if (Offset > 0) and (LinAtual = 0) then Resultado.Add('');
      Resultado.Add('');
    end;
    Resultado[LinAtual + Offset] := Resultado[LinAtual + Offset] + Original2[I];
    Inc(LinAtual);
  end;
  Original2.Free;
end;

initialization

  // seta formatos de data
  ShortDateFormat := 'dd/MM/yyyy';
  LongDateFormat  := 'dd/MM/yyyy';

  // define as propriedades padrão para a var menuOpcoes usada pelo DesenhaMenuItem
  with MenuOpcoes do
  begin
    DeslocaTextoX    := 6;
    // Degrade
    DegradeVisible   := True;
    DegradeTam       := 18;
    DegradeCorInicial:= clBlack;
    DegradeCorFinal  := clBlue;
    // Fonte do item normal
    ItemAltura       := 20;
    ItemFont.Name    := 'Verdana';
    ItemFont.Size    := 8;
    ItemFont.Color   := clBlack;
    // Fonte dos hotkeys
    HotKeyFont.Name  := 'Verdana';
    HotKeyFont.Size  := 8;
    HotKeyFont.Color := clNavy;
    // Fonte do item selecionado
    SelecaoFont.Name := 'Verdana';
    SelecaoFont.Size := 8;
    SelecaoFont.Color:= clNavy;
    // Fonte do texto vertical
    VertText         := 'Menu';
    VertTextDeslocaX := 0;
    VertFont.Name    := 'Tahoma';
    VertFont.Size    := 10;
    VertFont.Color   := clWhite;
    VertFont.Style   := [fsBold];
    // Fonte do hotkey selecionado
    SelecaoCor       := clYellow;
    SelecaoHotKeyFont.Name  := 'Verdana';
    SelecaoHotKeyFont.Size  := 8;
    SelecaoHotKeyFont.Color := clNavy;
  end;

end.

