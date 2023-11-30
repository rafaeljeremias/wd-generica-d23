unit ConsultaDetalhadaGenericaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, ComCtrls, ExtCtrls, StdCtrls, Buttons, DB,
  DBClient, Grids, DBGrids, JvExDBGrids, JvDBGrid, TeeProcs, TeEngine,
  Chart, Menus, FMTBcd, SqlExpr, wiseUnit, JvExControls, JvComponent,
  JvGroupHeader, JvExStdCtrls, JvEdit, JvValidateEdit,
  JvExExtCtrls, Series, Math,
  CheckLst, JvExCheckLst, JvCheckListBox, RpDefine, RpBase, RpSystem,
  RpRender, RpRenderPDF;

type
  TConsultaDetalhadaGenericaForm = class(TFormBasicoPanelForm)
    PageControl: TPageControl;
    consultaTabSheet: TTabSheet;
    graficoTabSheet: TTabSheet;
    parametrosTabSheet: TTabSheet;
    SairButton: TBitBtn;
    JvDBGrid: TJvDBGrid;
    cds: TClientDataSet;
    ds: TDataSource;
    imprimirButton: TBitBtn;
    Chart: TChart;
    condicaoCDS: TClientDataSet;
    condicaoCDScondicao: TStringField;
    condicaoCDSdescricao: TStringField;
    camposCDS: TClientDataSet;
    camposCDScampo: TStringField;
    camposCDSdescricao: TStringField;
    camposCDSchave: TStringField;
    camposCDSvisivel: TStringField;
    detalharComboBox: TComboBox;
    Label1: TLabel;
    DetalharButton: TBitBtn;
    detalharCDS: TClientDataSet;
    detalharCDScampo: TStringField;
    detalharCDSdescricao: TStringField;
    qy: TSQLQuery;
    camposCDSagregado: TStringField;
    camposCDSid: TIntegerField;
    detalharCDSid: TIntegerField;
    camposCDStipo: TStringField;
    parametroGroupBox: TGroupBox;
    condicoesGroupBox: TGroupBox;
    condicaoDS: TDataSource;
    condicaoJvDBGrid: TJvDBGrid;
    condicaoCDSfg_detalhe: TStringField;
    camposCDSordem: TStringField;
    outrosGroupBox: TGroupBox;
    Label2: TLabel;
    OutrosComboBox: TComboBox;
    outrosDepoisDeEdit: TJvValidateEdit;
    Label3: TLabel;
    outrosPeEdit: TJvValidateEdit;
    Label4: TLabel;
    outrosValorEdit: TJvValidateEdit;
    Label5: TLabel;
    reprocessarButton: TBitBtn;
    camposCDSdescritivo: TStringField;
    seriesGroupBox: TGroupBox;
    seriesJvCheckListBox: TJvCheckListBox;
    Label6: TLabel;
    posicaoLegendaComboBox: TComboBox;
    Label7: TLabel;
    rv: TRvSystem;
    impressaoGroupBox: TGroupBox;
    orientacaoComboBox: TComboBox;
    Label8: TLabel;
    RvPDF: TRvRenderPDF;
    rvGrafico: TRvSystem;
    camposCDSnome: TStringField;
    detalharCDSnome: TStringField;
    ordemCDS: TClientDataSet;
    ordemCDScampo: TStringField;
    ordemCDStipo: TStringField;
    procedure SairButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure JvDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DetalharButtonClick(Sender: TObject);
    procedure JvDBGridTitleClick(Column: TColumn);
    procedure reprocessarButtonClick(Sender: TObject);
    procedure seriesJvCheckListBoxClickCheck(Sender: TObject);
    procedure posicaoLegendaComboBoxChange(Sender: TObject);
    procedure rvBeforePrint(Sender: TObject);
    procedure rvPrint(Sender: TObject);
    procedure rvPrintFooter(Sender: TObject);
    procedure rvPrintHeader(Sender: TObject);
    procedure imprimirButtonClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure ChartClick(Sender: TObject);
    procedure rvGraficoPrintHeader(Sender: TObject);
    procedure rvGraficoPrint(Sender: TObject);

  private
    { Private declarations }
    campo_index_old, campo_desc_old : String; // Armazena o Ultimo Campo Ordenado Clicando no Título
    campoOutros, tituloAdicional : String;
    condicao_outros : Array[ 0..50 ] of String;
    procedure setCamposCDS; // Cria os campos adicionados no addCampo
    procedure setCDS; // monta o ClientDataSet da Consulta
    procedure setOutros; // Processa a condição de Outros
    procedure setGrafico; // Gera o Gráfico das Informações
  public
    { Public declarations }
    sql_base : String;
    procedure addCondicao( chave, condicao, descricao : String; fg_detalhe : String = 'N' );
    procedure addFiltro( condicao, descricao : String );
    procedure addCampo( campo, descricao, nome : String; tipo : String; agregado : Boolean = False; chave : Boolean = false; visivel : Boolean = True; campoDescritivo : Boolean = false; orderAsc : Boolean = False; orderDesc : Boolean = False );
    procedure addDetalhe( campo, descricao, nome : String; id : integer );
    procedure addOrdem( campo, tipo : String );

    procedure deleteCondicaoDetalhe;
    procedure setTitulo( titulo : String );
    procedure setTituloAdicional( descricao : String );
    function executaQuery : Boolean;
  end;
var
  ConsultaDetalhadaGenericaForm: TConsultaDetalhadaGenericaForm;
