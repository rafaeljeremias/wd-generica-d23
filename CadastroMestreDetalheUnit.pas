unit CadastroMestreDetalheUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, DBClient, SimpleDS, StdCtrls, Buttons,
  ExtCtrls, STRUtils, SqlExpr, Provider, WiseUnit, FMTBcd, JvDBGrid;

type
  TCadastroMestreDetalheForm = class(TForm)
    Panel: TPanel;
    PanelBotao: TPanel;
    GravaButton: TBitBtn;
    CancelaButton: TBitBtn;
    NovoButton: TBitBtn;
    DBGrid1: TDBGrid;
    MestreDataSource: TDataSource;
    MestreClientDataSet: TClientDataSet;
    MestreDataSetProvider: TDataSetProvider;
    MestreSQLDataSet: TSQLDataSet;
    DetalheSQLDataSet: TSQLDataSet;
    DS: TDataSource;
    DetalheClientDataSet: TClientDataSet;
    DetalheDataSource: TDataSource;
    procedure GravaButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DetalheSimpleDataSetReconcileError(
      DataSet: TCustomClientDataSet; E: EReconcileError;
      UpdateKind: TUpdateKind; var Action: TReconcileAction);
    procedure CancelaButtonClick(Sender: TObject);
    procedure MestreDataSetProviderBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    Chave : String;
    procedure setCorrigeBotoes;

  protected
    SomenteLeitura : Boolean;
  public
    Tipo: string[1];
    inserindo, editando, excluindo : Boolean;
    procedure AbreEditar(const campo, valor: string; const SQL: String = ''; mostrarForm : Boolean = True; Leitura : Boolean = False ); virtual;
    procedure AbreExcluir(const campo, valor: string; const SQL: String = '');
    procedure AbreNovo( Abrir: boolean = True );
    function getNomeForm : string;

  end;

var
  CadastroMestreDetalheForm: TCadastroMestreDetalheForm;

implementation

uses GenericaReconcileErrorUnit;
{$R *.dfm}

procedure TCadastroMestreDetalheForm.GravaButtonClick(Sender: TObject);
var
  codigo: integer;
  muda_rec: boolean;
begin
  if DBGrid1.SelectedIndex = Pred(Dbgrid1.Columns.Count) then
    DBGrid1.SelectedIndex := 0
  else
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex+1;
  DetalheClientDataSet.CheckBrowseMode;
  muda_rec := DetalheClientDataSet.State in [dsEdit, dsBrowse];
  codigo := DetalheClientDataSet.RecNo;
  MestreClientDataSet.CheckBrowseMode;
  if (DetalheClientDataSet.ApplyUpdates(0) = 0) then
    if Sender = GravaButton then
      close
    else
      if Sender = NovoButton then
        MestreClientDataSet.Insert;
  if (Sender <> GravaButton) and (Sender <> NovoButton) then
    if muda_rec then
      DetalheClientDataSet.RecNo := codigo
    else
      Abort;
  if DetalheClientDataSet.ChangeCount > 0 then
    abort;
end;

procedure TCadastroMestreDetalheForm.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
var
  pos, tamanho, i, j : integer;
  coluna : String;
begin
  if ((DetalheClientDataSet.ChangeCount > 0)and(DetalheClientDataSet.State in [dsEdit, dsInsert])or
      (MestreClientDataSet.ChangeCount > 0)and(MestreClientDataSet.State in [dsEdit, dsInsert])) then
    if msgConfirma('Cancelar Alterações?') then
    begin
      MestreClientDataSet.Cancel;
      DetalheClientDataSet.Cancel;
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
{  if (DBGrid1.Tag <> 99)and(dgcolumnresize in DBGrid1.Options) then
    for i:= 0 to Pred(DBGrid1.Columns.Count) do
    begin
      GravaReg(IncludeTrailingPathDelimiter(chave)+IncludeTrailingPathDelimiter(DBGrid1.Name)+
               DBGrid1.Columns[i].DisplayName,'width',DBGrid1.Columns[i].Width);
      GravaReg(IncludeTrailingPathDelimiter(chave)+IncludeTrailingPathDelimiter(DBGrid1.Name)+
               DBGrid1.Columns[i].DisplayName,'index',DBGrid1.Columns[i].Index);
    end;}

  for i := 0 to Pred( ComponentCount ) do
  begin
    if ( ( ( Components[i] is TDBGrid ) or ( Components[i] is TJvDBGrid ) ) and ( Components[i].Tag <> 99 ) ) then
    begin
      if ( dgcolumnresize in ( Components[i] as TDBGrid ).Options ) then
      begin
        for j := 0 to Pred( ( Components[i] as TDBGrid ).Columns.Count ) do
        begin
          coluna := chave + '\' + IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
          pos := ( Components[i] as TDBGrid ).Columns[j].Index;
          tamanho := ( Components[i] as TDBGrid ).Columns[j].Width;
          GravaReg( coluna,'width', tamanho );
          GravaReg( coluna,'posicao', pos );
        end;
      end;
    end;
  end;

