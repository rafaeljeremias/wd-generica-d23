unit graficoGerencialGenericoComparativoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, DB, DBClient, StdCtrls, Buttons, ComCtrls,
  RpDefine, RpBase, RpSystem, TeEngine, Series, TeeProcs, Chart, Grids,
  DBGrids, ExtCtrls, FMTBcd, SqlExpr, wiseUnit, dateUtils, JvExDBGrids,
  JvDBGrid, Menus;

type
  TgraficoGerencialGenericoComparativoForm = class(TFormBasicoPanelForm)
    rv: TRvSystem;
    mostrarValoresCheckBox: TCheckBox;
    dt_inicialEdit: TDateTimePicker;
    dt_inicialLabel: TLabel;
    aLabel: TLabel;
    dt_finalEdit: TDateTimePicker;
    dt_finalLabel: TLabel;
    imprimirButton: TBitBtn;
    fecharButton: TBitBtn;
    tituloCamposMestreCDS: TClientDataSet;
    tituloCamposMestreCDSnm_campo: TStringField;
    tituloCamposMestreCDSnm_titulo: TStringField;
    tituloCamposDetalheCDS: TClientDataSet;
    tituloCamposDetalheCDSnm_campo: TStringField;
    tituloCamposDetalheCDSnm_titulo: TStringField;
    camposParametroDetalheCDS: TClientDataSet;
    camposParametroDetalheCDScampoParametro: TStringField;
    camposParametroDetalheCDSnomeField: TStringField;
    camposParametroDetalheCDStipo: TStringField;
    camposParametroCDS: TClientDataSet;
    camposParametroCDScampoParametro: TStringField;
    camposParametroCDSnomeField: TStringField;
    camposParametroCDStipo: TStringField;
    detalheCDS: TClientDataSet;
    detalheDS: TDataSource;
    mestreDS: TDataSource;
    mestreCDS: TClientDataSet;
    mestreQy: TSQLQuery;
    detalheQy: TSQLQuery;
    processandoPanel: TPanel;
    chart: TChart;
    Series1: TLineSeries;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid: TJvDBGrid;
    Splitter2: TSplitter;
    Panel4: TPanel;
    mes_anoDBGrid: TJvDBGrid;
    graficoPanel: TPanel;
    procedure mestreCDSAfterScroll(DataSet: TDataSet);
    procedure imprimirButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mostrarValoresCheckBoxClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rvBeforePrint(Sender: TObject);
    procedure rvPrint(Sender: TObject);
    procedure rvPrintFooter(Sender: TObject);
    procedure rvPrintHeader(Sender: TObject);
    procedure mestreQyBeforeOpen(DataSet: TDataSet);
    procedure detalheQyBeforeOpen(DataSet: TDataSet);
    procedure detalheQyAfterClose(DataSet: TDataSet);
    procedure mestreQyAfterClose(DataSet: TDataSet);
  private
    { Private declarations }
    vezes : Double;
  public
    { Public declarations }
    nm_titulo_grafico, sql_select_detalhe, sql_group_by_detalhe, sql_base_detalhe, campoDescricao, campoValor, sql, sql_inicial, sql_extra, titulo : String;
    indice_detalhe : String;
    campoDescricaoDetalhe, campoValorDetalhe : String;
    tipo : String;
    formMae : Boolean;
    processar : Boolean;
    dt_inicial, dt_final : TDateTime;
    procedure montaGrafico;
    procedure adicionaTituloCampoMestre( nm_campo, nm_titulo : String; limpar : Boolean = False );
    procedure adicionaTituloCampoDetalhe( nm_campo, nm_titulo : String; limpar : Boolean = False );
    procedure adicionaCondicaoParametro( nm_campo, nm_field, tipo : String; limpar : Boolean = False );
    procedure adicionaCondicaoParametroDetalhe( nm_campo, nm_field, tipo : String; limpar : Boolean = False );
    function retornaSQLExtra( query : string ) : String;
    function retornaSQLParametros( query : string ) : String;
  end;

