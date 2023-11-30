unit consultaGenericaConsultaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, ExtCtrls, FMTBcd, SqlExpr, Menus, RpDefine,
  RpBase, RpSystem, DB, Grids, DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, StdCtrls, ComCtrls, Buttons, DBClient, wiseUnit, dateUtils;

type
  TconsultaGenericaConsultaForm = class(TFormBasicoPanelForm)
    tituloCamposCDS: TClientDataSet;
    tituloCamposCDSnm_campo: TStringField;
    tituloCamposCDSnm_titulo: TStringField;
    tituloCamposCDStamanho: TIntegerField;
    camposParametroCDS: TClientDataSet;
    camposParametroCDScampoParametro: TStringField;
    camposParametroCDSnomeField: TStringField;
    camposParametroCDStipo: TStringField;
    imprimirButton: TBitBtn;
    dt_inicialDate: TDateTimePicker;
    dt_finalDate: TDateTimePicker;
    mensagemLabel: TLabel;
    fecharButton: TBitBtn;
    buscaLabel: TLabel;
    buscaComboBox: TComboBox;
    JvDBGrid: TJvDBGrid;
    DataSource: TDataSource;
    rv: TRvSystem;
    PopupMenu: TPopupMenu;
    DetalharMenu: TMenuItem;
    N1: TMenuItem;
    qy: TSQLQuery;
    cds: TClientDataSet;
    procedure imprimirButtonClick(Sender: TObject);
    procedure rvBeforePrint(Sender: TObject);
    procedure rvPrintFooter(Sender: TObject);
    procedure rvPrint(Sender: TObject);
    procedure rvPrintHeader(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure JvDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure buscaComboBoxChange(Sender: TObject);
    procedure fecharButtonClick(Sender: TObject);
    procedure JvDBGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
  private
    { Private declarations }
    titulo : String;
    fg_debug : Boolean;
    ds_parametro_extra : String;
  public
    { Public declarations }
    sql_padrao, sql_select, sql_groupBy, sql_extra : String;
    usaData : Boolean;
    campoData, campoDescricao, campoValor : String;
    tipoConsulta : String;
    procedure adicionaTituloCampo( nm_campo, nm_titulo : String; limpar : Boolean = False; tamanho : Integer = -1 );
    procedure adicionaCondicaoParametro( nm_campo, nm_field, tipo : String; limpar : Boolean = False );
    function retornaSQLExtra( query : string ) : String;
    function retornaSQLParametros( query : string ) : String;
    procedure setDebugSQL( lfg_debug : Boolean );
    procedure setParametroExtra( ds_extra : String );
    function getParametroExtra : string;

  end;

var
  consultaGenericaConsultaForm: TconsultaGenericaConsultaForm;

implementation

uses DMUnit, globalUnit, GraficoGenericoTituloImpressaoUnit, Math;

{$R *.dfm}

{ TconsultaGenericaConsultaForm }

procedure TconsultaGenericaConsultaForm.adicionaCondicaoParametro(nm_campo,
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

procedure TconsultaGenericaConsultaForm.adicionaTituloCampo(nm_campo,
  nm_titulo: String; limpar: Boolean; tamanho: Integer);
begin
  if limpar then
    tituloCamposCDS.EmptyDataSet;

  tituloCamposCDS.Append;
  tituloCamposCDSnm_campo.AsString  := nm_campo;
  tituloCamposCDSnm_titulo.AsString := nm_titulo;
  tituloCamposCDStamanho.AsInteger  := tamanho;  
  tituloCamposCDS.Post;

end;

function TconsultaGenericaConsultaForm.retornaSQLExtra(
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

function TconsultaGenericaConsultaForm.retornaSQLParametros(
  query: string): String;
var sql_adicional : String;
begin
  sql_adicional := '';
  if not camposParametroCDS.IsEmpty then
  begin
    camposParametroCDS.First;
    repeat
      if camposParametroCDStipo.AsString = 'C' then
      begin
        if Copy( cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString, 1, 1 ) <> '0' then
          sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + QuotedStr( cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString )
        else
          sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' is null';
      end
      else
        if camposParametroCDStipo.AsString = 'D' then
          sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy', cds.fieldByName( camposParametroCDSnomeField.AsString ).AsDateTime ) )
        else
          if cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString <> '0' then
            sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' = ' + cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString
          else
            sql_adicional := sql_adicional + ' and ' + camposParametroCDScampoParametro.AsString + ' is null';

      camposParametroCDS.Next;
    until camposParametroCDS.Eof;
  end;
  result := sql_adicional;

end;

procedure TconsultaGenericaConsultaForm.imprimirButtonClick(
  Sender: TObject);
begin
  inherited;
  if not cds.IsEmpty then
  begin
    graficoGenericoTituloImpressaoForm := TgraficoGenericoTituloImpressaoForm.Create(Self);
    if titulo = '' then titulo := caption;
    graficoGenericoTituloImpressaoForm.tituloEdit.Text := titulo + ' ' + ds_parametro_extra;
    graficoGenericoTituloImpressaoForm.ShowModal;
    if graficoGenericoTituloImpressaoForm.ModalResult = mrOk then
    begin
      titulo := graficoGenericoTituloImpressaoForm.tituloEdit.Text;
      cds.DisableControls;
      cds.First;
      rv.SystemPrinter.Title := titulo;
      rv.Execute;
      cds.EnableControls;
      cds.First;
    end;
    graficoGenericoTituloImpressaoForm.Free;
  end
  else
    msgInformacao('A consulta está vazia');

end;

procedure TconsultaGenericaConsultaForm.rvBeforePrint(Sender: TObject);
var  i : integer;
  alinhamento : TPrintJustify;
  tamanho, pe, tamanhoTotal : Double;
  primeira : Boolean;
  tamanhoTotalCM : Double;
begin
  tamanhoTotal := 0;

  for i := 0 to Pred( JvDBGrid.Columns.Count ) do
    tamanhoTotal := tamanhoTotal + JvDBGrid.Columns[i].Width;


  with sender as TBaseReport do
  begin
    ClearTabs;
    tamanhoTotalCM := PageWidth - MarginLeft - MarginRight;

    primeira := True;
    for i := 0 to Pred( JvDBGrid.Columns.Count ) do
    begin
      pe := JvDBGrid.Columns[i].Width / tamanhoTotal;
      tamanho := tamanhoTotalCM * pe; // Tamanho em CM da Coluna
      if ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TDateTimeField ) or ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TDateTimeField )  then
        alinhamento := pjCenter
      else
        if ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TIntegerField ) or ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TSmallintField ) then
          alinhamento := pjRight
        else
          if ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) then
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

