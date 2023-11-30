unit RelatorioExtratoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RelatorioGenericoUnit, StdCtrls, Buttons, ExtCtrls, FMTBcd, DB,
  DBClient, SqlExpr, Provider, RpDefine, RpBase, RpSystem, ComCtrls,
  WDSimplesEdit, wiseUnit, dateUtils;

type
  TrelatorioExtratoForm = class(TRelatorioGenericoForm)
    Label4: TLabel;
    cd_empresaEdit: TWDSimplesEdit;
    empresaListagemButton: TButton;
    nm_empresaEdit: TEdit;
    Label12: TLabel;
    cd_grupo_materialEdit: TWDSimplesEdit;
    grupoMaterialListagemButton: TButton;
    ds_grupo_materialEdit: TEdit;
    Label10: TLabel;
    cd_materialEdit: TWDSimplesEdit;
    materialListagemButton: TButton;
    ds_materialEdit: TEdit;
    periodoGroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dt_finalDateTime: TDateTimePicker;
    dt_inicialDateTime: TDateTimePicker;
    rv: TRvSystem;
    Provider: TDataSetProvider;
    Query: TSQLQuery;
    CDS: TClientDataSet;
    CDSCD_MATERIAL: TIntegerField;
    CDSTIPO: TStringField;
    CDSDT_ENTRADA: TDateField;
    CDSQT_MATERIAL: TFMTBCDField;
    CDSVL_MATERIAL: TFMTBCDField;
    CDSDS_MATERIAL: TStringField;
    CDSCD_UNIDADE_MEDIDA: TStringField;
    CDSDS_GRUPO_MATERIAL: TStringField;
    CDSOBSERVACOES: TStringField;
    CDSCD_GRUPO_MATERIAL: TIntegerField;
    CDSCD_EMPRESA: TIntegerField;
    CDSNM_EMPRESA: TStringField;
    CDSNR_CONTROLE: TIntegerField;
    CDSdummy1: TAggregateField;
    DataSource: TDataSource;
    procedure empresaListagemButtonClick(Sender: TObject);
    procedure grupoMaterialListagemButtonClick(Sender: TObject);
    procedure materialListagemButtonClick(Sender: TObject);
    procedure ImprimirButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rvBeforePrint(Sender: TObject);
    procedure rvPrintHeader(Sender: TObject);
    procedure rvPrintFooter(Sender: TObject);
    procedure rvPrint(Sender: TObject);
  private
    { Private declarations }
    sql_padrao : string;
  public
    { Public declarations }
  end;

var
  relatorioExtratoForm: TrelatorioExtratoForm;

implementation

uses ConsultaEmpresaUnit, ConsultaGrupoMaterialUnit, ConsultaMaterialUnit,
  globalUnit, dmUnit;

{$R *.dfm}

procedure TrelatorioExtratoForm.empresaListagemButtonClick(
  Sender: TObject);
begin
  inherited;
  AbreConsultaFormEdit( TconsultaEmpresaForm, consultaEmpresaForm, [ 'cd_empresa', 'nm_empresa' ], [ cd_empresaEdit, nm_empresaEdit ] );
end;

procedure TrelatorioExtratoForm.grupoMaterialListagemButtonClick(
  Sender: TObject);
begin
  inherited;
  AbreConsultaFormEdit( TconsultaGrupoMaterialForm, consultaGrupoMaterialForm, [ 'cd_grupo_material', 'ds_grupo_material' ], [ cd_grupo_materialEdit, ds_grupo_materialEdit ] );

end;

procedure TrelatorioExtratoForm.materialListagemButtonClick(
  Sender: TObject);
begin
  inherited;
  AbreConsultaFormEdit( TconsultaMaterialForm, consultaMaterialForm, [ 'cd_material', 'ds_material' ], [ cd_materialEdit, ds_materialEdit ] );
end;

