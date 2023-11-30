unit ConsultaMaterialUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ConsultaSimplesGenericaUnit, FMTBcd, Menus, DB, Provider,
  DBClient, SqlExpr, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  TConsultaMaterialForm = class(TConsultaSimplesGenericaForm)
    CDSQyCD_MATERIAL: TIntegerField;
    CDSQyDS_MATERIAL: TStringField;
    CDSQyCD_UNIDADE_MEDIDA: TStringField;
    CDSQyCD_GRUPO_MATERIAL: TIntegerField;
    CDSQyFL_ATIVO: TStringField;
    CDSQyDS_GRUPO_MATERIAL: TStringField;
    procedure NovoButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultaMaterialForm: TConsultaMaterialForm;

implementation

uses dmUnit, CadastroMaterialUnit;

{$R *.dfm}

procedure TConsultaMaterialForm.NovoButtonClick(Sender: TObject);
begin
  inherited;
  cadastroMaterialForm := TcadastroMaterialForm.Create(self);
  Try
    with cadastroMaterialForm do
      case TBitBtn(Sender).Tag of
        0: AbreNovo;
        1: AbreEditar('cd_material',CDSQyCD_MATERIAL.AsString);
        2: AbreExcluir('cd_material',CDSQyCD_MATERIAL.AsString);
      end;
  finally
    cadastroMaterialForm.Free;
    if CDSQy.Active then
      CDSQy.Refresh;
  end;

end;

end.