const
  sizeInteger  = 10;
  sizeString   = 1.5; // Multiplicado pelo size do campo
  sizeData     = 10;
  sizeCurrency = 15;
  sizePe       = 8;
implementation

uses DMUnit, StrUtils, globalUnit;

{$R *.dfm}

procedure TConsultaDetalhadaGenericaForm.SairButtonClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TConsultaDetalhadaGenericaForm.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl.ActivePageIndex := 0;
  campo_index_old := '';
  campo_desc_old  := '';
  campoOutros     := '';
  tituloAdicional := '';
end;

procedure TConsultaDetalhadaGenericaForm.addCampo(campo, descricao, nome: String;
  tipo : String; agregado : Boolean; chave : Boolean; visivel: Boolean; campoDescritivo : Boolean; orderAsc : Boolean; orderDesc : Boolean );
begin

  { campo - nome do campo na query
    descrição - descrição do campo para ser exibido na consulta
    tipo - tipo do campo. Tipos Válidos: I - Inteiro, S - String, D - Data, F - Currency
    agregado - Indica se o campo é agregado. Necessário para fazer não por o campo no group by
    chave - Indica se o campo é chave ou não. Necessário para fazer o detalhamento, esse campo será passado como parâmetro
    campoDescritivo - Indica se o campo é o campo principal de descrição. Usado no Label do Chart
    orderAsc - Ordena o campo em ordem ascendente
    orderDesc - Ordena o campo em ordem descendente
}

  if ( campo <> '' ) and ( descricao <> '' ) then
  begin
    if ( tipo <> 'I' ) and ( Copy( tipo, 1, 1 ) <> 'S' ) and ( tipo <> 'F' ) and ( tipo <> 'D' ) then
    begin
      msgInformacao('Tipo Inválido. Tipos Válidos: I - Inteiro, S[tamanho] - String, D - Data, F - Currency');
      exit;
    end;

    if ( orderAsc ) and ( orderDesc ) then
    begin
      msgInformacao('A Ordem deve ser ou ascendente ou descendente. Nunca Ambas.');
      exit;
    end;

    camposCDS.Append;
    camposCDScampo.AsString     := campo;
    camposCDSdescricao.AsString := descricao;
    camposCDSnome.AsString      := nome;

    if agregado then
      camposCDSagregado.AsString := 'S'
    else
      camposCDSagregado.AsString := 'N';
    if chave then
      camposCDSchave.AsString := 'S'
    else
      camposCDSchave.AsString := 'N';
    if visivel then
      camposCDSvisivel.AsString := 'S'
    else
      camposCDSvisivel.AsString := 'N';

    if campoDescritivo then
      camposCDSdescritivo.AsString := 'S'
    else
      camposCDSdescritivo.AsString := 'N';


    camposCDStipo.AsString := tipo;

    camposCDSordem.AsString := '';
    if orderAsc then
      camposCDSordem.AsString := 'asc';
    if orderDesc then
      camposCDSordem.AsString := 'desc';

    camposCDS.Post;

    if tipo = 'F' then
    begin
      OutrosComboBox.Items.Add( descricao );
      campoOutros := descricao;
    end;


  end;

end;

procedure TConsultaDetalhadaGenericaForm.addCondicao( chave, condicao, descricao : String; fg_detalhe : String  );
begin
  if ( chave <> '' ) and ( condicao <> '' ) and ( descricao <> '' ) then
  begin
    if not condicaoCDS.FindKey( [ chave + ' ' + condicao ] ) then
    begin
      condicaoCDS.Append;
      condicaoCDScondicao.AsString   := chave + ' ' + condicao;
      condicaoCDSdescricao.AsString  := descricao;
      condicaoCDSfg_detalhe.AsString := fg_detalhe;
      condicaoCDS.Post;
    end;

  end;
end;



procedure TConsultaDetalhadaGenericaForm.addDetalhe(campo,
  descricao, nome: String; id : integer );
begin
  detalharComboBox.Items.Add( descricao );
  detalharCDS.Append;
  detalharCDScampo.AsString     := campo;
  detalharCDSdescricao.AsString := descricao;
  detalharCDScampo.AsString     := nome;
  detalharCDSid.AsInteger       := id;
  detalharCDS.Post;
end;

procedure TConsultaDetalhadaGenericaForm.FormShow(Sender: TObject);
begin
  inherited;
  if detalharComboBox.Items.Count >= 0 then
    detalharComboBox.ItemIndex := 0;
end;

function TConsultaDetalhadaGenericaForm.executaQuery : Boolean;
var sql : String;
    groupby : string;
begin
  result := false;
  if not camposCDS.IsEmpty then
  begin
    // Campos Select
    sql := 'select ';
    camposCDS.First;
    repeat
      if sql <> 'select ' then
        sql := sql + ', ';
      sql := sql + camposCDScampo.AsString;
      camposCDS.Next;
    until camposCDS.Eof;
    // Tabelas
    sql := sql + sql_base;
    if AnsiPos( 'WHERE', AnsiUpperCase( sql ) ) = 0 then
      sql := sql + ' where 1=1 ';
    // Condições
    if not condicaoCDS.IsEmpty  then
    begin
      condicaoCDS.First;
      repeat
        sql := sql + ' and ' + condicaoCDScondicao.AsString;
        condicaoCDS.Next;
      until condicaoCDS.Eof;
    end;

    // Group by
    groupby := ' Group by ';
    camposCDS.First;
    repeat
      if camposCDSagregado.AsString = 'N' then
      begin
        if groupby <> ' Group by ' then
          groupby := groupby + ', ';
        groupby := groupby + camposCDScampo.AsString;
      end;
      camposCDS.Next;
    until camposCDS.Eof;
    sql := sql + groupby;
    setCamposCDS;
    qy.Close;
    qy.SQL.Text := sql;
 //   ShowMessage( sql );
    try
      qy.Open;
    except
      msgErro( sql );
    end;
    if qy.IsEmpty then
    begin
      msgAlerta('Nada Encontrado');
      result := false;
    end
    else
    begin
      result := true;
      setCDS; // Preenche CDS 
    end;
  end;