var
  graficoGerencialGenericoComparativoForm: TgraficoGerencialGenericoComparativoForm;

implementation

uses graficoGerencialGenericoTituloImpressaoUnit;

{$R *.dfm}

{ TgraficoGerencialGenericoComparativoForm }

procedure TgraficoGerencialGenericoComparativoForm.adicionaCondicaoParametro(
  nm_campo, nm_field, tipo: String; limpar: Boolean);
begin
  if limpar then
    camposParametroCDS.EmptyDataSet;

  camposParametroCDS.Append;
  camposParametroCDScampoParametro.AsString  := nm_campo;
  camposParametroCDSnomeField.AsString := nm_field;
  camposParametroCDStipo.AsString := tipo;
  camposParametroCDS.Post;

end;

procedure TgraficoGerencialGenericoComparativoForm.adicionaCondicaoParametroDetalhe(
  nm_campo, nm_field, tipo: String; limpar: Boolean);
begin
  if limpar then
    camposParametroDetalheCDS.EmptyDataSet;

  camposParametroDetalheCDS.Append;
  camposParametroDetalheCDScampoParametro.AsString  := nm_campo;
  camposParametroDetalheCDSnomeField.AsString := nm_field;
  camposParametroDetalheCDStipo.AsString := tipo;
  camposParametroDetalheCDS.Post;

end;

procedure TgraficoGerencialGenericoComparativoForm.adicionaTituloCampoDetalhe(
  nm_campo, nm_titulo: String; limpar: Boolean);
begin
  if limpar then
    tituloCamposDetalheCDS.EmptyDataSet;

  tituloCamposDetalheCDS.Append;
  tituloCamposDetalheCDSnm_campo.AsString  := nm_campo;
  tituloCamposDetalheCDSnm_titulo.AsString := nm_titulo;
  tituloCamposDetalheCDS.Post;

end;

procedure TgraficoGerencialGenericoComparativoForm.adicionaTituloCampoMestre(
  nm_campo, nm_titulo: String; limpar: Boolean);
begin
  if limpar then
    tituloCamposMestreCDS.EmptyDataSet;

  tituloCamposMestreCDS.Append;
  tituloCamposMestreCDSnm_campo.AsString  := nm_campo;
  tituloCamposMestreCDSnm_titulo.AsString := nm_titulo;
  tituloCamposMestreCDS.Post;

end;

procedure TgraficoGerencialGenericoComparativoForm.montaGrafico;
var i  : Integer;
    aValores  : Array[0..19] of Currency;
begin

  mestreCDS.DisableControls;

  for i := 0 to Pred( Length( aValores ) ) do
    aValores[i] := 0;

