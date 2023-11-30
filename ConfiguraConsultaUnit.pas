unit ConfiguraConsultaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, ExtCtrls, StdCtrls, Buttons, WiseUnit;

type
  TConfiguraConsultaForm = class(TFormBasicoPanelForm)
    OpcaoRadioGroup: TRadioGroup;
    GroupBox1: TGroupBox;
    OrdemComboBox: TComboBox;
    InverteCheckBox: TCheckBox;
    GroupBox2: TGroupBox;
    CampoComboBox: TComboBox;
    FiltroComboBox: TComboBox;
    BitBtn1: TBitBtn;
    AbertaCheckBox: TCheckBox;
    procedure CampoComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Lista : TStringList;
  public
    procedure configura(Lista: TStringList);
  end;

var
  ConfiguraConsultaForm: TConfiguraConsultaForm;

implementation

{$R *.dfm}

procedure TConfiguraConsultaForm.CampoComboBoxChange(Sender: TObject);
begin
  inherited;
  // caso o campo escolhido da combo seja do tipo string, habilita o radiogroup e desabilita o filtro
  // para pesquisa exata ou parcial. Caso seja outro tipo (data, float, integer) habilita  o filtro
  // e desabilita o radio group
  if Separa(Lista[CampoComboBox.ItemIndex], '#',2) = 'String' then
  begin
    OpcaoRadioGroup.Enabled := True;
    FiltroComboBox.Enabled  := False
  end
  else
  begin
    OpcaoRadioGroup.Enabled := False;
    FiltroComboBox.Enabled  := True;
  end;
end;

procedure TConfiguraConsultaForm.configura(Lista: TStringList);
begin
  Self.Lista.AddStrings(Lista);
end;

procedure TConfiguraConsultaForm.FormCreate(Sender: TObject);
begin
  inherited;
  Lista := TStringList.Create;
end;

procedure TConfiguraConsultaForm.FormDestroy(Sender: TObject);
begin
  Lista.Free;
  inherited;
end;

end.
