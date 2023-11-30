unit ConsultaComercialVendasResultadoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, consultaGenericaConsultaUnit, FMTBcd, SqlExpr, Menus, RpDefine,
  RpBase, RpSystem, DB, DBClient, ComCtrls, StdCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ExtCtrls, strUtils;

type
  TConsultaComercialVendasResultadoForm = class(TconsultaGenericaConsultaForm)
    EmpresaMenu: TMenuItem;
    ClienteMenu: TMenuItem;
    GrupoMenu: TMenuItem;
    ProdutoServicoMenu: TMenuItem;
    CidadeMenu: TMenuItem;
    EstadoMenu: TMenuItem;
    PeriodoMenu: TMenuItem;
    camposCDS: TClientDataSet;
    camposCDScd_campo: TStringField;
    camposCDSvl_campo: TStringField;
    tipoInsumoMenu: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure PeriodoMenuClick(Sender: TObject);
  private
    { Private declarations }
    cd_id : String;
    procedure addCampo;
  public
    { Public declarations }
    procedure addCampos ( cd_campo, vl_campo : String );
    procedure setPeriodo( dt_inicial, dt_final : TDateTime );
    procedure setID( lcd_id : Integer );
    procedure setRemessa( r : boolean );
  end;

var
  ConsultaComercialVendasResultadoForm: TConsultaComercialVendasResultadoForm;

implementation

uses globalUnit;

{$R *.dfm}

{ TConsultaComercialVendasResultadoForm }

procedure TConsultaComercialVendasResultadoForm.addCampo;
begin
  camposParametroCDS.First;
  repeat
    camposCDS.Append;
    camposCDScd_campo.AsString := camposParametroCDSnomeField.AsString;
    if cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString <> '0' then
      camposCDSvl_campo.AsString := cds.fieldByName( camposParametroCDSnomeField.AsString ).AsString
    else
      camposCDSvl_campo.AsString := 'is null';
    camposCDS.Post;
    camposParametroCDS.Next;
  until camposParametroCDS.Eof;

end;

procedure TConsultaComercialVendasResultadoForm.addCampos(cd_campo,
  vl_campo: String);
begin
  if ( cd_campo <> '' ) and ( vl_campo <> '' ) then
  begin
    camposCDS.Append;
    camposCDScd_campo.AsString := cd_campo;
    camposCDSvl_campo.AsString := vl_campo;
    camposCDS.Post;
  end;
end;

procedure TConsultaComercialVendasResultadoForm.setID(lcd_id: Integer);
begin
  cd_id := IntToStr( lcd_id );
end;

procedure TConsultaComercialVendasResultadoForm.setPeriodo(dt_inicial,
  dt_final: TDateTime);
begin
  dt_inicialDate.DateTime := dt_inicial;
  dt_finalDate.DateTime   := dt_final;
end;

procedure TConsultaComercialVendasResultadoForm.setRemessa(r: boolean);
begin

end;

