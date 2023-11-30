unit ConsultaGenericaImpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoUnit, Grids, DBGrids, DB, DBClient, Buttons, RpDefine,
  RpBase, RpSystem, StdCtrls, ExtCtrls, IniFiles, ImgList, Math,
  ComCtrls, WDPrinter, WiseUnit, StrUtils, RpRender, RpRenderPDF;

type
  TconsultaGenericaImpressaoForm = class(TFormBasicoForm)
    camposDisponiveisGraficoCDS: TClientDataSet;
    camposSelecionadosGraficoCDS: TClientDataSet;
    camposDisponiveisGraficoCDSnm_campo: TStringField;
    camposDisponiveisGraficoCDSds_campo: TStringField;
    camposDisponiveisGraficoCDStamanho: TIntegerField;
    camposSelecionadosGraficoCDSnm_campo: TStringField;
    camposSelecionadosGraficoCDSds_campo: TStringField;
    camposSelecionadosGraficoCDStamanho: TFloatField;
    camposSelecionadosGraficoCDSordem: TIntegerField;
    camposSelecionadosGraficoCDSquebra: TStringField;
    camposDisponiveisGraficoDataSource: TDataSource;
    camposSelecionadosGraficoDataSource: TDataSource;
    Rv: TRvSystem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    camposSelecionadosGraficoCDSalinhamento: TStringField;
    camposDisponiveisGraficoCDSalinhamento: TStringField;
    camposSelecionadosGraficoCDStipo: TStringField;
    camposDisponiveisGraficoCDStipo: TStringField;
    checkBoxImageList: TImageList;
    alinhamentoImageList: TImageList;
    camposSelecionadosGraficoCDSfuncao: TStringField;
    impressaoPageControl: TPageControl;
    modoGraficoTabSheet: TTabSheet;
    modoMatricialTabSheet: TTabSheet;
    Panel1: TPanel;
    removerGraficoSpeedButton: TSpeedButton;
    removerGraficoTodosSpeedButton: TSpeedButton;
    Label2: TLabel;
    Label1: TLabel;
    adicionarGraficoTodosSpeedButton: TSpeedButton;
    adicionarGraficoSpeedButton: TSpeedButton;
    pularLinhaCadaRegistroCheckBox: TCheckBox;
    orientacaoRadioGroup: TRadioGroup;
    margensGroupBox: TGroupBox;
    margemSuperiorEdit: TLabeledEdit;
    margemInferiorEdit: TLabeledEdit;
    margemEsquerdaEdit: TLabeledEdit;
    margemDireitaEdit: TLabeledEdit;
    camposSelecionadosGraficoDBGrid: TDBGrid;
    camposDisponiveisGraficoDBGrid: TDBGrid;
    cabecalhoGroupBox: TGroupBox;
    imprimirNumeroPaginaCheckBox: TCheckBox;
    imprimirDataHoraCheckBox: TCheckBox;
    tituloCabecalhoEdit: TEdit;
    rodapeGroupBox: TGroupBox;
    tituloRodapeEdit: TEdit;
    ajusteAutomaticoCamposCheckBox: TCheckBox;
    bottomPanel: TPanel;
    abrirButton: TBitBtn;
    ImprimirButton: TBitBtn;
    fecharButton: TBitBtn;
    salvaButton: TBitBtn;
    camposDisponiveisMatricialDBGrid: TDBGrid;
    Label3: TLabel;
    adicionarMatricialSpeedButton: TSpeedButton;
    adicionarTudoMatricialSpeedButton: TSpeedButton;
    removerMatricialSpeedButton: TSpeedButton;
    removerTudoMatricialSpeedButton: TSpeedButton;
    camposSelecionadosMatricialDBGrid: TDBGrid;
    Label4: TLabel;
    Panel2: TPanel;
    abrirEsquemaMatricialButton: TBitBtn;
    imprimirMatricialButton: TBitBtn;
    cancelarMatricialButton: TBitBtn;
    salvarEsquemaMatricialButton: TBitBtn;
    GroupBox1: TGroupBox;
    tituloCabecalhoMatricialEdit: TEdit;
    pularLinhaCadaRegistroMatricialCheckBox: TCheckBox;
    camposDisponiveisMatricialCDS: TClientDataSet;
    camposDisponiveisMatricialCDSnm_campo: TStringField;
    camposDisponiveisMatricialCDSds_campo: TStringField;
    camposDisponiveisMatricialCDStamanho: TIntegerField;
    camposDisponiveisMatricialCDSalinhamento: TStringField;
    camposDisponiveisMatricialCDStipo: TStringField;
    camposDisponiveisMatricialDataSource: TDataSource;
    camposSelecionadosMatricialCDS: TClientDataSet;
    camposSelecionadosMatricialCDSnm_campo: TStringField;
    camposSelecionadosMatricialCDSds_campo: TStringField;
    camposSelecionadosMatricialCDStamanho: TIntegerField;
    camposSelecionadosMatricialCDSordem: TIntegerField;
    camposSelecionadosMatricialCDSquebra: TStringField;
    camposSelecionadosMatricialCDSalinhamento: TStringField;
    camposSelecionadosMatricialCDStipo: TStringField;
    camposSelecionadosMatricialCDSfuncao: TStringField;
    camposSelecionadosMatricialCDScaracteres: TStringField;
    camposSelecionadosMatricialDataSource: TDataSource;
    GroupBox2: TGroupBox;
    margemEsquerdaMatricialEdit: TLabeledEdit;
    linhasPorPaginaEdit: TLabeledEdit;
    distanciaMatricialEdit: TLabeledEdit;
    arquivoCSVCheckBox: TCheckBox;
    caracterSeparadorEdit: TLabeledEdit;
    camposSelecionadosGraficoCDSvl_funcao: TCurrencyField;
    camposSelecionadosMatricialCDSvl_funcao: TCurrencyField;
    linhasGradeCheckBox: TCheckBox;
    WDPrinter: TWDPrinter;
    RvRenderPDF1: TRvRenderPDF;
    procedure adicionarGraficoSpeedButtonClick(Sender: TObject);
    procedure adicionarGraficoTodosSpeedButtonClick(Sender: TObject);
    procedure removerGraficoSpeedButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure removerGraficoTodosSpeedButtonClick(Sender: TObject);
    procedure RvPrintHeader(Sender: TObject);
    procedure imprimirButtonClick(Sender: TObject);
    procedure RvPrint(Sender: TObject);
    procedure camposSelecionadosGraficoCDSalinhamentoValidate(Sender: TField);
    procedure RvPrintFooter(Sender: TObject);
    procedure camposSelecionadosGraficoDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure camposDisponiveisGraficoDBGridDblClick(Sender: TObject);
    procedure camposSelecionadosGraficoDBGridColEnter(Sender: TObject);
    procedure camposSelecionadosGraficoDBGridCellClick(Column: TColumn);
    procedure salvaButtonClick(Sender: TObject);
    procedure abrirButtonClick(Sender: TObject);
    procedure fecharButtonClick(Sender: TObject);
    procedure margemSuperiorEditExit(Sender: TObject);
    procedure margemDireitaEditExit(Sender: TObject);
    procedure margemEsquerdaEditExit(Sender: TObject);
    procedure margemInferiorEditExit(Sender: TObject);
    procedure camposSelecionadosGraficoDBGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure tituloRodapeEditChange(Sender: TObject);
    procedure adicionarMatricialSpeedButtonClick(Sender: TObject);
    procedure adicionarTudoMatricialSpeedButtonClick(Sender: TObject);
    procedure removerMatricialSpeedButtonClick(Sender: TObject);
    procedure removerTudoMatricialSpeedButtonClick(Sender: TObject);
    procedure camposDisponiveisMatricialDBGridDblClick(Sender: TObject);
    procedure camposSelecionadosMatricialDBGridCellClick(Column: TColumn);
    procedure camposSelecionadosMatricialDBGridColEnter(Sender: TObject);
    procedure camposSelecionadosMatricialDBGridDrawColumnCell(
      Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure camposSelecionadosMatricialDBGridKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure imprimirMatricialButtonClick(Sender: TObject);
    procedure xPrnAfterCabecalho(Sender: TObject);
    procedure salvarEsquemaMatricialButtonClick(Sender: TObject);
    procedure abrirEsquemaMatricialButtonClick(Sender: TObject);
    procedure tracoMatricial;
    procedure linhasPorPaginaEditExit(Sender: TObject);
    procedure margemEsquerdaMatricialEditExit(Sender: TObject);
    procedure distanciaMatricialEditExit(Sender: TObject);
    procedure arquivoCSVCheckBoxClick(Sender: TObject);
    procedure WDPrinterCabecalho(Sender: TObject);
    procedure WDPrinterImprime(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  consultaGenericaImpressaoForm: TconsultaGenericaImpressaoForm;

implementation

uses ConsultaSimplesGenericaUnit;

{$R *.dfm}

procedure TconsultaGenericaImpressaoForm.adicionarGraficoSpeedButtonClick(
  Sender: TObject);
begin
  inherited;
  if not camposSelecionadosGraficoCDS.Locate( 'nm_campo', camposDisponiveisGraficoCDSnm_campo.AsString, [] ) then
  begin
    camposSelecionadosGraficoCDS.Append;
    camposSelecionadosGraficoCDSnm_campo.AsString  := camposDisponiveisGraficoCDSnm_campo.AsString;
    camposSelecionadosGraficoCDSds_campo.AsString  := camposDisponiveisGraficoCDSds_campo.AsString;
    if camposDisponiveisGraficoCDStamanho.AsCurrency <= 3 then
      camposSelecionadosGraficoCDStamanho.AsCurrency := RoundTo( camposDisponiveisGraficoCDStamanho.AsCurrency / 3, -2 )
    else
      camposSelecionadosGraficoCDStamanho.AsCurrency := RoundTo( camposDisponiveisGraficoCDStamanho.AsCurrency / 6, -2 );
    camposSelecionadosGraficoCDSordem.AsInteger      := camposSelecionadosGraficoCDS.RecordCount + 1;
    camposSelecionadosGraficoCDSalinhamento.AsString := camposDisponiveisGraficoCDSalinhamento.AsString;
    camposSelecionadosGraficoCDStipo.AsString        := camposDisponiveisGraficoCDStipo.AsString;
    camposSelecionadosGraficoCDS.Post;
  end;
end;

procedure TconsultaGenericaImpressaoForm.adicionarGraficoTodosSpeedButtonClick(
  Sender: TObject);
Var
  j : Byte;
begin
  inherited;
  j := camposDisponiveisGraficoCDS.RecNo;
  camposDisponiveisGraficoCDS.First;
  Repeat
    adicionarGraficoSpeedButtonClick(Self);
    camposDisponiveisGraficoCDS.Next;
  Until camposDisponiveisGraficoCDS.Eof;
  camposDisponiveisGraficoCDS.RecNo := j;
end;

procedure TconsultaGenericaImpressaoForm.removerGraficoSpeedButtonClick(
  Sender: TObject);
begin
  inherited;
  if not camposSelecionadosGraficoCDS.IsEmpty then
    camposSelecionadosGraficoCDS.Delete;
end;

procedure TconsultaGenericaImpressaoForm.FormCreate(Sender: TObject);
var i : Byte;
begin
  inherited;

  for i := 0 to TconsultaSimplesGenericaForm( Owner ).CDSQy.FieldCount - 1 do
  begin
    if TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].Visible then
    begin
      if TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].FieldKind = fkData then
      begin
        // Campos na TabSheet Gráfico
        camposDisponiveisGraficoCDS.Append;
        camposDisponiveisGraficoCDSnm_campo.AsString := TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].FieldName;
        camposDisponiveisGraficoCDSds_campo.AsString := TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].DisplayLabel;
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TMemoField ) then
          camposDisponiveisGraficoCDStamanho.AsInteger := 100
        else
          camposDisponiveisGraficoCDStamanho.AsInteger := TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].DisplayWidth;

        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TStringField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TMemoField ) then
          camposDisponiveisGraficoCDStipo.AsString := 'S';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TIntegerField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TSmallintField ) then
          camposDisponiveisGraficoCDStipo.AsString := 'I';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TFloatField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TCurrencyField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TBCDField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TFMTBCDField ) then
          camposDisponiveisGraficoCDStipo.AsString := 'N';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TDateField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TDateTimeField ) then
          camposDisponiveisGraficoCDStipo.AsString := 'D';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TTimeField ) then
          camposDisponiveisGraficoCDStipo.AsString := 'T';

        if camposDisponiveisGraficoCDStipo.AsString = 'S' then
          camposDisponiveisGraficoCDSalinhamento.AsString := 'E'
        else
          if ( camposDisponiveisGraficoCDStipo.AsString = 'D' ) or ( camposDisponiveisGraficoCDStipo.AsString = 'T' ) then
            camposDisponiveisGraficoCDSalinhamento.AsString := 'C'
          else
            camposDisponiveisGraficoCDSalinhamento.AsString := 'D';

        camposDisponiveisGraficoCDS.Post;

        // Campos na TabSheet Matricial
        camposDisponiveisMatricialCDS.Append;
        camposDisponiveisMatricialCDSnm_campo.AsString := TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].FieldName;
        camposDisponiveisMatricialCDSds_campo.AsString := TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].DisplayLabel;
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TMemoField ) then
          camposDisponiveisMatricialCDStamanho.AsInteger := 30
        else
          camposDisponiveisMatricialCDStamanho.AsInteger := TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i].DisplayWidth;

        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TStringField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TMemoField ) then
          camposDisponiveisMatricialCDStipo.AsString := 'S';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TIntegerField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TSmallintField ) then
          camposDisponiveisMatricialCDStipo.AsString := 'I';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TFloatField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TCurrencyField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TBCDField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TFMTBCDField ) then
          camposDisponiveisMatricialCDStipo.AsString := 'N';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TDateField ) or ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TDateTimeField ) then
          camposDisponiveisMatricialCDStipo.AsString := 'D';
        if ( TconsultaSimplesGenericaForm( Owner ).CDSQy.Fields.Fields[i] is TTimeField ) then
          camposDisponiveisMatricialCDStipo.AsString := 'T';

        if camposDisponiveisMatricialCDStipo.AsString = 'S' then
          camposDisponiveisMatricialCDSalinhamento.AsString := 'E'
        else
          if ( camposDisponiveisMatricialCDStipo.AsString = 'D' ) or ( camposDisponiveisMatricialCDStipo.AsString = 'T' ) then
            camposDisponiveisMatricialCDSalinhamento.AsString := 'C'
          else
            camposDisponiveisMatricialCDSalinhamento.AsString := 'D';

        camposDisponiveisMatricialCDS.Post;

      end;
    end;
  end;
  camposDisponiveisGraficoCDS.First;
  camposDisponiveisMatricialCDS.First;  
  if Pos( 'Consulta', Trim( TconsultaSimplesGenericaForm(Owner).Caption ) ) > 0 then
  begin
    tituloCabecalhoEdit.Text := 'Relatório ' + Copy( Trim( TconsultaSimplesGenericaForm(Owner).Caption ), 10, 40 );
    tituloCabecalhoMatricialEdit.Text := 'Relatório ' + Copy( Trim( TconsultaSimplesGenericaForm(Owner).Caption ), 10, 40 );
  end
  else
  begin
    tituloCabecalhoEdit.Text := TconsultaSimplesGenericaForm(Owner).Caption;
    tituloCabecalhoMatricialEdit.Text := TconsultaSimplesGenericaForm(Owner).Caption;
  end;
