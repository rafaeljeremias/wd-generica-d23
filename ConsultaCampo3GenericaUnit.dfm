inherited ConsultaCampo3GenericaForm: TConsultaCampo3GenericaForm
  Left = 201
  Top = 176
  Caption = 'ConsultaCampo3GenericaForm'
  ExplicitLeft = 201
  ExplicitTop = 176
  ExplicitWidth = 737
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    inherited pesquisaPanel: TPanel
      inherited ValorLabel: TLabel
        Left = 307
        Width = 254
        ExplicitLeft = 307
        ExplicitWidth = 254
      end
      inherited ConsultaButton: TSpeedButton
        Left = 570
        ExplicitLeft = 570
      end
      object Label7: TLabel [4]
        Left = 207
        Top = 6
        Width = 39
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Campo3'
      end
      inherited ValorEdit: TEdit
        Left = 307
        Width = 256
        TabOrder = 3
        ExplicitLeft = 307
        ExplicitWidth = 256
      end
      object Campo3Edit: TEdit
        Left = 207
        Top = 22
        Width = 93
        Height = 21
        TabOrder = 2
        OnKeyDown = Campo3EditKeyDown
      end
    end
  end
end