end;

procedure TCadastroMestreDetalheForm.DetalheSimpleDataSetReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

procedure TCadastroMestreDetalheForm.AbreNovo( Abrir: boolean = True );
var
  where : String;
begin
  try
    Tipo :='N';
    inserindo := true;
    DetalheClientDataSet.Close;
    MestreClientDataSet.Close;
    where := ' where ';
    if AnsiContainsText( MestreSQLDataSet.CommandText, 'where') then
      where := ' and ';
    MestreSQLDataSet.CommandText := MestreSQLDataSet.CommandText + Where + '1 = 2';
    MestreClientDataSet.Open;
    DetalheClientDataSet.Open;
    MestreClientDataSet.Insert;
    NovoButton.Visible := True;
    NovoButton.Top := CancelaButton.Top;
  finally
    if abrir then
      ShowModal;
  end;
end;

procedure TCadastroMestreDetalheForm.AbreEditar(const campo, valor: string; const SQL: String = ''; mostrarForm : Boolean = True; Leitura : Boolean = False );
var
  Where : String;
begin
  SomenteLeitura := Leitura;
  where := ' where ';
  if AnsiContainsText(MestreSQLDataSet.CommandText, 'where') then
    where := ' and ';
  try
    Tipo := 'E';
    editando := true;
    MestreClientDataSet.Close;
    if SQL = '' then
      MestreSQLDataSet.CommandText := MestreSQLDataSet.CommandText + Where + campo + ' = ' + valor
    else
      MestreSQLDataSet.CommandText := SQL;
    MestreClientDataSet.Open;

    if not MestreClientDataSet.ReadOnly then
      MestreClientDataSet.Edit
    else
      GravaButton.Enabled := False;  
  finally
    if mostrarForm then
      ShowModal;
  end;
end;

procedure TCadastroMestreDetalheForm.AbreExcluir(const campo, valor: string; const SQL: String = '');
var
  Where : String;
begin
  where := ' where ';
  if AnsiContainsText(MestreSQLDataSet.CommandText, 'where') then
    where := ' and ';
  Tipo := 'D';
  excluindo := true;
  MestreClientDataSet.Close;
  if SQL = '' then
    MestreSQLDataSet.CommandText := MestreSQLDataSet.CommandText + Where + campo + ' = ' + valor
  else
    MestreSQLDataSet.CommandText := SQL ;
  MestreClientDataSet.Open;
  if msgConfirma('Tem certeza que deseja excluir?') then
  begin
    MestreClientDataSet.Delete;
    MestreClientDataSet.ApplyUpdates(0);
  end;
end;

procedure TCadastroMestreDetalheForm.CancelaButtonClick(Sender: TObject);
begin
  close;
end;