end;

procedure TconsultaGenericaImpressaoForm.removerGraficoTodosSpeedButtonClick(
  Sender: TObject);
begin
  inherited;
  if not camposSelecionadosGraficoCDS.IsEmpty then
  begin
    camposSelecionadosGraficoCDS.First;
    Repeat
      camposSelecionadosGraficoCDS.Delete;
    Until camposSelecionadosGraficoCDS.IsEmpty
  end;

end;

procedure TconsultaGenericaImpressaoForm.RvPrintHeader(Sender: TObject);
var alinhamento   : TPrintJustify;
    nr_tab, linhasGrade : Byte;
    primeiroCampo : Boolean;
    tamanho, posicaoY : Real;

begin
  inherited;
  alinhamento := pjLeft;
  With Sender as TBaseReport Do
  begin
    if Trim( tituloCabecalhoEdit.Text ) <> '' then
    begin
      Bold := True;
      SetFont( 'Arial', 14 );
      Print ( tituloCabecalhoEdit.Text );
      NewLine;
      MoveTo( MarginLeft, YPos - 0.3 );
      LineTo( PageWidth - MarginRight, YPos - 0.3 );
      Bold := False;
    end;
    SetFont( 'Arial', 8 );

    posicaoY := YPos;
    if imprimirDataHoraCheckBox.Checked then
      PrintXY( PageWidth - MarginRight - 4.5, MarginTop, FormatDateTime( 'dd/mm/yyyy hh:nn:ss', now ) );

    if imprimirNumeroPaginaCheckBox.Checked then
      PrintXY( PageWidth - MarginRight - 1.5, MarginTop, 'Página: ' + Trim( IntToStr( CurrentPage ) ) );

    YPos := posicaoY;
    camposSelecionadosGraficoCDS.First;
    // Tabs do Campos
    ClearTabs;
    nr_tab := 1;
    primeiroCampo := True;
    tamanho := rv.SystemPrinter.MarginLeft;
    if linhasGradeCheckBox.Checked then
      linhasGrade := BOXLINEALL
    else
      linhasGrade := BOXLINENONE;

    Repeat
      if camposSelecionadosGraficoCDSalinhamento.AsString = 'E' then
         alinhamento := pjLeft;
      if camposSelecionadosGraficoCDSalinhamento.AsString = 'D' then
         alinhamento := pjRight;
      if camposSelecionadosGraficoCDSalinhamento.AsString = 'C' then
         alinhamento := pjCenter;
      if primeiroCampo then
      begin
        SetTab( MarginLeft, alinhamento, camposSelecionadosGraficoCDStamanho.AsFloat, 3, linhasGrade, 0 );
        primeiroCampo := False;
      end
      else
        SetTab( NA, alinhamento, camposSelecionadosGraficoCDStamanho.AsFloat, 3, linhasGrade, 0 );
      if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
      begin
        SaveTabs( nr_tab );
        Inc( nr_tab );
        ClearTabs;
        primeiroCampo := True;
        tamanho := rv.SystemPrinter.MarginLeft;
      end;
      tamanho := tamanho + camposSelecionadosGraficoCDStamanho.AsFloat;
      camposSelecionadosGraficoCDS.Next;
      if ( ( tamanho + camposSelecionadosGraficoCDStamanho.AsFloat ) > PageWidth ) and ( ajusteAutomaticoCamposCheckBox.Checked ) then
      begin
        camposSelecionadosGraficoCDS.Prior;
        camposSelecionadosGraficoCDS.Edit;
        camposSelecionadosGraficoCDSquebra.AsString := 'S';
        camposSelecionadosGraficoCDS.Post;
        camposSelecionadosGraficoCDS.Next;
        tamanho := rv.SystemPrinter.MarginLeft;
        SaveTabs( nr_tab );
        Inc( nr_tab );
        ClearTabs;
        primeiroCampo := True;
      end;

    Until camposSelecionadosGraficoCDS.Eof;
    SaveTabs( nr_tab);

    camposSelecionadosGraficoCDS.First;
    // Tabs do Cabecalho
    nr_tab := 5;
    ClearTabs;
    primeiroCampo := True;
    Repeat
      if primeiroCampo then
      begin
        SetTab( MarginLeft, pjCenter, camposSelecionadosGraficoCDStamanho.AsFloat, 3, linhasGrade, 0 );
        primeiroCampo := False;
      end
      else
        SetTab( NA, pjCenter, camposSelecionadosGraficoCDStamanho.AsFloat, 3, linhasGrade, 0 );
      if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
      begin
        SaveTabs( nr_tab );
        Inc( nr_tab );
        ClearTabs;
        primeiroCampo := True;
      end;
      camposSelecionadosGraficoCDS.Next;
    Until camposSelecionadosGraficoCDS.Eof;
    SaveTabs( nr_tab );

    ClearTabs;
    nr_tab := 5;
    RestoreTabs( nr_tab );
    NewLine;
    Bold := True;
    camposSelecionadosGraficoCDS.First;
    Repeat
      PrintTab( camposSelecionadosGraficoCDSds_campo.AsString );
      if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
      begin
        Inc( nr_tab );
        ClearTabs;
        RestoreTabs( nr_tab );
        NewLine;
      end;
      camposSelecionadosGraficoCDS.Next;
    Until camposSelecionadosGraficoCDS.Eof;
    Bold := False;
    restoreTabs(1);
    if currentPage > 1 then
      newline;
  End;
