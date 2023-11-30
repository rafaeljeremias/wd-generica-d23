unit CadastroGenericoSimples;

interface

uses
  DB, DBClient, SimpleDS, StdCtrls, Buttons, Classes, Controls, ExtCtrls, Forms,
  StrUtils, DBCtrls, Provider, SqlExpr, Windows, messages, dialogs, WiseUnit,
  FMTBcd;
type
  TCadastroGenericoSimplesForm = class(TForm)  
    Panel: TPanel;
    PanelBotao: TPanel;
    GravaButton: TBitBtn;
    CancelaButton: TBitBtn;
    NovoButton: TBitBtn;
    DS: TDataSource;
    SQLData: TSQLDataSet;
    IBData: TClientDataSet;
    DSProvider: TDataSetProvider;
    procedure GravaButtonClick(Sender: TObject);
    procedure CancelaButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IBDataReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
    procedure DSProviderBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    chave : string;
    BotaoEnter : String;
    SQLOriginal : String;
    fRetorno: Boolean;
  protected
    SomenteLeitura : Boolean;
  public
    Tipo: string[1];
    inserindo, editando, excluindo : Boolean;
    procedure setRetorno(retorno: boolean);
    procedure AbreNovo( Abrir: boolean = True );
    procedure AbreEditar(const campo, valor: string; const SQL: String = ''; const Modal: boolean = True; const Leitura: boolean = False; const Abrir: boolean = True);
    procedure AbreExcluir(const campo, valor: string; const SQL: String = '');
    procedure setBotaoEnter(BotaoEnter :String);
    property Retorno: Boolean read FRetorno write setRetorno;
  end;

var
  CadastroGenericoSimplesForm: TCadastroGenericoSimplesForm;

implementation

{$R *.dfm}

uses GenericaReconcileErrorUnit, Variants, SysUtils;


procedure TCadastroGenericoSimplesForm.AbreNovo( Abrir: boolean = True );
var
  Where : String;
begin
  try
      Tipo :='N';
      inserindo := true;
      IBData.Close;
      where := ' where ';
      if AnsiContainsText( SQLData.CommandText, 'where') then
        where := ' and ';
      SQLData.CommandText := SQLData.CommandText + Where + '1 = 2';
      IBData.Open;
      IBData.Insert;
      NovoButton.Visible := True;
      NovoButton.Top := CancelaButton.Top;
      NovoButton.Left := CancelaButton.Left - NovoButton.Width - 5;
      GravaButton.Left := NovoButton.Left - GravaButton.Width - 5;
  Except
    on E: Exception do // gerenerics
      msgErro( 'Erro ao Inserir'+ #13 + E.Message );
  end;
  if abrir then
    ShowModal;
end;

procedure TCadastroGenericoSimplesForm.AbreEditar(const campo, valor: string; const SQL: String = ''; const Modal: boolean = True; const Leitura: boolean = False; const Abrir: boolean = True);
var
  Where : String;
begin
  SomenteLeitura := Leitura;
  where := ' where ';
  if AnsiContainsText( SQLOriginal, 'where') then
    where := ' and ';
  try
    Tipo := 'E';
    editando := true;
    IBData.Close;
    if SQL = '' then
      SQLData.CommandText := SQLOriginal + Where + campo + ' = ' + valor
    else
      SQLData.CommandText := SQL;
    IBData.Open;
    if not Leitura then
      IBData.Edit
    else
      GravaButton.Enabled := False;
  finally
    if Abrir then
      if modal then
        ShowModal
      else
        Show;
  end;
end;

procedure TCadastroGenericoSimplesForm.AbreExcluir(const campo, valor: string; const SQL: String = '');
var
  Where : String;
begin
  where := ' where ';
  excluindo := true;
  if AnsiContainsText(SQLData.CommandText, 'where') then
    where := ' and ';
  Tipo := 'D';
  IBData.Close;
  if SQL = '' then
    SQLData.CommandText := SQLData.CommandText + Where + campo + ' = ' + valor
  else
    SQLData.CommandText := SQL ;
  IBData.Open;
  if msgConfirma('Tem certeza que deseja excluir?') then
  begin
    IBData.Delete;
    IBdata.ApplyUpdates(0);
  end;
end;

procedure TCadastroGenericoSimplesForm.GravaButtonClick(Sender: TObject);
var
  i : integer;

begin
  fRetorno := False;
  
  for i := 0 to Pred(IbData.FieldCount) do
    if ( IbData.Fields[i].Required ) and ( ( IbData.Fields[i].IsNull ) or ( IBData.Fields[i].AsString = '' ) ) then
       IbData.Fields[i].FocusControl;

  if IBData.Modified then
    IBData.Post;

  if (Sender = GravaButton)and(IBData.ChangeCount = 0) then
    close;

  if (IBData.ChangeCount > 0)and(IBdata.ApplyUpdates(0) = 0) then
  begin
    fRetorno := True;

    if Sender = GravaButton then
      close
    else
    if Sender = NovoButton then
      IBData.Insert;
  end;
end;


procedure TCadastroGenericoSimplesForm.CancelaButtonClick(Sender: TObject);
begin
  close;
end;

procedure TCadastroGenericoSimplesForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (IBData.Modified)and(IBData.State in [dsEdit, dsInsert]) then
    if msgConfirma('Cancelar Alterações?') then
    begin
      IBData.Cancel;
      CanClose := True;
    end
    else
      CanClose := False;
  if self.WindowState = wsnormal then
  begin
    GravaReg(chave,'width',self.Width);
    GravaReg(chave,'height',self.Height);
    GravaReg(chave,'top',self.Top);
    GravaReg(chave,'left',self.Left);
  end;
end;

procedure TCadastroGenericoSimplesForm.IBDataReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

procedure TCadastroGenericoSimplesForm.DSProviderBeforeUpdateRecord(
  Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  i, x : integer;
begin
  //para resolver bug do clientdataset com campos que nao sao atualizados no banco de dados
  if SourceDS.Fields.Count > 0 then
  begin
    x := 0;
    for i := 0 to Pred(SourceDS.Fields.Count) do
      if DeltaDs.Fields.FindField(SourceDs.Fields[i].FieldName) <> nil then
        if not VarIsEmpty(DeltaDs.FieldByName(SourceDs.Fields[i].FieldName).NewValue) then
          if DeltaDs.FieldByName(SourceDs.Fields[i].FieldName).ProviderFlags <> [] then
            inc(x);
    Applied := x = 0;
  end;
end;

procedure TCadastroGenericoSimplesForm.FormCreate(Sender: TObject);
begin
  SQLOriginal := SQLData.CommandText;
  BotaoEnter := '';
  SomenteLeitura := false;
  inserindo := false;
  editando  := false;
  excluindo := false;
  fRetorno  := False;
  Chave := IncludeTrailingPathDelimiter(ExtractFileName(Application.ExeName)) +  self.Name;
  
  if LerReg(chave,'width',-1)= -1 then
    self.Position := poDesktopCenter
  else
    self.Position := poDesigned;
  
  self.Top := LerReg(chave,'top',self.Top);
  self.Left := LerReg(chave,'left',self.left);
end;

procedure TCadastroGenericoSimplesForm.setBotaoEnter(BotaoEnter: String);
begin
  self.BotaoEnter := BotaoEnter;
end;


procedure TCadastroGenericoSimplesForm.setRetorno(retorno: boolean);
begin
  self.fRetorno := retorno;
end;

end.
