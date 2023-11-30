unit FormBasicoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WiseUnit, strUtils;

type
  TFormBasicoForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    chave : String;
  public
    { Public declarations }
    function getNomeForm : string;
  end;

var
  FormBasicoForm: TFormBasicoForm;

implementation

{$R *.dfm}

procedure TFormBasicoForm.FormCreate(Sender: TObject);
begin
  Chave := getNomeForm;
  if LerReg(chave,'width',-1)= -1 then
    self.Position := poDesktopCenter
  else
    self.Position := poDesigned;
  self.Width := LerReg(chave,'width',self.Width);
  self.Height := LerReg(chave,'height',self.Height);
  self.Top := LerReg(chave,'top',self.Top);
  self.Left := LerReg(chave,'left',self.left);
end;

procedure TFormBasicoForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if self.WindowState = wsnormal then
  begin
    GravaReg(chave,'width',self.Width);
    GravaReg(chave,'height',self.Height);
    GravaReg(chave,'top',self.Top);
    GravaReg(chave,'left',self.Left);
  end;
end;

procedure TFormBasicoForm.FormClose(Sender: TObject;  var Action: TCloseAction);
var
  I : Integer;

begin
  i := 0;
  // manda uma mensagem para atualizar a lista de janelas abertas
  if Screen.FormCount > 0 then
    for I := 0 to Screen.FormCount - 1 do
      if Screen.Forms[I] = Self then Break;
        if Screen.Forms[I].Visible then
          SendMessage(Application.MainForm.Handle, WM_USER + 1, I, 0);
end;

function TFormBasicoForm.getNomeForm: string;
var nm_form : string;
    i : byte;
begin
  nm_form := self.Name;
  for i := 1 to 20 do
    nm_form := AnsiReplaceStr( nm_form, '_' + IntToStr(i), '' );
  result := IncludeTrailingPathDelimiter(ExtractFileName(Application.ExeName)) + nm_form;
end;

end.
