unit ConsultaDuplaGenericaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ConsultaSimplesGenericaUnit, Provider, DBClient, DB, SqlExpr,
  StdCtrls, Grids, DBGrids, ExtCtrls, Buttons, StrUtils,
  ImgList;

type
  TConsultaDuplaGenericaForm = class(TConsultaSimplesGenericaForm)
    CodigoEdit: TEdit;
    CodigoButton: TButton;
    NomeEdit: TEdit;
    MasterLabel: TLabel;
    QyAux: TSQLQuery;
    procedure ConsultaButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CodigoEditExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovoButtonClick(Sender: TObject);
  private
    fCampoChave, fCampoString, fSQL, fCampoLink : String;
    fChaveString : boolean;
    procedure AtualizaMaster;
  public
    procedure Abrir(SQL, CampoChave, CampoString: String; ChaveString : boolean = False; Modal : Boolean = False; CampoLink : String = '');
  end;

var
  ConsultaDuplaGenericaForm: TConsultaDuplaGenericaForm;

implementation

{$R *.dfm}

procedure TConsultaDuplaGenericaForm.Abrir(SQL, CampoChave, CampoString :String; ChaveString : boolean = False; Modal : Boolean = False; CampoLink : String = '');
begin
  // seta as variaveis globais
  fSQL := SQL; fCampoChave := CampoChave; fCampoString := CampoString; fChaveString := ChaveString;
  if CampoLink = '' then
    fCampoLink := CampoChave
  else
    fCampoLink := CampoLink;
  if modal then
    ShowModal
  else
    Show;
end;

procedure TConsultaDuplaGenericaForm.ConsultaButtonClick(Sender: TObject);
var
  TempSQL, Where : String;
begin
  //salva a query antes de baguncar ela
  TempSQL := SQLQuery;
  try
    //verifica se o codigo master nao esta em branco
    if Trim(CodigoEdit.Text) = '' then
    begin
      showmessage('Código não foi preenchido!!');
      abort;
    end;
    where := ' where ';
    if AnsiContainsText(SQLQuery, 'where') then
      where := ' and ';
    // adiciona a query a restricao do campo master
    SQLQuery := SQLQuery + Where + fCampoLink + ' = ' + CodigoEdit.Text ;
    inherited;
  finally
    // volta a query ao valor antigo
    SQLQuery := TempSQL;
  end;
end;

procedure TConsultaDuplaGenericaForm.FormCreate(Sender: TObject);
begin
  //caso o jumento esqueca de setar o conection da Query auxiliar ja faco o trabalho pra ele
  QyAux.SQLConnection := IBQy.SQLConnection;
  inherited;
end;

//atualiza os campos master (codigo e nome)
procedure TConsultaDuplaGenericaForm.AtualizaMaster;
var
  Where :String;
begin
  QyAux.Close;
  QyAux.SQL.Clear;
  QyAux.SQL.Add(fSQL);

  //quando abre o form da primeira fez nao executa isso
  where := ' where ';
  if AnsiContainsText(SQLQuery, 'where') then
    where := ' and ';
  if Trim(CodigoEdit.Text) <> '' then
    QyAux.SQL.Add(Where+fCampoChave+'='+StrUtils.ifThen(fChaveString,QuotedStr(CodigoEdit.Text),CodigoEdit.Text));

  QyAux.Open;

  //so executa da primeira vez
  if Trim(CodigoEdit.Text) = '' then
    CodigoEdit.Text := QyAux.FieldByName(fCampoChave).AsString;

  //atualiza o campo nome somente se nao estiver vazio
  if fCampoString <> '' then
    NomeEdit.Text   := QyAux.FieldByName(fCampoString).AsString;

  //verificar se o codigo digitado existe
  if (Trim(CodigoEdit.Text) <> '')and(Trim(QyAux.FieldByName(fCampoChave).AsString)='') then
  begin
    showmessage('Código não encontrado!');
    abort;
  end;
end;

procedure TConsultaDuplaGenericaForm.CodigoEditExit(Sender: TObject);
begin
  inherited;
  if Trim(CodigoEdit.Text)='' then
  begin
    NomeEdit.Text := '';
    //ActiveControl := CodigoEdit;
    showmessage('Código não foi preenchido!!');
    Abort;
  end
  else
  begin
    //atualiza campos do master
    AtualizaMaster;
    //atualiza grid
    ConsultaButtonClick(self);
  end;
end;

procedure TConsultaDuplaGenericaForm.FormShow(Sender: TObject);
var
  Where, TempSQL : String;
begin
  // pega um coitado do master para iniciar
  AtualizaMaster;
  //salva o SQL antes de fazer as burrada
  TempSQL := IBQy.SQL.Text;
  where := ' where ';
  if AnsiContainsText(TempSQL, 'where') then
    where := ' and ';
  Try
    // insere sql para filtrar somente registros do master escolhido
    if Trim(CodigoEdit.Text) <> '' then
      IBQy.SQL.Add(Where + fCampoLink + '=' + StrUtils.ifThen(fChaveString,QuotedStr(CodigoEdit.Text),CodigoEdit.Text));
    inherited;
  finally
    //volta o sql antigo
    SQLQuery := TempSQL;
  end
end;

procedure TConsultaDuplaGenericaForm.NovoButtonClick(Sender: TObject);
begin
  inherited;
  //nao abre o cadastro sem preencher o master
  if Trim(CodigoEdit.Text) = '' then
  begin
    showmessage('Código não foi preenchido!!');
    abort;
  end;
end;

end.
