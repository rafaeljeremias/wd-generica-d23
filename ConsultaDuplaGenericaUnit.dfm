inherited ConsultaDuplaGenericaForm: TConsultaDuplaGenericaForm
  Left = 270
  Top = 176
  Width = 499
  Height = 404
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    Width = 491
    Height = 350
    DesignSize = (
      491
      350)
    inherited ConsultaButton: TSpeedButton
      Left = 294
      Top = 46
    end
    inherited ValorLabel: TLabel
      Left = 5
      Top = 42
    end
    object MasterLabel: TLabel [2]
      Left = 6
      Top = 2
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Master'
    end
    inherited SairButton: TBitBtn
      Left = 410
      Top = 312
      TabOrder = 7
    end
    inherited ValorEdit: TEdit
      Left = 5
      Top = 57
      TabOrder = 4
    end
    inherited NovoButton: TBitBtn
      Top = 312
      TabOrder = 3
    end
    inherited Grid: TDBGrid
      Top = 84
      Width = 478
      Height = 225
      TabOrder = 9
    end
    inherited ExcluiButton: TBitBtn
      Top = 312
      TabOrder = 6
    end
    inherited AlteraButton: TBitBtn
      Top = 312
      TabOrder = 5
    end
    inherited RetornaButton: TBitBtn
      Left = 332
      Top = 312
      TabOrder = 8
    end
    object CodigoEdit: TEdit
      Left = 5
      Top = 18
      Width = 49
      Height = 21
      TabOrder = 0
      OnExit = CodigoEditExit
    end
    object CodigoButton: TButton
      Left = 56
      Top = 18
      Width = 21
      Height = 21
      Caption = '---'
      TabOrder = 1
    end
    object NomeEdit: TEdit
      Left = 79
      Top = 18
      Width = 365
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  inherited IBQy: TSQLQuery
    Left = 355
    Top = 137
  end
  inherited FiltroCDS: TClientDataSet
    Aggregates = <
      item
        Active = True
        Expression = 'count(cd_condicao)'
        IndexName = 'id1'
        Visible = False
      end
      item
        Active = True
        Expression = 'max(cd_condicao)'
        IndexName = 'id1'
        Visible = False
      end>
  end
  object QyAux: TSQLQuery
    Params = <>
    Left = 20
    Top = 252
  end
end
