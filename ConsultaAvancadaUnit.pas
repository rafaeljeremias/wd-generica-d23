unit ConsultaAvancadaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, SqlExpr, StdCtrls, Buttons, Grids, DBGrids, DBClient,
  Provider, WiseUnit, ExtCtrls, FMTBcd;

type
  TConsultaAvancadaForm = class(TForm)
    ConsultaDBGrid: TDBGrid;
    ConsultaBitBtn: TBitBtn;
    AdicionaBitBtn: TBitBtn;
    RemoveBitBtn: TBitBtn;
    CondicaoDBGrid: TDBGrid;
    CondicaoCDS: TClientDataSet;
    CondicaoCDScd_condicao: TIntegerField;
    CondicaoCDSds_condicao: TStringField;
    CondicaoCDSe_ou: TStringField;
    CondicaoCDSds_clausula: TStringField;
    CondicaoDS: TDataSource;
    Qy: TSQLDataSet;
    DataSetProvider: TDataSetProvider;
    ConsultaCDS: TClientDataSet;
    ConsultaDS: TDataSource;
    OrdemDBGrid: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    OrdemCDS: TClientDataSet;
    OrdemDS: TDataSource;
    OrdemCDSdesc: TStringField;
    CamposCDS: TClientDataSet;
    CamposCDScd_campo: TIntegerField;
    OrdemCDScd_campo: TIntegerField;
    CamposCDSdisplay: TStringField;
    OrdemCDScampo: TStringField;
    CondicaoCDSds_mostra: TStringField;
    Panel1: TPanel;
    procedure CondicaoCDSCalcFields(DataSet: TDataSet);
    procedure CondicaoCDSAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure ConsultaBitBtnClick(Sender: TObject);
    procedure RemoveBitBtnClick(Sender: TObject);
    procedure OrdemCDSNewRecord(DataSet: TDataSet);
    procedure AdicionaBitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CondicaoDBGridDblClick(Sender: TObject);
  private
    Expressao,Ordem, SQL, Chave : String;
  public
    { Public declarations }
  end;

var
  ConsultaAvancadaForm: TConsultaAvancadaForm;

implementation

uses CondicaoUnit;

{$R *.dfm}

procedure TConsultaAvancadaForm.CondicaoCDSCalcFields(DataSet: TDataSet);
begin
  if CondicaoCDSe_ou.AsString = 'OU' then
    CondicaoCDSds_clausula.AsString := CondicaoCDSds_condicao.AsString + ' or '
  else
    CondicaoCDSds_clausula.AsString := CondicaoCDSds_condicao.AsString + ' and '
end;

procedure TConsultaAvancadaForm.CondicaoCDSAfterInsert(DataSet: TDataSet);
begin
  if VarIsNull(CondicaoCDS.Aggregates[1].Value) then
    CondicaoCDScd_condicao.AsInteger := 1
  else
    CondicaoCDScd_condicao.AsInteger := CondicaoCDS.Aggregates[1].Value + 1;
  CondicaoCDSe_ou.AsString := 'E';
end;

procedure TConsultaAvancadaForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  CondicaoCDS.LogChanges := False;
  OrdemCDS.LogChanges := False;
  CamposCDS.LogChanges := False;
  SQL                    := Qy.CommandText;
  for i := 0 to Pred(ConsultaCDS.FieldCount) do
  begin
    if ConsultaCDS.Fields[i].Visible then
    begin
      CamposCDS.Append;
      CamposCDScd_campo.AsInteger := i;
      CamposCDSdisplay.AsString   := ConsultaCDS.Fields[i].DisplayName;
      CamposCDS.Post;
    end;
  end;
  CamposCDS.Close;
  OrdemCDS.Close;
  CamposCDS.Open;
  OrdemCDS.Open;
  Chave := IncludeTrailingPathDelimiter(ExtractFileName(Application.ExeName)) +  self.Name;
  if LerReg(chave,'width',-1)= -1 then
    self.Position := poDesktopCenter
  else
    self.Position := poDesigned;
  self.Width := LerReg(chave,'width',self.Width);
  self.Height := LerReg(chave,'height',self.Height);
  self.Top := LerReg(chave,'top',self.Top);
  self.Left := LerReg(chave,'left',self.left);
