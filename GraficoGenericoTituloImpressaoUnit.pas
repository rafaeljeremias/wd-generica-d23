unit GraficoGenericoTituloImpressaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, ExtCtrls, StdCtrls, Buttons;

type
  TgraficoGenericoTituloImpressaoForm = class(TFormBasicoPanelForm)
    tituloEdit: TLabeledEdit;
    okButton: TBitBtn;
    fecharButton: TBitBtn;
    procedure fecharButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  graficoGenericoTituloImpressaoForm: TgraficoGenericoTituloImpressaoForm;

implementation

{$R *.dfm}

procedure TgraficoGenericoTituloImpressaoForm.fecharButtonClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

end.
