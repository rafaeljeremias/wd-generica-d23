inherited ConsultaCampo1GenericaForm: TConsultaCampo1GenericaForm
  Caption = 'ConsultaCampo1GenericaForm'
  ExplicitWidth = 737
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    inherited botoesPanel: TPanel
      TabOrder = 2
    end
    inherited pesquisaPanel: TPanel
      TabOrder = 0
      inherited ValorLabel: TLabel
        Left = 106
        Top = 6
        ExplicitLeft = 106
        ExplicitTop = 6
      end
      inherited ConsultaButton: TSpeedButton
        Left = 389
        ExplicitLeft = 389
      end
      object Label5: TLabel [2]
        Left = 8
        Top = 6
        Width = 39
        Height = 13
        AutoSize = False
        Caption = 'Campo1'
      end
      inherited ValorEdit: TEdit
        Left = 106
        TabOrder = 1
        ExplicitLeft = 106
      end
      object Campo1Edit: TEdit
        Left = 8
        Top = 22
        Width = 93
        Height = 21
        TabOrder = 0
        OnKeyDown = Campo1EditKeyDown
      end
    end
    inherited gridPanel: TPanel
      TabOrder = 1
    end
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
end
