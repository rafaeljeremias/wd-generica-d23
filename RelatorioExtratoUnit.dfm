inherited relatorioExtratoForm: TrelatorioExtratoForm
  Caption = 'Relat'#243'rio Extrato'
  ClientHeight = 246
  ClientWidth = 432
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 432
    Height = 206
    object Label4: TLabel
      Left = 8
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object Label12: TLabel
      Left = 8
      Top = 48
      Width = 69
      Height = 13
      Caption = 'Grupo Material'
    end
    object Label10: TLabel
      Left = 8
      Top = 88
      Width = 37
      Height = 13
      Caption = 'Material'
    end
    object cd_empresaEdit: TWDSimplesEdit
      Left = 8
      Top = 24
      Width = 69
      Height = 21
      Hint = 'F3 - Consulta'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Botao = empresaListagemButton
      SQL.Strings = (
        'Select nm_empresa'
        ' from tb_empresa '
        '')
      Conexao = dm.conexao
      Chave = <
        item
          Edit = nm_empresaEdit
          Tipo = fdString
        end>
      Dependencia = <>
      CampoChave = 'cd_empresa'
      Mensagem = 'Empresa n'#227'o Encontrada'
      Tipo = fdInteger
    end
    object empresaListagemButton: TButton
      Left = 82
      Top = 24
      Width = 21
      Height = 21
      Hint = 'Clique aqui para obter '#13#10'uma listagem de Empresa'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = empresaListagemButtonClick
    end
    object nm_empresaEdit: TEdit
      Left = 108
      Top = 24
      Width = 313
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object cd_grupo_materialEdit: TWDSimplesEdit
      Left = 8
      Top = 64
      Width = 69
      Height = 21
      Hint = 'F3 - Consulta'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Botao = grupoMaterialListagemButton
      SQL.Strings = (
        'Select ds_grupo_material '
        'from tb_grupo_material')
      Conexao = dm.conexao
      Chave = <
        item
          Edit = ds_grupo_materialEdit
          Tipo = fdString
        end>
      Dependencia = <>
      CampoChave = 'cd_grupo_material'
      Mensagem = 'Grupo de Material n'#227'o Encontrado'
      Tipo = fdInteger
    end
    object grupoMaterialListagemButton: TButton
      Left = 82
      Top = 64
      Width = 21
      Height = 21
      Hint = 'Clique aqui para obter '#13#10'uma listagem de Grupo Material'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
      OnClick = grupoMaterialListagemButtonClick
    end
    object ds_grupo_materialEdit: TEdit
      Left = 108
      Top = 64
      Width = 313
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object cd_materialEdit: TWDSimplesEdit
      Left = 8
      Top = 104
      Width = 69
      Height = 21
      Hint = 'F3 - Consulta'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Botao = materialListagemButton
      SQL.Strings = (
        'Select ds_material'
        'from tb_material')
      Conexao = dm.conexao
      Chave = <
        item
          Edit = ds_materialEdit
          Tipo = fdString
        end>
      Dependencia = <>
      CampoChave = 'cd_material'
      Mensagem = 'Material n'#227'o Encontrado'
      Tipo = fdInteger
    end
    object materialListagemButton: TButton
      Left = 82
      Top = 104
      Width = 21
      Height = 21
      Hint = 'Clique aqui para obter '#13#10'uma listagem de Material'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      TabStop = False
      OnClick = materialListagemButtonClick
    end
    object ds_materialEdit: TEdit
      Left = 108
      Top = 104
      Width = 313
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object periodoGroupBox: TGroupBox
      Left = 8
      Top = 132
      Width = 225
      Height = 61
      Caption = ' Per'#237'odo '
      TabOrder = 9
      object Label1: TLabel
        Left = 108
        Top = 36
        Width = 6
        Height = 13
        Caption = 'a'
      end
      object Label2: TLabel
        Left = 8
        Top = 16
        Width = 27
        Height = 13
        Caption = 'Inicial'
      end
      object Label3: TLabel
        Left = 124
        Top = 16
        Width = 22
        Height = 13
        Caption = 'Final'
      end
      object dt_finalDateTime: TDateTimePicker
        Left = 124
        Top = 32
        Width = 93
        Height = 21
        Hint = 'Intervalo Final para a Data de In'#237'cio'
        Date = 37804.690213773140000000
        Time = 37804.690213773140000000
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object dt_inicialDateTime: TDateTimePicker
        Left = 8
        Top = 32
        Width = 93
        Height = 21
        Hint = 'Intervalo Inicial para a Data de In'#237'cio'
        Date = 37804.690019907400000000
        Time = 37804.690019907400000000
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
  end
  inherited Panel2: TPanel
    Top = 206
    Width = 432
    inherited ImprimirButton: TBitBtn
      Left = 274
      OnClick = ImprimirButtonClick
    end
    inherited CancelarButton: TBitBtn
      Left = 352
    end
  end
  object rv: TRvSystem
    TitleSetup = 'Op'#231#245'es de Sa'#237'da'
    TitleStatus = 'Relat'#243'rio Extrato Material'
    TitlePreview = 'Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.RulerType = rtBothCm
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.MarginBottom = 1.500000000000000000
    SystemPrinter.MarginLeft = 1.000000000000000000
    SystemPrinter.MarginRight = 1.000000000000000000
    SystemPrinter.MarginTop = 1.800000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Solicita'#231#227'o de Compra'
    SystemPrinter.Units = unCM
    SystemPrinter.UnitsFactor = 2.540000000000000000
    OnPrint = rvPrint
    OnBeforePrint = rvBeforePrint
    OnPrintHeader = rvPrintHeader
    OnPrintFooter = rvPrintFooter
    Left = 184
    Top = 32
  end
  object Provider: TDataSetProvider
    DataSet = Query
    UpdateMode = upWhereKeyOnly
    Left = 260
    Top = 32
  end
  object Query: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'dt_inicial'
        ParamType = ptInput
        Value = 0d
      end
      item
        DataType = ftDate
        Name = 'dt_final'
        ParamType = ptInput
        Value = 0d
      end
      item
        DataType = ftDate
        Name = 'dt_inicial'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dt_final'
        ParamType = ptInput
      end>
    SQL.Strings = (
      
        'select e.cd_empresa, ep.nm_empresa, ei.cd_material, '#39'E'#39' as tipo,' +
        ' e.dt_entrada, ei.qt_material,'
      
        'ei.vl_material, m.ds_material, m.cd_unidade_medida, gm.ds_grupo_' +
        'material, ei.observacoes,'
      'm.cd_grupo_material, ei.nr_controle'
      'from tb_entrada_item ei'
      'inner join tb_entrada e on ( e.nr_controle = ei.nr_controle )'
      'inner join tb_material m on ( ei.cd_material = m.cd_material )'
      'inner join tb_empresa ep on ( e.cd_empresa = ep.cd_empresa )'
      
        'inner join tb_grupo_material gm on ( m.cd_grupo_material = gm.cd' +
        '_grupo_material )'
      'where 1=1'
      'and e.dt_entrada between :dt_inicial and :dt_final'
      'union'
      
        'select s.cd_empresa, ep.nm_empresa, ei.cd_material, '#39'S'#39' as tipo,' +
        ' s.dt_saida, ei.qt_material,'
      
        'ei.vl_material, m.ds_material, m.cd_unidade_medida, gm.ds_grupo_' +
        'material, ei.observacoes,'
      'm.cd_grupo_material, ei.nr_controle'
      'from tb_saida_item ei'
      'inner join tb_saida s on ( s.nr_controle = ei.nr_controle )'
      'inner join tb_material m on ( ei.cd_material = m.cd_material )'
      
        'inner join tb_grupo_material gm on ( m.cd_grupo_material = gm.cd' +
        '_grupo_material )'
      'inner join tb_empresa ep on ( s.cd_empresa = ep.cd_empresa )'
      'where 1=1'
      'and s.dt_saida between :dt_inicial and :dt_final'
      '')
    SQLConnection = dm.conexao
    Left = 308
    Top = 32
  end
  object CDS: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'CD_EMPRESA'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NM_EMPRESA'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CD_MATERIAL'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TIPO'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DT_ENTRADA'
        Attributes = [faRequired]
        DataType = ftDate
      end
      item
        Name = 'QT_MATERIAL'
        Attributes = [faRequired]
        DataType = ftFMTBcd
        Precision = 15
        Size = 4
      end
      item
        Name = 'VL_MATERIAL'
        DataType = ftFMTBcd
        Precision = 15
        Size = 2
      end
      item
        Name = 'DS_MATERIAL'
        Attributes = [faRequired]
        DataType = ftString
        Size = 60
      end
      item
        Name = 'CD_UNIDADE_MEDIDA'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'DS_GRUPO_MATERIAL'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'OBSERVACOES'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'CD_GRUPO_MATERIAL'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NR_CONTROLE'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'cdx'
        Fields = 
          'cd_empresa;ds_grupo_material;cd_grupo_material;ds_material;cd_ma' +
          'terial;dt_entrada;tipo;nr_controle'
        GroupingLevel = 7
      end>
    IndexName = 'cdx'
    Params = <>
    ProviderName = 'Provider'
    StoreDefs = True
    Left = 308
    Top = 100
    object CDSCD_MATERIAL: TIntegerField
      FieldName = 'CD_MATERIAL'
      Required = True
    end
    object CDSTIPO: TStringField
      FieldName = 'TIPO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CDSDT_ENTRADA: TDateField
      FieldName = 'DT_ENTRADA'
      Required = True
    end
    object CDSQT_MATERIAL: TFMTBCDField
      FieldName = 'QT_MATERIAL'
      Required = True
      Precision = 15
      Size = 8
    end
    object CDSVL_MATERIAL: TFMTBCDField
      FieldName = 'VL_MATERIAL'
      Precision = 15
      Size = 2
    end
    object CDSDS_MATERIAL: TStringField
      FieldName = 'DS_MATERIAL'
      Required = True
      Size = 60
    end
    object CDSCD_UNIDADE_MEDIDA: TStringField
      FieldName = 'CD_UNIDADE_MEDIDA'
      Required = True
      FixedChar = True
      Size = 3
    end
    object CDSDS_GRUPO_MATERIAL: TStringField
      FieldName = 'DS_GRUPO_MATERIAL'
      Required = True
      Size = 50
    end
    object CDSOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 255
    end
    object CDSCD_GRUPO_MATERIAL: TIntegerField
      FieldName = 'CD_GRUPO_MATERIAL'
      Required = True
    end
    object CDSCD_EMPRESA: TIntegerField
      FieldName = 'CD_EMPRESA'
      Required = True
    end
    object CDSNM_EMPRESA: TStringField
      FieldName = 'NM_EMPRESA'
      Required = True
      Size = 50
    end
    object CDSNR_CONTROLE: TIntegerField
      FieldName = 'NR_CONTROLE'
      Required = True
    end
    object CDSdummy1: TAggregateField
      FieldName = 'dummy1'
      Active = True
      GroupingLevel = 2
      IndexName = 'cdx'
    end
  end
  object DataSource: TDataSource
    DataSet = CDS
    Left = 264
    Top = 100
  end
end
