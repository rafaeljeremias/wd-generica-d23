unit opcaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, ExtCtrls, StdCtrls, Buttons;

type
  TopcaoForm = class(TFormBasicoPanelForm)
    okButton: TBitBtn;
    cancelarButton: TBitBtn;
    opcoesRadioGroup: TRadioGroup;
    procedure okButtonClick(Sender: TObject);
  private
    { Private declarations }
    respondeu : boolean;
  public
    { Public declarations }
    procedure setTitulo( titulo : String );
    procedure setCaption( Caption : String );
    function getRespondeu : boolean;
    function getResposta : Integer;
    procedure addResposta( ds : string );
    procedure setRespostaDefault( r : integer );
    procedure setTamanho( wdt, hgt : integer );    

  end;

var
  opcaoForm: TopcaoForm;

implementation

{$R *.dfm}

{ TopcaoForm }

procedure TopcaoForm.addResposta(ds: string);
begin
  opcoesRadioGroup.Items.Add( ds );
end;

function TopcaoForm.getRespondeu: boolean;
begin
  Result := respondeu;
end;

function TopcaoForm.getResposta: Integer;
begin
  result := opcoesRadioGroup.ItemIndex;
end;

procedure TopcaoForm.setCaption(Caption: String);
begin
  opcoesRadioGroup.Items.Clear;
  opcoesRadioGroup.Caption := Caption;
end;

procedure TopcaoForm.setRespostaDefault(r: integer);
begin
  opcoesRadioGroup.ItemIndex := r;
end;

procedure TopcaoForm.setTamanho(wdt, hgt: integer);
begin
  Width := wdt;
  Height := hgt;                               
end;

procedure TopcaoForm.setTitulo(titulo: String);
begin
  Caption := titulo;
end;

procedure TopcaoForm.okButtonClick(Sender: TObject);
begin
  inherited;
  respondeu := true;
  close;

end;

end.
