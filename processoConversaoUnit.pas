unit processoConversaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, ExtCtrls, StdCtrls, Buttons, WDSimplesEdit,
  FMTBcd, SqlExpr, Provider, DB, DBClient, aRotinasUnit;

type
  TprocessoConversaoForm = class(TFormBasicoPanelForm)
    fecharButton: TBitBtn;
    processarButton: TBitBtn;
    Label1: TLabel;
    cd_sgbd_origemEdit: TWDSimplesEdit;
    Label2: TLabel;
    cd_sgbd_destinoEdit: TWDSimplesEdit;
    sgbdDestinoButton: TButton;
    sgbdOrigemButton: TButton;
    nm_sgbd_origemEdit: TEdit;
    nm_sgbd_destinoEdit: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    origemMemo: TMemo;
    destinoMemo: TMemo;
    cds: TClientDataSet;
    cdsCD_SGBD_ORIGEM: TIntegerField;
    cdsCD_SGBD_DESTINO: TIntegerField;
    cdsDS_TOKEN: TStringField;
    cdsDS_TOKEN_SUBSTITUIR: TStringField;
    cdsDS_PARAMETROS_ORIGEM: TStringField;
    cdsDS_PARAMETROS_DESTINO: TStringField;
    DSProvider: TDataSetProvider;
    SQLData: TSQLDataSet;
    SQLDataCD_SGBD_ORIGEM: TIntegerField;
    SQLDataCD_SGBD_DESTINO: TIntegerField;
    SQLDataDS_TOKEN: TStringField;
    SQLDataDS_TOKEN_SUBSTITUIR: TStringField;
    SQLDataDS_PARAMETROS_ORIGEM: TStringField;
    SQLDataDS_PARAMETROS_DESTINO: TStringField;
    procedure fecharButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure processarButtonClick(Sender: TObject);
  private
    { Private declarations }
    sql_padrao : String;
  public
    { Public declarations }
  end;

var
  processoConversaoForm: TprocessoConversaoForm;

implementation

uses dmUnit;

{$R *.dfm}

procedure TprocessoConversaoForm.fecharButtonClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TprocessoConversaoForm.FormCreate(Sender: TObject);
begin
  inherited;
  cd_sgbd_origemEdit.Conexao := dm.conexao;
  cd_sgbd_destinoEdit.Conexao := dm.conexao;
  SQLData.SQLConnection := dm.conexao;
  sql_padrao := SQLData.CommandText;

end;

procedure TprocessoConversaoForm.processarButtonClick(Sender: TObject);
var i, j : Integer;
    st, token, novo_token : String;
    nr_abre_parenteses, nr_fecha_parenteses : Integer;
begin
  inherited;
  if cd_sgbd_origemEdit.Text = '' then
  begin
    msgInforma('Entre com o Banco Origem');
    Exit;
  end;
  if cd_sgbd_destinoEdit.Text = '' then
  begin
    msgInforma('Entre com o Banco Destino');
    Exit;
  end;
  if origemMemo.Lines.Text = '' then
  begin
    msgInforma('Entre com a Query de Origem');
    origemMemo.SetFocus;
    Exit;
  end;
  cds.Close;
  SQLData.CommandText := sql_padrao;
  SQLData.CommandText := SQLData.CommandText + ' where cd_sgbd_origem = ' + cd_sgbd_origemEdit.Text + ' and cd_sgbd_destino = ' + cd_sgbd_destinoEdit.Text;
  cds.Open;
  st := origemMemo.Lines.Text;
  i := 1;
  j := length( st );
  token := '';
  repeat
    token := token + st[i];
    if cds.FindKey( [ token ] ) then
    begin
      novo_token := '!@' + cdsDS_TOKEN_SUBSTITUIR.AsString;
      if st[i] = '(' then
      begin
        nr_abre_parenteses := 1;
        nr_fecha_parenteses := 0;
        Inc(i);
      end;
      repeat
        novo_token := novo_token + st[i];
        if st[i] = '(' then
          Inc( nr_abre_parenteses );
        if st[i] = ')' then
          Inc( nr_fecha_parenteses );
        Inc(i);
      until ( i > j ) or ( nr_abre_parenteses = nr_fecha_parenteses );
    end;
    Inc(i);
  until i > j;
  ShowMessage( novo_token );

end;

end.