procedure TrelatorioExtratoForm.ImprimirButtonClick(Sender: TObject);
begin
  inherited;
  CDS.Close;
  query.SQL.Text := sql_padrao;
  if ( cd_materialEdit.Text <> '' ) then
    setParametroQy( query, ' ei.cd_material = ' + cd_materialEdit.Text  );
  if ( cd_grupo_materialEdit.Text <> '' ) then
    setParametroQy( query, ' m.cd_grupo_material = ' + cd_grupo_materialEdit.Text  );

  Query.ParamByName('dt_inicial').AsDate := dt_inicialDateTime.Date;
  Query.ParamByName('dt_final').AsDate := dt_finalDateTime.Date;

//  ShowMessage( query.SQL.Text );
  CDS.Open;
  if not cds.IsEmpty then
    rv.Execute
  else
    msgInformacao('Nada Encontrado');
  Cds.Close;

end;

procedure TrelatorioExtratoForm.FormCreate(Sender: TObject);
begin
  inherited;
  sql_padrao := query.sql.text;
  dt_inicialDateTime.DateTime := StartOfTheMonth( now );
  dt_finalDateTime.DateTime   := EndOfTheMonth( now );
end;

procedure TrelatorioExtratoForm.rvBeforePrint(Sender: TObject);
begin
  inherited;
  With Sender as TBaseReport Do
  begin
    ClearTabs;
    SetTab( MarginLeft + 0.5, pjRight,     1.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjCenter,    2.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,       3, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,       3, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,       3, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,        5, 3, BOXLINEALL, 0 );
    SaveTabs(1);
    ClearTabs;
    SetTab( MarginLeft + 0.5, pjRight,      4, 3, BOXLINEALL, 5 );
    SetTab( NA              , pjLeft,      14, 3, BOXLINEALL, 5 );
    SaveTabs(2);
    ClearTabs;
    SetTab( MarginLeft + 0.5, pjRight,      4, 3, BOXLINEALL, 2 );
    SetTab( NA              , pjLeft,      13, 3, BOXLINEALL, 2 );
    SetTab( NA              , pjLeft,       1, 3, BOXLINEALL, 2 );
    SaveTabs(3);

  end;

end;

procedure TrelatorioExtratoForm.rvPrintHeader(Sender: TObject);
begin
  inherited;
  With Sender as TBaseReport Do
  begin
    Bold := True;
    SetFont( 'Arial', 14 );
    Bold := True;

    PrintXY( MarginLeft, MarginTop, 'Extrato de Material ' );
    SetFont( 'Arial', 10 );
    PrintXY( 15, YPos, 'Período:' );
    Print( FormatDateTime( 'dd/mm/yyyy', dt_inicialDateTime.Date ) );
    Print( ' a ' );
    Print( FormatDateTime( 'dd/mm/yyyy', dt_finalDateTime.Date ) );
    NewLine;
    ClearTabs;
    RestoreTabs(1);
    NewLine;
    SetFont( 'Arial', 10 );
    Bold := True;
    SetPen(clSilver,psSolid,-1,pmCopy);
    PrintTab( 'E/S' );
    PrintTab( 'Data' );
    PrintTab( 'Quantidade' );
    PrintTab( 'Valor' );
    PrintTab( 'Qtd Saldo' );
    PrintTab( 'Observações' );

    YPos := MarginTop + 1;
    Bold := False;


  End;

end;

procedure TrelatorioExtratoForm.rvPrintFooter(Sender: TObject);
begin
  inherited;
  With Sender as TBaseReport Do
  begin
    FontColor := clBlack;
    MoveTo( MarginLeft, PageHeight - MarginBottom - 1 );
    LineTo( PageWidth - MarginRight, PageHeight - MarginBottom - 1 );
    Bold := False;
    PrintXY( PageWidth - MarginRight - 1.5, PageHeight - MarginBottom - 0.5, 'Página: ' + Trim( IntToStr( CurrentPage ) ) );
    PrintXY( MarginLeft, PageHeight - MarginBottom - 0.5, FormatDateTime( 'dd/mm/yyyy hh:nn:ss', now ) );
  end;
