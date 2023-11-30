unit BematechUnit;

interface

uses Dialogs, Forms;

function Bematech_FI_LeituraX: Integer; StdCall; External 'BEMAFI32.DLL' ;
function Bematech_FI_ReducaoZ( Data: String; Hora: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_RetornoImpressora( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_AberturaDoDia( ValorCompra: string; FormaPagamento: string ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_Sangria( Valor: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_Suprimento( Valor: String; FormaPagamento: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_FechamentoDoDia: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_FechamentoDoDia';
function Bematech_FI_RelatorioGerencial( Texto: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_FechaRelatorioGerencial: Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_AbreCupom( CGC_CPF: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_VendeItem( Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_IniciaFechamentoCupom( AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_EfetuaFormaPagamento( FormaPagamento: String; ValorFormaPagamento: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_TerminaFechamentoCupom( Mensagem: String): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_CancelaItemGenerico( NumeroItem: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_CancelaCupom: Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_DataHoraImpressora( Data: String; Hora: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_NumeroSerie( NumeroSerie: String ): Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_NumeroCupom( NumeroCupom: String ): Integer; StdCall; External 'BEMAFI32.DLL';

procedure Analisa_iRetorno(iRetorno: Integer);
procedure Retorno_Impressora;

implementation

procedure Retorno_Impressora();
var
  iACK, iST1, iST2, iRetorno: Integer;
begin
  iACK := 0; iST1 := 0; iST2 := 0;
  iRetorno := Bematech_FI_RetornoImpressora( iACK, iST1, iST2 );
  if iACK = 21 Then
  begin
    MessageDlg('A Impressora retornou NAK. O programa ser� abortado!', mtError, [mbOk],0);
    Application.Terminate;
    Exit;
  end;
  if (iACK = 6) then
  begin
    // Verifica ST1
    if iST1 >= 128 then begin iST1 := iST1 - 128; Showmessage('ACK - ST1 - Fim do papel'); end;
    if iST1 >= 64  then begin iST1 := iST1 - 64;  Showmessage('ACK - ST1 - Pouco papel'); end;
    if iST1 >= 32  then begin iST1 := iST1 - 32;  Showmessage('ACK - ST1 - Erro no rel�gio'); end;
    if iST1 >= 16  then begin iST1 := iST1 - 16;  Showmessage('ACK - ST1 - Impressora em erro'); end;
    if iST1 >= 8   then begin iST1 := iST1 - 8;   Showmessage('ACK - ST1 - Comando n�o iniciado em ESC'); end;
    if iST1 >= 4   then begin iST1 := iST1 - 4;   Showmessage('ACK - ST1 - Comando inexistente'); end;
    if iST1 >= 2   then begin iST1 := iST1 - 2;   Showmessage('ACK - ST1 - Cupom aberto'); end;
    if iST1 >= 1   then begin iST1 := iST1 - 1;   Showmessage('ACK - ST1 - No. de par�metros inv�lido'); end;

    // Verifica ST2
    if iST2 >= 128 then begin iST2 := iST2 - 128; Showmessage('ACK - ST2 - Tipo de par�metro inv�lido'); end;
    if iST2 >= 64  then begin iST2 := iST2 - 64;  Showmessage('ACK - ST2 - Mem�ria fiscal Lotada'); end;
    if iST2 >= 32  then begin iST2 := iST2 - 32;  Showmessage('ACK - ST2 - CMOS n�o vol�til'); end;
    if iST2 >= 16  then begin iST2 := iST2 - 16;  Showmessage('ACK - ST2 - Al�quota n�o programada'); end;
    if iST2 >= 8   then begin iST2 := iST2 - 8;   Showmessage('ACK - ST2 - Al�quotas lotadas'); end;
    if iST2 >= 4   then begin iST2 := iST2 - 4;   Showmessage('ACK - ST2 - Cancelamento n�o permitido'); end;
    if iST2 >= 2   then begin iST2 := iST2 - 2;   Showmessage('ACK - ST2 - CGC/IE n�o programados'); end;
    if iST2 >= 1   then begin iST2 := iST2 - 1;   Showmessage('ACK - ST2 - Comando n�o executado'); end;
  end;
end;

procedure Analisa_iRetorno(iRetorno: Integer);
begin
  case iRetorno of
    0: MessageDlg( 'Erro de Comunica��o !', mtError, [mbOk], 0);
   -1: MessageDlg( 'Erro de Execu��o na Fun��o. Verifique!', mtError, [mbok],0);
   -2: MessageDlg( 'Par�metro Inv�lido !', mtError,[mbok],0);
   -3: MessageDlg( 'Al�quota n�o programada !', mtWarning,[mbok],0);
   -4: MessageDlg( 'Arquivo BemaFI32.INI n�o encontrado. Verifique!', mtWarning, [mbok],0);
   -5: MessageDlg( 'Erro ao Abrir a Porta de Comunica��o', mtError, [mbok],0);
   -6: MessageDlg( 'Impressora Desligada ou Desconectada', mtWarning, [mbok],0);
   -7: MessageDlg( 'Banco N�o Cadastrado no Arquivo BemaFI32.ini', mtWarning, [mbok],0);
   -8: MessageDlg( 'Erro ao Criar ou Gravar no Arquivo Retorno.txt ou Status.txt', mtError, [mbok],0);
   -18: MessageDlg( 'N�o foi poss�vel abrir arquivo INTPOS.001 !', mtWarning, [mbok],0);
   -19: MessageDlg( 'Par�metro diferentes !', mtWarning, [mbok],0);
   -20: MessageDlg( 'Transa��o cancelada pelo Operador !', mtWarning, [mbok],0);
   -21: MessageDlg( 'A Transa��o n�o foi aprovada !', mtWarning, [mbok],0);
   -22: MessageDlg( 'N�o foi poss�vel terminal a Impress�o !', mtWarning, [mbok],0);
   -23: MessageDlg( 'N�o foi poss�vel terminal a Opera��o !', mtWarning, [mbok],0);
   -24: MessageDlg( 'Forma de pagamento n�o programada.', mtWarning, [mbok],0);
   -25: MessageDlg( 'Totalizador n�o fiscal n�o programado.', mtWarning, [mbok],0);
   -26: MessageDlg( 'Transa��o j� Efetuada !', mtWarning, [mbok],0);
   -28: MessageDlg( 'N�o h� Informa��es para serem Impressas !', mtWarning, [mbok],0);
  end;
end;

end.
