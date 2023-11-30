{$WARN UNIT_PLATFORM OFF;}
unit PastaGenericaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ShellCtrls;

type
  TPastaForm = class(TForm)
    Shell: TShellTreeView;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Pasta: String;
  end;

var
  PastaForm: TPastaForm;

implementation

{$R *.dfm}

procedure TPastaForm.BitBtn1Click(Sender: TObject);
begin
  Pasta := Shell.Path;
  Close; 
end;

end.