end;

procedure TrelatorioExtratoForm.rvPrint(Sender: TObject);
var qt_saldo, qt_entradas, qt_saidas : Currency;
begin
  inherited;
  qt_saldo := 0;
  qt_entradas := 0;
  qt_saidas := 0;
  With Sender as TBaseReport Do
  begin
    cds.First;
    Repeat
      if LinesLeft < 5 then
        NewPage;
      if gbFirst in cds.getgroupState(1) then
      begin
        SetFont( 'Arial', 12 );
        ClearTabs;
        RestoreTabs(2);
        NewLine;
        Bold := True;
        PrintTab( 'Empresa: ' + CDSCD_EMPRESA.AsString );
        PrintTab( CDSNM_EMPRESA.AsString );
      end;

      if gbFirst in cds.getgroupState(3) then
      begin
        SetFont( 'Arial', 10 );
        ClearTabs;
        RestoreTabs(2);
        NewLine;
        Bold := True;
        PrintTab( 'Grupo: ' + CDSCD_GRUPO_MATERIAL.AsString );
        PrintTab( CDSDS_GRUPO_MATERIAL.AsString );
        NewLine;
      end;

      if gbFirst in cds.getgroupState(5) then
      begin
        qt_entradas := 0;
        qt_saidas   := 0;
        qt_saldo := dm.estoqueMaterialData( CDSCD_EMPRESA.AsInteger, CDSCD_MATERIAL.AsInteger, IncSecond( dt_inicialDateTime.Date, -1 ) );
        SetFont( 'Arial', 10 );
        ClearTabs;
        RestoreTabs(3);
        NewLine;
        PrintTab( 'Material: ' + CDSCD_MATERIAL.AsString );
        PrintTab( CDSDS_MATERIAL.AsString );
        PrintTab( CDSCD_UNIDADE_MEDIDA.AsString );
        SetFont( 'Arial', 10 );
        ClearTabs;
        RestoreTabs(1);
        NewLine;
        Bold := True;
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( 'Saldo Anterior:' );
        PrintTab( FormatFloat( '#,##0.00', qt_saldo ) );
        PrintTab( CDSOBSERVACOES.AsString );
      end;

      SetFont( 'Arial', 10 );
      ClearTabs;
      RestoreTabs(1);
      NewLine;
      if CDSTIPO.AsString = 'E' then
      begin
        qt_saldo    := qt_saldo    + CDSQT_MATERIAL.AsCurrency;
        qt_entradas := qt_entradas + CDSQT_MATERIAL.AsCurrency;
      end
      else
      begin
        qt_saldo  := qt_saldo  - CDSQT_MATERIAL.AsCurrency;
        qt_saidas := qt_saidas + CDSQT_MATERIAL.AsCurrency;
      end;

      PrintTab( CDSTIPO.AsString );
      PrintTab( CDSDT_ENTRADA.AsString );
      PrintTab( FormatFloat( '#,##0.00', CDSQT_MATERIAL.AsCurrency ) );
      PrintTab( FormatFloat( '#,##0.00', CDSVL_MATERIAL.AsCurrency ) );
      PrintTab( FormatFloat( '#,##0.00', qt_saldo ) );
      PrintTab( CDSOBSERVACOES.AsString );

      if gbLast in cds.getgroupState(5) then
      begin
        SetFont( 'Arial', 10 );
        ClearTabs;
        RestoreTabs(1);
        NewLine;
        Bold := True;
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( 'Total Entradas:' );
        PrintTab( FormatFloat( '#,##0.00', qt_entradas ) );
        NewLine;
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( 'Total Saídas:' );
        PrintTab( FormatFloat( '#,##0.00', qt_saidas ) );
        NewLine;
        Bold := True;
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( 'Saldo Final:' );
        PrintTab( FormatFloat( '#,##0.00', qt_saldo ) );
      end;

      cds.Next;
    until cds.Eof;
  end;

end;

end.
