inherited graficoGerencialGenericoComparativoForm: TgraficoGerencialGenericoComparativoForm
  Left = 170
  Top = 105
  Caption = 'graficoGerencialGenericoComparativoForm'
  ClientHeight = 528
  ClientWidth = 748
  ExplicitLeft = 170
  ExplicitTop = 105
  ExplicitWidth = 764
  ExplicitHeight = 566
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainPanel: TPanel
    Width = 748
    Height = 484
    ExplicitWidth = 756
    ExplicitHeight = 488
    DesignSize = (
      748
      484)
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 746
      Height = 211
      Align = alClient
      TabOrder = 2
      ExplicitWidth = 754
      ExplicitHeight = 215
      object Splitter1: TSplitter
        Left = 1
        Top = 207
        Width = 744
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 211
        ExplicitWidth = 752
      end
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 744
        Height = 206
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 752
        ExplicitHeight = 210
        object Splitter2: TSplitter
          Left = 517
          Top = 1
          Height = 204
          Align = alRight
          ExplicitLeft = 525
          ExplicitHeight = 208
        end
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 516
          Height = 204
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 524
          ExplicitHeight = 208
          object DBGrid: TJvDBGrid
            Tag = 999
            Left = 1
            Top = 1
            Width = 514
            Height = 202
            Align = alClient
            DataSource = mestreDS
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnDrawColumnCell = DBGridDrawColumnCell
            AlternateRowColor = clMoneyGreen
            MaxColumnWidth = 200
            AutoSizeColumns = True
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
          end
        end
        object Panel4: TPanel
          Left = 520
          Top = 1
          Width = 223
          Height = 204
          Align = alRight
          TabOrder = 1
          ExplicitLeft = 528
          ExplicitHeight = 208
          object mes_anoDBGrid: TJvDBGrid
            Tag = 999
            Left = 1
            Top = 1
            Width = 221
            Height = 202
            Align = alClient
            DataSource = detalheDS
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            AlternateRowColor = clMoneyGreen
            MaxColumnWidth = 100
            AutoSizeColumns = True
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
          end
        end
      end
    end
    object processandoPanel: TPanel
      Left = 3
      Top = 220
      Width = 749
      Height = 41
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Processando Informa'#231#245'es...'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object graficoPanel: TPanel
      Left = 1
      Top = 212
      Width = 746
      Height = 271
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 216
      ExplicitWidth = 754
      object chart: TChart
        Left = 1
        Top = 1
        Width = 744
        Height = 269
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Legend.Alignment = laBottom
        Legend.LegendStyle = lsValues
        Legend.Visible = False
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'T'#237'tulo')
        Title.Visible = False
        BottomAxis.LabelsAngle = 90
        BottomAxis.LabelsFont.Charset = ANSI_CHARSET
        View3D = False
        Zoom.Allow = False
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 752
        object Series1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 20
          Marks.Style = smsValue
          Marks.Visible = False
          PercentFormat = '##0 %'
          SeriesColor = clBlue
          Title = 'Serie'
          ValueFormat = '#,##0.00'
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
  end
  inherited BottomPanel: TPanel
    Top = 484
    Width = 748
    ExplicitTop = 488
    ExplicitWidth = 756
    DesignSize = (
      748
      44)
    object dt_inicialLabel: TLabel
      Left = 259
      Top = 4
      Width = 27
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Inicial'
      Visible = False
    end
    object aLabel: TLabel
      Left = 355
      Top = 24
      Width = 6
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'a'
      Visible = False
    end
    object dt_finalLabel: TLabel
      Left = 371
      Top = 4
      Width = 22
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Final'
      Visible = False
    end
    object mostrarValoresCheckBox: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Mostrar &Valores'
      TabOrder = 0
      OnClick = mostrarValoresCheckBoxClick
    end
    object dt_inicialEdit: TDateTimePicker
      Left = 259
      Top = 20
      Width = 89
      Height = 21
      Anchors = [akLeft, akBottom]
      Date = 37855.000000000000000000
      Time = 37855.000000000000000000
      TabOrder = 1
      Visible = False
    end
    object dt_finalEdit: TDateTimePicker
      Left = 371
      Top = 20
      Width = 89
      Height = 21
      Anchors = [akLeft, akBottom]
      Date = 37855.000000000000000000
      Time = 37855.000000000000000000
      TabOrder = 2
      Visible = False
    end
    object imprimirButton: TBitBtn
      Left = 591
      Top = 6
      Width = 75
      Height = 33
      Hint = 'Processa o Relat'#243'rio'
      Anchors = [akRight, akBottom]
      Caption = '&Imprimir'
      DoubleBuffered = True
      Enabled = False
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000220B0000220B00000001000000010000212121002121
        290029292900292931003131310039393900424242004A4A4A00525252005A5A
        5A00635A6300636363006B6B6B007B7B7B00848484008C84840084C684008C8C
        8C009C949C009C9C9C00A59C9C00A59CA500A5A5A500ADA5A500F7B5A500FFBD
        A500ADA5AD00ADADAD00B5ADAD00ADB5AD00E7B5AD00FFC6AD00B5ADB500B5B5
        B500BDB5B500DEB5B500E7BDB500F7BDB500FFC6B500FFCEB500BDB5BD00BDBD
        BD00C6BDBD00E7BDBD00E7C6BD00FFCEBD00FFD6BD00C6BDC600C6C6C600CEC6
        C600E7C6C600E7CEC600FFD6C600C6C6CE00CEC6CE00CECECE00D6CECE00EFCE
        CE00EFD6CE00FFDECE00D6CED600D6D6D600DED6D600F7DED600FFDED600FFE7
        D600D6F7D600D6D6DE00D6DEDE00DEDEDE00E7DEDE00EFDEDE00DEE7DE00E7E7
        DE00FFE7DE00FFEFDE00E7E7E700EFE7E700FFEFE700EFEFEF00FFF7EF00F7F7
        F700FFF7F700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00535353535353
        53535353535353535353535353535353535353535353535353531B361B135353
        1B3D3E291B53535353535353535353531B305151291B090B0E1B31464C3D2153
        5353535353531B224C54544F221C070004060B0E1B374C4517535353531B4554
        5251524F2121120C07040204060B11165353531637515151514C301B13161B21
        1C130D0905020614535353164F514F452917213D2116141314172121160E0C14
        535353164C3E2216223D454C4C3D30221B161413161B2116535353161C16293D
        453D3D4D51514F4C3D3729211716141353535316293D3D3D3D3D4C51302F3745
        4C4C453D37302916535353163D3D3D3D3D4551291D10211B1B29303D45453D1B
        5353535329453D3D4C4C21294F424F4C25291C171B292921535353535321303D
        301B315151514F4C4C4C453D3717165353535353535353142945371B30454C4C
        4C4C4C4530225353535353535353531B5151452929303D3D3D3D301B22535353
        5353535353535353474A41403F3F3F4746453053535353535353535353535353
        2C4A403B342D26261F3953535353535353535353535353532C4A403B342D261F
        18535353535353535353535353535353334A403B342D261F1853535353535353
        5353535353535353334A403B342D261F25535353535353535353535353535353
        334A403B342D2625255353535353535353535353535353324E4A403B342D2725
        53535353535353535353535353535333504A413B343425255353535353535353
        5353535353532333322C2C24241E255353535353535353535353}
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = imprimirButtonClick
    end
    object fecharButton: TBitBtn
      Left = 670
      Top = 6
      Width = 75
      Height = 33
      Hint = 'Fecha o Formul'#225'rio'
      Anchors = [akTop, akRight]
      Caption = '&Fechar'
      DoubleBuffered = True
      Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        2000000000000009000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A66660069333400FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009A6666009A66
        6600A3666600A766660069333400FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF009A6666009A666600A0666600B0666700C666
        6700CC666700B366670069333400FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A6666009A666600AF686900C0696A00CF696A00CE686900CD67
        6800CD676800B366670069333400AE6666009A6666009A6666009A6666009A66
        66009A6666009A6666009A6666009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600D26F7000D56F7000D46E6F00D36D6E00D26C6D00D16B
        6C00D06A6B00B467680069333400FEA2A300FDA8A900FCAFB000FBB6B700FABC
        BD00F9C2C200F9C5C600F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600D9737400D8727300D7717200D6707100D56F7000D46E
        6F00D36D6E00B6696A006933340059B2670033CB670033CB670033CB670033CB
        670033CB670033CB6700F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600DC767700DB757600DA747500D9737400D8727300D771
        7200D6707100B86B6B006933340059B2670033CB670033CB670033CB670033CB
        670033CB670033CB6700F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600DF797A00DF797A00DE787900DD777800DC767700DB75
        7600DA747500B96C6D006933340059B2670033CB670033CB670033CB670033CB
        670033CB670033CB6700F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600E37D7E00E27C7D00E17B7C00E07A7B00DF797A00DE78
        7900DD777800BB6E6F006933340059B2670033CB670033CB670033CB670033CB
        670033CB670033CB6700F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600E6808100E57F8000E47E7F00E37D7E00E27C7D00E17B
        7C00E07A7B00BD7070006933340059B2670033CB670033CB670033CB670033CB
        670033CB670033CB6700F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600E9838400E8828300E7818200E6808100E7878800ECA6
        A700E47E7F00BE7172006933340073B8760033CB670033CB670033CB670033CB
        670033CB670033CB6700F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600ED878800EC868700EB858600EA848500F2B9BA00FFFF
        FF00F0B0B000C073740069333400F2D9C000C7F0BC0079DD900079DD900060D6
        810060D6810060D68100F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600F08A8B00EF898A00EE888900ED878800F5BBBC00FFFF
        FF00F0AAAB00C275750069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00E2F8CC00E2F8CC00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600F38D8E00F28C8D00F18B8C00F08A8B00EF898A00F3A6
        A700ED878800C376770069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600F6909100F6909100F58F9000F48E8F00F38D8E00F28C
        8D00F18B8C00C578780069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600FA949500F9939400F8929300F7919200F6909100F58F
        9000F48E8F00C77A7A0069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600FD979800FC969700FB959600FA949500F9939400F892
        9300F7919200C87B7C0069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600FF999A00FF999A00FE989900FD979800FD979800FC96
        9700FB959600CA7D7D0069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600FF999A00FF999A00FF999A00FF999A00FF999A00FE98
        9900FE989900CC7F7F0069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A666600F9969700FF999A00FF999A00FF999A00FF999A00FF99
        9A00FF999A00CD80800069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A6666009A666600C0797A00DF898A00FF999A00FF999A00FF99
        9A00FF999A00CD80800069333400F2D9C000FFFFDD00FFFFDD00FFFFDD00FFFF
        DD00FFFFDD00FFFFDD00F9C5C6009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF009A6666009A666600A76C6D00C67C7D00F293
        9400FF999A00CD80800069333400A76666009A6666009A6666009A6666009A66
        66009A6666009A6666009A6666009A666600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009A6666009A66
        6600AD707000B373730069333400FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A66660069333400FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ModalResult = 2
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
  end
  object rv: TRvSystem
    TitleSetup = 'Op'#231#245'es de Sa'#237'da'
    TitleStatus = 'Report Status'
    TitlePreview = 'Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.RulerType = rtBothCm
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.MarginBottom = 1.000000000000000000
    SystemPrinter.MarginLeft = 1.800000000000000000
    SystemPrinter.MarginRight = 1.000000000000000000
    SystemPrinter.MarginTop = 1.000000000000000000
    SystemPrinter.Orientation = poLandScape
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Relat'#243'rio de Or'#231'amentos de Servi'#231'o Pendente Aprova'#231#227'o'
    SystemPrinter.Units = unCM
    SystemPrinter.UnitsFactor = 2.540000000000000000
    OnPrint = rvPrint
    OnBeforePrint = rvBeforePrint
    OnPrintHeader = rvPrintHeader
    OnPrintFooter = rvPrintFooter
    Left = 128
    Top = 360
  end
  object tituloCamposMestreCDS: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nm_campo'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'nm_titulo'
        DataType = ftString
        Size = 40
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 164
    Top = 96
    Data = {
      550000009619E0BD0100000018000000020000000000030000005500086E6D5F
      63616D706F0100490000000100055749445448020002002800096E6D5F746974
      756C6F01004900000001000557494454480200020028000000}
    object tituloCamposMestreCDSnm_campo: TStringField
      FieldName = 'nm_campo'
      Size = 40
    end
    object tituloCamposMestreCDSnm_titulo: TStringField
      FieldName = 'nm_titulo'
      Size = 40
    end
  end
  object tituloCamposDetalheCDS: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 132
    Top = 60
    Data = {
      550000009619E0BD0100000018000000020000000000030000005500086E6D5F
      63616D706F0100490000000100055749445448020002002800096E6D5F746974
      756C6F01004900000001000557494454480200020028000000}
    object tituloCamposDetalheCDSnm_campo: TStringField
      FieldName = 'nm_campo'
      Size = 40
    end
    object tituloCamposDetalheCDSnm_titulo: TStringField
      FieldName = 'nm_titulo'
      Size = 40
    end
  end
  object camposParametroDetalheCDS: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 284
    Top = 164
    Data = {
      740000009619E0BD01000000180000000300000000000300000074000E63616D
      706F506172616D6574726F010049000000010005574944544802000200280009
      6E6F6D654669656C640100490000000100055749445448020002002800047469
      706F01004900000001000557494454480200020001000000}
    object camposParametroDetalheCDScampoParametro: TStringField
      FieldName = 'campoParametro'
      Size = 40
    end
    object camposParametroDetalheCDSnomeField: TStringField
      FieldName = 'nomeField'
      Size = 40
    end
    object camposParametroDetalheCDStipo: TStringField
      FieldName = 'tipo'
      Size = 1
    end
  end
  object camposParametroCDS: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'campoParametro'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'nomeField'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'tipo'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 284
    Top = 96
    Data = {
      740000009619E0BD01000000180000000300000000000300000074000E63616D
      706F506172616D6574726F010049000000010005574944544802000200280009
      6E6F6D654669656C640100490000000100055749445448020002002800047469
      706F01004900000001000557494454480200020001000000}
    object camposParametroCDScampoParametro: TStringField
      FieldName = 'campoParametro'
      Size = 40
    end
    object camposParametroCDSnomeField: TStringField
      FieldName = 'nomeField'
      Size = 40
    end
    object camposParametroCDStipo: TStringField
      FieldName = 'tipo'
      Size = 1
    end
  end
  object detalheCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 92
  end
  object detalheDS: TDataSource
    DataSet = detalheCDS
    Left = 448
    Top = 164
  end
  object mestreDS: TDataSource
    DataSet = mestreCDS
    Left = 28
    Top = 168
  end
  object mestreCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = mestreCDSAfterScroll
    Left = 28
    Top = 96
  end
  object mestreQy: TSQLQuery
    BeforeOpen = mestreQyBeforeOpen
    AfterClose = mestreQyAfterClose
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DM.Conexao
    Left = 27
    Top = 45
  end
  object detalheQy: TSQLQuery
    BeforeOpen = detalheQyBeforeOpen
    AfterClose = detalheQyAfterClose
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DM.Conexao
    Left = 451
    Top = 45
  end
end
