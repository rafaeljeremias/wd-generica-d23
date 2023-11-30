unit tipoGraficoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, StdCtrls, Buttons, ExtCtrls,  TeEngine, Series, Chart;
type
  TtipoGraficoForm = class(TFormBasicoPanelForm)
    fecharButton: TBitBtn;
    okButton: TBitBtn;
    colunas2dButton: TSpeedButton;
    colunas3dButton: TSpeedButton;
    linhas2dButton: TSpeedButton;
    linhas3dButton: TSpeedButton;
    barras2dButton: TSpeedButton;
    barras3dButton: TSpeedButton;
    Panel1: TPanel;
    Label1: TLabel;
    serieComboBox: TComboBox;
    procedure okButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure serieComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    grafico   : TChart;
    tipo      : TChartSeriesClass;
    gChart3d  : Boolean;
    procedure mudaGrafico( Chart : TChart );
    procedure atualizaBotaoTipoGrafico( serie : Integer );
  end;

var
  tipoGraficoForm: TtipoGraficoForm;

implementation

{$R *.dfm}

procedure TtipoGraficoForm.mudaGrafico(Chart: TChart );
Var
  serieGrafico : TChartSeries;
  i : Integer;
begin
  if serieComboBox.ItemIndex = 0 then
  begin
    for i := 0 to Pred( grafico.SeriesCount ) do
    begin
      if grafico.Series[i].Active then
      begin
        serieGrafico := Chart.Series[ i ];
        ChangeSeriesType( serieGrafico, tipo );
      end;
    end;
  end
  else
  begin
    serieGrafico := Chart.Series[ Pred( serieComboBox.ItemIndex ) ];
    ChangeSeriesType( serieGrafico, tipo );
  end;
  Chart.View3D := gChart3d;
end;

procedure TtipoGraficoForm.okButtonClick(Sender: TObject);
begin
  inherited;
  gChart3d := False;
  if ( colunas3dButton.Down ) or ( linhas3dButton.Down ) or ( barras3dButton.Down ) then
    gchart3d := True;

  if ( colunas3dButton.Down ) or ( colunas2dButton.Down ) then
    tipo := TBarSeries;

  if ( linhas2dButton.Down ) or ( linhas3dButton.Down ) then
    tipo := TLineSeries;

  if ( barras2dButton.Down ) or ( barras3dButton.Down ) then
    tipo := THorizBarSeries;
end;

procedure TtipoGraficoForm.FormShow(Sender: TObject);
var i : Integer;
begin
  inherited;
  serieComboBox.Clear;
  serieComboBox.Items.Add( 'Todas' );
  for i := 0 to Pred( grafico.SeriesCount ) do
  begin
    if grafico.Series[i].Active then
      serieComboBox.Items.Add( grafico.SeriesTitleLegend(i) );
  end;
  serieComboBox.ItemIndex := 0;

  atualizaBotaoTipoGrafico( 0 );

end;

procedure TtipoGraficoForm.atualizaBotaoTipoGrafico(serie: Integer);
var
  tipoSerie : TChartSeries;
  chart3d   : Boolean;
begin

  tipoSerie := grafico.Series[serie];
  chart3d   := grafico.View3D;

  if tipoSerie is TBarSeries then
  begin
    if chart3d then
      colunas3dButton.Down := True
    else
      colunas2dButton.Down := True;
  end;

  if tipoSerie is TLineSeries then
  begin
    if chart3d then
      linhas3dButton.Down := True
    else
      linhas2dButton.Down := True;
  end;

  if tipoSerie is THorizBarSeries then
  begin
    if chart3d then
      barras3dButton.Down := True
    else
      barras2dButton.Down := True;
  end;

end;

procedure TtipoGraficoForm.serieComboBoxChange(Sender: TObject);
begin
  inherited;
  if serieComboBox.ItemIndex = 0 then
    atualizaBotaoTipoGrafico( 0 )
  else
    atualizaBotaoTipoGrafico( Pred( serieComboBox.ItemIndex ) );

end;

end.