end;

procedure TConsultaAvancadaForm.ConsultaBitBtnClick(Sender: TObject);
var
  prim : boolean;
begin
  ConsultaCDS.Close;
  Qy.CommandText := SQL;
  Expressao := '';
  CondicaoCDS.First;
  while not CondicaoCDS.Eof do
  begin
    if CondicaoCDScd_condicao.AsInteger = CondicaoCDS.Aggregates[1].Value then
      Expressao := Expressao + CondicaoCDSds_condicao.AsString
    else
      Expressao := Expressao + CondicaoCDSds_clausula.AsString;
    CondicaoCDS.Next;
  end;
  if CondicaoCDS.IsEmpty then
    Qy.CommandText := SQL
  else
    Qy.CommandText := SQL + ' where ' + Expressao;

  prim := True;
  Ordem := '';
  OrdemCds.First;
  While not OrdemCDS.Eof do
  begin
    if Prim then prim := False else Ordem := Ordem + ',';
     if Trim(ConsultaCDS.Fields[OrdemCDScd_campo.asInteger].Origin) <> '' then
        Ordem := Ordem + ConsultaCDS.Fields[OrdemCDScd_campo.asInteger].Origin
     else
       Ordem := Ordem + ConsultaCDS.Fields[OrdemCDScd_campo.asInteger].FieldName;
    if OrdemCDSdesc.AsString = 'S' then
      Ordem := Ordem + ' desc';
    OrdemCDS.Next;
  end;
  if not OrdemCDS.IsEmpty then
    Qy.CommandText := qy.CommandText + ' order by ' + Ordem;
  ConsultaCDS.Open;
end;

procedure TConsultaAvancadaForm.RemoveBitBtnClick(Sender: TObject);
begin
  if msgConfirma('Excluir condição?') then CondicaoCDS.Delete;
end;

procedure TConsultaAvancadaForm.OrdemCDSNewRecord(DataSet: TDataSet);
begin
  OrdemCDSdesc.AsString := 'N';
end;

procedure TConsultaAvancadaForm.AdicionaBitBtnClick(Sender: TObject);
begin
  Try
    CondicaoForm := TCondicaoForm.Create(self);
    CondicaoForm.CarregaFields(ConsultaCDS.Fields);
    CondiCaoForm.ShowModal;
    if CondicaoForm.ModalResult = mrOk then
    begin
      CondicaoCDS.Append;
      CondicaoCDSds_condicao.AsString := CondicaoForm.GetCondicao;
      CondicaoCDSds_mostra.AsString   := CondicaoForm.GetMostra;
      CondicaoCDS.Post;
    end;
  finally
    CondicaoForm.Free;
  end;
end;

procedure TConsultaAvancadaForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  for I := 0 to Screen.FormCount - 1 do
    if Screen.Forms[I] = Self then Break;
      SendMessage(Application.MainForm.Handle, WM_USER + 1, I, 0);
  Action := caFree;
end;

procedure TConsultaAvancadaForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if self.WindowState = wsnormal then
  begin
    GravaReg(chave,'width',self.Width);
    GravaReg(chave,'height',self.Height);
    GravaReg(chave,'top',self.Top);
    GravaReg(chave,'left',self.Left);
  end;
end;

procedure TConsultaAvancadaForm.CondicaoDBGridDblClick(Sender: TObject);
begin
  Try
    CondicaoForm := TCondicaoForm.Create(self);
    CondicaoForm.CarregaFields(ConsultaCDS.Fields);
    CondiCaoForm.ShowModal;
    if CondicaoForm.ModalResult = mrOk then
    begin
      CondicaoCDS.Edit;
      CondicaoCDSds_condicao.AsString := CondicaoForm.GetCondicao;
      CondicaoCDSds_mostra.AsString   := CondicaoForm.GetMostra;
      CondicaoCDS.Post;
    end;
  finally
    CondicaoForm.Free;
  end;
end;

end.
