unit RelatorioEntradaMaterialUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RelatorioGenericoUnit, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  WDSimplesEdit, FMTBcd, SqlExpr, DB, DBClient, Provider, RpDefine, RpBase,
  RpSystem, wiseUnit, dateUtils;

type
  TRelatorioEntradaMaterialForm = class(TRelatorioGenericoForm)
    Label4: TLabel;
    empresaListagemButton: TButton;
    nm_empresaEdit: TEdit;
    Label10: TLabel;
    materialListagemButton: TButton;
    ds_materialEdit: TEdit;
    Label12: TLabel;
    grupoMaterialListagemButton: TButton;
    ds_grupo_materialEdit: TEdit;
    Label5: TLabel;
    fornecedorListagemButton: TButton;
    nm_fornecedorEdit: TEdit;
    periodoGroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dt_finalDateTime: TDateTimePicker;
    dt_inicialDateTime: TDateTimePicker;
    Label11: TLabel;
    tipoRelatorioComboBox: TComboBox;
    porLabel: TLabel;
    agrupadoComboBox: TComboBox;
    cd_empresaEdit: TWDSimplesEdit;
    cd_grupo_materialEdit: TWDSimplesEdit;
    cd_materialEdit: TWDSimplesEdit;
    cd_fornecedorEdit: TWDSimplesEdit;
    rv: TRvSystem;
    Provider: TDataSetProvider;
    DataSource: TDataSource;
    CDS: TClientDataSet;
    CDSNR_CONTROLE: TIntegerField;
    CDSCD_EMPRESA: TIntegerField;
    CDSCD_FORNECEDOR: TIntegerField;
    CDSDT_ENTRADA: TDateField;
    CDSNR_DOCUMENTO: TStringField;
    CDSDT_EMISSAO: TDateField;
    CDSNR_ITEM: TIntegerField;
    CDSCD_MATERIAL: TIntegerField;
    CDSQT_MATERIAL: TFMTBCDField;
    CDSVL_UNITARIO: TFMTBCDField;
    CDSVL_MATERIAL: TFMTBCDField;
    CDSOBSERVACOES: TStringField;
    CDSDS_MATERIAL: TStringField;
    CDSCD_UNIDADE_MEDIDA: TStringField;
    CDSNM_EMPRESA: TStringField;
    CDSNM_FORNECEDOR: TStringField;
    CDSCD_GRUPO_MATERIAL: TIntegerField;
    CDSDS_GRUPO_MATERIAL: TStringField;
    Query: TSQLQuery;
    procedure fornecedorListagemButtonClick(Sender: TObject);
    procedure empresaListagemButtonClick(Sender: TObject);
    procedure materialListagemButtonClick(Sender: TObject);
    procedure grupoMaterialListagemButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImprimirButtonClick(Sender: TObject);
    procedure rvBeforePrint(Sender: TObject);
    procedure rvPrint(Sender: TObject);
    procedure rvPrintFooter(Sender: TObject);
    procedure rvPrintHeader(Sender: TObject);
  private
    { Private declarations }
    sql_anterior : String;
    
  public
    { Public declarations }
  end;

var
  RelatorioEntradaMaterialForm: TRelatorioEntradaMaterialForm;

implementation

uses dmUnit, ConsultaPessoaUnit, ConsultaEmpresaUnit,
  ConsultaGrupoMaterialUnit, ConsultaMaterialUnit;

{$R *.dfm}

procedure TRelatorioEntradaMaterialForm.fornecedorListagemButtonClick(
  Sender: TObject);
begin
  inherited;
  AbreConsultaFormEdit( TconsultaPessoaForm, consultaPessoaForm, [ 'cd_pessoa', 'nm_pessoa' ], [ cd_fornecedorEdit, nm_fornecedorEdit ] );
end;

procedure TRelatorioEntradaMaterialForm.empresaListagemButtonClick(
  Sender: TObject);
begin
  inherited;
  AbreConsultaFormEdit( TconsultaEmpresaForm, consultaEmpresaForm, [ 'cd_empresa', 'nm_empresa' ], [ cd_empresaEdit, nm_empresaEdit ] );

end;

procedure TRelatorioEntradaMaterialForm.materialListagemButtonClick(
  Sender: TObject);