//  ShowMessage( mestreQy.SQL.Text );

  mestreQy.Open;
  if not mestreQy.IsEmpty then
  begin
    mestreCDS.Close;
    mestreCDS.Fields.Clear;
    mestreCDS.FieldDefs.Clear;
    mestreCDS.Aggregates.Clear;
    mestreCDS.AggFields.Clear;
    mestreCDS.IndexDefs.Clear;

    for i := 0 to Pred( mestreQy.Fields.Count ) do
    begin
      with mestreCDS.FieldDefs do
      begin
        with AddFieldDef do
        begin
          DataType := mestreQy.Fields[i].DataType;
          Name := mestreQy.Fields[i].FullName;
          if DataType = ftString then
            Size := mestreQy.Fields[i].Size;
          if ( DataType = ftCurrency ) or ( DataType = ftFMTBcd	) or ( DataType = ftFloat ) then
          begin
            Precision := 15;
            Size := 4;
          end;
        end;
      end;
    end;
    with mestreCDS.FieldDefs do
    begin
      with AddFieldDef do
      begin
        DataType := ftInteger;
        Name := 'ordem';
      end;
    end;

    mestreCDS.IndexDefs.Add( 'idx', 'ordem;' + campoValor, [ixDescending]);
    mestreCDS.IndexDefs.Add( 'idx1', campoValor, [ ixDescending ]);
    mestreCDS.IndexName := 'idx1';

    mestreCDS.CreateDataSet;

    mestreCDS.FieldByName('ordem').Visible := false;

    // Monta Grid
    mestreQy.First;
    Repeat
      mestreCDS.Append;
      for i := 0 to Pred( mestreQy.Fields.Count ) do
      begin
        If mestreCDS.Fields[i] is TStringField then
          mestreCDS.Fields[i].AsString := AnsiLowerCase( mestreQy.Fields[i].AsString )
        else
        begin
          mestreCDS.Fields[i].Value := mestreQy.Fields[i].Value;
          if ( mestreCDS.Fields[i] is TCurrencyField ) or ( mestreCDS.Fields[i] is TFloatField ) or ( mestreCDS.Fields[i] is TFMTBCDField ) then
            aValores[i] := aValores[i] + mestreCDS.Fields[i].Value;
        end;
      end;
      mestreCDS.FieldByName('ordem').AsInteger := 1;
      mestreCDS.Post;
      mestreQy.Next;
    Until mestreQy.Eof;

    mestreCDS.First;

    // Totais
    mestreCDS.Append;
    mestreCDS.FieldByName( campoDescricao ).AsString := 'TOTAL';
    mestreCDS.FieldByName('ordem').AsInteger := 999;

    for i := 0 to Pred( mestreQy.Fields.Count ) do
      if ( mestreCDS.Fields[i] is TCurrencyField ) or ( mestreCDS.Fields[i] is TFloatField ) or ( mestreCDS.Fields[i] is TFMTBCDField ) then
        mestreCDS.Fields[i].Value := aValores[i];

    mestreCDS.Post;

    mestreCDS.IndexName := 'idx';
    mestreCDS.First;

    // Títulos do CDS MEstre

    if not tituloCamposMestreCDS.IsEmpty then
    begin
      tituloCamposMestreCDS.First;
      repeat
        mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ).DisplayLabel := tituloCamposMestreCDSnm_titulo.AsString;
        if ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TCurrencyField ) or ( mestrecds.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TFloatField ) or ( mestrecds.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TBCDField ) or ( mestrecds.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TFMTBCDField ) then
        begin
          if ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TCurrencyField ) then
          begin
            ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) as TCurrencyField ).currency := false;
            ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) as TCurrencyField ).DisplayFormat := '#,##0.00';
          end;
          if ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TFloatField ) then
            ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) as TFloatField ).DisplayFormat := '#,##0.00';
          if ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TBCDField ) then
            ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) as TBCDField ).DisplayFormat := '#,##0.00';
          if ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) is TFMTBCDField ) then
            ( mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ) as TFMTBCDField ).DisplayFormat := '#,##0.00';

          mestreCDS.FieldByName( tituloCamposMestreCDSnm_campo.AsString ).DisplayWidth := 20;
        end;
        tituloCamposMestreCDS.Next;
      until tituloCamposMestreCDS.Eof;
    end;

    processar := true;

    mestreCDS.First;

    imprimirButton.Enabled := True;

  end
  else
    msgAlerta('Nada Encontrado');

  mestreCDS.EnableControls;

end;

function TgraficoGerencialGenericoComparativoForm.retornaSQLExtra(
  query: string): String;
var posicaoSQLExtra, posicaoGroupBy : Integer;
begin
  posicaoSQLExtra := AnsiPos( '/*sqlextra*/',AnsiLowerCase( query ) );
  posicaoGroupBy := AnsiPos( 'group by', AnsiLowerCase( query ) );
  if posicaoSQLExtra > 0 then
  begin
    if posicaoGroupBy = 0 then
      result := Copy( query, posicaoSQLExtra + Length( '/*sqlextra*/' ), length( query ) - posicaoSQLExtra - Length( '/*sqlextra*/' ))
    else
      result := Copy( query, posicaoSQLExtra + Length( '/*sqlextra*/' ), posicaoGroupBy - posicaoSQLExtra - Length( '/*sqlextra*/' ) );
  end
  else
    result := '/*Sem SQLExtra*/';

