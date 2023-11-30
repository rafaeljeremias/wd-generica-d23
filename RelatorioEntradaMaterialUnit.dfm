inherited RelatorioEntradaMaterialForm: TRelatorioEntradaMaterialForm
  Left = 189
  Top = 319
  Caption = 'Relat'#243'rio Entrada Material'
  ClientHeight = 333
  ClientWidth = 427
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 427
    Height = 293
    object Label4: TLabel
      Left = 8
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object Label10: TLabel
      Left = 8
      Top = 88
      Width = 37
      Height = 13
      Caption = 'Material'
    end
    object Label12: TLabel
      Left = 8
      Top = 48
      Width = 69
      Height = 13
      Caption = 'Grupo Material'
    end
    object Label5: TLabel
      Left = 8
      Top = 128
      Width = 54
      Height = 13
      Caption = 'Fornecedor'
    end
    object Label11: TLabel
      Left = 8
      Top = 244
      Width = 66
      Height = 13
      Caption = 'Tipo Relat'#243'rio'
    end
    object porLabel: TLabel
      Left = 112
      Top = 244
      Width = 16
      Height = 13
      Caption = 'Por'
      Visible = False
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
    object fornecedorListagemButton: TButton
      Left = 82
      Top = 144
      Width = 21
      Height = 21
      Hint = 'Clique aqui para obter '#13#10'uma listagem de Fornecedor'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      TabStop = False
      OnClick = fornecedorListagemButtonClick
    end
    object nm_fornecedorEdit: TEdit
      Left = 108
      Top = 144
      Width = 313
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
    end
    object periodoGroupBox: TGroupBox
      Left = 8
      Top = 176
      Width = 225
      Height = 61
      Caption = ' Per'#237'odo Entrada '
      TabOrder = 12
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
    object tipoRelatorioComboBox: TComboBox
      Left = 8
      Top = 260
      Width = 101
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 13
      Text = 'Detalhado'
      Items.Strings = (
        'Detalhado'
        'Agrupado')
    end
    object agrupadoComboBox: TComboBox
      Left = 112
      Top = 260
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 14
      Text = 'Material'
      Visible = False
      Items.Strings = (
        'Material'
        'Grupo de Material'
        'Empresa'
        'Fornecedor')
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
    object cd_fornecedorEdit: TWDSimplesEdit
      Left = 8
      Top = 144
      Width = 69
      Height = 21
      Hint = 'F3 - Consulta'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Botao = fornecedorListagemButton
      SQL.Strings = (
        'Select nm_pessoa '
        'from tb_pessoa')
      Conexao = dm.conexao
      Chave = <
        item
          Edit = nm_fornecedorEdit
          Tipo = fdString
        end>
      Dependencia = <>
      CampoChave = 'cd_fornecedor'
      Mensagem = 'Fornecedor n'#227'o Encontrado'
      Tipo = fdInteger
    end
  end
  inherited Panel2: TPanel
    Top = 293
    Width = 427
    inherited ImprimirButton: TBitBtn
      Left = 269
      OnClick = ImprimirButtonClick
    end
    inherited CancelarButton: TBitBtn
      Left = 347
    end
  end
  object rv: TRvSystem
    TitleSetup = 'Op'#231#245'es de Sa'#237'da'
    TitleStatus = 'Relat'#243'rio Entrada Material'
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
  object DataSource: TDataSource
    DataSet = CDS
    Left = 264
    Top = 100
  end
  object CDS: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NR_CONTROLE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CD_EMPRESA'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CD_FORNECEDOR'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DT_ENTRADA'
        Attributes = [faRequired]
        DataType = ftDate
      end
      item
        Name = 'NR_DOCUMENTO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DT_EMISSAO'
        Attributes = [faRequired]
        DataType = ftDate
      end
      item
        Name = 'NR_CONTROLE_1'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NR_ITEM'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CD_MATERIAL'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'QT_MATERIAL'
        Attributes = [faRequired]
        DataType = ftFMTBcd
        Precision = 15
        Size = 4
      end
      item
        Name = 'VL_UNITARIO'
        Attributes = [faRequired]
        DataType = ftFMTBcd
        Precision = 15
        Size = 4
      end
      item
        Name = 'VL_MATERIAL'
        Attributes = [faRequired]
        DataType = ftFMTBcd
        Precision = 15
        Size = 2
      end
      item
        Name = 'OBSERVACOES'
        DataType = ftString
        Size = 255
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
        Name = 'NM_EMPRESA'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'NM_FORNECEDOR'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CD_GRUPO_MATERIAL'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DS_GRUPO_MATERIAL'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'Provider'
    StoreDefs = True
    Left = 308
    Top = 100
    object CDSNR_CONTROLE: TIntegerField
      FieldName = 'NR_CONTROLE'
      Required = True
    end
    object CDSCD_EMPRESA: TIntegerField
      FieldName = 'CD_EMPRESA'
      Required = True
    end
    object CDSCD_FORNECEDOR: TIntegerField
      FieldName = 'CD_FORNECEDOR'
      Required = True
    end
    object CDSDT_ENTRADA: TDateField
      FieldName = 'DT_ENTRADA'
      Required = True
    end
    object CDSNR_DOCUMENTO: TStringField
      FieldName = 'NR_DOCUMENTO'
      Required = True
    end
    object CDSDT_EMISSAO: TDateField
      FieldName = 'DT_EMISSAO'
      Required = True
    end
    object CDSNR_ITEM: TIntegerField
      FieldName = 'NR_ITEM'
      Required = True
    end
    object CDSCD_MATERIAL: TIntegerField
      FieldName = 'CD_MATERIAL'
      Required = True
    end
    object CDSQT_MATERIAL: TFMTBCDField
      FieldName = 'QT_MATERIAL'
      Required = True
      Precision = 15
      Size = 8
    end
    object CDSVL_UNITARIO: TFMTBCDField
      FieldName = 'VL_UNITARIO'
      Required = True
      Precision = 15
      Size = 8
    end
    object CDSVL_MATERIAL: TFMTBCDField
      FieldName = 'VL_MATERIAL'
      Required = True
      Precision = 15
      Size = 2
    end
    object CDSOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 255
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
    object CDSNM_EMPRESA: TStringField
      FieldName = 'NM_EMPRESA'
      Required = True
      Size = 50
    end
    object CDSNM_FORNECEDOR: TStringField
      FieldName = 'NM_FORNECEDOR'
      Required = True
      Size = 50
    end
    object CDSCD_GRUPO_MATERIAL: TIntegerField
      FieldName = 'CD_GRUPO_MATERIAL'
      Required = True
    end
    object CDSDS_GRUPO_MATERIAL: TStringField
      FieldName = 'DS_GRUPO_MATERIAL'
      Required = True
      Size = 50
    end
  end
  object Query: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select e.*, ei.*, m.DS_MATERIAL, m.CD_UNIDADE_MEDIDA, '
      'ep.NM_EMPRESA, p.NM_PESSOA as NM_FORNECEDOR,'
      'm.CD_GRUPO_MATERIAL, gm.DS_GRUPO_MATERIAL'
      'from TB_ENTRADA e '
      
        'inner join TB_ENTRADA_ITEM ei on ( e.NR_CONTROLE = ei.NR_CONTROL' +
        'E )'
      'inner join TB_EMPRESA ep on ( e.CD_EMPRESA = ep.CD_EMPRESA )'
      'inner join TB_PESSOA p on ( e.CD_FORNECEDOR = p.CD_PESSOA )'
      'inner join TB_MATERIAL m on ( ei.CD_MATERIAL = m.CD_MATERIAL )'
      
        'inner join TB_GRUPO_MATERIAL gm on ( m.CD_GRUPO_MATERIAL = gm.CD' +
        '_GRUPO_MATERIAL )'
      'where 1=1')
    SQLConnection = dm.conexao
    Left = 308
    Top = 32
  end
end