begin
  inherited;
  AbreConsultaFormEdit( TconsultaMaterialForm, consultaMaterialForm, [ 'cd_material', 'ds_material' ], [ cd_materialEdit, ds_materialEdit ] );

end;

procedure TRelatorioEntradaMaterialForm.grupoMaterialListagemButtonClick(
  Sender: TObject);
begin
  inherited;
  AbreConsultaFormEdit( TconsultaGrupoMaterialForm, consultaGrupoMaterialForm, [ 'cd_grupo_material', 'ds_grupo_material' ], [ cd_grupo_materialEdit, ds_grupo_materialEdit ] );

end;

procedure TRelatorioEntradaMaterialForm.FormCreate(Sender: TObject);
begin
  inherited;
  dt_inicialDateTime.DateTime := StartOfTheMonth( now );
  dt_finalDateTime.DateTime   := EndOfTheMonth( now );
  sql_anterior := query.SQL.Text;

end;

procedure TRelatorioEntradaMaterialForm.ImprimirButtonClick(
  Sender: TObject);
var agregado : TAggregate;
begin
  inherited;
  cds.Close;
  Query.SQL.Text := sql_anterior;
  if ( cd_empresaEdit.Text <> '0' ) and ( cd_empresaEdit.Text <> '' ) then
    query.SQL.Add( ' and e.cd_empresa = ' + cd_empresaEdit.Text );
  if ( cd_fornecedorEdit.Text <> '0' ) and ( cd_fornecedorEdit.Text <> '' ) then
    query.SQL.Add( ' and e.cd_fornecedor = ' + cd_fornecedorEdit.Text );
  if ( cd_materialEdit.Text <> '0' ) and ( cd_materialEdit.Text <> '' ) then
    query.SQL.Add( ' and ei.cd_material = ' + cd_materialEdit.Text );
  if ( cd_grupo_materialEdit.Text <> '0' ) and ( cd_grupo_materialEdit.Text <> '' ) then
    query.SQL.Add( ' and m.cd_grupo_material = ' + cd_grupo_materialEdit.Text );

  Query.SQL.Add( ' and e.dt_entrada between ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy', dt_inicialDateTime.Date ) ) + ' and ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy', dt_finalDateTime.Date ) ) );

  cds.Aggregates.Clear;
  cds.AggFields.Clear;
  cds.IndexDefs.Clear;

  if tipoRelatorioComboBox.ItemIndex = 1 then
  begin

    // Cria Índices

    Case agrupadoComboBox.ItemIndex of
      0 : cds.IndexDefs.Add( 'idx', 'ds_material;cd_material', [] );
      1 : cds.IndexDefs.Add( 'idx', 'ds_grupo_material;cd_grupo_material', [] );
      2 : cds.IndexDefs.Add( 'idx', 'nm_empresa;cd_empresa', [] );
      3 : cds.IndexDefs.Add( 'idx', 'nm_fornecedor;cd_fornecedor', [] );      
    end;

    cds.IndexDefs.Items[0].GroupingLevel := 1;
    cds.IndexName := 'idx';

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'qt_total_material';
      Expression := 'Sum( qt_material )';
      GroupingLevel := 1;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'vl_total_material';
      Expression := 'Sum( vl_material )';
      GroupingLevel := 1;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'nr_entradas';
      Expression := 'Count(*)';
      GroupingLevel := 1;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;


    // Inclui Aggregates

    agregado := TAggregate.Create(Nil);
    with agregado do
    begin
      AggregateName := 'ag1';
      GroupingLevel := 1;
      IndexName := 'idx';
      Active := True;
    end;

    cds.Aggregates.Add;
    cds.Aggregates[0] := agregado;

    agregado.Free;

    agregado := TAggregate.Create(Nil);
    with agregado do
    begin
      AggregateName := 'ag2';
      GroupingLevel := 1;
      IndexName := 'idx';
      Active := True;
    end;

    cds.Aggregates.add;
    cds.Aggregates[1] := agregado;

    agregado.Free;

    agregado := TAggregate.Create(Nil);
    with agregado do
    begin
      AggregateName := 'ag3';
      GroupingLevel := 1;
      IndexName := 'idx';
      Active := True;
    end;

    cds.Aggregates.add;
    cds.Aggregates[2] := agregado;

    agregado.Free;

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'vl_total';
      Expression := 'Sum( vl_material )';
      GroupingLevel := 0;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'nr_total';
      Expression := 'Count( vl_material )';
      GroupingLevel := 0;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;


    agregado := TAggregate.Create(Nil);
    with agregado do
    begin
      AggregateName := 'ag4';
      GroupingLevel := 0;
      IndexName := 'idx';
      Active := True;
    end;

    cds.Aggregates.Add;
    cds.Aggregates[3] := agregado;

    agregado.Free;

    agregado := TAggregate.Create(Nil);
    with agregado do
    begin
      AggregateName := 'ag5';
      GroupingLevel := 0;
      IndexName := 'idx';
      Active := True;
    end;

    cds.Aggregates.Add;
    cds.Aggregates[4] := agregado;

    agregado.Free;


  end
  else
  begin
    // Cria Índices

    cds.IndexDefs.Add( 'idx', 'nr_controle;nr_item', [] );

    cds.IndexDefs.Items[0].GroupingLevel := 1;
    cds.IndexName := 'idx';

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'nr_entradas';
      Expression := 'Count(*)';
      GroupingLevel := 1;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;
    // Inclui Aggregates

    agregado := TAggregate.Create(Nil);
    with agregado do
    begin
      AggregateName := 'ag1';
      GroupingLevel := 1;
      IndexName := 'idx';
      Active := True;
    end;

    cds.Aggregates.Add;
    cds.Aggregates[0] := agregado;

    agregado.Free;

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'vl_total';
      Expression := 'Sum( vl_material )';
      GroupingLevel := 0;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;

    with TAggregateField.Create(nil) do
    begin
      FieldKind := fkAggregate;
      FieldName := 'nr_total';
      Expression := 'Count( vl_material )';
      GroupingLevel := 0;
      IndexName := 'idx';
      DataSet := cds;
      Active := True;
    end;


    agregado := TAggregate.Create(Nil);
    with agregado do
    begin
      AggregateName := 'ag1';
      GroupingLevel := 0;
      IndexName := 'idx';
      Active := True;
    end;

    cds.Aggregates.Add;
    cds.Aggregates[1] := agregado;

    cds.Aggregates.Add;
    cds.Aggregates[2] := agregado;


    agregado.Free;


  end;

  cds.AggregatesActive := True;

  Cds.Open;

  if cds.IsEmpty then
    msgInformacao('Nada Encontrado')
  else
    rv.Execute;

  cds.Close;

