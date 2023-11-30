unit RegistroUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, wiseUnit, GlobalUnit;

type
  TRegistroForm = class(TForm)
    ChaveEdit: TLabeledEdit;
    RegistroEdit: TLabeledEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    RegistroButton: TBitBtn;
    CancelarButton: TBitBtn;
    procedure CancelarButtonClick(Sender: TObject);
    procedure RegistroButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    chave_registro_win : String;
  public
    { Public declarations }
    procedure setChaveRegistroWin( lchave : String );
  end;

var
  RegistroForm: TRegistroForm;

implementation

uses dmUnit;

{$R *.dfm}

procedure TRegistroForm.CancelarButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TRegistroForm.FormCreate(Sender: TObject);
begin
  chave_registro_win := '';
end;

procedure TRegistroForm.RegistroButtonClick(Sender: TObject);
var
  dt_registro, registro, key, k, r: string;
begin
  key      := Decrip(ChaveEdit.Text, chaveregistro);
  registro := Decrip(RegistroEdit.Text, chave);
  if key = registro then
  begin
    k := Encrip(copy(key,1,6), chaveregistro);
    r := Encrip(registro, chave);
    GravaReg(chave_registro_win, 'chave', k);
    GravaReg(chave_registro_win, 'registro', r);
    msgAlerta('Registro efetuado com sucesso');
    dt_registro := Encrip(FormatDateTime('dd/mm/yyyy', now ), chave);
    dm.setParametro('dt_registro', dt_registro, 'S');
    dm.setParametro('dt_ultimo_login', dt_registro,'S');

  end;
  Application.Terminate;
end;

procedure TRegistroForm.setChaveRegistroWin(lchave: String);
begin
  chave_registro_win := lchave;
end;

end.