procedure TconsultaGenericaConsultaForm.rvPrintFooter(Sender: TObject);
begin
  inherited;
  imprimeRodapeRV(TBaseReport(Sender));
end;

procedure TconsultaGenericaConsultaForm.rvPrint(Sender: TObject);
var i, j, tamMax, o : integer;
    vl_outros : Array[0..15] of Double;
    teveOutros : Boolean;
begin
{  if rv.SystemPrinter.Orientation in [ poPortrait ] then
    tamMax := 71
  else
    tamMax := 42;}

  tamMax := 99999;    

  With Sender as TBaseReport Do
  begin
    for o := 0 to 15 do
      vl_outros[o] := 0;
    j := 1;
    teveOutros := false;
    repeat
      SetFont( 'Arial', 8 );
      Bold := False;
      if j < tamMax then
      begin
        NewLine;
        for i := 0 to Pred( cds.Fields.Count ) do
        begin
          if cds.fieldbyname( cds.Fields[i].FieldName ).Visible then
          begin
            if cds.fieldbyname( cds.Fields[i].FieldName ).AsString = 'TOTAL'  then
              Bold := True;
            if ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) then
               PrintTab( FormatFloat( '#,##0.00', cds.fieldbyname( cds.Fields[i].FieldName ).AsCurrency ) )
            else
               PrintTab( cds.fieldbyname( cds.Fields[i].FieldName ).AsString )
          end;
        end;
      end
      else
      begin
        o := 0;
        teveOutros := true;
        for i := 0 to Pred( cds.Fields.Count ) do
          if ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) then
          begin
            vl_outros[o] := vl_outros[o] + cds.fieldbyname( cds.Fields[i].FieldName ).AsCurrency;
            inc(o);
          end;
      end;
      Inc( j );
      if LinesLeft < 3 then
        NewPage;
      cds.Next;
    until cds.Eof;
    if teveOutros then
    begin
      o := 0;
      NewLine;      
      for i := 0 to Pred( cds.Fields.Count ) do
      begin
        if cds.fieldbyname( cds.Fields[i].FieldName ).Visible then
        begin
          Italic := True;
          if cds.Fields[i].FieldName = campoDescricao then
            PrintTab( 'Outros' )
          else
            if ( TconsultaGenericaConsultaForm( Self ).cds.Fields.Fields[i] is TCurrencyField ) then
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
  End;

end;

