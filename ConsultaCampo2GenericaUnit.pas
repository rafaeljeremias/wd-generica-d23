unit ConsultaCampo2GenericaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ConsultaCampo1GenericaUnit, Provider, DBClient, DB, SqlExpr,
  StdCtrls, Grids, DBGrids, ExtCtrls, Buttons, ImgList, FMTBcd, Menus;

type
  TConsultaCampo2GenericaForm = class(TConsultaCampo1GenericaForm)
    Label6: TLabel;
    Campo2Edit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ConsultaButtonClick(Sender: TObject);
    procedure Campo2EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Campo, Tipo :String;
  public
    { Public declarations }
  end;

var
  ConsultaCampo2GenericaForm: TConsultaCampo2GenericaForm;

implementation

{$R *.dfm}

procedure TConsultaCampo2GenericaForm.FormCreate(Sender: TObject);
var
  n, i : integer;
begin
  n := 0;
  Campo :='';
  Tipo := '';
  for i:=0 to Pred(CdsQy.Fields.Count) do
  begin
   if CdsQy.Fields[i].Tag = 102 then
   begin
     inc(n);
     if CdsQy.Fields[i].Origin <> '' then
       Campo := CDSQy.Fields[i].origin
     else
       Campo := CDSQy.Fields[i].fieldName;
     if CDSQy.Fields[i].DataType = ftString   then
       Tipo := 'String';
     if CDSQy.Fields[i].DataType = ftInteger  then
       Tipo := 'Integer';
     if CDSQy.Fields[i].DataType in [ftFloat, ftFMTBcd, ftBCD] then
       Tipo := 'Float';
     if CDSQy.Fields[i].DataType = ftDateTime then
       Tipo := 'DateTime';
     if CDSQy.Fields[i].DataType = ftTime then
       Tipo := 'Time';
     if CDSQy.Fields[i].DataType = ftDate then
       Tipo := 'Date';
   end;
  end;
  if n <> 1 then
    showmessage('Falta setar a tag para o campo 2');
  inherited;
end;

procedure TConsultaCampo2GenericaForm.ConsultaButtonClick(Sender: TObject);
begin
  if not (FindComponent('Campo3Edit') <> nil) then
    ClearSQL;
  if Trim(Campo2Edit.Text) <> '' then
    AddWhere(MontaCondicao(Campo,Campo2Edit.Text,Tipo));
  inherited;
end;

procedure TConsultaCampo2GenericaForm.Campo2EditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = Vk_Return then
    ConsultaButton.Click;
end;

end.