end;

function TgraficoGerencialGenericoComparativoForm.retornaSQLParametros(
  query: string): String;
var sql_adicional : String;
begin
  sql_adicional := '';
  if not camposParametroCDS.IsEmpty then
  begin
    camposParametroCDS.First;
    repeat
      // Verifica se é nulo
      if mestreCDS.fieldByName( camposParametroCDSnomeField.AsString ).AsString = '' then
        sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' is null '      
      else
      begin
        if camposParametroCDStipo.AsString = 'C' then
          sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + QuotedStr( mestreCDS.fieldByName( camposParametroCDSnomeField.AsString ).AsString )
        else
          if camposParametroCDStipo.AsString = 'D' then
            sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy', mestreCDS.fieldByName( camposParametroCDSnomeField.AsString ).AsDateTime ) )
          else
            sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + mestreCDS.fieldByName( camposParametroCDSnomeField.AsString ).AsString;
      end;
      camposParametroCDS.Next;
    until camposParametroCDS.Eof;
  end;
  result := sql_adicional;

end;

procedure TgraficoGerencialGenericoComparativoForm.mestreCDSAfterScroll(
  DataSet: TDataSet);
var sql_adicional : String;
    i : Integer;
    menor, maior : Double;
begin
  inherited;

  if not processar then
    Exit;
  // Monta Gráfico

  processandoPanel.Visible := true;
  processandoPanel.Refresh;

  detalheQy.Close;
  detalheQy.SQL.Text := sql_base_detalhe;

  if sql_select_detalhe = '' then
  begin
    msgAlerta('Defina o SQL Select');
    Exit
  end;

  if sql_base_detalhe = '' then
  begin
    msgAlerta('Defina o SQL Base');
    Exit
  end;

  if sql_group_by_detalhe = '' then
  begin
    msgAlerta('Defina o SQL Group By');
  end;

  detalheQy.SQL.Insert( 0, 'select ' + sql_select_detalhe );

  sql_adicional := '';

  if mestreCDS.FieldByName('ordem').AsInteger <> 999 then
  begin
    if not camposParametroDetalheCDS.IsEmpty then
    begin
      camposParametroDetalheCDS.First;
      repeat
        if mestreCDS.fieldByName( camposParametroDetalheCDSnomeField.AsString ).AsString = '' then
          sql_adicional := sql_adicional + ' and ' + camposParametroDetalheCDScampoParametro.AsString + ' is null '
        else
        begin
          if camposParametroDetalheCDStipo.AsString = 'C' then
            sql_adicional := sql_adicional + ' and Upper( ' + camposParametroDetalheCDScampoParametro.AsString + ' ) = Upper( ' + QuotedStr( mestreCDS.fieldByName( camposParametroDetalheCDSnomeField.AsString ).AsString ) + ' ) '
          else
            if camposParametroDetalheCDStipo.AsString = 'D' then
              sql_adicional := sql_adicional + ' and ' + camposParametroDetalheCDScampoParametro.AsString + ' = ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy', mestreCDS.fieldByName( camposParametroDetalheCDSnomeField.AsString ).AsDateTime ) )
            else
              sql_adicional := sql_adicional + ' and ' + camposParametroDetalheCDScampoParametro.AsString + ' = ' + mestreCDS.fieldByName( camposParametroDetalheCDSnomeField.AsString ).AsString;
        end;
        camposParametroDetalheCDS.Next;
      until camposParametroDetalheCDS.eof;
    end;
  end;

  detalheQy.SQL.Add( sql_adicional );
  detalheQy.SQL.Add( 'group by ' + sql_group_by_detalhe );

  Chart.Series[0].Clear;

  // Inicio do Datelhe

  detalheCDS.Close;
  detalheCDS.Fields.Clear;
  detalheCDS.FieldDefs.Clear;
  detalheCDS.Aggregates.Clear;
  detalheCDS.AggFields.Clear;
  detalheCDS.IndexDefs.Clear;
  if indice_detalhe <> '' then
  begin
    detalheCDS.IndexDefs.Add( 'idx', indice_detalhe, []);
    detalheCDS.IndexName := 'idx';
  end;

