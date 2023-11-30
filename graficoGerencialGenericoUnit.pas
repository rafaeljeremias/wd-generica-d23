unit graficoGerencialGenericoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, Buttons, TeEngine, Series, TeeProcs, Chart,
  Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, ExtCtrls, FMTBcd,
  JvComponent, JvBaseDlg, JvProgressDialog, RpDefine, RpBase, RpSystem, DB,
  DBClient, SqlExpr, JvDBGridExport, ShellAPI, wiseUnit;

type
  TgraficoGerencialGenericoForm = class(TFormBasicoPanelForm)
    fecharButton: TBitBtn;
    exportarButton: TBitBtn;
    imprimirButton: TBitBtn;
    DBGrid: TJvDBGrid;
    chart: TChart;
    Series1: THorizBarSeries;
    graficoSpeedButton: TSpeedButton;
    gridSpeedButton: TSpeedButton;
    Qy: TSQLQuery;
    DS: TDataSource;
    cds: TClientDataSet;
    tituloCamposCDS: TClientDataSet;
    tituloCamposCDSnm_campo: TStringField;
    tituloCamposCDSnm_titulo: TStringField;
    rv: TRvSystem;
    camposParametroCDS: TClientDataSet;
    camposParametroCDScampoParametro: TStringField;
    camposParametroCDSnomeField: TStringField;
    camposParametroCDStipo: TStringField;
    SaveDialog: TSaveDialog;
    JvProgressDialog: TJvProgressDialog;
    mensagemLabel: TLabel;
    processandoPanel: TPanel;
    procedure fecharButtonClick(Sender: TObject);
    procedure imprimirButtonClick(Sender: TObject);
    procedure graficoSpeedButtonClick(Sender: TObject);
    procedure chartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure rvBeforePrint(Sender: TObject);
    procedure rvPrint(Sender: TObject);
    procedure rvPrintFooter(Sender: TObject);
    procedure rvPrintHeader(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure exportarButtonClick(Sender: TObject);
    procedure QyAfterClose(DataSet: TDataSet);
    procedure QyBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    peChart, peGrid : Double;
    procedure SaveDoc(AExportClass: TJvCustomDBGridExportClass; const Filename: string);
    procedure DoExportProgress(Sender: TObject; Min, Max, Position: Cardinal; const AText: string; var AContinue: Boolean);
  public
    { Public declarations }
    campoDescricao, campoValor, sql, sql_inicial, sql_extra, titulo : String;
    tipo : String;
    formMae : Boolean;
    procedure montaGrafico;
    procedure insereWhere( expressao : string );
    procedure adicionaTituloCampo( nm_campo, nm_titulo : String; limpar : Boolean = False );
    procedure adicionaCondicaoParametro( nm_campo, nm_field, tipo : String; limpar : Boolean = False );
    function retornaSQLExtra( query : string ) : String;
    function retornaSQLParametros( query : string ) : String;
  end;

var
  graficoGerencialGenericoForm: TgraficoGerencialGenericoForm;

implementation

uses graficoGerencialGenericoTituloImpressaoUnit, GlobalUnit;

{$R *.dfm}

procedure TgraficoGerencialGenericoForm.adicionaCondicaoParametro(nm_campo,
  nm_field, tipo: String; limpar: Boolean);
begin
  if limpar then
    camposParametroCDS.EmptyDataSet;

  camposParametroCDS.Append;
  camposParametroCDScampoParametro.AsString  := nm_campo;
  camposParametroCDSnomeField.AsString := nm_field;
  camposParametroCDStipo.AsString := tipo;
  camposParametroCDS.Post;
end;

procedure TgraficoGerencialGenericoForm.adicionaTituloCampo(nm_campo,
  nm_titulo: String; limpar: Boolean);
begin
  if limpar then
    tituloCamposCDS.EmptyDataSet;

  tituloCamposCDS.Append;
  tituloCamposCDSnm_campo.AsString  := nm_campo;
  tituloCamposCDSnm_titulo.AsString := nm_titulo;
  tituloCamposCDS.Post;

end;

procedure TgraficoGerencialGenericoForm.DoExportProgress(Sender: TObject;
  Min, Max, Position: Cardinal; const AText: string;
  var AContinue: Boolean);
begin
  JvProgressDialog.Min := Min;
  JvProgressDialog.Max := Max;
  JvProgressDialog.Position := Position;
  JvProgressDialog.Caption := AText;
  if Max > 0 then
    JvProgressDialog.Text := Format('Exportando (%d%% finished)', [round(Position / Max * 100)]);
  AContinue := not JvProgressDialog.Cancelled;
  if not AContinue or (Position >= Max) then
    JvProgressDialog.Hide;
end;

procedure TgraficoGerencialGenericoForm.fecharButtonClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TgraficoGerencialGenericoForm.insereWhere(expressao: string);
var sql : String;
begin
  sql := Qy.SQL.Text;
  If AnsiPos( '1=1', sql ) > 0 then
    Insert( expressao, sql, Pos( '1=1', sql ) + 4 );
  If AnsiPos( '2=2', Qy.SQL.Text ) > 0 then
    Insert( expressao, sql, Pos( '2=2', sql ) + 4 );
  Qy.SQL.Text := sql;
//   ShowMessage( Qy.SQL.Text );

end;

procedure TgraficoGerencialGenericoForm.montaGrafico;
var vl_outros : currency;
    itens, i  : Integer;
    cor       : TColor;
    aValores  : Array[0..19] of Currency;
begin

  cds.DisableControls;

  for i := 0 to Pred( Length( aValores ) ) do
    aValores[i] := 0;

  Qy.Open;
  // Monta Campos do CDS
  if not Qy.IsEmpty then
  begin
    cds.Close;
    cds.Fields.Clear;
    cds.FieldDefs.Clear;
    cds.Aggregates.Clear;
    cds.AggFields.Clear;
    cds.IndexDefs.Clear;

    for i := 0 to Pred( Qy.Fields.Count ) do
    begin
      with cds.FieldDefs do
      begin
        with AddFieldDef do
        begin
          DataType := Qy.Fields[i].DataType;
          Name := Qy.Fields[i].FullName;
          if DataType = ftString then
            Size := Qy.Fields[i].Size;
          if ( DataType = ftCurrency ) or ( DataType = ftFMTBcd	) or ( DataType = ftFloat ) then
          begin
            Precision := 15;
            Size := 4;
          end;
        end;
      end;
    end;
    with cds.FieldDefs do // Ordem de Exibição dos Valores
    begin
      with AddFieldDef do
      begin
        DataType := ftInteger;
        Name := 'ordem';
      end;
    end;

    cds.IndexDefs.Add( 'idx', 'ordem;' + campoValor, [ixDescending]);
    cds.IndexDefs.Add( 'idx1', campoValor, [ ixDescending ]);
    cds.IndexName := 'idx1';

    cds.CreateDataSet;

    cds.FieldByName('ordem').Visible := false;

    // Monta Grid
    Qy.First;
    Repeat
      cds.Append;
      for i := 0 to Pred( Qy.Fields.Count ) do
      begin
        If cds.Fields[i] is TStringField then
        begin
          if not camposParametroCDS.FindKey( [ Qy.Fields[i].FieldName ] ) then
            cds.Fields[i].AsString := AnsiLowerCase( Qy.Fields[i].AsString )
          else
            cds.Fields[i].AsString := Qy.Fields[i].AsString;
        end
        else
        begin
          cds.Fields[i].Value := Qy.Fields[i].Value;
          if ( cds.Fields[i] is TCurrencyField ) or ( cds.Fields[i] is TFloatField ) or ( cds.Fields[i] is TFMTBCDField ) then
            aValores[i] := aValores[i] + cds.Fields[i].Value;
        end;
      end;
      cds.FieldByName('ordem').AsInteger := 1;
      cds.Post;
      Qy.Next;
    Until Qy.Eof;

    cds.First;

    // Monta Gráfico
    itens     := 1;
    vl_outros := 0;

    Chart.Series[0].Clear;
    Repeat
      Case itens of
        1 : cor := clBlue;
        2 : cor := clRed;
        3 : cor := clGreen;
        4 : cor := clPurple;
        5 : cor := clYellow;
        else cor := clGray;
      end;
      if itens <= 5 then
        Chart.Series[0].Add( cds.FieldByName( campoValor ).AsCurrency, AnsiLowerCase( cds.FieldByName( campoDescricao ).AsString ), cor )
      else
        vl_outros := vl_outros + cds.FieldByName( campoValor ).AsCurrency;
      Cds.Next;
      Inc( itens );
    Until Cds.Eof;

    if vl_outros > 0 then
       Chart.Series[0].Add( vl_outros, 'Outros', cor );


    // Totais
    cds.Append;
    cds.FieldByName( campoDescricao ).AsString := 'TOTAL';
    cds.FieldByName('ordem').AsInteger := 999;

    for i := 0 to Pred( Qy.Fields.Count ) do
      if ( cds.Fields[i] is TCurrencyField ) or ( cds.Fields[i] is TFloatField ) or ( cds.Fields[i] is TFMTBCDField ) then
        cds.Fields[i].Value := aValores[i];

    cds.Post;

    cds.IndexName := 'idx';
    cds.First;

    // Formatação do CDS
    if not tituloCamposCDS.IsEmpty then
    begin
      tituloCamposCDS.First;
      repeat
        cds.FieldByName( tituloCamposCDSnm_campo.AsString ).DisplayLabel := tituloCamposCDSnm_titulo.AsString;
        if ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TCurrencyField ) or ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TFloatField ) or ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TBCDField ) or ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TFMTBCDField ) then
        begin
          if ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TCurrencyField ) then
          begin
            ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) as TCurrencyField ).currency := false;
            ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) as TCurrencyField ).DisplayFormat := '#,##0.00';
          end;
          if ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TFloatField ) then
            ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) as TFloatField ).DisplayFormat := '#,##0.00';
          if ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TBCDField ) then
            ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) as TBCDField ).DisplayFormat := '#,##0.00';
          if ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TFMTBCDField ) then
            ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) as TFMTBCDField ).DisplayFormat := '#,##0.00';
          cds.FieldByName( tituloCamposCDSnm_campo.AsString ).DisplayWidth := 20;
        end;
        tituloCamposCDS.Next;
      until tituloCamposCDS.Eof;
    end;

    cds.First;
    imprimirButton.Enabled := True;
    exportarButton.Enabled := True;

  end
  else
    msgAlerta('Nada Encontrado');

  cds.EnableControls;

  qy.Close;