procedure TconsultaGenericaConsultaForm.rvPrintHeader(Sender: TObject);
var i : integer;
begin
  With Sender as TBaseReport Do
  begin
    Bold := True;
    SetFont( 'Arial', 14 );
    SetPen(clSilver,psSolid,-1,pmCopy);
    PrintXY( MarginLeft, MarginTop, titulo );
    SetFont( 'Arial', 8 );
    NewLine;
    if mensagemLabel.Caption <> 'Label' then
      PrintXY( PageWidth - MarginRight - ( Length(  mensagemLabel.Caption ) / 6 ), YPos, mensagemLabel.Caption );
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

procedure TconsultaGenericaConsultaForm.FormCreate(Sender: TObject);
begin
  inherited;
  sql_padrao := '';
  sql_select := '';
  sql_groupBy := '';
  sql_extra := '';
  campoValor := '';
  campoDescricao := '';
  usaData := false;
  campoData := '';
  fg_debug := false;
  TStringGrid(JvDBGrid).Options:= TStringGrid(JvDBGrid).Options-[goColMoving]; // Tira a Propriedade de pode mover as colunas

end;

procedure TconsultaGenericaConsultaForm.FormShow(Sender: TObject);
var i  : Integer;
    aValores  : Array[0..19] of Currency;
    criar_pe : boolean;
begin
  inherited;
  JvDBGrid.DataSource := nil;
  Qy.SQL.Text := sql_select + #13 + sql_padrao + #13 + sql_extra;

  if sql_groupBy <> '' then
    Qy.SQL.Add( sql_groupBy );
  if ( usaData ) and ( campoData <> '' ) then
    setParametroQy( qy, campoData + ' between ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy hh:nn:ss', StartOfTheDay( dt_inicialDate.DateTime ) ) ) + ' and ' + QuotedStr( FormatDateTime( 'mm/dd/yyyy hh:nn:ss', EndOfTheDay( dt_finalDate.DateTime ) ) ) );
  //ShowMessage( Qy.SQL.Text );

  if ( campoValor = '' ) and ( campoDescricao = '' ) then
  begin
    msgInformacao('Defina Campo Valor e Descrição');
    Exit;
  end;

  if ( sql_select <> '' ) and ( sql_padrao <> '' ) then
  begin
    if fg_debug then
      ShowMessage( qy.SQL.Text );
    try
      Qy.Open;
    except on e:exception do
      begin
        msgErro( e.Message );
        ShowMessage( qy.SQL.Text );
        exit;
      end;
    end;

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
        criar_pe := false;


        with cds.FieldDefs do
        begin
          with AddFieldDef do
          begin
            if not ( Qy.Fields[i].DataType = ftFMTBcd ) then
              DataType := Qy.Fields[i].DataType
            else
            begin
              DataType := ftCurrency;
              criar_pe := true;
              if AnsiPos( '_SEMPE_', qy.Fields[i].FieldName ) > 0 then
                criar_pe := false;

            end;
            Name := Qy.Fields[i].fieldName;
            if DataType = ftString then
              Size := Qy.Fields[i].Size;
          end;
          if criar_pe then
          begin
            with AddFieldDef do
            begin
              DataType := ftCurrency;
              Name := 'pe_' + Qy.Fields[i].fieldName;
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
      buscaComboBox.Items.Clear;
      Qy.First;
      Repeat
        cds.Append;
        for i := 0 to Pred( Qy.Fields.Count ) do
        begin
          If cds.FieldByName( Qy.Fields[i].fieldName ) is TStringField then
          begin
            if not camposParametroCDS.Locate( 'nomeField', Qy.Fields[i].fieldName, [] ) then
              cds.FieldByName( Qy.Fields[i].fieldName ).AsString := Qy.Fields[i].Value
            else
              cds.FieldByName( Qy.Fields[i].fieldName ).AsString := Qy.Fields[i].Value;
          end
          else
          begin
            cds.FieldByName( Qy.Fields[i].fieldName ).Value := Qy.Fields[i].Value;
            if ( cds.FieldByName( Qy.Fields[i].fieldName ).DataType = ftCurrency )then
              aValores[i] := aValores[i] + Qy.Fields[i].Value;
          end;
        end;
        cds.FieldByName('ordem').AsInteger := 1;
        cds.Post;
        buscaComboBox.Items.Add( Qy.fieldByName( campoDescricao ).AsString );
        Qy.Next;

      Until Qy.Eof;

      buscaComboBox.Sorted := true;

      cds.First;

      // Totais
      cds.Append;
      cds.FieldByName( campoDescricao ).AsString := 'TOTAL';
      cds.FieldByName('ordem').AsInteger := 999;

      for i := 0 to Pred( Qy.Fields.Count ) do
         if ( cds.FieldByName( Qy.Fields[i].fieldName ).DataType = ftCurrency )then
          cds.FieldByName( Qy.Fields[i].fieldName ).Value := aValores[i];

      cds.Post;

      // Percentual
      cds.First;

      repeat
        for i := 0 to Pred( Qy.Fields.Count ) do
         if ( cds.FieldByName( Qy.Fields[i].fieldName ).DataType = ftCurrency )then
         begin
           if AnsiPos( '_SEMPE_', cds.FieldByName( Qy.Fields[i].fieldName ).FieldName ) = 0 then
           begin
             if aValores[i] > 0 then
             begin
               cds.Edit;
               cds.FieldByName( 'pe_' + Qy.Fields[i].fieldName ).Value := ( cds.FieldByName( Qy.Fields[i].fieldName ).Value / aValores[i] ) * 100;
               cds.Post;
             end;
           end;
         end;
        cds.Next;
      until cds.Eof;


      cds.IndexName := 'idx';
      cds.First;

      // Formatar Campos
      if not tituloCamposCDS.IsEmpty then
      begin
        tituloCamposCDS.First;
        repeat
          cds.FieldByName( tituloCamposCDSnm_campo.AsString ).DisplayLabel := tituloCamposCDSnm_titulo.AsString;
          if ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ).DataType = ftCurrency )then
          begin
            if ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) is TCurrencyField ) then
            begin
              ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) as TCurrencyField ).currency := false;
              ( cds.FieldByName( tituloCamposCDSnm_campo.AsString ) as TCurrencyField ).DisplayFormat := '#,##0.00';
            end;
          end;
          if tituloCamposCDStamanho.AsInteger > 0 then
            cds.FieldByName( tituloCamposCDSnm_campo.AsString ).DisplayWidth := tituloCamposCDStamanho.AsInteger;
          tituloCamposCDS.Next;
        until tituloCamposCDS.Eof;
      end;

      for i := 0 to Pred( cds.Fields.Count ) do
        if AnsiPos( 'pe_', cds.Fields[i].FieldName ) > 0 then
        begin
          ( cds.Fields[i] as TCurrencyField ).DisplayLabel := '%';
          ( cds.Fields[i] as TCurrencyField ).currency := false;
          ( cds.Fields[i] as TCurrencyField ).DisplayFormat := '#,##0.00%';
          ( cds.Fields[i] as TCurrencyField ).DisplayWidth := 7;
        end;

      tituloCamposCDS.First;
      repeat
        if tituloCamposCDStamanho.AsInteger > 0 then
          cds.FieldByName( tituloCamposCDSnm_campo.AsString ).DisplayWidth := tituloCamposCDStamanho.AsInteger;
        tituloCamposCDS.Next;
      until tituloCamposCDS.Eof;

      cds.First;
      imprimirButton.Enabled := True;

    end
    else
      msgAlerta('Nada Encontrado');

    JvDBGrid.DataSource := DataSource;

    if usaData then
    begin
      mensagemLabel.Caption := 'Período: ' + FormatDateTime( 'dd/mm/yyyy', dt_inicialDate.DateTime ) + ' a ' + FormatDateTime( 'dd/mm/yyyy', dt_finalDate.DateTime );
      mensagemLabel.Visible := true;
    end
    else
      mensagemLabel.Caption := ''; 
  end
  else
    msgInformacao('Defina Corretamente o Select');