end;

procedure TConsultaDetalhadaGenericaForm.setCamposCDS;
var i, tamanho : integer;
    indice, camposDesc : String;
begin
  cds.Close;
  cds.IndexName := '';
  cds.FieldDefs.Clear;
  camposCDS.First;
  // Criação do Campo que posiciona o Total sempre na primeira linha
  with cds.FieldDefs do
  begin
    with cds.FieldDefs do
    begin
      with AddFieldDef do
      begin
        DisplayName := 'ordem';
        Name        := 'ordem';
        DataType    := ftInteger;
      end;
    end;
  end;

  // Criação dos Campos
  repeat
    with cds.FieldDefs do
    begin
      with AddFieldDef do
      begin
        DisplayName := camposCDSdescricao.AsString;
        Name        := camposCDSnome.AsString;
        if camposCDStipo.AsString = 'I' then
          DataType := ftInteger;
        if Copy( camposCDStipo.AsString, 1, 1 ) = 'S' then
        begin
          DataType := ftString;
          tamanho := StrToIntDef( Copy( camposCDStipo.AsString, 3, AnsiPos( ']', camposCDStipo.AsString ) - 3 ), 40 );
          size := tamanho;
        end;
        if camposCDStipo.AsString = 'F' then
          DataType := ftCurrency;
        if camposCDStipo.AsString = 'D' then
          DataType := ftDateTime;

        if camposCDSagregado.AsString = 'S' then
        begin
          with AddFieldDef do
          begin
            DisplayName := 'pe_' + camposCDSdescricao.AsString;
            Name        := 'pe_' + camposCDSnome.AsString;
            DataType    := ftCurrency;
          end;
        end;
      end;
    end;
    camposCDS.Next;
  until camposCDS.Eof;

  // Outros
  with cds.FieldDefs do
  begin
    with cds.FieldDefs do
    begin
      with AddFieldDef do
      begin
        DisplayName := 'outros';
        Name        := 'outros';
        DataType    := ftString;
        size        := 1;
      end;
    end;
  end;

  cds.CreateDataSet;

  // Seta os Labels
  camposCDS.First;
  cds.Fields[0].Visible := false;
  cds.Fields[ Pred( cds.FieldCount )].Visible := false;

  i := 1;
  repeat
    cds.Fields[i].DisplayLabel := camposCDSdescricao.AsString;
    cds.Fields[i].Visible      := camposCDSvisivel.AsString = 'S';
    if camposCDStipo.AsString = 'I' then
      cds.Fields[i].DisplayWidth := sizeInteger;
    if Copy( camposCDStipo.AsString, 1, 1 ) = 'S' then
    begin
      cds.Fields[i].DisplayWidth := Trunc( sizeString * StrToIntDef( Copy( camposCDStipo.AsString, 3, AnsiPos( ']', camposCDStipo.AsString ) - 3 ), 40 ) );
      if cds.Fields[i].DisplayWidth > 40 then
        cds.Fields[i].DisplayWidth := 40;
    end;
    if camposCDStipo.AsString = 'F' then
    begin
      cds.Fields[i].DisplayWidth := sizeCurrency;
      ( cds.Fields[i] as TCurrencyField ).currency := false;
      ( cds.Fields[i] as TCurrencyField ).DisplayFormat := '#,##0.00;(#,##0.00);-';
    end;
    if camposCDStipo.AsString = 'D' then
    begin
      cds.Fields[i].DisplayWidth := sizeData;
      ( cds.Fields[i] as TDateTimeField ).DisplayFormat := 'dd/mm/yyyy';
    end;

    if camposCDSagregado.AsString = 'S' then
    begin
      inc(i);
      cds.Fields[i].DisplayLabel := '%';
      cds.Fields[i].Visible      := true;
      cds.Fields[i].DisplayWidth := sizePe;
      ( cds.Fields[i] as TCurrencyField ).currency := false;
      ( cds.Fields[i] as TCurrencyField ).DisplayFormat := '#,##0.0%;(#,##0.0%);-';
    end;
    inc(i);
    camposCDS.Next;
  until camposCDS.Eof;

  // Cria o Índice

  if ordemCDS.IsEmpty then
  begin
    camposCDS.First;
    indice := 'ordem';
    camposDesc := '';
    repeat
      if camposCDSordem.AsString <> '' then
      begin
        indice := indice + ';' + camposCDSnome.AsString;
        if camposCDSordem.AsString = 'desc' then
        begin
          if camposDesc <> '' then
            camposDesc := camposDesc + ';';
          camposDesc := camposDesc + camposCDSnome.AsString;
        end;
      end;
      camposCDS.Next;
    until camposCDS.Eof;
  end
  else
  begin
    ordemCDS.First;
    indice := 'ordem';
    camposDesc := '';
    repeat
      if ordemCDScampo.AsString <> '' then
      begin
        if indice <> '' then
          indice := indice + ';';
        indice := indice + ordemCDScampo.AsString;
        if ordemCDStipo.AsString = 'D' then
        begin
          if camposDesc <> '' then
            camposDesc := camposDesc + ';';
          camposDesc := camposDesc + ordemCDScampo.AsString;
        end;
      end;
      ordemCDS.Next;
    until ordemCDS.Eof;
  end;


  cds.AddIndex( 'idx', indice, [], camposDesc );
  cds.IndexName := 'idx';