procedure TCadastroMestreDetalheForm.MestreDataSetProviderBeforeUpdateRecord(
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

procedure TCadastroMestreDetalheForm.setCorrigeBotoes;
begin
  // corrige um bug que amontoa os botoes em algumas situacoes
  CancelaButton.Left := Width - CancelaButton.Width - 20;
  GravaButton.Left := CancelaButton.Left - GravaButton.Width - 3;
  NovoButton.Left := GravaButton.Left - NovoButton.Width - 3;
end;

procedure TCadastroMestreDetalheForm.FormCreate(Sender: TObject);
var
  i, j : integer;
  pos, tamanho : Integer;
  coluna : String;
  fg_mudar : Boolean;
  posicao_registro, posicao_grid, qtd_mudanca  : Integer;
begin
  SomenteLeitura := false;
  inserindo := false;
  editando  := false;
  excluindo := false;
  Chave := IncludeTrailingPathDelimiter(ExtractFileName(Application.ExeName)) +  getNomeForm;
  if LerReg(chave,'width',-1)= -1 then
    self.Position := poDesktopCenter
  else
    self.Position := poDesigned;
  self.Width := LerReg(chave,'width',self.Width);
  self.Height := LerReg(chave,'height',self.Height);
  self.Top := LerReg(chave,'top',self.Top);
  self.Left := LerReg(chave,'left',self.left);

 { if (dbGrid1.Tag <> 99)and(dgcolumnresize in dbGrid1.Options) then
    for i:= 0 to Pred(dbGrid1.Columns.Count) do
    begin
      dbGrid1.Columns[i].Width := LerReg(IncludeTrailingPathDelimiter(chave)+IncludeTrailingPathDelimiter(dbGrid1.Name)+
                                  dbGrid1.Columns[i].DisplayName,'width',dbGrid1.Columns[i].Width);
      dbGrid1.Columns[i].Index := LerReg(IncludeTrailingPathDelimiter(chave)+IncludeTrailingPathDelimiter(dbGrid1.Name)+
                                  dbGrid1.Columns[i].DisplayName,'index',dbGrid1.Columns[i].Index);
    end;}

  // Restaura tamanho de colunas da grid
  qtd_mudanca := 0;
  for i := 0 to Pred( ComponentCount ) do
  begin
    if ( ( ( Components[i] is TDBGrid ) or ( Components[i] is TJvDBGrid ) ) and ( Components[i].Tag <> 99 ) ) then
    begin
      if ( dgcolumnresize in ( Components[i] as TDBGrid ).Options ) then
      begin
        fg_mudar := true;
        while ( fg_mudar ) and ( qtd_mudanca <= 15 ) do
        begin
          fg_mudar := false;
          for j := 0 to Pred( ( components[i] as TDBGrid ).Columns.Count) do
          begin
            coluna := chave + '\' +IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
            pos := LerReg(coluna,'posicao', -1 );
            if pos >= 0 then
              ( components[i] as TDBGrid ).Columns[j].Index := pos;
          end;

          for j := 0 to Pred( ( components[i] as TDBGrid ).Columns.Count) do
          begin
            coluna := chave + '\' +IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
            posicao_grid     := j;
            posicao_registro := LerReg(coluna,'posicao', -1 );
            if posicao_registro <> -1 then
            begin
              if posicao_registro <> posicao_grid then
                fg_mudar := true;
            end;
          end;
          inc( qtd_mudanca );

        end;

        for j := Pred(( components[i] as TDBGrid ).Columns.Count) downto 0 do
        begin
          coluna := chave + '\' +IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
          tamanho := LerReg(coluna,'width', -1 );
          if tamanho >= 0 then
            ( components[i] as TDBGrid ).Columns[j].Width := tamanho;
        end;
      end;
    end;
  end;
end;

procedure TCadastroMestreDetalheForm.FormShow(Sender: TObject);
begin
  setCorrigeBotoes;
end;

procedure TCadastroMestreDetalheForm.DBGrid1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if (Key = vk_F3)and(Dbgrid1.SelectedIndex<>-1)and(dbgrid1.Columns[Dbgrid1.SelectedIndex].ButtonStyle = cbsEllipsis) then
     if assigned(dbgrid1.OnEditButtonClick) then
       dbgrid1.OnEditButtonClick(dbgrid1);
end;

function TCadastroMestreDetalheForm.getNomeForm: string;
var nm_form : string;
    i : byte;
begin
  nm_form := self.Name;
  for i := 1 to 20 do
    nm_form := AnsiReplaceStr( nm_form, '_' + IntToStr(i), '' );
  result := nm_form;

end;

end.