end;

function TgraficoGerencialGenericoForm.retornaSQLExtra(
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

function TgraficoGerencialGenericoForm.retornaSQLParametros(
  query: string): String;
var sql_adicional : String;
begin
  sql_adicional := '';
  if not camposParametroCDS.IsEmpty then
  begin
    camposParametroCDS.First;
    repeat
      if cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString = '' then
        sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' is null '      
      else
      begin
        if camposParametroCDStipo.AsString = 'C' then
          sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + QuotedStr( cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString )
        else
          if camposParametroCDStipo.AsString = 'D' then
            sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy', cds.fieldByName( camposParametroCDSnomeField.AsString ).AsDateTime ) )
          else
            sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString;
      end;
      camposParametroCDS.Next;
    until camposParametroCDS.Eof;
  end;
  result := sql_adicional;
end;

procedure TgraficoGerencialGenericoForm.SaveDoc(
  AExportClass: TJvCustomDBGridExportClass; const Filename: string);
var
  AExporter: TJvCustomDBGridExport;
begin
  AExporter := AExportClass.Create(self);
  try
    AExporter.Grid := DBGrid;
    if AExporter is TJvDBGridCSVExport then
      TJvDBGridCSVExport(AExporter).ExportSeparator := esComma; // this to be compatible with JvCsvData
    AExporter.Filename := Filename;
    AExporter.OnProgress := DoExportProgress;
    JvProgressDialog.Caption := AExporter.Caption;
    JvProgressDialog.Show;
    AExporter.ExportGrid;
  finally
    AExporter.Free;
  end;

end;

procedure TgraficoGerencialGenericoForm.imprimirButtonClick(
  Sender: TObject);
var rec : Integer;
begin
  inherited;
  graficoGerencialGenericoTituloImpressaoForm := TgraficoGerencialGenericoTituloImpressaoForm.Create(Self);
  if titulo = '' then titulo := caption;
  graficoGerencialGenericoTituloImpressaoForm.tituloEdit.Text := titulo;
  graficoGerencialGenericoTituloImpressaoForm.ShowModal;
  if graficoGerencialGenericoTituloImpressaoForm.ModalResult = mrOk then
  begin
    titulo := graficoGerencialGenericoTituloImpressaoForm.tituloEdit.Text;
    rec := cds.RecNo;
    cds.DisableControls;
    cds.First;
    rv.Execute;
    cds.EnableControls;    
    cds.RecNo := rec;

  end;
  graficoGerencialGenericoTituloImpressaoForm.Free;

end;

procedure TgraficoGerencialGenericoForm.graficoSpeedButtonClick(
  Sender: TObject);
begin
  inherited;
  if ( graficoSpeedButton.Down ) and ( gridSpeedButton.Down ) then
  begin
    DBGrid.Height := Round( ( mainPanel.Height * peGrid ) );
    Chart.Height  := Round( ( mainPanel.Height * peChart ) );
    Chart.Top   := DBGrid.Top + DBGrid.Height + 7;
  end
  else
  begin
    if ( gridSpeedButton.Down ) then
      DBGrid.Height := mainPanel.Height - 55;
    if ( graficoSpeedButton.Down ) then
    begin
      Chart.Height := mainPanel.Height - 55;
      Chart.Top  := DBGrid.Top;
    end;
  end;


  if graficoSpeedButton.Down then
    Chart.Visible := True
  else
    Chart.Visible := False;

  if gridSpeedButton.Down then
    DBGrid.Visible := True
  else
    DBGrid.Visible := False;

end;

procedure TgraficoGerencialGenericoForm.chartClick(Sender: TObject);
Var serieGrafico : TChartSeries;
begin
  inherited;
  Chart.Legend.Visible := False;
  Chart.View3DOptions.Orthogonal := True;
  if Chart.Series[0] is THorizBarSeries then
  begin
    serieGrafico := Chart.Series[0];
    ChangeSeriesType( serieGrafico, TBarSeries );
    Exit;
  end;
  if Chart.Series[0] is TBarSeries then
  begin
    serieGrafico := Chart.Series[0];
    Chart.Legend.Visible := True;
    ChangeSeriesType( serieGrafico, TPieSeries );
    Exit;
  end;

  if Chart.Series[0] is TPieSeries then
  begin
    Chart.View3DOptions.Orthogonal := False;
    serieGrafico := Chart.Series[0];
    ChangeSeriesType( serieGrafico, TLineSeries );
    Exit;
  end;
  if Chart.Series[0] is TLineSeries then
  begin
    serieGrafico := Chart.Series[0];
    ChangeSeriesType( serieGrafico, THorizBarSeries );
    if Chart.View3D then
      Chart.View3D := False
    else
      Chart.View3D := True;
    Exit;
  end;
end;

procedure TgraficoGerencialGenericoForm.FormShow(Sender: TObject);
begin
  inherited;
  if mensagemLabel.Caption = 'Label' then
    mensagemLabel.Visible := False
  else
    mensagemLabel.Visible := True;
  if sql_extra <> '' then
     insereWhere( sql_extra );

  sql_inicial := qy.SQL.Text;

  if qy.SQL.Text = '' then
    Exit;

//  ShowMessage( qy.SQL.Text );

  if ( campoDescricao <> '' ) and ( campoValor <> '' ) then
    montaGrafico;


  if titulo <> '' then
  begin
    Caption := Caption + ' ( ' + titulo + ' )';
    Chart.Title.Text.Add( ' ( ' + titulo + ' )' );
  end
  else
  begin
    Chart.Title.Text.Clear;
    Chart.Title.Text.Add( Caption );
  end;

end;

procedure TgraficoGerencialGenericoForm.FormResize(Sender: TObject);
begin
  inherited;
  graficoSpeedButtonClick( Self );
end;

procedure TgraficoGerencialGenericoForm.rvBeforePrint(Sender: TObject);
var  i : integer;
  alinhamento : TPrintJustify;
  tamanho, tamanhoMeiaPagina, pe, tamanhoTotal : Double;
  primeira : Boolean;
begin
  tamanhoTotal := 0;
  for i := 0 to Pred( cds.Fields.Count ) do
    tamanhoTotal := tamanhoTotal + cds.Fields[i].DisplayWidth;

  with sender as TBaseReport do
  begin
    if DBGrid.Visible then
    begin
      ClearTabs;
      primeira := True;
      if chart.Visible then
        tamanhoMeiaPagina := ( 29 - MarginLeft - MarginRight ) / 2
      else
        tamanhoMeiaPagina := ( 29 - MarginLeft - MarginRight );
      for i := 0 to Pred( cds.Fields.Count ) do
      begin
        pe := cds.Fields[i].DisplayWidth / tamanhoTotal;
        tamanho := tamanhoMeiaPagina * pe;
        tamanho := tamanho + ( tamanho * 0.20 );
        if tamanho < 1 then tamanho := 1;        
        if tamanho > 8.5 then tamanho := 8.5;
        if ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TDateTimeField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TDateTimeField )  then
          alinhamento := pjCenter
        else
          if ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TIntegerField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TSmallintField ) then
            alinhamento := pjRight
          else
            if ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFloatField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFMTBCDField ) then
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

  end;