end;

procedure TConsultaDetalhadaGenericaForm.setCDS;
var i, j, k : integer;
    totais : Array[0..50] of Currency;
    pe : Currency;
begin
  for i := 0 to 50 do
    totais[i] := 0;

  // Calcula os Totais
  repeat
    cds.Append;
    i := 0;
    j := 0;
    cds.Fields[i].AsInteger := 1;
    camposCDS.First;
    repeat
      inc(i);
      if camposCDSagregado.AsString <> 'S' then // Se for um campos agregado, totaliza
        cds.Fields[i].Value := qy.Fields[j].Value
      ELSE
        cds.Fields[i].Value := SeNulo( qy.Fields[j].Value, 0 );      
      if camposCDSagregado.AsString = 'S' then // Se for um campos agregado, totaliza
      begin
        totais[i] := totais[i] + SeNulo( cds.Fields[i].Value, 0 );
        inc(i);
        cds.Fields[i].Value := 0;
      end;
      inc(j);
      camposCDS.Next;
    until camposCDS.Eof;
    cds.FieldByName('outros').AsString := 'N';
    cds.Post;
    qy.Next;
  until qy.Eof;

  // Totais
  // Procura o campo String com maior tamanho para por o label "Total"
  k := -1; // Posição do Maior campo string;
  j := 0; // Tamanho do Maior campo string;
  cds.First;
  cds.Insert;
  cds.Fields[0].AsInteger := 0;
  for i := 0 to 50 do
  begin
    if i <= Pred( cds.Fields.Count ) then
    begin
      if cds.Fields[i] is TStringField then
      begin
        if ( cds.Fields[i] as TStringField ).Size > j then
        begin
          k := i;
          j := ( cds.Fields[i] as TStringField ).Size;
        end;
      end;
      if cds.Fields[i] is TCurrencyField then // Põe o total
        cds.Fields[i].AsCurrency := totais[i];
    end;
  end;
  if k > -1 then
    cds.Fields[k].AsString := 'TOTAL';
  cds.FieldByName('outros').AsString := 'N';    
  cds.Post;


  // Percentua antes de outros devido a condição que leva em consideração o percentual
  cds.First;
  repeat
    i := 0;
    repeat
      if i <= Pred( cds.Fields.Count ) then
      begin
        if cds.Fields[i] is TCurrencyField then
        begin
          if totais[i] <> 0 then
            pe := ( cds.Fields[i].AsCurrency / totais[i] ) * 100
          else
            pe := 0;
          inc(i);
          cds.Edit;
          cds.Fields[i].AsCurrency := pe;
          cds.Post;
        end;
      end;
      inc(i);
    until i = 50;
    cds.Next;
  until cds.Eof;
  cds.First;

  // Processa Outros
  setOutros;

  // Percentua novamente devido ao outros
  cds.First;
  repeat
    i := 0;
    repeat
      if i <= Pred( cds.Fields.Count ) then
      begin
        if cds.Fields[i] is TCurrencyField then
        begin
          if totais[i] <> 0 then
            pe := ( cds.Fields[i].AsCurrency / totais[i] ) * 100
          else
            pe := 0;
          inc(i);
          cds.Edit;
          cds.Fields[i].AsCurrency := pe;
          cds.Post;
        end;
      end;
      inc(i);
    until i = 50;
    cds.Next;
  until cds.Eof;
  cds.First;

  setGrafico;

end;

procedure TConsultaDetalhadaGenericaForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TConsultaDetalhadaGenericaForm.JvDBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not cds.IsEmpty then
  begin
    if cds.FieldByName('ordem').AsInteger = 0 then
    begin
      JvDBGrid.Canvas.Font.Style := [fsBold];
      JvDBGrid.Canvas.FillRect( Rect );
      JvDBGrid.DefaultDataCellDraw( Rect, Column.Field, state );
    end;
    if cds.FieldByName('ordem').AsInteger = 2 then
    begin
      JvDBGrid.Canvas.Font.Style := [fsBold];
      JvDBGrid.Canvas.FillRect( Rect );
      JvDBGrid.DefaultDataCellDraw( Rect, Column.Field, state );
    end;

  end;
end;

procedure TConsultaDetalhadaGenericaForm.DetalharButtonClick(
  Sender: TObject);
var
  campo, condicao : String;
  i : Integer;
