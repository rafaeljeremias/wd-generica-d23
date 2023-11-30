unit ConsultaMaterialEmpresaUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ConsultaSimplesGenericaUnit, FMTBcd, Menus, DB, Provider,
  DBClient, SqlExpr, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  TConsultaMaterialEmpresaForm = class(TConsultaSimplesGenericaForm)
    CDSQyCD_EMPRESA: TIntegerField;
    CDSQyCD_MATERIAL: TIntegerField;
    CDSQyQT_ESTOQUE: TFMTBCDField;
    CDSQyFL_ATIVO: TStringField;
    CDSQyFL_PERMITE_ESTOQUE_NEGATIVO: TStringField;
    CDSQyVL_ULTIMA_ENTRADA: TFMTBCDField;
    CDSQyDT_ULTIMA_ENTRADA: TDateField;
    CDSQyVL_CUSTO_MEDIO: TFMTBCDField;
    CDSQyDT_ULTIMA_SAIDA: TDateField;
    CDSQyVL_ESTOQUE: TFMTBCDField;
    CDSQyFL_CONTROLA_ESTOQUE: TStringField;
    CDSQyDS_MATERIAL: TStringField;
    CDSQyCD_UNIDADE_MEDIDA: TStringField;
    procedure NovoButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultaMaterialEmpresaForm: TConsultaMaterialEmpresaForm;

implementation

uses dmUnit, CadastroMaterialEmpresaUnit;

{$R *.dfm}

procedure TConsultaMaterialEmpresaForm.NovoButtonClick(Sender: TObject);
var sql : string;
begin
  inherited;
  cadastroMaterialEmpresaForm := TcadastroMaterialEmpresaForm.Create(self);
  sql := cadastroMaterialEmpresaForm.SQLData.CommandText;
  if CDSQyCD_EMPRESA.AsString <> '' then
    sql := sql + ' where me.cd_empresa = ' + CDSQyCD_EMPRESA.AsString + ' and me.cd_material = ' + CDSQyCD_MATERIAL.AsString;
  Try
    with cadastroMaterialEmpresaForm do
      case TBitBtn(Sender).Tag of
        0: AbreNovo;
        1: AbreEditar('','',sql);
        2: AbreExcluir('','',sql);
      end;
  finally
    cadastroMaterialEmpresaForm.Free;
    if CDSQy.Active then
      CDSQy.Refresh;
  end;

end;

end.