end;

procedure TRelatorioEntradaMaterialForm.rvBeforePrint(Sender: TObject);
begin
  inherited;
  With Sender as TBaseReport Do
  begin
    ClearTabs;
    SetTab( MarginLeft + 0.5, pjRight,      2, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,     2.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,     2.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,     7.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,       4, 3, BOXLINEALL, 0 );
    SaveTabs(1);
    ClearTabs;
    SetTab( MarginLeft + 0.5, pjRight,      1, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,      2, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,       6, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,      1, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,    2.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,    2.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,     3.5, 3, BOXLINEALL, 0 );
    SaveTabs(2);
    ClearTabs;
    SetTab( MarginLeft + 0.5, pjRight,      2, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,       7, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,      1, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,    3.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,    3.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,    1.5, 3, BOXLINEALL, 0 );
    SaveTabs(3);
    ClearTabs;
    SetTab( MarginLeft + 0.5, pjRight,      2, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjLeft,     9.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,    3.5, 3, BOXLINEALL, 0 );
    SetTab( NA              , pjRight,    3.5, 3, BOXLINEALL, 0 );
    SaveTabs(4);

  end;

end;

procedure TRelatorioEntradaMaterialForm.rvPrint(Sender: TObject);
begin
  inherited;
  With Sender as TBaseReport Do
  begin
    cds.First;
    Repeat
      if LinesLeft < 5 then
        NewPage;
      if tipoRelatorioComboBox.ItemIndex = 0 then // Detalhado
      begin
        SetFont( 'Arial', 10 );
        ClearTabs;
        RestoreTabs(1);
        if gbFirst in cds.getgroupState(1) then
        begin
          NewLine;
          PrintTab( CDSNR_CONTROLE.AsString );
          PrintTab( CDSDT_EMISSAO.AsString );
          PrintTab( CDSDT_ENTRADA.AsString );
          PrintTab( CDSNM_FORNECEDOR.AsString );
          PrintTab( CDSNR_DOCUMENTO.AsString );
          // Cabecalho
          ClearTabs;
          RestoreTabs(2);
          NewLine;
          Bold := True;
          PrintTab( '#' );
          PrintTab( 'Material' );
          PrintTab( 'Descrição Material' );
          PrintTab( 'UN' );
          PrintTab( 'Qtd' );
          PrintTab( 'Valor Total' );
          PrintTab( 'Observação' );
        end;
        SetFont( 'Arial', 10 );
        ClearTabs;
        RestoreTabs(2);
        NewLine;
        PrintTab( CDSNR_ITEM.AsString );
        PrintTab( CDSCD_MATERIAL.AsString );
        PrintTab( CDSDS_MATERIAL.AsString );
        PrintTab( CDSCD_UNIDADE_MEDIDA.AsString );
        PrintTab( FormatFloat( '#,##0.00', CDSQT_MATERIAL.AsCurrency ) );
        PrintTab( FormatFloat( '#,##0.00', CDSVL_MATERIAL.AsCurrency ) );
        PrintTab( CDSOBSERVACOES.AsString );
        if gbLast in cds.getgroupState(1) then
          NewLine;
      end
      else // Agrupado
      begin
        case agrupadoComboBox.ItemIndex of
          0 : begin
                if gbLast in cds.getgroupState(1) then
                begin
                  SetFont( 'Arial', 10 );
                  ClearTabs;
                  RestoreTabs(3);
                  NewLine;
                  PrintTab( CDSCD_MATERIAL.AsString );
                  PrintTab( CDSDS_MATERIAL.AsString );
                  PrintTab( CDSCD_UNIDADE_MEDIDA.AsString );
                  PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('qt_total_material').Value  ) );
                  PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('vl_total_material').Value ) );
                  PrintTab( FormatFloat( '#,##0', cds.fieldByName('nr_entradas').Value ) );                  
                end;
              end;
          1 : begin
                if gbLast in cds.getgroupState(1) then
                begin
                  SetFont( 'Arial', 10 );
                  ClearTabs;
                  RestoreTabs(4);
                  NewLine;
                  PrintTab( CDSCD_GRUPO_MATERIAL.AsString );
                  PrintTab( CDSDS_GRUPO_MATERIAL.AsString );
                  PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('vl_total_material').Value ) );
                  PrintTab( FormatFloat( '#,##0', cds.fieldByName('nr_entradas').Value ) );
                end;
              end;

          2 : begin
                if gbLast in cds.getgroupState(1) then
                begin
                  SetFont( 'Arial', 10 );
                  ClearTabs;
                  RestoreTabs(4);
                  NewLine;
                  PrintTab( CDSCD_EMPRESA.AsString );
                  PrintTab( CDSNM_EMPRESA.AsString );
                  PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('vl_total_material').Value ) );
                  PrintTab( FormatFloat( '#,##0', cds.fieldByName('nr_entradas').Value ) );
                end;
              end;
          3 : begin
                if gbLast in cds.getgroupState(1) then
                begin
                  SetFont( 'Arial', 10 );
                  ClearTabs;
                  RestoreTabs(4);
                  NewLine;
                  PrintTab( CDSCD_FORNECEDOR.AsString );
                  PrintTab( CDSNM_FORNECEDOR.AsString );
                  PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('vl_total_material').Value ) );
                  PrintTab( FormatFloat( '#,##0', cds.fieldByName('nr_entradas').Value ) );
                end;
              end;

        end;
      end;
      cds.Next;
    until cds.Eof;
    if tipoRelatorioComboBox.ItemIndex = 0 then // Detalhado
    begin
      SetFont( 'Arial', 10 );
      ClearTabs;
      RestoreTabs(2);
      Bold := True;
      NewLine;
      PrintTab( '' );
      PrintTab( '' );
      PrintTab( 'Total Geral' );
      PrintTab( '' );
      PrintTab( '' );
      PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('vl_total').Value ) );
      PrintTab( FormatFloat( '#,##0', cds.fieldByName('nr_total').Value ) );      
    end
    else
    begin
      SetFont( 'Arial', 10 );
      ClearTabs;
      if agrupadoComboBox.ItemIndex = 0 then
      begin
        RestoreTabs(3);
        Bold := True;
        NewLine;
        PrintTab( '' );
        PrintTab( 'Total Geral' );
        PrintTab( '' );
        PrintTab( '' );
        PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('vl_total').Value ) );
        PrintTab( FormatFloat( '#,##0', cds.fieldByName('nr_total').Value ) );        
      end
      else
      begin
        RestoreTabs(4);
        Bold := True;
        NewLine;
        PrintTab( '' );
        PrintTab( 'Total Geral' );
        PrintTab( FormatFloat( '#,##0.00', cds.fieldByName('vl_total').Value ) );
        PrintTab( FormatFloat( '#,##0', cds.fieldByName('nr_total').Value ) );
      end;
    end;

  end;