end;

procedure TgraficoGerencialGenericoForm.rvPrint(Sender: TObject);
var i, j, o : integer;
    x, y, tamanho, compensacaoX, compensacaoY : Double;
    bitmap : TBitmap;
    vl_outros : Array[0..15] of Double;
    cTop, cLeft, cWidth,cHeight : Integer;
begin
  With Sender as TBaseReport Do
  begin
    y := YPos;
    if DBGrid.Visible then
    begin
      for o := 0 to 15 do
        vl_outros[o] := 0;
      j := 1;
      repeat
        SetFont( 'Arial', 10 );
        Bold := False;
        if j < 37 then
        begin
          NewLine;
          for i := 0 to Pred( cds.Fields.Count ) do
          begin
            if cds.fieldbyname( cds.Fields[i].FieldName ).Visible then
            begin
              if cds.fieldbyname( cds.Fields[i].FieldName ).AsString = 'TOTAL'  then
                Bold := True;
              if ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFloatField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFMTBCDField ) then
                 PrintTab( FormatFloat( '#,##0.00', cds.fieldbyname( cds.Fields[i].FieldName ).AsCurrency ) )
              else
                 PrintTab( AnsiLowerCase( cds.fieldbyname( cds.Fields[i].FieldName ).AsString ) )
            end;
          end;
        end
        else
        begin
          // Soma valor a outros
          o := 0;
          for i := 0 to Pred( cds.Fields.Count ) do
            if ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFloatField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFMTBCDField ) then
            begin
              vl_outros[o] := vl_outros[o] + cds.fieldbyname( cds.Fields[i].FieldName ).AsCurrency;
              inc(o);
            end;
        end;
        Inc( j );
        cds.Next;
      until cds.Eof;
      // Mostra Outros
      if vl_outros[0] > 0 then
      begin
        o := 0;
        NewLine;
        for i := 0 to Pred( cds.Fields.Count ) do
        begin
          if cds.fieldbyname( cds.Fields[i].FieldName ).Visible then
          begin
            Italic := True;
            if AnsiLowerCase( cds.Fields[i].FieldName ) = AnsiLowerCase( campoDescricao ) then
              PrintTab( 'Outros' )
            else
              if ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFloatField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) or ( TgraficoGerencialGenericoForm( Self ).cds.Fields.Fields[i] is TFMTBCDField ) then
              begin
                PrintTab( FormatFloat( '#,##0.00', vl_outros[o] ) );
                Inc(o);
              end
              else
                PrintTab( '' );
            Italic := False;
          end;
        end;
      end;
    end;
    if chart.Visible then
    begin
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
      chart.Color  := clBtnFace;
      bitmap.LoadFromFile( 'c:\grafico.bmp' );
      if DBGrid.Visible then
      begin
        x := ( ( 29 - MarginLeft - MarginRight ) / 2 ) + 3;
        tamanho := 12;
        compensacaoX := ( tamanho * 0.05 );
        compensacaoY := ( tamanho * 0.10 ) * -1;
      end
      else
      begin
        x := 2;
        tamanho := 15;
        compensacaoX := ( tamanho * 0.55 );
        compensacaoY := ( tamanho * 0.10 ) * -1;
      end;
      chart.Top    := cTop;
      chart.Left   := cLeft;
      chart.Width  := cWidth;
      chart.Height := cHeight;

      PrintBitmapRect( x, y, x + tamanho + compensacaoX, y + tamanho + compensacaoY, bitmap );
      bitmap.Free;
    end;
  End;

