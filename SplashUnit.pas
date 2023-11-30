unit SplashUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, strUtils;

type
  TSplashForm = class(TForm)
    Timer: TTimer;
    Panel1: TPanel;
    LogoImagem: TImage;
    Bevel1: TBevel;
    NomeSistemaLabel: TLabel;
    LogoSistema: TImage;
    Bevel2: TBevel;
    DireitosLabel: TLabel;
    copyrightLabel: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.dfm}

procedure TSplashForm.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  Close;
end;

procedure TSplashForm.FormShow(Sender: TObject);
begin
  Timer.Enabled := True;
  copyrightLabel.Caption := ansiReplaceStr( copyrightLabel.Caption, '<ano>', FormatDateTime( 'yyyy', Now ) );
end;

procedure TSplashForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Escape then close;
end;

end.
