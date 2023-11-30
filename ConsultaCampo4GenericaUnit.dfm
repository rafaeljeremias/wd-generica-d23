inherited ConsultaCampo4GenericaForm: TConsultaCampo4GenericaForm
  Left = 214
  Top = 184
  Width = 763
  Caption = 'ConsultaCampo4GenericaForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    Width = 755
    inherited ConsultaButton: TSpeedButton
      Left = 602
    end
    inherited ValorLabel: TLabel
      Left = 327
    end
    inherited FiltroButton: TSpeedButton
      Left = 677
    end
    inherited imprimirSpeedButton: TSpeedButton
      Left = 715
    end
    inherited ConfiguraButton: TSpeedButton
      Left = 639
    end
    inherited Label6: TLabel
      Left = 87
    end
    inherited Label7: TLabel
      Left = 167
    end
    object Label8: TLabel [8]
      Left = 247
      Top = 6
      Width = 39
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Campo4'
    end
    inherited SairButton: TBitBtn
      Left = 677
      TabOrder = 8
    end
    inherited ValorEdit: TEdit
      Left = 327
      Width = 269
      TabOrder = 6
    end
    inherited NovoButton: TBitBtn
      TabOrder = 4
    end
    inherited Grid: TDBGrid
      Width = 742
      TabOrder = 10
    end
    inherited ExcluiButton: TBitBtn
      TabOrder = 7
    end
    inherited AlteraButton: TBitBtn
      TabOrder = 5
    end
    inherited RetornaButton: TBitBtn
      Left = 599
      TabOrder = 9
    end
    inherited Campo1Edit: TEdit
      Width = 75
    end
    inherited Campo2Edit: TEdit
      Left = 87
      Width = 75
    end
    inherited Campo3Edit: TEdit
      Left = 167
      Width = 75
    end
    object Campo4Edit: TEdit
      Left = 247
      Top = 22
      Width = 75
      Height = 21
      TabOrder = 3
      OnKeyDown = Campo4EditKeyDown
    end
  end
end