procedure TConsultaComercialVendasResultadoForm.FormShow(Sender: TObject);
begin
  sql_padrao := '  from tb_venda_tmp ns ' +
                ' inner join tb_produto_servico ps on ( ns.cd_produto_servico = ps.cd_produto_servico ) ' +
                ' inner join tb_grupo_produto gp on ( ns.cd_grupo = gp.cd_grupo_produto ) ' +
                ' inner join tb_unidade_medida um on ( ns.cd_unidade_medida = um.cd_unidade_medida ) ' +
                ' inner join tb_pessoa pc on (ns.cd_cliente=pc.cd_pessoa) ' +
                ' inner join tb_pessoa pe on (ns.cd_empresa = pe.cd_pessoa) ' +
                ' inner join tb_condicao_pagamento cp on (ns.cd_condicao_pagamento=cp.cd_condicao_pagamento) ' +
                '  left join tb_cidade ci on (pc.cd_cidade=ci.cd_cidade) ' +
                '  left join tb_estado es on (ci.cd_estado=es.cd_estado) ' +
                ' where ns.cd_venda_tmp = ' + cd_id +
                ' /*SQLExtra*/';

  campoData := '';
  usaData := false;

  campoValor := 'vl_faturado';

  sql_select := 'sum( ns.vl_faturado ) as vl_faturado, sum( ns.qt_faturada ) as qt_faturada, Sum( vl_remessa ) as vl_remessa, Sum( qt_remessa ) as qt_remessa ';

  if tipoConsulta <> '' then
  begin
    if tipoConsulta = 'Empresa' then
    begin
      campoDescricao := 'nm_empresa';
      sql_select := 'Select pe.nr_empresa, pe.nm_fantasia as nm_empresa, ' + sql_select;
      sql_groupBy := 'Group by 1, 2 ';
      adicionaTituloCampo( 'nr_empresa', 'Emp', true, 5 );
      adicionaTituloCampo( 'nm_empresa', 'Nome da Empresa', false,25 );
      adicionaCondicaoParametro( 'pe.nr_empresa', 'nr_empresa', 'I', true );
    end;

    if tipoConsulta = 'Cliente' then
    begin
      campoDescricao := 'nm_cliente';
      sql_select := 'Select ns.cd_cliente, pc.nm_fantasia as nm_cliente, ' + sql_select;
      sql_groupBy := 'Group by 1, 2 ';
      adicionaTituloCampo( 'cd_cliente', 'Código', true, 5 );
      adicionaTituloCampo( 'nm_cliente', 'Nome do Cliente', false, 25 );
      adicionaCondicaoParametro( 'ns.cd_cliente', 'cd_cliente', 'I', true );
    end;

    if tipoConsulta = 'Grupo' then
    begin
      campoDescricao := 'ds_grupo_produto';
      sql_select := 'Select ns.cd_grupo, gp.ds_grupo_produto, ' + sql_select;
      sql_groupBy := 'Group by 1, 2 ';
      adicionaTituloCampo( 'cd_grupo', 'Código', true, 5 );
      adicionaTituloCampo( 'ds_grupo_produto', 'Descrição do Grupo', false, 25 );
      adicionaCondicaoParametro( 'ns.cd_grupo', 'cd_grupo', 'I', true );
    end;

    if tipoConsulta = 'Cidade' then
    begin
      campoDescricao := 'nm_cidade';
      sql_select := 'Select Coalesce( ci.cd_cidade, 0 ) as cd_cidade, Coalesce( ci.nm_cidade, ''Não informado'') as nm_cidade, Coalesce( es.sg_estado, ''--'' ) as sg_estado, ' + sql_select;
      sql_groupBy := 'Group by 1, 2, 3 ';
      adicionaTituloCampo( 'cd_cidade', 'Código', true, 5 );
      adicionaTituloCampo( 'nm_cidade', 'Nome da Cidade', false, 25 );
      adicionaTituloCampo( 'sg_estado', 'Estado', false, 5 );
      adicionaCondicaoParametro( 'ci.cd_cidade', 'cd_cidade', 'I', true );
    end;


    if tipoConsulta = 'Produto/Serviço' then
    begin
      campoDescricao := 'ds_produto_servico';
      sql_select := 'Select ns.cd_produto_servico, ps.ds_produto_servico, um.sg_unidade_medida, ' + sql_select;
      sql_groupBy := 'Group by 1, 2, 3 ';
      adicionaTituloCampo( 'cd_produto_servico', 'Código', true, 10 );
      adicionaTituloCampo( 'ds_produto_servico', 'Descrição Produto/Serviço', false, 25 );
      adicionaTituloCampo( 'sg_unidade_medida', 'UN', false, 10 );
      adicionaCondicaoParametro( 'ns.cd_produto_servico', 'cd_produto_servico', 'I', True );
    end;

    if tipoConsulta = 'Estado' then
    begin
      campoDescricao := 'sg_estado';
      sql_select := 'Select Coalesce( es.cd_estado, 0 ) as cd_estado, Coalesce( es.sg_estado, ''--'' ) as sg_estado, Coalesce( es.nm_estado, ''Não Informado'' ) as nm_estado, ' + sql_select;
      sql_groupBy := 'Group by 1, 2, 3 ';
      adicionaTituloCampo( 'cd_estado', 'Código', true, 5 );
      adicionaTituloCampo( 'sg_estado', 'UF', false, 5 );
      adicionaTituloCampo( 'nm_estado', 'Nome Unidade Federativa', false, 25 );
      adicionaCondicaoParametro( 'es.cd_estado', 'cd_estado', 'C', true );
    end;

    if tipoConsulta = 'Condição de Pagamento' then
    begin
      campoDescricao := 'ds_condicao_pagamento';
      sql_select := 'Select ns.cd_condicao_pagamento, cp.ds_condicao_pagamento, ' + sql_select;
      sql_groupBy := 'Group by 1, 2 ';
      adicionaTituloCampo( 'cd_condicao_pagamento', 'Código', true, 5 );
      adicionaTituloCampo( 'ds_condicao_pagamento', 'Descrição da Condição de Pagamento', false, 25 );
      adicionaCondicaoParametro( 'ns.cd_condicao_pagamento', 'cd_condicao_pagamento', 'I', true );
    end;

    if tipoConsulta = 'Período' then
    begin
      campoDescricao := 'periodo';
      sql_select := 'Select periodo,  ' + sql_select;
      sql_groupBy := 'Group by 1 ';
      adicionaTituloCampo( 'periodo', 'Mês/Ano', true, 5 );
      adicionaCondicaoParametro( 'periodo', 'periodo', 'C', true );
    end;

    if tipoConsulta = 'Tipo de Insumo' then
    begin
      campoDescricao := 'tipo_insumo';
      sql_select := 'select ( Case when ps.fg_produto_servico = ''P'' then ''Produto'' else ''Serviço'' end ) as tipo_insumo, ps.fg_produto_servico as fg_produto_servico, ' + sql_select;
      sql_groupBy := 'Group by 1, 2 ';
      adicionaTituloCampo( 'tipo_insumo', 'Tipo Insumo', true, 5 );
      adicionaTituloCampo( 'fg_produto_servico', 'P/S', false, 0 );

      adicionaCondicaoParametro( 'ps.fg_produto_servico', 'fg_produto_servico', 'C', true );
    end;


    adicionaTituloCampo( 'vl_faturado', 'Vlr Faturado', false,15 );
    adicionaTituloCampo( 'qt_faturada', 'Qtd Faturada', false,15 );
    adicionaTituloCampo( 'vl_remessa', 'Vlr Remessa', false,15 );
    adicionaTituloCampo( 'qt_remessa', 'Qtd Remessa', false,15 );

  end;

  Caption := Caption + ' ( ' + tipoConsulta +  ' )';
  inherited;