end;

procedure TgraficoGerencialGenericoForm.rvPrintFooter(Sender: TObject);
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

procedure TgraficoGerencialGenericoForm.rvPrintHeader(Sender: TObject);
var i : integer;
begin
  With Sender as TBaseReport Do
  begin
    Bold := True;
    SetFont( 'Arial', 14 );
    PrintXY( MarginLeft, MarginTop, titulo );
    SetFont( 'Arial', 10 );
    if mensagemLabel.Caption <> 'Label' then
      PrintXY( PageWidth - MarginRight - ( Length(  mensagemLabel.Caption ) / 6 ), MarginTop, mensagemLabel.Caption );
    Bold := True;
    NewLine;
    MoveTo( MarginLeft, YPos );
    LineTo( PageWidth - MarginRight, Ypos );
    NewLine;
    NewLine;
    for i := 0 to Pred( cds.Fields.Count ) do
      if cds.fieldbyname( cds.Fields[i].FieldName ).Visible then
        PrintTab( cds.Fields[i].DisplayName );
    Bold := False;
  End;

end;

procedure TgraficoGerencialGenericoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TgraficoGerencialGenericoForm.FormCreate(Sender: TObject);
begin
  peChart := chart.Height  / mainPanel.Height;
  peGrid  := dbgrid.Height / mainPanel.Height;
  formMae := False;
  inherited;

