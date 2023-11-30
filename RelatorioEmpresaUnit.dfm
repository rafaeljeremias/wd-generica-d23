inherited RelatorioTempoAposentadoriaForm: TRelatorioTempoAposentadoriaForm
  Caption = 'RelatorioTempoAposentadoriaForm'
  ClientWidth = 583
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 583
    object Label1: TLabel
      Left = 12
      Top = 68
      Width = 120
      Height = 13
      Caption = 'Aposentadoria Requerida'
    end
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 49
      Height = 13
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object aposentadoriaRequeridaComboBox: TComboBox
      Left = 12
      Top = 84
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = '15 Anos'
      Items.Strings = (
        '15 Anos'
        '20 Anos'
        '25 Anos'
        '35 Anos')
    end
    object cd_empresaEdit: TWDSimplesEdit
      Left = 8
      Top = 24
      Width = 69
      Height = 21
      Hint = 'F3 - Consulta'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Botao = empresaButton
      SQL.Strings = (
        'Select nm_empresa'
        'from tb_empresa')
      Conexao = dm.Conexao
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
    object empresaButton: TButton
      Left = 80
      Top = 24
      Width = 20
      Height = 21
      Caption = '...'
      TabOrder = 2
      TabStop = False
      OnClick = empresaButtonClick
    end
    object nm_empresaEdit: TEdit
      Left = 106
      Top = 24
      Width = 369
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
  end
  inherited Panel2: TPanel
    Width = 583
    inherited ImprimirButton: TBitBtn
      Left = 425
    end
    inherited CancelarButton: TBitBtn
      Left = 503
    end
  end
end
