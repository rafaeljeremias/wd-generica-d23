unit graficoGerencialGenericoTituloImpressaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoPanelUnit, StdCtrls, Buttons, ExtCtrls;

type
  TgraficoGerencialGenericoTituloImpressaoForm = class(TFormBasicoPanelForm)
    tituloEdit: TLabeledEdit;
    fecharButton: TBitBtn;
    okButton: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  graficoGerencialGenericoTituloImpressaoForm: TgraficoGerencialGenericoTituloImpressaoForm;

implementation

{$R *.dfm}

end.
