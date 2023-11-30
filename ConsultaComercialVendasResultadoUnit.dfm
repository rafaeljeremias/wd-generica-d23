inherited ConsultaComercialVendasResultadoForm: TConsultaComercialVendasResultadoForm
  Caption = 'Consulta de Vendas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainPanel: TPanel
    ExplicitWidth = 744
    ExplicitHeight = 384
  end
  inherited PopupMenu: TPopupMenu
    object EmpresaMenu: TMenuItem
      Caption = 'Empresa'
      OnClick = PeriodoMenuClick
    end
    object ClienteMenu: TMenuItem
      Caption = 'Cliente'
      OnClick = PeriodoMenuClick
    end
    object GrupoMenu: TMenuItem
      Caption = 'Grupo'
      OnClick = PeriodoMenuClick
    end
    object ProdutoServicoMenu: TMenuItem
      Caption = 'Produto/Servi'#231'o'
      OnClick = PeriodoMenuClick
    end
    object CidadeMenu: TMenuItem
      Caption = 'Cidade'
      OnClick = PeriodoMenuClick
    end
    object EstadoMenu: TMenuItem
      Caption = 'Estado'
      OnClick = PeriodoMenuClick
    end
    object PeriodoMenu: TMenuItem
      Caption = 'Per'#237'odo'
      OnClick = PeriodoMenuClick
    end
    object tipoInsumoMenu: TMenuItem
      Caption = 'Tipo de Insumo'
      OnClick = PeriodoMenuClick
    end
  end
  object camposCDS: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 276
    Data = {
      540000009619E0BD01000000180000000200000000000300000054000863645F
      63616D706F0100490000000100055749445448020002001E0008766C5F63616D
      706F0100490000000100055749445448020002000A000000}
    object camposCDScd_campo: TStringField
      FieldName = 'cd_campo'
      Size = 30
    end
    object camposCDSvl_campo: TStringField
      FieldName = 'vl_campo'
      Size = 10
    end
  end
end