//  ShowMessage( detalheQy.sql.Text );

  detalheQy.Open;

  for i := 0 to Pred( detalheQy.Fields.Count ) do
  begin
    with detalheCDS.FieldDefs do
    begin
      with AddFieldDef do
      begin
        DataType := detalheQy.Fields[i].DataType;
        Name := detalheQy.Fields[i].FullName;
        if DataType = ftString then
          Size := detalheQy.Fields[i].Size;
        if ( DataType = ftCurrency ) or ( DataType = ftFMTBcd	) or ( DataType = ftFloat ) then
        begin
          Precision := 15;
          Size := 4;
        end;
      end;
    end;
  end;

  detalheCDS.CreateDataSet;

  detalheCDS.FieldByName('mes').Visible := false;
  detalheCDS.FieldByName('ano').Visible := false;

  menor := 99999999;
  maior := -99999999;
  if not detalheQy.IsEmpty then
  begin
    detalheCDS.EmptyDataSet;

    chart.LeftAxis.Automatic := true;
    repeat
      detalheCDS.Append;
      for i := 0 to Pred( detalheQy.Fields.Count ) do
      begin
        If detalheCDS.Fields[i] is TStringField then
          detalheCDS.Fields[i].AsString := AnsiLowerCase( detalheQy.Fields[i].AsString )
        else
        begin
          detalheCDS.Fields[i].Value := detalheQy.Fields[i].Value;
          if detalheQy.Fields[i].Value < menor then
            menor := detalheQy.Fields[i].Value;
          if detalheQy.Fields[i].Value > maior then
            maior := detalheQy.Fields[i].Value;
        end;
      end;
      detalheCDS.Post;
      detalheQy.Next;
    until detalheQy.Eof;

    detalheCDS.First;
    if detalheCDS.RecordCount > 1 then
    begin
      Repeat
        Chart.Series[0].Add( detalheCDS.FieldByName( campoValorDetalhe ).AsCurrency, AnsiLowerCase( detalheCDS.FieldByName( campoDescricaoDetalhe ).AsString ), clBlue );
        detalheCDS.Next;
      Until detalheCDS.Eof;
      Chart.Title.Text.Text := nm_titulo_grafico + ' - ' + mestreCDS.FieldByName( campoDescricao ).AsString;
      chart.LeftAxis.Automatic := false;
      chart.LeftAxis.Minimum := -9999999999;
      chart.LeftAxis.Maximum := maior * 1.2;
      chart.LeftAxis.Minimum := menor * 0.8;
      Chart.Visible := true;
    end
    else
      Chart.Visible := false;

    if not tituloCamposDetalheCDS.IsEmpty then
    begin
      tituloCamposDetalheCDS.First;
      repeat
        detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ).DisplayLabel := tituloCamposDetalheCDSnm_titulo.AsString;
        if ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TCurrencyField ) or ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TFloatField ) or ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TBCDField ) or ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TFMTBCDField ) then
        begin
          if ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TCurrencyField ) then
          begin
            ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) as TCurrencyField ).currency := false;
            ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) as TCurrencyField ).DisplayFormat := '#,##0.00';
          end;
          if ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TFloatField ) then
            ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) as TFloatField ).DisplayFormat := '#,##0.00';
          if ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TBCDField ) then
            ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) as TBCDField ).DisplayFormat := '#,##0.00';
          if ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) is TFMTBCDField ) then
            ( detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ) as TFMTBCDField ).DisplayFormat := '#,##0.00';
          detalheCDS.FieldByName( tituloCamposDetalheCDSnm_campo.AsString ).DisplayWidth := 20;
        end;
        tituloCamposDetalheCDS.Next;
      until tituloCamposDetalheCDS.Eof;
    end;
    detalheCDS.First;
  end;

  processandoPanel.Visible := False;