begin
  inherited;
  i := 0;
  camposCDS.First;
  repeat
    if camposCDSchave.AsString = 'S' then
    begin
      campo := camposCDSnome.AsString;
      if cds.FieldByName( 'ordem' ).AsString <> '0' then
      begin
        if cds.FieldByName( campo ).AsString <> '' then
        begin
          if camposCDStipo.AsString = 'I' then
            condicao := cds.FieldByName( campo ).AsString;
          if Copy( camposCDStipo.AsString, 1, 1 ) = 'S' then
            condicao := QuotedStr( cds.FieldByName( campo ).AsString );
          if camposCDStipo.AsString = 'D' then
            condicao := QuotedStr( FormatDateTime( 'mm/dd/yyyy', cds.FieldByName( campo ).AsDateTime ) );
          if camposCDStipo.AsString = 'F' then
            condicao :=  AnsiReplaceStr( FormatFloat( '0.00', cds.FieldByName( campo ).AsCurrency ), ',', '.' );
          addCondicao( camposCDScampo.AsString + ' = ', condicao, camposCDSdescricao.AsString + ' = ' + cds.FieldByName( campo ).AsString, 'S' );
        end;
        if condicao_outros[i] <> '' then
          addCondicao( camposCDScampo.AsString + ' in ( ', condicao_outros[i] + ') ', camposCDSdescricao.AsString + ' em ( ' + condicao_outros[i] + ' )', 'S' );

      end;
    end;
    inc(i);
    camposCDS.Next;
  until camposCDS.Eof;
end;


procedure TConsultaDetalhadaGenericaForm.addFiltro(condicao,
  descricao: String);
begin
  if ( condicao <> '' ) and ( descricao <> '' ) then
  begin
    if not condicaoCDS.FindKey( [ condicao ] ) then
    begin
      condicaoCDS.Append;
      condicaoCDScondicao.AsString  := condicao;
      condicaoCDSdescricao.AsString := descricao;
      condicaoCDS.Post;
    end;

  end;
end;

procedure TConsultaDetalhadaGenericaForm.deleteCondicaoDetalhe;
begin
  condicaoCDS.First;
  repeat
    if condicaoCDSfg_detalhe.AsString = 'S' then
      condicaoCDS.Delete
    else
      condicaoCDS.Next;
  until condicaoCDS.Eof;
  condicaoCDS.First;
end;

procedure TConsultaDetalhadaGenericaForm.JvDBGridTitleClick(
  Column: TColumn);
var indice, camposDesc : String;
begin
  inherited;

  cds.IndexName := '';
  cds.DeleteIndex('idx');
  // Ordena pelo Campo Clicado
  camposCDS.First;
  indice := 'ordem;';
  camposDesc := '';

  indice := indice + Column.FieldName;
  if ( Column.FieldName = campo_index_old ) and ( campo_desc_old = '' ) then
    camposDesc := Column.FieldName;

  campo_index_old := Column.FieldName;
  campo_desc_old  := camposDesc;

  cds.AddIndex( 'idx', indice, [], camposDesc );
  cds.IndexName := 'idx';

end;

procedure TConsultaDetalhadaGenericaForm.setOutros;
var
  qtd_registros, i : Integer;
  eh_outros : boolean;
  campo : String;
  valor, pe : Currency;
  vl_outros : Currency;
  k, j : integer;
begin
  // Seta campo de outros

  vl_outros := 0;

  if OutrosComboBox.ItemIndex = -1 then
  begin
    if campoOutros <> '' then
      OutrosComboBox.ItemIndex := OutrosComboBox.Items.IndexOf( campoOutros )
    else
      OutrosComboBox.ItemIndex := Pred( OutrosComboBox.Items.Count );
  end;

  camposCDS.IndexName := 'idx';
  camposCDS.FindKey( [ OutrosComboBox.Text ] );
  campo := camposCDSnome.AsString;

  for qtd_registros := 0 to 50 do
    condicao_outros[qtd_registros] := '';


  if not cds.IsEmpty then
  begin
    cds.First;
    qtd_registros := 1;
    repeat
      if cds.Fields[0].AsInteger = 1 then
      begin
        valor := cds.fieldByName( campo ).AsCurrency;
        pe    := cds.fieldByName( 'pe_'+ campo ).AsCurrency;
        eh_outros := ( valor < outrosValorEdit.Value ) or ( pe < outrosPeEdit.Value ) or ( ( outrosDepoisDeEdit.Value > 0 ) and ( qtd_registros > outrosDepoisDeEdit.Value ) );
        if eh_outros then
        begin
          vl_outros := vl_outros + valor;
          cds.Edit;
          cds.FieldByName('outros').AsString := 'S';
          cds.Post;
          camposCDS.First;
          i := 0;
          repeat
            if camposCDSchave.AsString = 'S' then
            begin
              if condicao_outros[i] <> '' then
                condicao_outros[i] := condicao_outros[i] + ', ';
              if camposCDStipo.AsString = 'I' then
                condicao_outros[i] := condicao_outros[i] + cds.FieldByName( camposCDSnome.AsString ).AsString;
              if camposCDStipo.AsString = 'F' then
                condicao_outros[i] := condicao_outros[i] + AnsiReplaceStr( FormatFloat( '0.00', cds.FieldByName( camposCDSnome.AsString ).AsCurrency ), ',', '.' );;
              if Copy( camposCDStipo.AsString, 1, 1 ) = 'S' then
                condicao_outros[i] := condicao_outros[i] + QuotedStr( cds.FieldByName( camposCDSnome.AsString ).AsString );
              if camposCDStipo.AsString = 'D' then
                condicao_outros[i] := condicao_outros[i] + QuotedStr( FormatDateTime( 'mm/dd/yyyy', cds.FieldByName( camposCDSnome.AsString ).AsDateTime ) );
            end;
            camposCDS.Next;
            inc(i);
          until camposCDS.Eof;
        end;
        inc( qtd_registros );
      end;
      cds.Next;
    until cds.Eof;
  end;
  if vl_outros > 0 then
  begin
    // Totais
    // Procura o campo String com maior tamanho para por o label "Total"
    k := -1; // Posição do Maior campo string;
    j := 0; // Tamanho do Maior campo string;
    cds.First;
    cds.Insert;
    cds.Fields[0].AsInteger := 2;
    for i := 0 to 50 do
    begin
      if i <= Pred( cds.Fields.Count ) then
      begin
        if cds.Fields[i] is TStringField then
        begin
          if ( cds.Fields[i] as TStringField ).Size > j then
          begin
            k := i;
            j := ( cds.Fields[i] as TStringField ).Size;
          end;
        end;
      end;
    end;
    if k > -1 then
      cds.Fields[k].AsString := 'OUTROS';
    cds.FieldByName('outros').AsString := 'N';
    cds.FieldByName( campo ).AsCurrency := vl_outros;
    cds.Post;

    cds.First;
    repeat
      if cds.FieldByName('outros').AsString = 'S' then
        cds.Delete
      else
        cds.Next;
    until cds.Eof;
  end;
  cds.First;