end;

procedure TconsultaGenericaConsultaForm.JvDBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not cds.IsEmpty then
  begin
    if cds.FieldByName('ordem').AsInteger = 999 then
    begin
      JvDBGrid.Canvas.Font.Style := [ fsBold ];
      JvDBGrid.Canvas.FillRect( Rect );
      JvDBGrid.DefaultDrawDataCell( Rect, Column.Field, State  );
    end;
  end;

end;

procedure TconsultaGenericaConsultaForm.buscaComboBoxChange(
  Sender: TObject);
begin
  inherited;
  cds.Locate( campoDescricao, buscaComboBox.Items[ buscaComboBox.ItemIndex ], [] );

end;

procedure TconsultaGenericaConsultaForm.JvDBGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
  inherited;
  cds.IndexDefs.Clear;
  cds.IndexFieldNames := 'ordem;' + Field.FieldName;

end;

procedure TconsultaGenericaConsultaForm.setDebugSQL(lfg_debug: Boolean);
begin
  fg_debug := lfg_debug;
end;

procedure TconsultaGenericaConsultaForm.setParametroExtra(
  ds_extra: String);
begin
  ds_parametro_extra := ds_extra;
end;

function TconsultaGenericaConsultaForm.getParametroExtra: string;
begin
  result := ds_parametro_extra;
end;

procedure TconsultaGenericaConsultaForm.fecharButtonClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