end;

procedure TgraficoGerencialGenericoComparativoForm.imprimirButtonClick(
  Sender: TObject);
var rec : Integer;
begin
  graficoGerencialGenericoTituloImpressaoForm := TgraficoGerencialGenericoTituloImpressaoForm.Create(Self);
  if titulo = '' then titulo := caption + ' ( ' + FormatDateTime( 'dd/mm/yyyy', dt_inicialEdit.DateTime ) + ' a ' + FormatDateTime( 'dd/mm/yyyy', dt_finalEdit.DateTime ) + ' )';
  graficoGerencialGenericoTituloImpressaoForm.tituloEdit.Text := titulo;
  graficoGerencialGenericoTituloImpressaoForm.ShowModal;
  if graficoGerencialGenericoTituloImpressaoForm.ModalResult = mrOk then
  begin
    titulo := graficoGerencialGenericoTituloImpressaoForm.tituloEdit.Text;
    rec := detalheCDS.RecNo;
    detalheCDS.First;
    rv.Execute;
    detalheCDS.RecNo := rec;
  end;
  graficoGerencialGenericoTituloImpressaoForm.Free;

end;

procedure TgraficoGerencialGenericoComparativoForm.FormCreate(
  Sender: TObject);
begin
  inherited;
  processar := False;
  indice_detalhe := 'ano;mes';
end;

procedure TgraficoGerencialGenericoComparativoForm.mostrarValoresCheckBoxClick(
  Sender: TObject);
var i : Byte;
begin
  for i := 0 to Pred( chart.SeriesCount ) do
  begin
    if mostrarValoresCheckBox.Checked then
      chart.series[i].Marks.Visible := True
    else
      chart.series[i].Marks.Visible := False;
  end;

end;

procedure TgraficoGerencialGenericoComparativoForm.DBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not mestreCDS.IsEmpty then
  begin
    if mestreCDS.FieldByName('ordem').AsInteger = 999 then
    begin
      DBGrid.Canvas.Font.Style := [ fsBold ];
      DBGrid.Canvas.FillRect( Rect );
      DBGrid.DefaultDrawDataCell( Rect, Column.Field, State  );
    end;
  end;

end;

procedure TgraficoGerencialGenericoComparativoForm.rvBeforePrint(
  Sender: TObject);
var  i : integer;
     alinhamento : TPrintJustify;
     j, tamanho, tamanhoCM, tamanhoPagina, pe, tamanhoTotal : Double;
     primeira : Boolean;
begin
  tamanhoTotal := 0;
  tamanhoCM    := 0;
  vezes        := 0;
  for i := 0 to Pred( detalheCDS.Fields.Count ) do
    if detalheCDS.Fields[i].Visible then
      tamanhoTotal := tamanhoTotal + detalheCDS.Fields[i].DisplayWidth;

  with sender as TBaseReport do
  begin
    repeat
      for i := 0 to Pred( detalheCDS.Fields.Count ) do
      begin
        if detalheCDS.Fields[i].Visible then
        begin
          pe := detalheCDS.Fields[i].DisplayWidth / tamanhoTotal;
          tamanhoCM := tamanhoCM + ( pe * 5.6 );
        end;
      end;
      if tamanhoCM < 28 then
        vezes := vezes + 1;
    until tamanhoCM > 28;

    ClearTabs;
    primeira := True;
    tamanhoPagina := ( 29 - MarginLeft - MarginRight ) / vezes;
    j := 1;
    repeat
      for i := 0 to Pred( detalheCDS.Fields.Count ) do
      begin
        if detalheCDS.Fields[i].Visible then
        begin
          pe := ( detalheCDS.Fields[i].DisplayWidth / tamanhoTotal ) * ( tamanhoPagina / vezes );
          tamanho := tamanhoPagina * pe;
          if ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TDateTimeField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TDateTimeField )  then
            alinhamento := pjCenter
          else
            if ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TIntegerField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TSmallintField ) then
              alinhamento := pjRight
            else
              if ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TFloatField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TCurrencyField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TFMTBCDField ) then
                alinhamento := pjRight
              else
                alinhamento := pjLeft;

          if primeira then
          begin
            SetTab( MarginLeft , alinhamento, tamanho, 1, BOXLINETOPBOTTOM, 0 );
            primeira := False;
          end
          else
            SetTab( NA         , alinhamento, tamanho, 1, BOXLINETOPBOTTOM, 0 )
        end;
      end;
      SetTab( NA         , pjCenter, 0.5, 1, BOXLINENONE, 0 );
      j := j + 1;
    until j > vezes;
    SaveTabs(1);
  end;

