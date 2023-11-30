unit RelatorioGenericoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, WiseUnit;

type
  TCampoTipo = (ctEdit, ctRadioButton, ctCheckBox, ctRadioGroup, ctCombobox, ctDataTime);

  TCampo = record
    nm_campo: String;
    tp_campo: TCampoTipo;
    fg_nulo : Boolean;
  end;

  TListCampo = Array of TCampo;

  IGeradorRelatorio = Interface(IInterface)

    function getSufixoNome: String;
    function getListaCampos: TListCampo;
    function getNomeBotaoExportarCSV: String;

    property ListaCampos: TListCampo read getListaCampos;
    property botaoExportarCSV: String read getNomeBotaoExportarCSV;
  end;

  TRelatorioGenericoForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ImprimirButton: TBitBtn;
    CancelarButton: TBitBtn;
    procedure CancelarButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Chave : String;
  end;

  function campoTipoToStr(const tipo: TCampoTipo) : String;
  function strToCampoTipo(var ok: boolean; const s: String): TCampoTipo;

var
  RelatorioGenericoForm: TRelatorioGenericoForm;

implementation

{$R *.dfm}

uses GlobalUnit;

procedure TRelatorioGenericoForm.CancelarButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TRelatorioGenericoForm.FormClose(Sender: TObject;  var Action: TCloseAction);
var i : integer;
begin
  for I := 0 to Screen.FormCount - 1 do
    if Screen.Forms[I] = Self then Break;
      SendMessage(Application.MainForm.Handle, WM_USER + 1, I, 0);
  Action := caFree;
end;

procedure TRelatorioGenericoForm.FormCreate(Sender: TObject);
begin
  Chave := IncludeTrailingPathDelimiter(ExtractFileName(Application.ExeName)) +  self.Name;
  if LerReg(chave,'width',-1)= -1 then
    self.Position := poDesktopCenter
  else
    self.Position := poDesigned;
  //self.Width := LerReg(chave,'width',self.Width);
  //self.Height := LerReg(chave,'height',self.Height);
  self.Top := LerReg(chave,'top',self.Top);
  self.Left := LerReg(chave,'left',self.left);
end;

procedure TRelatorioGenericoForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    CancelarButtonClick(CancelarButton);
end;

procedure TRelatorioGenericoForm.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  //GravaReg(chave,'width',self.Width);
  //GravaReg(chave,'height',self.Height);
  GravaReg(chave,'top',self.Top);
  GravaReg(chave,'left',self.Left);
end;

function campoTipoToStr(const tipo: TCampoTipo) : String;
begin
  result := EnumeradoToStr(tipo, ['E', 'R', 'X', 'G', 'B', 'D'],
                                 [ctEdit, ctRadioButton, ctCheckBox, ctRadioGroup, ctCombobox, ctDataTime]);
end;

function strToCampoTipo(var ok: boolean; const s: String): TCampoTipo;
begin
  result := StrToEnumerado(ok, s, ['E', 'R', 'X', 'G', 'B', 'D'],
                                  [ctEdit, ctRadioButton, ctCheckBox, ctRadioGroup, ctCombobox, ctDataTime]);
end;

end.