end;

procedure TConsultaComercialVendasResultadoForm.PeriodoMenuClick(
  Sender: TObject);
var subForm : TconsultaComercialVendasResultadoForm;
    sql_extra_form, condicao_extra : String;
begin
  subForm := TconsultaComercialVendasResultadoForm.Create(Self);
  subForm.setID( StrToInt( cd_id ) );
  sql_extra_form := retornaSQLExtra( qy.SQL.Text );
  condicao_extra := '';
  if ( cds.FieldByName('ordem').AsInteger <> 999 )  then
  begin
    addCampo;
    condicao_extra := retornaSQLParametros( qy.SQL.Text );
    subForm.Caption := subForm.Caption + ' ( ' + cds.fieldByName( campoDescricao ).AsString + ' )';
  end;

  if not camposCDS.IsEmpty then
  begin
    camposCDS.First;
    repeat
      subForm.camposCDS.Append;
      subForm.camposCDScd_campo.AsString := camposCDScd_campo.AsString;
      subForm.camposCDSvl_campo.AsString := camposCDSvl_campo.AsString;
      subForm.camposCDS.Post;
      camposCDS.Next;
    until camposCDS.Eof;
  end;
  subForm.dt_inicialDate.DateTime := dt_inicialDate.DateTime;
  subForm.dt_finalDate.DateTime   := dt_finalDate.DateTime;
  subForm.sql_extra := sql_extra_form + condicao_extra;
  subForm.tipoConsulta := AnsiReplaceStr( ( Sender as TMenuItem ).Caption, '&', '' );
  subForm.setParametroExtra( getParametroExtra );
  subForm.mensagemLabel.Caption := mensagemLabel.Caption;
  subForm.Show;

end;

end.