end;

procedure TConsultaDetalhadaGenericaForm.reprocessarButtonClick(
  Sender: TObject);
begin
  inherited;
  camposCDS.First;
  repeat
    camposCDS.Edit;
    camposCDSordem.AsString := '';
    camposCDS.Post;
    camposCDS.Next;
  until camposCDS.Eof;

  camposCDS.IndexName := 'idx';
  camposCDS.FindKey( [ OutrosComboBox.Text ] );
  camposCDS.Edit;
  camposCDSordem.AsString := 'desc';
  camposCDS.Post;
  camposCDS.IndexName := '';

  executaQuery;
end;

procedure TConsultaDetalhadaGenericaForm.setGrafico;
var
  graficoBarra : TBarSeries;
  i, j : Integer;
  descricaoLabel : String;
  campoDescricao : Array[0..50] of String;
begin
  for j := Pred( chart.SeriesCount ) downto 0 do
    chart.Series[j].Free;
    
  for j := 0 to 50 do
    campoDescricao[j] := '';

  camposCDS.First;
  j := 0;
  repeat
    if camposCDSdescritivo.AsString = 'S' then
    begin
      campoDescricao[j] := camposCDSnome.AsString;
      inc(j);
    end;
    camposCDS.Next;
  until camposCDS.Eof;

  camposCDS.First;
  j := 0; // Indicador da Serie
  repeat
    if camposCDSagregado.AsString = 'S' then
    begin
      graficoBarra := TBarSeries.Create( chart );
      graficoBarra.Title := camposCDSdescricao.AsString;
      graficoBarra.ShowInLegend := true;
      graficoBarra.Marks.Visible := true;
      graficoBarra.Marks.Style := smsValue;
      chart.AddSeries( graficoBarra );
      cds.First;
      repeat
        if cds.FieldByName('ordem').AsInteger <> 0 then
        begin
          descricaoLabel := '';
          for i := 0 to 50 do
          begin
            if campoDescricao[i] <> '' then
            begin
              if descricaoLabel <> '' then
                descricaoLabel := descricaoLabel + ' - ';
              descricaoLabel := descricaoLabel + CDS.fieldByName( campoDescricao[i] ).AsString;
            end;
          end;
          chart.Series[j].Add( cds.fieldByName( camposCDSnome.AsString ).AsCurrency, descricaoLabel );
        end;
        cds.Next;
      until cds.Eof;
      inc(j);
    end;
    camposCDS.Next;
  until camposCDS.Eof;

  seriesJvCheckListBox.Items.Clear;

  for j := 0 to Pred( Chart.SeriesCount ) do
  begin
    chart.Series[j].Active := true;
    seriesJvCheckListBox.Items.Add( chart.Series[j].Title );
    seriesJvCheckListBox.Checked[j] := true;
  end;

  chart.LeftAxis.AxisValuesFormat   := '#,##0.00;(#,##0.00);-';
  chart.RightAxis.AxisValuesFormat  := '#,##0.00;(#,##0.00);-';
  chart.TopAxis.AxisValuesFormat    := '#,##0.00;(#,##0.00);-';
  chart.BottomAxis.AxisValuesFormat := '#,##0.00;(#,##0.00);-';

  chart.Title.Text.Text := caption;

  cds.First;

  posicaoLegendaComboBoxChange(Self);
end;

procedure TConsultaDetalhadaGenericaForm.seriesJvCheckListBoxClickCheck(
  Sender: TObject);
var j : Integer;
begin
  inherited;
  for j := 0 to Pred( Chart.SeriesCount ) do
    chart.Series[j].Active := seriesJvCheckListBox.Checked[j];

end;

procedure TConsultaDetalhadaGenericaForm.setTitulo(titulo: String);
begin
  caption := titulo;
  if tituloAdicional <> '' then
    Caption := Caption + ' - ' + tituloAdicional;
end;

procedure TConsultaDetalhadaGenericaForm.setTituloAdicional(
  descricao: String);
begin
  tituloAdicional := descricao;
end;

procedure TConsultaDetalhadaGenericaForm.posicaoLegendaComboBoxChange(
  Sender: TObject);
