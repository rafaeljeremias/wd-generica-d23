inherited ConsultaCampo2GenericaForm: TConsultaCampo2GenericaForm
  Top = 130
  Caption = 'ConsultaCampo2GenericaForm'
  ExplicitTop = 130
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    inherited pesquisaPanel: TPanel
      inherited ValorLabel: TLabel
        Left = 206
        ExplicitLeft = 206
      end
      inherited ConsultaButton: TSpeedButton
        Left = 489
        ExplicitLeft = 489
      end
      object Label6: TLabel [3]
        Left = 107
        Top = 6
        Width = 39
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Campo2'
      end
      inherited ValorEdit: TEdit
        Left = 206
        TabOrder = 2
        ExplicitLeft = 206
      end
      object Campo2Edit: TEdit
        Left = 107
        Top = 22
        Width = 93
        Height = 21
        TabOrder = 1
        OnKeyDown = Campo2EditKeyDown
      end
    end
  end
end