end;

procedure TgraficoGerencialGenericoComparativoForm.rvPrint(
  Sender: TObject);
var i, j, k, l : integer;
    x, y : Double;
    bitmap : TBitmap;
    cTop, cLeft, cWidth,cHeight : Integer;
begin
  With Sender as TBaseReport Do
  begin
    y := YPos;
    j := 0;
    k := 0;
    Bold := True;
    ClearTabs;
    RestoreTabs(1);
    for i := 0 to Pred( detalheCDS.Fields.Count ) do
      if detalheCDS.Fields[i].Visible then
      begin
        PrintTab( detalheCDS.Fields[i].DisplayName );
      end;

    repeat
      SetFont( 'Arial', 10 );
      Bold := False;
      NewLine;
      for  l := 1 to j do
      begin
        for i := 0 to Pred( detalheCDS.Fields.Count ) do
          if detalheCDS.Fields[i].Visible then
            PrintTab( '' );
        PrintTab('');
      end;

      for i := 0 to Pred( detalheCDS.Fields.Count ) do
      begin
        if detalheCDS.Fields[i].Visible then
        begin
          if ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TFloatField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TCurrencyField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).detalheCDS.Fields.Fields[i] is TFMTBCDField ) then
            PrintTab( FormatFloat( '#,##0.00', detalheCDS.fieldbyname( detalheCDS.Fields[i].FieldName ).AsCurrency ) )
          else
            PrintTab( detalheCDS.fieldbyname( detalheCDS.Fields[i].FieldName ).AsString );
        end;
      end;
      inc(k);
      detalheCDS.Next;
      if k > 17 then
      begin
        YPos := Y;
        inc(j);
        NewLine;
        Bold := True;
        for  l := 1 to j do
        begin
          for i := 0 to Pred( detalheCDS.Fields.Count ) do
            if detalheCDS.Fields[i].Visible then
              PrintTab( '' );
          PrintTab('');
        end;
        for i := 0 to Pred( detalheCDS.Fields.Count ) do
          if detalheCDS.Fields[i].Visible then
            PrintTab( detalheCDS.Fields[i].DisplayName );
        k := 0;
      end;
    until detalheCDS.Eof;
    y := 11;
    cTop    := chart.Top;
    cLeft   := chart.Left;
    cWidth  := chart.Width;
    cHeight := chart.Height;

    chart.Top := 0;
    chart.Left := 0;
    chart.Width := mainPanel.Width;
    chart.Height := mainPanel.Height;

    bitmap := TBitmap.Create;
    chart.Color := clWhite;
    chart.SaveToBitmapFile( 'c:\grafico.bmp' );
    chart.Color := clBtnFace;
    bitmap.LoadFromFile( 'c:\grafico.bmp' );
    x := MarginLeft;
    PrintBitmapRect( x, y, 28, 18, bitmap );
    bitmap.Free;
    chart.Top    := cTop;
    chart.Left   := cLeft;
    chart.Width  := cWidth;
    chart.Height := cHeight;
    
  end;

