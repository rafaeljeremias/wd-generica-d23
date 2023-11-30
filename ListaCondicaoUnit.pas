unit ListaCondicaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, CondicaoUnit, WiseUnit;

type
  TListaCondicaoForm = class(TForm)
    AdicionaBitBtn: TBitBtn;
    RemoveBitBtn: TBitBtn;
    CondicaoDBGrid: TDBGrid;
    Label1: TLabel;
    SairBitBtn: TBitBtn;
    procedure AdicionaBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RemoveBitBtnClick(Sender: TObject);
    procedure CondicaoDBGridDblClick(Sender: TObject);
    procedure SairBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListaCondicaoForm: TListaCondicaoForm;

implementation
uses
  ConsultaSimplesGenericaUnit;

{$R *.dfm}

procedure TListaCondicaoForm.AdicionaBitBtnClick(Sender: TObject);
begin
  Try
    CondicaoForm := TCondicaoForm.Create(self);
    CondicaoForm.CarregaFields(TConsultaSimplesGenericaForm(Owner).CDSQy.Fields);
    CondiCaoForm.ShowModal;
    if CondicaoForm.ModalResult = mrOk then
    begin
      TConsultaSimplesGenericaForm(Owner).InserirFiltro := True;
      TConsultaSimplesGenericaForm(Owner).FiltroCDS.Append;
      TConsultaSimplesGenericaForm(Owner).FiltroCDSds_condicao.AsString := CondicaoForm.GetCondicao;
      TConsultaSimplesGenericaForm(Owner).FiltroCDSds_mostra.AsString   := CondicaoForm.GetMostra;
      TConsultaSimplesGenericaForm(Owner).FiltroCDS.Post;
    end;
  finally
    CondicaoForm.Free;
    TConsultaSimplesGenericaForm(Owner).InserirFiltro := False;
  end;
end;

procedure TListaCondicaoForm.FormCreate(Sender: TObject);
begin
  CondicaoDBGrid.DataSource := TConsultaSimplesGenericaForm(Owner).FiltroDS;
end;

procedure TListaCondicaoForm.RemoveBitBtnClick(Sender: TObject);
begin
  if msgConfirma('Excluir condição?') then
    TConsultaSimplesGenericaForm(Owner).FiltroCDS.Delete;
end;

procedure TListaCondicaoForm.CondicaoDBGridDblClick(Sender: TObject);
begin
  Try
    CondicaoForm := TCondicaoForm.Create(self);
    CondicaoForm.CarregaFields(TConsultaSimplesGenericaForm(Owner).CDSQy.Fields);
    CondiCaoForm.ShowModal;
    if CondicaoForm.ModalResult = mrOk then
    begin
      TConsultaSimplesGenericaForm(Owner).InserirFiltro := True;
      TConsultaSimplesGenericaForm(Owner).FiltroCDS.Edit;
      TConsultaSimplesGenericaForm(Owner).FiltroCDSds_condicao.AsString := CondicaoForm.GetCondicao;
      TConsultaSimplesGenericaForm(Owner).FiltroCDSds_mostra.AsString   := CondicaoForm.GetMostra;
      TConsultaSimplesGenericaForm(Owner).FiltroCDS.Post;
    end;
  finally
    CondicaoForm.Free;
    TConsultaSimplesGenericaForm(Owner).InserirFiltro := False;
  end;
end;

procedure TListaCondicaoForm.SairBitBtnClick(Sender: TObject);
begin
  close;
end;

end.