end;

procedure TgraficoGerencialGenericoForm.DBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not cds.IsEmpty then
  begin
    if cds.FieldByName('ordem').AsInteger = 999 then
    begin
      DBGrid.Canvas.Font.Style := [ fsBold ];
      DBGrid.Canvas.FillRect( Rect );
      DBGrid.DefaultDrawDataCell( Rect, Column.Field, State  );
    end;
  end;  
end;

procedure TgraficoGerencialGenericoForm.exportarButtonClick(
  Sender: TObject);
begin
  inherited;
  if SaveDialog.Execute then
  begin
    case SaveDialog.FilterIndex of
      1: SaveDoc(TJvDBGridWordExport, SaveDialog.Filename);
      2: SaveDoc(TJvDBGridExcelExport, SaveDialog.Filename);
      3: SaveDoc(TJvDBGridHTMLExport, SaveDialog.Filename);
      4: SaveDoc(TJvDBGridCSVExport, SaveDialog.Filename);
      5: SaveDoc(TJvDBGridXMLExport, SaveDialog.Filename);
    end;
    // Open doc in default app
    ShellExecute(Handle, 'open', PChar(SaveDialog.Filename), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TgraficoGerencialGenericoForm.QyAfterClose(DataSet: TDataSet);
begin
  inherited;
  processandoPanel.Visible := false;
  processandoPanel.Refresh;
end;

procedure TgraficoGerencialGenericoForm.QyBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  processandoPanel.Visible := true;
  processandoPanel.Refresh;

end;

end.