end;

procedure TgraficoGerencialGenericoComparativoForm.rvPrintFooter(
  Sender: TObject);
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

procedure TgraficoGerencialGenericoComparativoForm.rvPrintHeader(
  Sender: TObject);
var  i : integer;
  alinhamento : TPrintJustify;
  tamanho, tamanhoMeiaPagina, pe, tamanhoTotal : Double;
  primeira : Boolean;
begin
  tamanhoTotal := 0;
  for i := 0 to Pred( mestreCDS.Fields.Count ) do
    if mestreCDS.Fields[i].Visible then
      tamanhoTotal := tamanhoTotal + mestreCDS.Fields[i].DisplayWidth;

  with sender as TBaseReport do
  begin
    ClearTabs;
    primeira := True;
    tamanhoMeiaPagina := ( 29 - MarginLeft - MarginRight );
    for i := 0 to Pred( mestreCDS.Fields.Count ) do
    begin
      if mestreCDS.Fields[i].Visible then
      begin
        pe := mestreCDS.Fields[i].DisplayWidth / tamanhoTotal;
        tamanho := tamanhoMeiaPagina * pe;
        tamanho := tamanho + ( tamanho * 0.20 );
        if tamanho > 6.5 then tamanho := 6.5;
        alinhamento := pjCenter;
        if primeira then
        begin
          SetTab( MarginLeft , alinhamento, tamanho, 1, BOXLINETOPBOTTOM, 0 );
          primeira := False;
        end
        else
          SetTab( NA         , alinhamento, tamanho, 1, BOXLINETOPBOTTOM, 0 )
      end;
    end;
    SaveTabs(2);
    ClearTabs;
    RestoreTabs(2);
    Bold := True;
    SetFont( 'Arial', 14 );
    PrintXY( MarginLeft, MarginTop, titulo );
    SetFont( 'Arial', 10 );
    Bold := True;
    NewLine;
    for i := 0 to Pred( mestreCDS.Fields.Count ) do
    begin
      if mestreCDS.Fields[i].Visible then
      begin
        PrintTab( mestreCDS.Fields[i].DisplayName );
        XPos := XPos + 0.5;
      end;
    end;
    Bold := False;
    NewLine;
    for i := 0 to Pred( mestreCDS.Fields.Count ) do
    begin
      if mestreCDS.Fields[i].Visible then
      begin
        if ( TgraficoGerencialGenericoComparativoForm( Self ).mestreCDS.Fields.Fields[i] is TFloatField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).mestreCDS.Fields.Fields[i] is TCurrencyField ) or ( TgraficoGerencialGenericoComparativoForm( Self ).mestreCDS.Fields.Fields[i] is TFMTBCDField ) then
          PrintTab( FormatFloat( '#,##0.00', mestreCDS.fieldbyname( mestreCDS.Fields[i].FieldName ).AsCurrency ) )
        else
          PrintTab( mestreCDS.fieldbyname( mestreCDS.Fields[i].FieldName ).AsString );
        XPos := XPos + 0.5;
      end;
    end;
    NewLine;
    MoveTo( MarginLeft, YPos );
    LineTo( PageWidth - MarginRight, Ypos );
    NewLine;
    NewLine;
  End;

end;

procedure TgraficoGerencialGenericoComparativoForm.mestreQyBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  processandoPanel.Visible := true;
  processandoPanel.Refresh;
end;

procedure TgraficoGerencialGenericoComparativoForm.detalheQyBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  processandoPanel.Visible := true;
  processandoPanel.Refresh;
end;

procedure TgraficoGerencialGenericoComparativoForm.detalheQyAfterClose(
  DataSet: TDataSet);
begin
  inherited;
  processandoPanel.Visible := false;
end;

procedure TgraficoGerencialGenericoComparativoForm.mestreQyAfterClose(
  DataSet: TDataSet);
begin
  inherited;
  processandoPanel.Visible := false;
end;

end.