begin
  inherited;
  Chart.Legend.Visible := not ( posicaoLegendaComboBox.Text = 'Sem Legenda' );

  if posicaoLegendaComboBox.Text = 'Esquerda' then
    Chart.Legend.Alignment := laLeft;

  if posicaoLegendaComboBox.Text = 'Direita' then
    Chart.Legend.Alignment := laRight;

  if posicaoLegendaComboBox.Text = 'Acima' then
    Chart.Legend.Alignment := laTop;

  if posicaoLegendaComboBox.Text = 'Abaixo' then
    Chart.Legend.Alignment := laBottom;

end;

procedure TConsultaDetalhadaGenericaForm.rvBeforePrint(Sender: TObject);
var  i : integer;
  alinhamento : TPrintJustify;
  tamanho, tamanhoMeiaPagina, pe, tamanhoTotal : Double;
  primeira : Boolean;
begin
  tamanhoTotal := 0;
  for i := 0 to Pred( cds.Fields.Count ) do
    if cds.Fields[i].Visible then
      tamanhoTotal := tamanhoTotal + cds.Fields[i].DisplayWidth;

  with sender as TBaseReport do
  begin
    ClearTabs;
    primeira := True;
    tamanhoMeiaPagina := ( PageWidth - ( MarginLeft + MarginRight ) );
    for i := 0 to Pred( cds.Fields.Count ) do
    begin
      if ( cds.Fields[i].Visible ) then
      begin
        pe := cds.Fields[i].DisplayWidth / tamanhoTotal;
        tamanho := tamanhoMeiaPagina * pe;
        if ( cds.Fields.Fields[i] is TDateTimeField ) then
          alinhamento := pjCenter
        else
          if ( cds.Fields.Fields[i] is TIntegerField ) or ( cds.Fields.Fields[i] is TSmallintField ) then
            alinhamento := pjRight
          else
            if ( cds.Fields.Fields[i] is TFloatField ) or ( cds.Fields.Fields[i] is TCurrencyField ) or ( cds.Fields.Fields[i] is TFMTBCDField ) then
              alinhamento := pjRight
            else
              alinhamento := pjLeft;

        if primeira then
        begin
          SetTab( MarginLeft , alinhamento, tamanho, 1, BOXLINEALL, 0 );
          primeira := False;
        end
        else
          SetTab( NA         , alinhamento, tamanho, 1, BOXLINEALL, 0 )
      end;
    end;
    SaveTabs(1);
  end;

end;

procedure TConsultaDetalhadaGenericaForm.rvPrint(Sender: TObject);
var i : integer;
begin
  With Sender as TBaseReport Do
  begin
    repeat
      setProximaPaginaRV( TBaseReport(Sender) );
      SetFont( 'Arial', 10 );
      Bold := False;
      ClearTabs;
      RestoreTabs(1);
      NewLine;
      for i := 0 to Pred( cds.Fields.Count ) do
      begin
        if cds.fieldbyname( cds.Fields[i].FieldName ).Visible then
        begin
          if ( cds.fieldbyname( cds.Fields[i].FieldName ).AsString = 'TOTAL' ) or ( cds.fieldbyname( cds.Fields[i].FieldName ).AsString = 'OUTROS' ) then
            Bold := True;
          if ( cds.Fields.Fields[i] is TFloatField ) or ( cds.Fields.Fields[i] is TCurrencyField ) or ( cds.Fields.Fields[i] is TFMTBCDField ) then
            PrintTab( FormatFloat( ( cds.fieldbyname( cds.Fields[i].FieldName ) as TCurrencyField ).displayformat, cds.fieldbyname( cds.Fields[i].FieldName ).AsCurrency ) )
          else
          begin
            if bold then // se for total ou outros
              PrintTab( cds.fieldbyname( cds.Fields[i].FieldName ).AsString )
            else
              PrintTab( AnsiLowerCase( cds.fieldbyname( cds.Fields[i].FieldName ).AsString ) );
          end;
        end;
      end;
      cds.Next;
    until cds.Eof;
    cds.First;
  End;

end;

procedure TConsultaDetalhadaGenericaForm.rvPrintFooter(Sender: TObject);
begin
  inherited;
  imprimeRodapeRV(TBaseReport(Sender));
end;

procedure TConsultaDetalhadaGenericaForm.rvPrintHeader(Sender: TObject);
var condicao : Array[0..100] of String;
    i : integer;
begin
  inherited;
  for i := 0 to 100 do
   condicao[i] := '';
  with Sender as TBaseReport do
  begin
    setFont('Arial',10);
    if not condicaoCDS.IsEmpty then
    begin
      condicaoCDS.First;
      i := 0;
      repeat
        condicao[i] := setFiltroRelatorio( '-', condicaoCDSdescricao.AsString, '-' );
        inc(i);
        condicaoCDS.Next;
      until condicaoCDS.Eof;
    end;
    bold := true;
    imprimeCabecalhoRV( TBaseReport(Sender), rv.TitleStatus, condicao  );
    SetFont( 'Arial', 10 );
    Bold := True;
    ClearTabs;
    RestoreTabs(1);
    NewLine;
    for i := 0 to Pred( cds.Fields.Count ) do
    begin
      if cds.fieldbyname( cds.Fields[i].FieldName ).Visible then
        PrintTab( cds.fieldbyname( cds.Fields[i].FieldName ).DisplayLabel );
    end;

    bold := false;
  end;

end;

procedure TConsultaDetalhadaGenericaForm.imprimirButtonClick(
  Sender: TObject);
