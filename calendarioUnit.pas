unit calendarioUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoUnit, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TcalendarioForm = class(TFormBasicoForm)
    MonthCalendar: TMonthCalendar;
    Panel1: TPanel;
    okButton: TBitBtn;
    fecharButton: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  calendarioForm: TcalendarioForm;

implementation

{$R *.dfm}

procedure TcalendarioForm.FormCreate(Sender: TObject);
begin
  inherited;
  MonthCalendar.Date := now;
end;

end.
