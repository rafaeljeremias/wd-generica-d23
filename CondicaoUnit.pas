unit CondicaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, Mask, WiseUnit;

const
  numerico : array[0..5] of String[2] = ('=','>=','<=','<','>','<>');
  Alfa     : array[0..3] of String[12] = ('Contém','Inicia com','Termina com','Igual a');

type
  TCondicaoForm = class(TForm)
    CamposComboBox: TComboBox;
    OKBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    SinalComboBox: TComboBox;
    ValorEdit: TMaskEdit;
    SensitivoCheckBox: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure OKBitBtnClick(Sender: TObject);
    procedure CamposComboBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ValorEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Campos   : TFields;
    Condicao : String;
    Mostra   : String;
    isalfa     : boolean;
    function CampoPosicao: integer;
  public
    procedure CarregaFields(Campos : TFields);
    function GetCondicao : String;
    function GetMostra : String;
  end;

var
  CondicaoForm: TCondicaoForm;

implementation

{$R *.dfm}

function TCondicaoForm.CampoPosicao : integer;
var
  i,j : integer;
begin
  i := 0;
  j := -1;
  While (j <> CamposComboBox.ItemIndex)and(i < Campos.Count) do
  begin
    if campos[i].Visible then
       inc(j);
    inc(i);
  end;
  Result := i - 1;
end;


function TCondicaoForm.GetCondicao : String;
begin
  Result := Condicao;
end;

function TCondicaoForm.GetMostra : String;
begin
  Result := Mostra;
end;

procedure TCondicaoForm.CarregaFields(Campos : TFields);
var
  i : integer;
begin
  CamposComboBox.Items.Clear;
  i := 0;
  While i <= Pred(Campos.Count) do
  begin
    if Campos[i].Visible then
      CamposComboBox.Items.Add(Campos[i].DisplayLabel);
    inc(i);
  end;
  if CamposComboBox.Items.Count > 0 then
    CamposComboBox.ItemIndex := 0;
  self.Campos := Campos;
  CamposComboBoxClick(self);
end;

procedure TCondicaoForm.OKBitBtnClick(Sender: TObject);
var
  campo, sinal, valor : String;
begin
  msgInformaAbort(Trim(ValorEdit.Text)='','Valor deve ser preenchido!!');
  if Trim(campos[campoPosicao].Origin) <> '' then
    campo := campos[CampoPosicao].Origin
  else
    campo := campos[CampoPosicao].FieldName;
  if (isAlfa)and(not SensitivoCheckBox.Checked) then
    Campo := 'upper('+Campo+')';

  if isAlfa then
    sinal := 'like'
  else
    sinal := SinalComboBox.Text;

  valor := ValorEdit.Text;
  if campos[CampoPosicao].DataType = ftDate then
    Valor := QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDate(ValorEdit.Text)));

  if campos[CampoPosicao].DataType = ftTimeStamp then
    Valor := QuotedStr(FormatDateTime('MM/DD/YYYY hh:nn:ss',StrToDateTime(ValorEdit.Text)));

  if isAlfa then
  begin
    if not SensitivoCheckBox.Checked then
      valor := UpperCase(valor);
    case SinalComboBox.ItemIndex of
      0 : valor := '%'+Valor+'%';
      1 : valor := Valor+'%';
      2 : valor := '%'+Valor;
    else
      valor := Valor;
    end;
    valor := QuotedStr(Valor);
  end;

  condicao := campo + ' ' + sinal +' '+ Valor;
  mostra := CamposComboBox.Text + ' ' + SinalComboBox.Text + ' ' + ValorEdit.Text;
end;


procedure TCondicaoForm.CamposComboBoxClick(Sender: TObject);
var
  i : integer;
begin
  ValorEdit.Text := '';
  ValorEdit.EditMask := '';

  if campos[CampoPosicao].DataType = ftDate then
    ValorEdit.EditMask := '!99/99/0099;1; ';

  if campos[CampoPosicao].DataType = ftTimeStamp then
    ValorEdit.EditMask := '!99/99/0099 99:99:99;1; ';

  SinalComboBox.Items.Clear;
  case campos[CampoPosicao].DataType of
    ftString: begin
                for i:= 0 to High(Alfa) do
                  SinalComboBox.Items.Add(String(alfa[i]));
                isalfa := True;
              end
  else
    for i:= 0 to High(Numerico) do
      SinalComboBox.Items.Add(String(Numerico[i]));
    isalfa := False;
  end;
  if SinalComboBox.Items.Count > 0 then
    SinalComboBox.ItemIndex := 0;
end;

procedure TCondicaoForm.FormCreate(Sender: TObject);
begin
  isalfa := False;
end;

procedure TCondicaoForm.ValorEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then
    OKBitBtn.Click;
end;

end.