end;

procedure TconsultaGenericaImpressaoForm.imprimirButtonClick(
  Sender: TObject);
begin
  inherited;
  if TconsultaSimplesGenericaForm( Owner ).CDSQy.IsEmpty then
  begin
    msgAlerta('Nenhum registro encoltrado para impressão!! ' + #13 + 'Favor realizar uma consulta para obter os registros para impressão!');
    Exit;
  end;

  If orientacaoRadioGroup.ItemIndex = 0 then
    rv.SystemPrinter.Orientation := poPortrait
  else
    rv.SystemPrinter.Orientation := poLandScape;

  rv.SystemPrinter.MarginBottom := StrToFloatDef( margemInferiorEdit.Text, 1 );
  rv.SystemPrinter.MarginTop    := StrToFloatDef( margemSuperiorEdit.Text, 1 );
  rv.SystemPrinter.MarginLeft   := StrToFloatDef( margemEsquerdaEdit.text, 1 );
  rv.SystemPrinter.MarginRight  := StrToFloatDef( margemDireitaEdit.Text, 1 );

  if not camposSelecionadosGraficoCDS.IsEmpty then
  begin
    camposSelecionadosGraficoCDS.DisableControls;
    Rv.Execute;
    camposSelecionadosGraficoCDS.EnableControls;
  end
  else
    showmessage('Selecione pelo Menos Um Campo');
end;

procedure TconsultaGenericaImpressaoForm.RvPrint(Sender: TObject);
var nr_tab : Integer;
    cdsClone : TClientDataSet;
    j : Byte;
    nr : Real;
begin
  inherited;
  j := 0; // Numero de Campos com Funções Agregadas
  camposSelecionadosGraficoCDS.First;
  Repeat
    if camposSelecionadosGraficoCDSfuncao.AsString <> '' then
      Inc( j );
    camposSelecionadosGraficoCDS.Edit;
    if camposSelecionadosGraficoCDSfuncao.AsString = 'Menor' then
      camposSelecionadosGraficoCDSvl_funcao.AsCurrency := 99999999
    else
      camposSelecionadosGraficoCDSvl_funcao.AsCurrency := 0;
    camposSelecionadosGraficoCDS.Next;
  Until camposSelecionadosGraficoCDS.Eof;

  cdsClone := TClientDataSet.Create(nil);
  Try
    cdsClone.CloneCursor( TconsultaSimplesGenericaForm( Owner ).CDSQy, false, false );
    cdsClone.First;
    With Sender as TBaseReport Do
    begin
      Repeat
        ClearTabs;
        nr_tab := 1;
        RestoreTabs( nr_tab );
        if pularLinhaCadaRegistroCheckBox.Checked then
          NewLine;
        if LinesLeft < 5 then NewPage else NewLine;
        camposSelecionadosGraficoCDS.First;
        Repeat
          if ( camposSelecionadosGraficoCDStipo.AsString = 'N' ) then
            PrintTab( FormatFloat( '#,##0.00', cdsClone.fieldbyname( camposSelecionadosGraficoCDSnm_campo.AsString ).AsCurrency ) )
          else
            PrintTab( cdsClone.fieldbyname( camposSelecionadosGraficoCDSnm_campo.AsString ).AsString );
          if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
          begin
            Inc( nr_tab );
            ClearTabs;
            RestoreTabs( nr_tab );
            if LinesLeft < 5 then NewPage else NewLine;
          end;
          if camposSelecionadosGraficoCDSfuncao.AsString <> '' then
          begin
            camposSelecionadosGraficoCDS.Edit;
            if camposSelecionadosGraficoCDSfuncao.AsString = 'Conta' then
              camposSelecionadosGraficoCDSvl_funcao.AsCurrency := camposSelecionadosGraficoCDSvl_funcao.AsCurrency + 1;
            if ( camposSelecionadosGraficoCDSfuncao.AsString = 'Soma' ) or ( camposSelecionadosGraficoCDSfuncao.AsString = 'Média' ) then
              camposSelecionadosGraficoCDSvl_funcao.AsCurrency := camposSelecionadosGraficoCDSvl_funcao.AsCurrency + cdsClone.fieldbyname( camposSelecionadosGraficoCDSnm_campo.AsString ).AsCurrency;
            if ( camposSelecionadosGraficoCDSfuncao.AsString = 'Maior' ) and ( camposSelecionadosGraficoCDSvl_funcao.AsCurrency < cdsClone.fieldbyname( camposSelecionadosGraficoCDSnm_campo.AsString ).AsCurrency ) then
              camposSelecionadosGraficoCDSvl_funcao.AsCurrency := cdsClone.fieldbyname( camposSelecionadosGraficoCDSnm_campo.AsString ).AsCurrency;
            if ( camposSelecionadosGraficoCDSfuncao.AsString = 'Menor' ) and ( camposSelecionadosGraficoCDSvl_funcao.AsCurrency > cdsClone.fieldbyname( camposSelecionadosGraficoCDSnm_campo.AsString ).AsCurrency ) then
              camposSelecionadosGraficoCDSvl_funcao.AsCurrency := cdsClone.fieldbyname( camposSelecionadosGraficoCDSnm_campo.AsString ).AsCurrency;
          end;
          camposSelecionadosGraficoCDS.Next;
        Until camposSelecionadosGraficoCDS.Eof;
        cdsClone.Next;
      Until cdsClone.Eof;

      // Imprime Funções Agregadas
      if j > 0 then
      begin
        ClearTabs;
        nr_tab := 1;
        RestoreTabs( nr_tab );
        Bold := True;
        if LinesLeft < 5 then NewPage else NewLine;
        camposSelecionadosGraficoCDS.First;
        Repeat
          if ( camposSelecionadosGraficoCDSfuncao.AsString = '' ) then
            PrintTab( '' )
          else
          begin
            if ( camposSelecionadosGraficoCDSfuncao.AsString = 'Média' ) then
              nr := camposSelecionadosGraficoCDSvl_funcao.AsCurrency / cdsClone.RecordCount
            else
              nr := camposSelecionadosGraficoCDSvl_funcao.AsCurrency;

            if camposSelecionadosGraficoCDStipo.AsString = 'I' then
              PrintTab( FormatFloat( '#,##0', nr ) )
            else
              PrintTab( FormatFloat( '#,##0.00', nr ) );
          end;
          if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
          begin
            Inc( nr_tab );
            ClearTabs;
            RestoreTabs( nr_tab );
            if LinesLeft < 5 then NewPage else NewLine;
          end;
          camposSelecionadosGraficoCDS.Next;
        Until camposSelecionadosGraficoCDS.Eof;

        // Imprime a Descrição das Funções

        ClearTabs;
        nr_tab := 1;
        RestoreTabs( nr_tab );
        Bold := True;
        if LinesLeft < 5 then NewPage else NewLine;
        camposSelecionadosGraficoCDS.First;
        Repeat
          if ( camposSelecionadosGraficoCDSfuncao.AsString = '' ) then
            PrintTab( '' )
          else
            PrintTab( camposSelecionadosGraficoCDSfuncao.AsString );
          if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
          begin
            Inc( nr_tab );
            ClearTabs;
            RestoreTabs( nr_tab );
            if LinesLeft < 5 then NewPage else NewLine;
          end;
          camposSelecionadosGraficoCDS.Next;
        Until camposSelecionadosGraficoCDS.Eof;

      end;
    end;
  Finally
    cdsClone.Free;
  end;
end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosGraficoCDSalinhamentoValidate(
  Sender: TField);
begin
  inherited;
  if camposSelecionadosGraficoCDSalinhamento.IsNull then
    camposSelecionadosGraficoCDSalinhamento.AsString := 'E';
  if ( camposSelecionadosGraficoCDSalinhamento.AsString <> 'E' ) and ( camposSelecionadosGraficoCDSalinhamento.AsString <> 'D' ) and ( camposSelecionadosGraficoCDSalinhamento.AsString <> 'C' ) then
  begin
    showmessage('O Alinhamento deve ser Esquerda, Direita ou Centralizado');
    Abort;
  end;

end;

procedure TconsultaGenericaImpressaoForm.RvPrintFooter(Sender: TObject);
begin
  inherited;
  if Trim( tituloRodapeEdit.Text ) <> '' then
  begin
    With Sender as TBaseReport Do
    begin
      MoveTo( MarginLeft, PageHeight - MarginBottom - 1 );
      LineTo( PageWidth - MarginRight, PageHeight - MarginBottom - 1 );
      YPos := PageHeight - MarginBottom - 0.5;
      if Trim( tituloRodapeEdit.Text ) <> '' then
        PrintXY( MarginLeft, PageHeight - MarginBottom - 0.5, tituloRodapeEdit.Text );
    end;
  end;
end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosGraficoDBGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_delete then
    camposSelecionadosGraficoCDS.Delete;
end;

procedure TconsultaGenericaImpressaoForm.camposDisponiveisGraficoDBGridDblClick(Sender: TObject);
begin
  inherited;
  adicionarGraficoSpeedButtonClick(Self);
end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosGraficoDBGridColEnter(Sender: TObject);
begin
  inherited;
  if ( camposSelecionadosGraficoDBGrid.SelectedField = camposSelecionadosGraficoCDSquebra ) or ( camposSelecionadosGraficoDBGrid.SelectedField = camposSelecionadosGraficoCDSalinhamento ) or ( camposSelecionadosGraficoDBGrid.SelectedField = camposSelecionadosGraficoCDSfuncao ) then
    camposSelecionadosGraficoDBGrid.Options := camposSelecionadosGraficoDBGrid.Options - [dgEditing]
  else
    camposSelecionadosGraficoDBGrid.Options := camposSelecionadosGraficoDBGrid.Options + [dgEditing];
end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosGraficoDBGridCellClick(Column: TColumn);
begin
  inherited;
  if column.Field = camposSelecionadosGraficoCDSquebra then
  begin
    camposSelecionadosGraficoCDS.Edit;
    if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
      camposSelecionadosGraficoCDSquebra.AsString := ''
    else
      camposSelecionadosGraficoCDSquebra.AsString := 'S';
  end;
  if column.Field = camposSelecionadosGraficoCDSalinhamento then
  begin
    camposSelecionadosGraficoCDS.Edit;
    if camposSelecionadosGraficoCDSalinhamento.AsString = 'E' then
      camposSelecionadosGraficoCDSalinhamento.AsString := 'C'
    else
      if camposSelecionadosGraficoCDSalinhamento.AsString = 'C' then
        camposSelecionadosGraficoCDSalinhamento.AsString := 'D'
      else
        if camposSelecionadosGraficoCDSalinhamento.AsString = 'D' then
          camposSelecionadosGraficoCDSalinhamento.AsString := 'E';
  end;

  if column.Field = camposSelecionadosGraficoCDSfuncao then
  begin
    if ( camposSelecionadosGraficoCDStipo.AsString = 'I' ) or ( camposSelecionadosGraficoCDStipo.AsString = 'N' ) then
    begin
      camposSelecionadosGraficoCDS.Edit;
      if camposSelecionadosGraficoCDSfuncao.AsString = 'Soma' then
        camposSelecionadosGraficoCDSfuncao.AsString := 'Média'
      else
        if camposSelecionadosGraficoCDSfuncao.AsString = 'Média' then
          camposSelecionadosGraficoCDSfuncao.AsString := 'Conta'
        else
          if camposSelecionadosGraficoCDSfuncao.AsString = 'Conta' then
            camposSelecionadosGraficoCDSfuncao.AsString := 'Menor'
          else
            if camposSelecionadosGraficoCDSfuncao.AsString = 'Menor' then
              camposSelecionadosGraficoCDSfuncao.AsString := 'Maior'
            else
              if camposSelecionadosGraficoCDSfuncao.AsString = 'Maior' then
                camposSelecionadosGraficoCDSfuncao.AsString := ''
              else
                if camposSelecionadosGraficoCDSfuncao.AsString = '' then
                  camposSelecionadosGraficoCDSfuncao.AsString := 'Soma';
    end;
  end;


end;

procedure TconsultaGenericaImpressaoForm.salvaButtonClick(Sender: TObject);
var nm_arquivo : String;
    arquivoIni : TIniFile;
begin
  inherited;
  if SaveDialog.Execute then
  begin
    nm_arquivo := SaveDialog.FileName;
    if Pos( '.eic', nm_arquivo ) = 0 then
      nm_arquivo := nm_arquivo + '.eic';

    arquivoIni := TIniFile.Create( nm_arquivo );
    arquivoIni.WriteString( 'parametros', 'orientacao', IntToStr( orientacaoRadioGroup.ItemIndex ) );
    arquivoIni.WriteString( 'parametros', 'pularLinhaCadaRegistro', BoolToStr( pularLinhaCadaRegistroCheckBox.Checked, true ) );
    arquivoIni.WriteString( 'parametros', 'linhasGrade', BoolToStr( linhasGradeCheckBox.Checked, true ) );    
    arquivoIni.WriteString( 'margens', 'superior', margemSuperiorEdit.Text );
    arquivoIni.WriteString( 'margens', 'inferior', margemInferiorEdit.Text );
    arquivoIni.WriteString( 'margens', 'esquerda', margemEsquerdaEdit.Text );
    arquivoIni.WriteString( 'margens', 'direita', margemDireitaEdit.Text );
    arquivoIni.WriteString( 'cabecalho', 'titulo', tituloCabecalhoEdit.Text );
    arquivoIni.WriteString( 'rodape', 'titulo', tituloRodapeEdit.Text );
    arquivoIni.WriteString( 'rodape', 'imprimirDataHora', BoolToStr( imprimirDataHoraCheckBox.Checked, true ) );
    arquivoIni.WriteString( 'rodape', 'imprimirNumeroPagina', BoolToStr( imprimirNumeroPaginaCheckBox.Checked, true ) );
    camposSelecionadosGraficoCDS.SaveToFile( nm_arquivo + '.fld', dfXML );
    showmessage('Parâmetos salvos no Arquivo ' + nm_arquivo );
  end;
end;

procedure TconsultaGenericaImpressaoForm.abrirButtonClick(Sender: TObject);
Var arquivoIni : TIniFile;
    opcao : String;
begin
  inherited;
  if OpenDialog.Execute then
  begin

    Try
      camposSelecionadosGraficoCDS.LoadFromFile( OpenDialog.FileName + '.fld' );

      if not camposDisponiveisGraficoCDS.Locate( 'nm_campo', camposSelecionadosGraficoCDSnm_campo.AsString, [] ) then
      begin
        showmessage('Este Esquema é invalído para esta Consulta');
        camposSelecionadosGraficoCDS.EmptyDataSet;
        Abort;
      end;

      arquivoIni := TIniFile.Create( OpenDialog.FileName );
      // Parâmetros
      opcao := arquivoIni.ReadString( 'parametros', 'orientacao', '0' );
      orientacaoRadioGroup.ItemIndex := StrToIntDef( opcao, 0 );
      opcao := arquivoIni.ReadString( 'parametros', 'pularLinhaCadaRegistro', 'FALSE' );
      pularLinhaCadaRegistroCheckBox.Checked := StrToBool( opcao );
      opcao := arquivoIni.ReadString( 'parametros', 'linhasGrade', 'FALSE' );
      linhasGradeCheckBox.Checked := StrToBool( opcao );

      // cabeçalho
      // Margens
      opcao := arquivoIni.ReadString( 'margens', 'superior', '1' );
      margemSuperiorEdit.Text := opcao;
      opcao := arquivoIni.ReadString( 'margens', 'inferior', '1' );
      margemInferiorEdit.Text := opcao;
      opcao := arquivoIni.ReadString( 'margens', 'esquerda', '1' );
      margemEsquerdaEdit.Text := opcao;
      opcao := arquivoIni.ReadString( 'margens', 'direita', '1' );
      margemDireitaEdit.Text := opcao;
      opcao := arquivoIni.ReadString( 'cabecalho', 'titulo', '' );
      tituloCabecalhoEdit.Text := opcao;

      // Rodapé
      opcao := arquivoIni.ReadString( 'rodape', 'titulo', '' );
      tituloRodapeEdit.Text := opcao;
      opcao := arquivoIni.ReadString( 'rodape', 'imprimirDataHora', 'TRUE' );
      imprimirDataHoraCheckBox.Checked := StrToBool( opcao );
      opcao := arquivoIni.ReadString( 'rodape', 'imprimirNumeroPagina', 'TRUE' );
      imprimirNumeroPaginaCheckBox.Checked := StrToBool( opcao );
      arquivoIni.Free;
    except
      showmessage('Problemas ao Ler o Esquema: ' + OpenDialog.FileName );
    end;

  end;
end;

procedure TconsultaGenericaImpressaoForm.fecharButtonClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TconsultaGenericaImpressaoForm.margemSuperiorEditExit(
  Sender: TObject);
begin
  inherited;
  margemSuperiorEdit.Text := FormatFloat( '##.00', StrToFloatDef( margemSuperiorEdit.Text, 1 ) );
end;

procedure TconsultaGenericaImpressaoForm.margemDireitaEditExit(
  Sender: TObject);
begin
  inherited;
  margemDireitaEdit.Text := FormatFloat( '##.00', StrToFloatDef( margemDireitaEdit.Text, 1 ) );
end;

procedure TconsultaGenericaImpressaoForm.margemEsquerdaEditExit(
  Sender: TObject);
begin
  inherited;
  margemEsquerdaEdit.Text := FormatFloat( '##.00', StrToFloatDef( margemEsquerdaEdit.Text, 1 ) );
end;

procedure TconsultaGenericaImpressaoForm.margemInferiorEditExit(
  Sender: TObject);
begin
  inherited;
  margemInferiorEdit.Text := FormatFloat( '##.00', StrToFloatDef( margemInferiorEdit.Text, 1 ) );
end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosGraficoDBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = camposSelecionadosGraficoCDSquebra then
  begin
    camposSelecionadosGraficoDBGrid.Canvas.FillRect(Rect);
    checkboxImageList.Draw( camposSelecionadosGraficoDBGrid.Canvas, rect.Left + 10, rect.Top + 1, 0 );
    if camposSelecionadosGraficoCDSquebra.AsString = 'S' then
      checkboxImageList.Draw( camposSelecionadosGraficoDBGrid.Canvas, rect.Left + 10, rect.Top + 1, 2 );
  end;
  if Column.Field = camposSelecionadosGraficoCDSalinhamento then
  begin
    camposSelecionadosGraficoDBGrid.Canvas.FillRect(Rect);
    if camposSelecionadosGraficoCDSalinhamento.AsString = 'E' then
      alinhamentoImageList.Draw( camposSelecionadosGraficoDBGrid.Canvas, rect.Left + 25, rect.Top + 1, 0 );
    if camposSelecionadosGraficoCDSalinhamento.AsString = 'C' then
      alinhamentoImageList.Draw( camposSelecionadosGraficoDBGrid.Canvas, rect.Left + 25, rect.Top + 1, 1 );
    if camposSelecionadosGraficoCDSalinhamento.AsString = 'D' then
      alinhamentoImageList.Draw( camposSelecionadosGraficoDBGrid.Canvas, rect.Left + 25, rect.Top + 1, 2 );


  end;

end;

procedure TconsultaGenericaImpressaoForm.tituloRodapeEditChange(
  Sender: TObject);
begin
  inherited;
  if Trim( tituloRodapeEdit.Text ) <> '' then
    if StrToFloatDef( margemInferiorEdit.Text, 0 ) = 0 then
      margemInferiorEdit.Text := '1,00'
    else
      margemInferiorEdit.Text := '0,00';    
end;

procedure TconsultaGenericaImpressaoForm.adicionarMatricialSpeedButtonClick(
  Sender: TObject);
begin
  inherited;
  if not camposSelecionadosMatricialCDS.Locate( 'nm_campo', camposDisponiveisMatricialCDSnm_campo.AsString, [] ) then
  begin
    camposSelecionadosMatricialCDS.Append;
    camposSelecionadosMatricialCDSnm_campo.AsString  := camposDisponiveisMatricialCDSnm_campo.AsString;
    camposSelecionadosMatricialCDSds_campo.AsString  := camposDisponiveisMatricialCDSds_campo.AsString;
    camposSelecionadosMatricialCDStamanho.AsInteger  := camposDisponiveisMatricialCDStamanho.AsInteger;
    camposSelecionadosMatricialCDSordem.AsInteger    := camposSelecionadosMatricialCDS.RecordCount + 1;
    camposSelecionadosMatricialCDSalinhamento.AsString := camposDisponiveisMatricialCDSalinhamento.AsString;
    camposSelecionadosMatricialCDStipo.AsString        := camposDisponiveisMatricialCDStipo.AsString;
    camposSelecionadosMatricialCDScaracteres.AsString  := '12cpp';    
    camposSelecionadosMatricialCDS.Post;
  end;

end;

procedure TconsultaGenericaImpressaoForm.adicionarTudoMatricialSpeedButtonClick(
  Sender: TObject);
Var
  j : Byte;
begin
  inherited;
  j := camposDisponiveisMatricialCDS.RecNo;
  camposSelecionadosMatricialCDS.First;
  Repeat
    adicionarMatricialSpeedButtonClick(Self);
    camposDisponiveisMatricialCDS.Next;
  Until camposDisponiveisMatricialCDS.Eof;
  camposDisponiveisMatricialCDS.RecNo := j;
end;

procedure TconsultaGenericaImpressaoForm.removerMatricialSpeedButtonClick(
  Sender: TObject);
begin
  inherited;
  if not camposSelecionadosMatricialCDS.IsEmpty then
    camposSelecionadosMatricialCDS.Delete;
end;

procedure TconsultaGenericaImpressaoForm.removerTudoMatricialSpeedButtonClick(
  Sender: TObject);
begin
  inherited;
  if not camposSelecionadosMatricialCDS.IsEmpty then
  begin
    camposSelecionadosMatricialCDS.First;
    Repeat
      camposSelecionadosMatricialCDS.Delete;
    Until camposSelecionadosMatricialCDS.IsEmpty;
  end;

end;

procedure TconsultaGenericaImpressaoForm.camposDisponiveisMatricialDBGridDblClick(
  Sender: TObject);
begin
  inherited;
  adicionarMatricialSpeedButtonClick(Self);
end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosMatricialDBGridCellClick(
  Column: TColumn);
begin
  inherited;
  if column.Field = camposSelecionadosMatricialCDSquebra then
  begin
    camposSelecionadosMatricialCDS.Edit;
    if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
      camposSelecionadosMatricialCDSquebra.AsString := ''
    else
      camposSelecionadosMatricialCDSquebra.AsString := 'S';
  end;
  if column.Field = camposSelecionadosMatricialCDSalinhamento then
  begin
    camposSelecionadosMatricialCDS.Edit;
    if camposSelecionadosMatricialCDSalinhamento.AsString = 'E' then
      camposSelecionadosMatricialCDSalinhamento.AsString := 'C'
    else
      if camposSelecionadosMatricialCDSalinhamento.AsString = 'C' then
        camposSelecionadosMatricialCDSalinhamento.AsString := 'D'
      else
        if camposSelecionadosMatricialCDSalinhamento.AsString = 'D' then
          camposSelecionadosMatricialCDSalinhamento.AsString := 'E';
  end;

  if column.Field = camposSelecionadosMatricialCDSfuncao then
  begin
    if ( camposSelecionadosMatricialCDStipo.AsString = 'I' ) or ( camposSelecionadosMatricialCDStipo.AsString = 'N' ) then
    begin
      camposSelecionadosMatricialCDS.Edit;
      if camposSelecionadosMatricialCDSfuncao.AsString = 'Soma' then
        camposSelecionadosMatricialCDSfuncao.AsString := 'Média'
      else
        if camposSelecionadosMatricialCDSfuncao.AsString = 'Média' then
          camposSelecionadosMatricialCDSfuncao.AsString := 'Conta'
        else
          if camposSelecionadosMatricialCDSfuncao.AsString = 'Conta' then
            camposSelecionadosMatricialCDSfuncao.AsString := ''
          else
            if camposSelecionadosMatricialCDSfuncao.AsString = '' then
              camposSelecionadosMatricialCDSfuncao.AsString := 'Soma';
    end;
  end;

  if column.Field = camposSelecionadosMatricialCDScaracteres then
  begin
    WDPrinter.EnviaComando( fiAcpp10  );
    camposSelecionadosMatricialCDS.Edit;
    if camposSelecionadosMatricialCDScaracteres.AsString = '10cpp' then
      camposSelecionadosMatricialCDScaracteres.AsString := '12cpp'
    else
      if camposSelecionadosMatricialCDScaracteres.AsString = '12cpp' then
        camposSelecionadosMatricialCDScaracteres.AsString := '17cpp'
      else
        if camposSelecionadosMatricialCDScaracteres.AsString = '17cpp' then
          camposSelecionadosMatricialCDScaracteres.AsString := '20cpp'
        else
          if camposSelecionadosMatricialCDScaracteres.AsString = '20cpp' then
            camposSelecionadosMatricialCDScaracteres.AsString := 'Enfatizado'
          else
            if camposSelecionadosMatricialCDScaracteres.AsString = 'Enfatizado' then
              camposSelecionadosMatricialCDScaracteres.AsString := '10cpp';


  end;



end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosMatricialDBGridColEnter(
  Sender: TObject);
begin
  inherited;
  if ( camposSelecionadosMatricialDBGrid.SelectedField = camposSelecionadosMatricialCDSquebra ) or ( camposSelecionadosMatricialDBGrid.SelectedField = camposSelecionadosMatricialCDSalinhamento ) or ( camposSelecionadosMatricialDBGrid.SelectedField = camposSelecionadosMatricialCDSfuncao ) or ( camposSelecionadosMatricialDBGrid.SelectedField = camposSelecionadosMatricialCDScaracteres ) then
    camposSelecionadosMatricialDBGrid.Options := camposSelecionadosMatricialDBGrid.Options - [dgEditing]
  else
    camposSelecionadosMatricialDBGrid.Options := camposSelecionadosMatricialDBGrid.Options + [dgEditing];
end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosMatricialDBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = camposSelecionadosMatricialCDSquebra then
  begin
    camposSelecionadosMatricialDBGrid.Canvas.FillRect(Rect);
    checkboxImageList.Draw( camposSelecionadosMatricialDBGrid.Canvas, rect.Left + 10, rect.Top + 1, 0 );
    if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
      checkboxImageList.Draw( camposSelecionadosMatricialDBGrid.Canvas, rect.Left + 10, rect.Top + 1, 2 );
  end;
  if Column.Field = camposSelecionadosMatricialCDSalinhamento then
  begin
    camposSelecionadosMatricialDBGrid.Canvas.FillRect(Rect);
    if camposSelecionadosMatricialCDSalinhamento.AsString = 'E' then
      alinhamentoImageList.Draw( camposSelecionadosMatricialDBGrid.Canvas, rect.Left + 25, rect.Top + 1, 0 );
    if camposSelecionadosMatricialCDSalinhamento.AsString = 'C' then
      alinhamentoImageList.Draw( camposSelecionadosMatricialDBGrid.Canvas, rect.Left + 25, rect.Top + 1, 1 );
    if camposSelecionadosMatricialCDSalinhamento.AsString = 'D' then
      alinhamentoImageList.Draw( camposSelecionadosMatricialDBGrid.Canvas, rect.Left + 25, rect.Top + 1, 2 );
  end;

end;

procedure TconsultaGenericaImpressaoForm.camposSelecionadosMatricialDBGridKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_delete then
    camposSelecionadosMatricialCDS.Delete;
end;

procedure TconsultaGenericaImpressaoForm.imprimirMatricialButtonClick(
  Sender: TObject);
begin
  inherited;
  margemEsquerdaMatricialEditExit(Self);
  linhasPorPaginaEditExit(Self);
  distanciaMatricialEditExit(Self);

  if arquivoCSVCheckBox.Checked then
  begin
    margemEsquerdaMatricialEdit.Text := '0';
    linhasPorPaginaEdit.Text := '99999999';
    distanciaMatricialEdit.Text := '0';
  end;

  WDPrinter.MargemEsquerda := StrToInt( distanciaMatricialEdit.Text );

  if not camposSelecionadosMatricialCDS.IsEmpty then
  begin
    camposSelecionadosMatricialCDS.DisableControls;
    WDPrinter.Execute;
    camposSelecionadosMatricialCDS.EnableControls;
  end
  else
    showmessage('Selecione pelo Menos Um Campo');

end;

procedure TconsultaGenericaImpressaoForm.xPrnAfterCabecalho(
  Sender: TObject);
var st : string;
begin
  inherited;
 
  camposSelecionadosMatricialCDS.First;
  Repeat
    st := '';
    if camposSelecionadosMatricialCDScaracteres.AsString = '10cpp' then
      WDPrinter.EnviaComando( fiAcpp10 );
    if camposSelecionadosMatricialCDScaracteres.AsString = '12cpp' then
      WDPrinter.EnviaComando( fiAcpp12 );
    if camposSelecionadosMatricialCDScaracteres.AsString = '17cpp' then
      WDPrinter.EnviaComando( fiAcpp17 );
    if camposSelecionadosMatricialCDScaracteres.AsString = '20cpp' then
      WDPrinter.EnviaComando( fiAcpp20 );
    if camposSelecionadosMatricialCDScaracteres.AsString = 'Enfatizado' then
      WDPrinter.EnviaComando( fiAenfat );


    // Margem Esquerda
    if ( camposSelecionadosMatricialCDS.Bof ) and ( margemEsquerdaMatricialEdit.Text <> '0' ) then
      WDPrinter.Imprime( DupeString( ' ', StrToInt( margemEsquerdaMatricialEdit.Text ) ) );


    st := camposSelecionadosMatricialCDSds_campo.AsString;

    if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'E' ) then
      WDPrinter.Imprime( AlinhaEsq( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );
    if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'C' ) then
      WDPrinter.Imprime( AlinhaCentro( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );
    if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'D' ) then
      WDPrinter.Imprime( AlinhaDir( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );

    if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
      WDPrinter.Pulalinha;

    camposSelecionadosMatricialCDS.Next;
  Until camposSelecionadosMatricialCDS.Eof;
  WDPrinter.Pulalinha;

  if not arquivoCSVCheckBox.Checked then
    tracoMatricial;

  camposSelecionadosMatricialCDS.First;
end;

procedure TconsultaGenericaImpressaoForm.salvarEsquemaMatricialButtonClick(
  Sender: TObject);
var nm_arquivo : String;
    arquivoIni : TIniFile;
begin
  inherited;
  if SaveDialog.Execute then
  begin
    nm_arquivo := SaveDialog.FileName;
    if Pos( '.eic', nm_arquivo ) = 0 then
      nm_arquivo := nm_arquivo + '.eic';

    arquivoIni := TIniFile.Create( nm_arquivo );
    arquivoIni.WriteString( 'parametros', 'pularLinhaCadaRegistro', BoolToStr( pularLinhaCadaRegistroMatricialCheckBox.Checked, true ) );
    arquivoIni.WriteString( 'parametros', 'arquivoCSV', BoolToStr( arquivoCSVCheckBox.Checked, true ) );
    arquivoIni.WriteString( 'parametros', 'caracterSeparador', caracterSeparadorEdit.Text );
    arquivoIni.WriteString( 'cabecalho', 'titulo', tituloCabecalhoMatricialEdit.Text );
    arquivoIni.WriteString( 'opcoes', 'margemEsquerda', margemEsquerdaMatricialEdit.Text );
    arquivoIni.WriteString( 'opcoes', 'linhasPagina', linhasPorPaginaEdit.Text );
    arquivoIni.WriteString( 'opcoes', 'distanciaCampos', distanciaMatricialEdit.Text );

    camposSelecionadosMatricialCDS.SaveToFile( nm_arquivo + '.fld', dfXML );
    showmessage('Parâmetos salvos no Arquivo ' + nm_arquivo );
  end;
end;

procedure TconsultaGenericaImpressaoForm.abrirEsquemaMatricialButtonClick(
  Sender: TObject);
Var arquivoIni : TIniFile;
    opcao : String;
begin
  inherited;
  if OpenDialog.Execute then
  begin

    Try
      camposSelecionadosMatricialCDS.LoadFromFile( OpenDialog.FileName + '.fld' );

      if not camposDisponiveisMatricialCDS.Locate( 'nm_campo', camposSelecionadosMatricialCDSnm_campo.AsString, [] ) then
      begin
        showmessage('Este Esquema é invalído para esta Consulta');
        camposSelecionadosMatricialCDS.EmptyDataSet;
        Abort;
      end;

      arquivoIni := TIniFile.Create( OpenDialog.FileName );
      // Parâmetros
      opcao := arquivoIni.ReadString( 'parametros', 'pularLinhaCadaRegistro', 'FALSE' );
      pularLinhaCadaRegistroMatricialCheckBox.Checked := StrToBool( opcao );
      opcao := arquivoIni.ReadString( 'parametros', 'arquivoCSV', 'FALSE' );
      arquivoCSVCheckBox.Checked := StrToBool( opcao );
      opcao := arquivoIni.ReadString( 'parametros', 'caracterSeparador', ';' );
      caracterSeparadorEdit.Text := opcao;

      // cabeçalho
      opcao := arquivoIni.ReadString( 'cabecalho', 'titulo', '' );
      tituloCabecalhoMatricialEdit.Text := opcao;

      // opcoes
      opcao := arquivoIni.ReadString( 'opcoes', 'margemEsquerda', '' );
      margemEsquerdaMatricialEdit.Text := opcao;
      opcao := arquivoIni.ReadString( 'opcoes', 'linhasPagina', '' );
      linhasPorPaginaEdit.Text := opcao;
      opcao := arquivoIni.ReadString( 'opcoes', 'distanciaCampos', '' );
      distanciaMatricialEdit.Text := opcao;

      arquivoIni.Free;
    except
      showmessage('Problemas ao Ler o Esquema: ' + OpenDialog.FileName );
    end;

  end;

end;

procedure TconsultaGenericaImpressaoForm.tracoMatricial;
var st : String;
begin
  camposSelecionadosMatricialCDS.First;
  Repeat

    st := '';
    if camposSelecionadosMatricialCDScaracteres.AsString = '10cpp' then
      WDPrinter.EnviaComando( fiacpp10 );
    if camposSelecionadosMatricialCDScaracteres.AsString = '12cpp' then
      WDPrinter.EnviaComando( fiAcpp12 );
    if camposSelecionadosMatricialCDScaracteres.AsString = '17cpp' then
      WDPrinter.EnviaComando( fiAcpp17 );
    if camposSelecionadosMatricialCDScaracteres.AsString = '20cpp' then
      WDPrinter.EnviaComando( fiAcpp20 );
    if camposSelecionadosMatricialCDScaracteres.AsString = 'Enfatizado' then
      WDPrinter.EnviaComando( fiAenfat );

    // Margem Esquerda
    if ( camposSelecionadosMatricialCDS.Bof ) and ( margemEsquerdaMatricialEdit.Text <> '0' ) then
      WDPrinter.Imprime( DupeString( ' ', StrToInt( margemEsquerdaMatricialEdit.Text ) ) );

    st := DupeString( '-' , camposSelecionadosMatricialCDStamanho.AsInteger );

    WDPrinter.Imprime( AlinhaEsq( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );

    if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
      WDPrinter.Pulalinha;

    camposSelecionadosMatricialCDS.Next;
  Until camposSelecionadosMatricialCDS.Eof;
  WDPrinter.Pulalinha;
end;

procedure TconsultaGenericaImpressaoForm.linhasPorPaginaEditExit(
  Sender: TObject);
begin
  inherited;
  linhasPorPaginaEdit.Text := IntToStr( StrToIntDef( linhasPorPaginaEdit.Text, 0 ) );
end;

procedure TconsultaGenericaImpressaoForm.margemEsquerdaMatricialEditExit(
  Sender: TObject);
begin
  inherited;
  margemEsquerdaMatricialEdit.Text := IntToStr( StrToIntDef( margemEsquerdaMatricialEdit.Text, 0 ) );
end;

procedure TconsultaGenericaImpressaoForm.distanciaMatricialEditExit(
  Sender: TObject);
begin
  inherited;
  distanciaMatricialEdit.Text := IntToStr( StrToIntDef( distanciaMatricialEdit.Text, 1 ) );
end;


procedure TconsultaGenericaImpressaoForm.arquivoCSVCheckBoxClick(
  Sender: TObject);
begin
  inherited;
  caracterSeparadorEdit.Visible := arquivoCSVCheckBox.Checked;
  tituloCabecalhoMatricialEdit.Enabled := not arquivoCSVCheckBox.Checked;

  if not arquivoCSVCheckBox.Checked then
    linhasPorPaginaEdit.Text := '0';
end;

procedure TconsultaGenericaImpressaoForm.WDPrinterCabecalho( Sender: TObject);
var
  st : string;
begin
  inherited;
   if ( Trim( tituloCabecalhoMatricialEdit.Text ) <> '' ) and ( tituloCabecalhoMatricialEdit.Enabled ) then
   begin
      WDPrinter.Imprimeln(tituloCabecalhoMatricialEdit.Text);
      camposSelecionadosMatricialCDS.First;
      repeat
        st := '';
        if not arquivoCSVCheckBox.Checked then
        begin
          if camposSelecionadosMatricialCDScaracteres.AsString = '10cpp' then
            WDPrinter.EnviaComando( fiAcpp10 );
          if camposSelecionadosMatricialCDScaracteres.AsString = '12cpp' then
            WDPrinter.EnviaComando( fiAcpp12 );
          if camposSelecionadosMatricialCDScaracteres.AsString = '17cpp' then
            WDPrinter.EnviaComando( fiAcpp17 );
          if camposSelecionadosMatricialCDScaracteres.AsString = '20cpp' then
            WDPrinter.EnviaComando( fiAcpp20 );
          if camposSelecionadosMatricialCDScaracteres.AsString = 'Enfatizado' then
            WDPrinter.EnviaComando( fiAenfat );
        end;
        // Margem Esquerda
        if ( camposSelecionadosMatricialCDS.Bof ) and ( margemEsquerdaMatricialEdit.Text <> '0' ) then
          WDPrinter.Imprime( DupeString( ' ', StrToInt( margemEsquerdaMatricialEdit.Text ) ) );

        st := camposSelecionadosMatricialCDSds_campo.AsString;

        if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'E' ) then
          WDPrinter.Imprime( AlinhaEsq( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );
        if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'C' ) then
          WDPrinter.Imprime( AlinhaCentro( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );
        if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'D' ) then
          WDPrinter.Imprime( AlinhaDir( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );

        // Espaco entre campos
        if ( distanciaMatricialEdit.Text <> '0' ) then
          WDPrinter.Imprime( DupeString( ' ', StrToInt( distanciaMatricialEdit.Text ) ) );

        {if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
          WDPrinter.Pulalinha;}

        camposSelecionadosMatricialCDS.Next;

        // Caracter Separador
        if ( arquivoCSVCheckBox.Checked ) and ( not camposSelecionadosMatricialCDS.Eof ) then
          WDPrinter.Imprime( Trim( caracterSeparadorEdit.Text ) );
      Until camposSelecionadosMatricialCDS.Eof;
      WDPrinter.Pulalinha;
   end
end;

procedure TconsultaGenericaImpressaoForm.WDPrinterImprime(Sender: TObject);
var cdsClone : TClientDataSet;
    j : Byte;
    nr : Real;
    st : String;
begin
  inherited;
      j := 0; // Numero de Campos com Funções Agregadas
      camposSelecionadosMatricialCDS.First;
      Repeat
        if camposSelecionadosMatricialCDSfuncao.AsString <> '' then
          Inc( j );
        camposSelecionadosMatricialCDS.Edit;
        camposSelecionadosMatricialCDSvl_funcao.AsCurrency := 0;
        camposSelecionadosMatricialCDS.Next;
      Until camposSelecionadosMatricialCDS.Eof;

      cdsClone := TClientDataSet.Create(nil);
      Try
        cdsClone.CloneCursor( TconsultaSimplesGenericaForm( Owner ).CDSQy, false, false );
        cdsClone.First;
        Repeat
          if pularLinhaCadaRegistroMatricialCheckBox.Checked then
            WDPrinter.Pulalinha;
          camposSelecionadosMatricialCDS.First;
          Repeat
            st := '';
            if not arquivoCSVCheckBox.Checked then
            begin
              if camposSelecionadosMatricialCDScaracteres.AsString = '10cpp' then
                WDPrinter.EnviaComando( fiAcpp10 );
              if camposSelecionadosMatricialCDScaracteres.AsString = '12cpp' then
                WDPrinter.EnviaComando( fiAcpp12 );
              if camposSelecionadosMatricialCDScaracteres.AsString = '17cpp' then
                WDPrinter.EnviaComando( fiAcpp17 );
              if camposSelecionadosMatricialCDScaracteres.AsString = '20cpp' then
                WDPrinter.EnviaComando( fiAcpp20 );
              if camposSelecionadosMatricialCDScaracteres.AsString = 'Enfatizado' then
                WDPrinter.EnviaComando( fiAenfat );
            end;

            // Margem Esquerda
            if ( camposSelecionadosMatricialCDS.Bof ) and ( margemEsquerdaMatricialEdit.Text <> '0' ) then
              WDPrinter.Imprime( DupeString( ' ', StrToInt( margemEsquerdaMatricialEdit.Text ) ) );

            if ( camposSelecionadosMatricialCDStipo.AsString = 'N' ) then
              st := FormatFloat( '#,##0.00', cdsClone.fieldbyname( camposSelecionadosMatricialCDSnm_campo.AsString ).AsCurrency )
            else
              st := cdsClone.fieldbyname( camposSelecionadosMatricialCDSnm_campo.AsString ).AsString;

            if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'E' ) then
              WDPrinter.Imprime( AlinhaEsq( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );
            if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'C' ) then
              WDPrinter.Imprime( AlinhaCentro( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );
            if ( camposSelecionadosMatricialCDSalinhamento.AsString = 'D' ) then
              WDPrinter.Imprime( AlinhaDir( st, camposSelecionadosMatricialCDStamanho.AsInteger  )  );

            // Espaco entre campos
            if ( distanciaMatricialEdit.Text <> '0' ) then
              WDPrinter.Imprime( DupeString( ' ', StrToInt( distanciaMatricialEdit.Text ) ) );

            if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
              WDPrinter.Pulalinha;

            if camposSelecionadosMatricialCDSfuncao.AsString <> '' then
            begin
              camposSelecionadosMatricialCDS.Edit;
              if camposSelecionadosMatricialCDSfuncao.AsString = 'Conta' then
                camposSelecionadosMatricialCDSvl_funcao.AsCurrency := camposSelecionadosMatricialCDSvl_funcao.AsCurrency + 1
              else
                camposSelecionadosMatricialCDSvl_funcao.AsCurrency := camposSelecionadosMatricialCDSvl_funcao.AsCurrency + cdsClone.fieldbyname( camposSelecionadosMatricialCDSnm_campo.AsString ).AsCurrency;
            end;
            camposSelecionadosMatricialCDS.Next;

            // Caracter Separador
            if ( arquivoCSVCheckBox.Checked ) and ( not camposSelecionadosMatricialCDS.Eof ) then
              WDPrinter.Imprime( Trim( caracterSeparadorEdit.Text ) );
          Until camposSelecionadosMatricialCDS.Eof;
          cdsClone.Next;
          WDPrinter.Pulalinha;
          if linhasPorPaginaEdit.Text <> '0' then
          begin
            if WDPrinter.LinhaAtual > StrToInt( linhasPorPaginaEdit.Text ) then
              WDPrinter.NovaPagina;
          end;
        Until cdsClone.Eof;
        // Imprime as Funções Selecionadas

        if j > 0 then
        begin
          if not arquivoCSVCheckBox.Checked then
            tracoMatricial;
          camposSelecionadosMatricialCDS.First;
          Repeat

            if camposSelecionadosMatricialCDScaracteres.AsString = '10cpp' then
              WDPrinter.EnviaComando( fiAcpp10 );
            if camposSelecionadosMatricialCDScaracteres.AsString = '12cpp' then
              WDPrinter.EnviaComando( fiAcpp12 );
            if camposSelecionadosMatricialCDScaracteres.AsString = '17cpp' then
              WDPrinter.EnviaComando( fiAcpp17 );
            if camposSelecionadosMatricialCDScaracteres.AsString = '20cpp' then
              WDPrinter.EnviaComando( fiAcpp20 );
            if camposSelecionadosMatricialCDScaracteres.AsString = 'Enfatizado' then
              WDPrinter.EnviaComando( fiAenfat );


            // Margem Esquerda
            if ( camposSelecionadosMatricialCDS.Bof ) and ( margemEsquerdaMatricialEdit.Text <> '0' ) then
              WDPrinter.Imprime( DupeString( ' ', StrToInt( margemEsquerdaMatricialEdit.Text ) ) );


            if ( camposSelecionadosMatricialCDSfuncao.AsString = '' ) then
              WDPrinter.Imprime( DupeString( ' ', camposSelecionadosMatricialCDStamanho.AsInteger ) )
            else
            begin
              if ( camposSelecionadosMatricialCDSfuncao.AsString = 'Conta' ) or ( camposSelecionadosMatricialCDSfuncao.AsString = 'Soma' ) then
                nr := camposSelecionadosMatricialCDSvl_funcao.AsCurrency
              else
                nr := camposSelecionadosMatricialCDSvl_funcao.AsCurrency / cdsClone.RecordCount;
              if camposSelecionadosMatricialCDStipo.AsString = 'I' then
                WDPrinter.Imprime( AlinhaDir( FormatFloat( '#,##0', nr ), camposSelecionadosMatricialCDStamanho.AsInteger  ) )
              else
                WDPrinter.Imprime( AlinhaDir( FormatFloat( '#,##0.00', nr ), camposSelecionadosMatricialCDStamanho.AsInteger ) );
            end;
            if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
              WDPrinter.Pulalinha;
            camposSelecionadosMatricialCDS.Next;
            // Caracter Separador
            if ( arquivoCSVCheckBox.Checked ) and ( not camposSelecionadosMatricialCDS.Eof ) then
              WDPrinter.Imprime( Trim( caracterSeparadorEdit.Text ) );

          Until camposSelecionadosMatricialCDS.Eof;
          camposSelecionadosMatricialCDS.First;

          // Descreve as Funções
          WDPrinter.Pulalinha;
          Repeat

            if camposSelecionadosMatricialCDScaracteres.AsString = '10cpp' then
              WDPrinter.EnviaComando( fiAcpp10 );
            if camposSelecionadosMatricialCDScaracteres.AsString = '12cpp' then
              WDPrinter.EnviaComando( fiAcpp12 );
            if camposSelecionadosMatricialCDScaracteres.AsString = '17cpp' then
              WDPrinter.EnviaComando( fiAcpp17 );
            if camposSelecionadosMatricialCDScaracteres.AsString = '20cpp' then
              WDPrinter.EnviaComando( fiAcpp20 );
            if camposSelecionadosMatricialCDScaracteres.AsString = 'Enfatizado' then
              WDPrinter.EnviaComando( fiAenfat );


            // Margem Esquerda
            if ( camposSelecionadosMatricialCDS.Bof ) and ( margemEsquerdaMatricialEdit.Text <> '0' ) then
              WDPrinter.Imprime( DupeString( ' ', StrToInt( margemEsquerdaMatricialEdit.Text ) ) );

            if ( camposSelecionadosMatricialCDSfuncao.AsString = '' ) then
              WDPrinter.Imprime( DupeString( ' ', camposSelecionadosMatricialCDStamanho.AsInteger ) )
            else
              WDPrinter.Imprime( AlinhaDir( camposSelecionadosMatricialCDSfuncao.AsString, camposSelecionadosMatricialCDStamanho.AsInteger  ) );
            if camposSelecionadosMatricialCDSquebra.AsString = 'S' then
              WDPrinter.Pulalinha;
            camposSelecionadosMatricialCDS.Next;
            // Caracter Separador
            if ( arquivoCSVCheckBox.Checked ) and ( not camposSelecionadosMatricialCDS.Eof ) then
              WDPrinter.Imprime( Trim( caracterSeparadorEdit.Text ) );

          Until camposSelecionadosMatricialCDS.Eof;
        end;
      Finally
        cdsClone.Free;
      end;
     WDPrinter.Pulalinha;

     if not arquivoCSVCheckBox.Checked then
       tracoMatricial;

     camposSelecionadosMatricialCDS.First;
end;

end.
