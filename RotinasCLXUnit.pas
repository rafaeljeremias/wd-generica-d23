unit RotinasCLXUnit;


interface

uses QDialogs, QControls, SysUtils;

// mensagens
procedure msgAlerta(const Texto: string);
procedure msgInforma(const texto: string);
procedure msgInformaAbort(const Condicao: Boolean; const Texto: string; Foca : TWidgetControl = nil);
procedure msgErro(const texto: String);
function msgConfirma(const Texto: string): Boolean;
//string
function Separa(const S: string; const Separador: Char; const Posicao: Integer): string;


implementation


// Separa( 'Flavio*de*Souza*Junior', '*', 1 ) = 'Flavio'
// Separa( 'Flavio*de*Souza*Junior', '*', 2 ) = 'de'
// Separa( 'Flavio*de*Souza*Junior', '*', 3 ) = 'Souza'
// Separa( 'Flavio*de*Souza*Junior', '*', 4 ) = 'Junior'
// Separa( 'Flavio*de*Souza*Junior', '*', 5 ) = ''
// Devolve o nº de vezes que separador ocorre em S
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



  //     ///  ///////  ///   //   //////   //////    //////   ///////  ///   //   //////
  ////  ////  //       ////  //  //       //    //  //        //       ////  //  //
  //////////  /////    // // //   /////   ////////  //  ////  /////    // // //   /////
  // //// //  //       //  ////       //  //    //  //    //  //       //  ////       //
  //  //  //  ///////  //   ///  //////   //    //   ///////  ///////  //   ///  //////

// Esta procedure exibe uma mensagem (alerta) para o usuário.
procedure msgAlerta(const texto: string);
begin
  MessageDlg(Texto, mtWarning, [mbOK], 0);
end;

procedure msgInforma(const texto: string);
begin
  MessageDlg(Texto, mtInformation, [mbOK], 0);
end;

procedure msgInformaAbort(const Condicao: Boolean; const Texto: string; Foca : TWidgetControl = nil);
begin
  if not Condicao then Exit;
  if Texto <> '' Then msgAlerta(Texto);
  if Assigned(Foca) then TWinControl(Foca).SetFocus;
  SysUtils.Abort;
end;

// Esta procedure exibe uma mensagem de erro para o usuário.
procedure msgErro(const texto: String);
begin
  MessageDlg(texto, mtError, [mbOK], 0);
end;

function msgConfirma(const Texto: string): Boolean;
begin
  Result := (MessageDlg(texto, mtConfirmation, [mbYes, mbNo], 0) = mrYes);
end;

end.
