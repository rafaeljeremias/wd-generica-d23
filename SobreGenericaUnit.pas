unit SobreGenericaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, ShellAPI, Winsock, strUtils;

type
  TSobreGenericaForm = class(TForm)
    LogoEmpresa: TImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    NomeSistemaLabel: TLabel;
    VersaoLabel: TLabel;
    LogoSistema: TImage;
    Bevel4: TBevel;
    EmpresaLabel: TLabel;
    SiteLabel: TLabel;
    copyrightLabel: TLabel;
    emailLabel: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SiteLabelClick(Sender: TObject);
    procedure emailLabelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SobreGenericaForm: TSobreGenericaForm;

implementation

{$R *.dfm}

procedure TSobreGenericaForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // manda uma mensagem para atualizar a lista de janelas abertas
  Action := caFree;
end;

procedure TSobreGenericaForm.FormShow(Sender: TObject);
begin
  copyrightLabel.Caption := ansiReplaceStr( copyrightLabel.Caption, '<ano>', FormatDateTime( 'yyyy', Now ) );
end;

procedure TSobreGenericaForm.SiteLabelClick(Sender: TObject);
begin
  ShellExecute(Handle, 'Open', 'www.automalog.com.br' , nil, nil, sw_Normal);
end;

procedure TSobreGenericaForm.emailLabelClick(Sender: TObject);
begin
  ShellExecute(Handle, 'Open', 'mailto:suporte@automalog.com.br' , nil, nil, sw_Normal);
end;


end.