begin
  inherited;
  cds.DisableControls;
  cds.First;
  if PageControl.ActivePage = consultaTabSheet then
  begin
    if not cds.IsEmpty then
    begin
      setParametroRV( rv, Caption );
      if orientacaoComboBox.ItemIndex = 0 then
        rv.SystemPrinter.Orientation := poPortrait
      else
        rv.SystemPrinter.Orientation := poLandScape;
      setParametroRV( Rv, 'Consulta Detalhada' );        
      rv.execute;
    end;
  end;
  if PageControl.ActivePage = graficoTabSheet then
  begin
    if not cds.IsEmpty then
    begin
      setParametroRV( rvGrafico, Caption );
      if orientacaoComboBox.ItemIndex = 0 then
        rvGrafico.SystemPrinter.Orientation := poPortrait
      else
        rvGrafico.SystemPrinter.Orientation := poLandScape;
      rvGrafico.execute;
    end;
  end;
  cds.EnableControls;
end;

procedure TConsultaDetalhadaGenericaForm.PageControlChange(
  Sender: TObject);
begin
  inherited;
  imprimirButton.Visible := not ( PageControl.ActivePage = parametrosTabSheet );
end;

procedure TConsultaDetalhadaGenericaForm.ChartClick(Sender: TObject);
Var serieGrafico : TChartSeries;
    i : integer;
begin
  inherited;
  if Chart.Series[0] is THorizBarSeries then
  begin
    for i := 0 to Pred( chart.SeriesCount ) do
    begin
      serieGrafico := Chart.Series[i];
      ChangeSeriesType( serieGrafico, TBarSeries );
    end;
    exit;
  end;
  if Chart.Series[0] is TBarSeries then
  begin
    for i := 0 to Pred( chart.SeriesCount ) do
    begin
      serieGrafico := Chart.Series[i];
      if chart.SeriesCount = 1 then
        ChangeSeriesType( serieGrafico, TPieSeries )
      else
      begin
        ChangeSeriesType( serieGrafico, TLineSeries );
        ( chart.Series[i] as TLineSeries ).LinePen.Width := 2;
        ( chart.Series[i] as TLineSeries ).Pointer.Visible := True;
      end;
     end;
    exit;
  end;

  if Chart.Series[0] is TPieSeries then
  begin
    for i := 0 to Pred( chart.SeriesCount ) do
    begin
      serieGrafico := Chart.Series[i];
      ChangeSeriesType( serieGrafico, TLineSeries );
      ( chart.Series[i] as TLineSeries ).LinePen.Width := 2;
      ( chart.Series[i] as TLineSeries ).Pointer.Visible := True;      
    end;
    exit;
  end;
  if Chart.Series[0] is TLineSeries then
  begin
    for i := 0 to Pred( chart.SeriesCount ) do
    begin
      serieGrafico := Chart.Series[i];
      ChangeSeriesType( serieGrafico, THorizBarSeries );
    end;
    exit;
  end;

end;

procedure TConsultaDetalhadaGenericaForm.rvGraficoPrintHeader(
  Sender: TObject);
var
  i : integer;
  condicao : Array[0..100] of String;    
begin
  inherited;
  for i := 0 to 100 do
   condicao[i] := '';
  with Sender as TBaseReport do
  begin
    setFont('Arial',10);
    if not condicaoCDS.IsEmpty then
    begin
      condicaoCDS.First;
      i := 0;
      repeat
        condicao[i] := setFiltroRelatorio( '-', condicaoCDSdescricao.AsString, '-' );
        inc(i);
        condicaoCDS.Next;
      until condicaoCDS.Eof;
    end;
    bold := true;
    imprimeCabecalhoRV( TBaseReport(Sender), rvGrafico.TitleStatus, condicao  );
  end;
end;


procedure TConsultaDetalhadaGenericaForm.rvGraficoPrint(Sender: TObject);
var
  bitmap : TBitmap;
  maximizou : Boolean;
begin
  inherited;
  maximizou := false;
  if not ( self.WindowState = wsMaximized ) then
  begin
    self.WindowState := wsMaximized;
    maximizou := true;
  end;
  With Sender as TBaseReport Do
  begin
    bitmap := TBitmap.Create;
    chart.Color := clWhite;
    chart.Title.Visible := false;
    chart.SaveToBitmapFile( ExtractFilePath( Application.ExeName ) + '\grafico.bmp' );
    chart.Title.Visible := true;
    chart.Color  := clBtnFace;
    bitmap.LoadFromFile( ExtractFilePath( Application.ExeName ) + '\grafico.bmp' );

    if rvGrafico.SystemPrinter.Orientation = poPortrait then
      PrintBitmapRect( MarginLeft, YPos, PageWidth - MarginLeft - MarginRight, PageHeight - YPOS - MarginBottom - 10, bitmap )
    else
      PrintBitmapRect( MarginLeft, YPos, PageWidth - MarginLeft - MarginRight, PageHeight - YPOS - MarginBottom, bitmap );
    bitmap.Free;
    DeleteFile( ExtractFilePath( Application.ExeName ) + '\grafico.bmp' );

  end;
  if maximizou then
    self.WindowState := wsNormal;

end;

procedure TConsultaDetalhadaGenericaForm.addOrdem(campo, tipo: String);
begin
  ordemCDS.Append;
  ordemCDScampo.AsString     := campo;
  ordemCDStipo.AsString      := tipo;
  ordemCDS.Post;
end;

end.