end;

procedure TRelatorioEntradaMaterialForm.rvPrintFooter(Sender: TObject);
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

procedure TRelatorioEntradaMaterialForm.rvPrintHeader(Sender: TObject);
begin
  inherited;
  With Sender as TBaseReport Do
  begin
    Bold := True;
    SetFont( 'Arial', 14 );
    Bold := True;

    PrintXY( MarginLeft, MarginTop, 'Relatório de Entradas ' );
    SetFont( 'Arial', 10 );
    PrintXY( 15, YPos, 'Período:' );
    Print( FormatDateTime( 'dd/mm/yyyy', dt_inicialDateTime.Date ) );
    Print( ' a ' );
    Print( FormatDateTime( 'dd/mm/yyyy', dt_finalDateTime.Date ) );
    NewLine;
    if tipoRelatorioComboBox.ItemIndex = 0 then
    begin
      ClearTabs;
      RestoreTabs(1);
      NewLine;
      SetFont( 'Arial', 10 );
      Bold := True;
      SetPen(clSilver,psSolid,-1,pmCopy);
      PrintTab( 'Controle' );
      PrintTab( 'Emissão' );
      PrintTab( 'Entrada' );
      PrintTab( 'Fornecedor' );
      PrintTab( 'Documento' );
    end
    else
    begin

      case agrupadoComboBox.ItemIndex of
        0 : begin
              ClearTabs;
              RestoreTabs(3);
              NewLine;
              SetFont( 'Arial', 10 );
              Bold := True;
              SetPen(clSilver,psSolid,-1,pmCopy);

              PrintTab( 'Material' );
              PrintTab( 'Descrição do Material' );
              PrintTab( 'UN' );
              PrintTab( 'Qtd. Material' );
              PrintTab( 'Valor Material' );
              PrintTab( 'Nr. Ent.' );
            end;
        1 : begin
              ClearTabs;
              RestoreTabs(4);
              NewLine;
              SetFont( 'Arial', 10 );
              Bold := True;
              SetPen(clSilver,psSolid,-1,pmCopy);

              PrintTab( 'Grupo' );
              PrintTab( 'Descrição do Grupo de Material' );
              PrintTab( 'Valor Total' );
              PrintTab( 'Entradas' );
            end;
        2 : begin
              ClearTabs;
              RestoreTabs(4);
              NewLine;
              SetFont( 'Arial', 10 );
              Bold := True;
              SetPen(clSilver,psSolid,-1,pmCopy);

              PrintTab( 'Empresa' );
              PrintTab( 'Nome da Empresa' );
              PrintTab( 'Valor Total' );
              PrintTab( 'Entradas' );
            end;
        3 : begin
              ClearTabs;
              RestoreTabs(4);
              NewLine;
              SetFont( 'Arial', 10 );
              Bold := True;
              SetPen(clSilver,psSolid,-1,pmCopy);

              PrintTab( 'Fornecedor' );
              PrintTab( 'Nome do Fornecedor' );
              PrintTab( 'Valor Total' );
              PrintTab( 'Entradas' );
            end;

      end;

    end;

{    MoveTo( MarginLeft, YPos + 0.2 );
    LineTo( PageWidth - MarginRight, Ypos + 0.2 );}
    YPos := MarginTop + 1;
    Bold := False;
  End;

end;

end.
