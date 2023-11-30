unit ConsultaCampo1GenericaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ConsultaSimplesGenericaUnit, Provider, DBClient, DB, SqlExpr,
  StdCtrls, Grids, DBGrids, ExtCtrls, Buttons, ImgList, FMTBcd, Menus;

type
  TConsultaCampo1GenericaForm = class(TConsultaSimplesGenericaForm)
    Campo1Edit: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ConsultaButtonClick(Sender: TObject);
    procedure Campo1EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Campo, Tipo :String;
  public
    { Public declarations }
  end;

var
  ConsultaCampo1GenericaForm: TConsultaCampo1GenericaForm;

implementation

{$R *.dfm}

procedure TConsultaCampo1GenericaForm.FormCreate(Sender: TObject);
var
  n, i : integer;
begin
  n := 0;
  Campo :='';
  Tipo := '';
  for i:=0 to Pred(CdsQy.Fields.Count) do
  begin
   if CdsQy.Fields[i].Tag = 101 then
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
    showmessage('Falta setar a tag para o campo 1');
  inherited;
end;

procedure TConsultaCampo1GenericaForm.ConsultaButtonClick(Sender: TObject);
begin
  if not (FindComponent('Campo2Edit') <> nil) then
    ClearSQL;
  if Trim(Campo1Edit.Text) <> '' then
    AddWhere(MontaCondicao(Campo,Campo1Edit.Text,Tipo));
  inherited;
end;

procedure TConsultaCampo1GenericaForm.Campo1EditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = Vk_Return then
    ConsultaButton.Click;
end;

end.
