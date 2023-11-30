inherited ConsultaDetalhadaGenericaForm: TConsultaDetalhadaGenericaForm
  Left = 279
  Top = 124
  Width = 750
  Height = 495
  Caption = 'ConsultaDetalhadaGenericaForm'
  Constraints.MinHeight = 400
  Constraints.MinWidth = 750
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainPanel: TPanel
    Width = 742
    Height = 417
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 740
      Height = 415
      ActivePage = consultaTabSheet
      Align = alClient
      TabOrder = 0
      OnChange = PageControlChange
      object consultaTabSheet: TTabSheet
        Caption = '&Consulta'
        DesignSize = (
          732
          387)
        object Label1: TLabel
          Left = 0
          Top = 346
          Width = 49
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Detalhar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object JvDBGrid: TJvDBGrid
          Left = 0
          Top = 0
          Width = 732
          Height = 343
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = ds
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = JvDBGridDrawColumnCell
          OnTitleClick = JvDBGridTitleClick
          AlternateRowColor = clMoneyGreen
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
        end
        object detalharComboBox: TComboBox
          Left = 0
          Top = 362
          Width = 145
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akBottom]
          ItemHeight = 13
          TabOrder = 1
        end
        object DetalharButton: TBitBtn
          Left = 148
          Top = 354
          Width = 93
          Height = 29
          Anchors = [akLeft, akBottom]
          Caption = '&Detalhar'
          TabOrder = 2
          OnClick = DetalharButtonClick
          Glyph.Data = {
            76060000424D7606000000000000360400002800000018000000180000000100
            08000000000040020000E30E0000E30E000000010000000100002D2D2D00373C
            3E0018556F0058534E005160610052636B0054777B00636B6B007C707800D477
            19008A5B520085787C008D787F00AD7B7300E08A1000EF9C2100F7A55A00F8B2
            6600FFB56B0000009A000316AC00021EAA0029799A000A62A0000018C6000936
            C9001029D600106BFF00FF00FF00299CEF00428CDE006D8AFD004ABDFF008C8C
            8C00949494009C9C94009C9C9C00B9858500A5A5A500ADADAD00ADB5B500B5B5
            B500F9C08600FBCA9500FBD3A900D6D6D600DEDEDE00E7E7E700EFEFEF00F7F7
            F700FFFFFF000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000001C1C1C1C1C1C
            1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C
            1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C
            1C1C1C1C1C07070707070707070707070707070707071C1C1C1C1C1C1C213232
            32323232323232323232323232211C1C1C1C1C1C1C2232121212121212121212
            1212121232221C1C1C1C1C1C1C22321232323212323232123232321232221C1C
            1C1C1C1C1C22321232323212323232123232321232221C1C1C1C1C1C1C223212
            32320003293232123232321232221C1C1C1C1C1C1C2332101010030104050E10
            1010101032231C1C1C1C1C1C1C24321032322D061E020A0E3232321032241C1C
            1C1C1C1C1C26321032323206160C090A2D32321032261C1C1C1C1C1C1C26310F
            3131310F082A11090A2D310F31261C1C1C1C1C1C1C26310F0F0F0F0F0B2B2A11
            090A0E0F30261C1C1C1C1C1C1C27300F3030300F300D2C2A11090A0E30271C1C
            1C1C1C1C1C272F0F2F2F2F0F2F2F0D2C2A11090A2D271C1C1C1C1C1C1C272F0F
            2F2F2F0F2F2F2F0D2C2A11090A271C1C1C1C1C1C1C282E0F0F0F0F0F0F0F0F0F
            0D2B251D20171C1C1C1C1C1C1C292D2D2D2D2D2D2D2D2D2D2D0D1D201D15131C
            1C1C1C1C1C29292929292929292929292929201D191A14181C1C1C1C1C1C1C1C
            1C1C1C1C1C1C1C1C1C1C1C181F1B181C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C
            1C1C1C1C18181C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C
            1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C}
        end
      end
      object graficoTabSheet: TTabSheet
        Caption = '&Gr'#225'fico'
        ImageIndex = 1
        object Chart: TChart
          Left = 0
          Top = 0
          Width = 732
          Height = 387
          AllowPanning = pmNone
          AllowZoom = False
          BackWall.Brush.Color = clWhite
          BackWall.Brush.Style = bsClear
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -16
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Title.Text.Strings = (
            'Titulo')
          BottomAxis.LabelsAngle = 90
          LeftAxis.AxisValuesFormat = '#,##0'
          LeftAxis.LabelStyle = talValue
          View3D = False
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          OnClick = ChartClick
        end
      end
      object parametrosTabSheet: TTabSheet
        Caption = '&Par'#226'metros'
        ImageIndex = 2
        object parametroGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 732
          Height = 189
          Align = alTop
          Caption = ' Par'#226'metros '
          TabOrder = 0
          DesignSize = (
            732
            189)
          object outrosGroupBox: TGroupBox
            Left = 4
            Top = 16
            Width = 413
            Height = 89
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Condi'#231#227'o para Outros '
            TabOrder = 0
            DesignSize = (
              413
              89)
            object Label2: TLabel
              Left = 8
              Top = 16
              Width = 60
              Height = 13
              Caption = 'Campo Valor'
            end
            object Label3: TLabel
              Left = 184
              Top = 16
              Width = 48
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Depois de'
            end
            object Label4: TLabel
              Left = 240
              Top = 16
              Width = 58
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Abaixo de %'
            end
            object Label5: TLabel
              Left = 308
              Top = 16
              Width = 74
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Abaixo de Valor'
            end
            object OutrosComboBox: TComboBox
              Left = 8
              Top = 32
              Width = 173
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              ItemHeight = 13
              TabOrder = 0
            end
            object outrosDepoisDeEdit: TJvValidateEdit
              Left = 184
              Top = 32
              Width = 53
              Height = 21
              Anchors = [akTop, akRight]
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              TabOrder = 1
            end
            object outrosPeEdit: TJvValidateEdit
              Left = 240
              Top = 32
              Width = 65
              Height = 21
              Anchors = [akTop, akRight]
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              DisplaySuffix = ' %'
              TabOrder = 2
            end
            object outrosValorEdit: TJvValidateEdit
              Left = 308
              Top = 32
              Width = 97
              Height = 21
              Anchors = [akTop, akRight]
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              TabOrder = 3
            end
            object reprocessarButton: TBitBtn
              Left = 9
              Top = 56
              Width = 396
              Height = 25
              Hint = 'Reprocessa as Informa'#231#245'es da Consulta'
              Anchors = [akLeft, akTop, akRight]
              Caption = '&Reprocessar'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              TabStop = False
              OnClick = reprocessarButtonClick
              Glyph.Data = {
                26040000424D2604000000000000360000002800000012000000120000000100
                180000000000F0030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF5100FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFF
                FFFFFFFFFFEF5100EF5100FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFF0000FF0000FF0000FF0000FFFFFFFFFFFFFFEF5100EF5100
                EF5100EF5100EF5100FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FF
                0000FF0000FF0000FF0000FFFFFFFFEF5100EF5100D64100EF5100D64100EF51
                00D64100EF5100FFFFFFFFFFFFFFFFFF0000FFFFFF0000FF0000FF0000FF0000
                FF0000FFFFFFFFFFFFFFD64100D64100D64100D64100D64100D64100D64100D6
                4100FFFFFFFFFFFF00000010FF0010FF0010FF0010FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFD64100D64100FFFFFFFFFFFFD64100D64100D64100FFFFFFFFFFFF
                0000002CFF002CFF002CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                9C2400FFFFFFFFFFFFFFFFFF9C24009C24009C2400FFFFFF0000005DFF005DFF
                005DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF9C24009C24009C2400FFFFFF0000005DFF005DFF005DFFFFFFFFFFFF
                FFFFFFFF005DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C24009C
                24009C2400FFFFFF0000FFFFFF0086FF0086FF0086FFFFFFFFFFFFFF0086FF00
                86FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF630C00630C00630C00630C00FFFFFF
                0000FFFFFF00A2FF00A2FF00A2FF00A2FF00A2FF00A2FF00A2FF00A2FFFFFFFF
                FFFFFF630C00520000630C00630C00630C00FFFFFFFFFFFF0000FFFFFFFFFFFF
                00B6FF00B6FF00B6FF00B6FF00B6FF00B6FF00B6FF00B6FFFFFFFF5200005200
                00520000520000520000FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF00B6
                FF00B6FF00B6FF00B6FF00B6FFFFFFFFFFFFFF520000520000520000520000FF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00B6FF00
                B6FFFFFFFFFFFFFFFFFFFF520000520000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00B6FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000}
            end
          end
          object seriesGroupBox: TGroupBox
            Left = 422
            Top = 16
            Width = 306
            Height = 165
            Anchors = [akTop, akRight]
            Caption = ' Gr'#225'fico  '
            TabOrder = 1
            DesignSize = (
              306
              165)
            object Label6: TLabel
              Left = 157
              Top = 12
              Width = 121
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'S'#233'ries do Gr'#225'fico Vis'#237'veis'
            end
            object Label7: TLabel
              Left = 8
              Top = 16
              Width = 98
              Height = 13
              Caption = 'Posi'#231#227'o da Legenda'
            end
            object seriesJvCheckListBox: TJvCheckListBox
              Left = 157
              Top = 28
              Width = 141
              Height = 129
              OnClickCheck = seriesJvCheckListBoxClickCheck
              Anchors = [akTop, akRight, akBottom]
              ItemHeight = 13
              TabOrder = 0
            end
            object posicaoLegendaComboBox: TComboBox
              Left = 8
              Top = 32
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 1
              TabOrder = 1
              Text = 'Direita'
              OnChange = posicaoLegendaComboBoxChange
              Items.Strings = (
                'Esquerda'
                'Direita'
                'Abaixo'
                'Acima'
                'Sem Legenda')
            end
          end
          object impressaoGroupBox: TGroupBox
            Left = 4
            Top = 108
            Width = 413
            Height = 73
            Anchors = [akLeft, akTop, akRight]
            Caption = ' Impress'#227'o '
            TabOrder = 2
            object Label8: TLabel
              Left = 8
              Top = 16
              Width = 52
              Height = 13
              Caption = 'Orienta'#231#227'o'
            end
            object orientacaoComboBox: TComboBox
              Left = 8
              Top = 32
              Width = 81
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 1
              TabOrder = 0
              Text = 'Paisagem'
              Items.Strings = (
                'Retrato'
                'Paisagem')
            end
          end
        end
        object condicoesGroupBox: TGroupBox
          Left = 0
          Top = 189
          Width = 732
          Height = 198
          Align = alClient
          Caption = ' Condi'#231#245'es '
          TabOrder = 1
          object condicaoJvDBGrid: TJvDBGrid
            Left = 2
            Top = 15
            Width = 728
            Height = 181
            Align = alClient
            DataSource = condicaoDS
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            AlternateRowColor = clInactiveCaptionText
            AutoSizeColumns = True
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
            Columns = <
              item
                Expanded = False
                FieldName = 'descricao'
                Width = 711
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited BottomPanel: TPanel
    Top = 417
    Width = 742
    DesignSize = (
      742
      44)
    object SairButton: TBitBtn
      Left = 645
      Top = 5
      Width = 92
      Height = 35
      Hint = 'Fecha o Formul'#225'rio'
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = SairButtonClick
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000230F0000230F00000001000000010000316B4A003173
        4A0029735A00397B5200317B5A00327E5900377E5B00424242005A6B52004A7B
        5A00637B5200427B63008C6363009A666600A7666600AD6B6300A76C6D00AF68
        6900B0666700B3666700B4676800B6696A00B86B6B00B96C6D00BB6E6F00AD70
        7000B3737300BD707000BE717200C6666700CD676800C0696A00CE696A00D06A
        6B00D16B6C00D26C6D00D36D6E00D46E6F00D56F7000C0737400C2757500C376
        7700C0797A00C5787800C77A7A00C87B7C00CA7D7D00CC7F7F00D6707100D872
        7300DA747500DB757600DC767700DD777800DE787900DF797A00E07A7B00E17B
        7C00E27C7D00E37D7E00E47E7F00EF7C790029845A0039845A001C9A74001E9D
        7700199E78001B9F7800298463002B8763002D866400298C630029896400218C
        6B00238F6C00298C6B00298D6B0035896B00368E6E0021946B00209370002194
        730020967200249672002E937100279A7500239C760017A37C0015A57D0016A4
        7D0015A57E0014A77F0018A17A0018A17B0018A27B0018A37B0018A37C0019A4
        7C0019A57D0042846B0094946B00B59C7300F6A46800FF00FF00C6848400CD80
        8000DF898A00E6808100E7818200E6878200E8828300EA848500EB858600EC86
        8700E7878800ED878800EE888900EF898A00F08A8B00F18B8C00F28C8D00F38D
        8E00F48E8F00F58F9000E49A9800F6909100F7919200F2939400F8929300F993
        9400FA949500FB959600FC969700FD979800FE989900FF999A00F7B58400F5BB
        BC00F7C09800F2C4A700F7C6A500EFCEBD00F7CEBD00FCD4BC00F7D6CE00FFDE
        CE00FADCDC00FFE7DE00FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000676767676767
        6767670C07676767676767676767676767676767676767670C0D0F0E07676767
        676767676767676767676767670C0D0F121D1E13070C0C0C0C0C0C0C0C0C0C0C
        6767670C0D111F1E1E1E1E13072A686A7F7F7F7F7F7F7F0C6767670F1E1E1E20
        2122221407475B5A58595F6061627F0C6767670F222222232425241507475A59
        575C434156557F0C6767670F252526303030251607475E5E5D424053544E7F0C
        6767670F253132333332321707445052514F4A4C4D637F0C6767670F25343637
        373635180702494B474845464B0B7F0C6767670F31343B3B3A39381B074B443E
        0405063F0B087F0C6767670F346E6C6B723D3C1C070003030103090808647F0C
        6767670F3B71706F89923D27070808010A0A646588887F0C6767670F3B757473
        92947F28076465658888888888887F0C6767670F6D7877767592732907668888
        8888888888887F0C6767670F777D7B7A7978772B076688888888888888887F0C
        6767670F7781807E7D7B7A2C0766888C8D8D8D8C88887F0C6767670F77848382
        81807E2D078C8C939393918D8D887F0C6767670F778786858584832E078D8F93
        91908D938C887F0C6767670F778787878786862F07668A8E93908E8C88887F0C
        6767670F7787878787878769076688888B8B8B8888887F0C6767670F0F687C87
        87878769076688888888888888887F0C67676767670D0F10687C8769070C0F0F
        0F0F0F0F0F0F0F0F67676767676767670D0F191A076767676767676767676767
        67676767676767676767670F0767676767676767676767676767}
    end
    object imprimirButton: TBitBtn
      Left = 5
      Top = 5
      Width = 92
      Height = 35
      Hint = 'Imprime as Informa'#231#245'es da Consulta'
      Anchors = [akLeft, akBottom]
      Caption = '&Imprimir'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = imprimirButtonClick
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
    end
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 153
    Top = 157
  end
  object ds: TDataSource
    DataSet = cds
    Left = 153
    Top = 217
  end
  object condicaoCDS: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'condicao'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'fg_detalhe'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'idx'
        Fields = 'condicao'
      end>
    IndexName = 'idx'
    Params = <>
    StoreDefs = True
    Left = 525
    Top = 157
    Data = {
      740000009619E0BD010000001800000003000000000003000000740008636F6E
      646963616F020049000000010005574944544802000200F40109646573637269
      63616F020049000000010005574944544802000200F4010A66675F646574616C
      686501004900000001000557494454480200020001000000}
    object condicaoCDScondicao: TStringField
      FieldName = 'condicao'
      Size = 500
    end
    object condicaoCDSdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o da Condi'#231#227'o'
      FieldName = 'descricao'
      Size = 500
    end
    object condicaoCDSfg_detalhe: TStringField
      FieldName = 'fg_detalhe'
      Size = 1
    end
  end
  object camposCDS: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'campo'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'tipo'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'agregado'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'chave'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'visivel'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'ordem'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'descritivo'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <
      item
        Name = 'idx'
        Fields = 'descricao'
      end>
    Params = <>
    StoreDefs = True
    Left = 524
    Top = 217
    Data = {
      1B0100009619E0BD01000000180000000A0000000000030000001B010563616D
      706F01004900000001000557494454480200020078000964657363726963616F
      0100490000000100055749445448020002002800047469706F01004900000001
      0005574944544802000200060008616772656761646F01004900000001000557
      4944544802000200010005636861766501004900000001000557494454480200
      02000100077669736976656C0100490000000100055749445448020002000100
      0269640400010000000000056F7264656D010049000000010005574944544802
      00020004000A6465736372697469766F01004900000001000557494454480200
      02000100046E6F6D650100490000000100055749445448020002001E000000}
    object camposCDScampo: TStringField
      FieldName = 'campo'
      Size = 120
    end
    object camposCDSdescricao: TStringField
      FieldName = 'descricao'
      Size = 40
    end
    object camposCDStipo: TStringField
      DisplayWidth = 6
      FieldName = 'tipo'
      Size = 6
    end
    object camposCDSagregado: TStringField
      FieldName = 'agregado'
      Size = 1
    end
    object camposCDSchave: TStringField
      FieldName = 'chave'
      Size = 1
    end
    object camposCDSvisivel: TStringField
      FieldName = 'visivel'
      Size = 1
    end
    object camposCDSid: TIntegerField
      FieldName = 'id'
    end
    object camposCDSordem: TStringField
      FieldName = 'ordem'
      Size = 4
    end
    object camposCDSdescritivo: TStringField
      FieldName = 'descritivo'
      Size = 1
    end
    object camposCDSnome: TStringField
      FieldName = 'nome'
      Size = 30
    end
  end
  object detalharCDS: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'campo'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <
      item
        Name = 'idx'
        Fields = 'id'
      end>
    IndexName = 'idx'
    Params = <>
    StoreDefs = True
    Left = 525
    Top = 289
    Data = {
      760000009619E0BD01000000180000000400000000000300000076000563616D
      706F01004900000001000557494454480200020028000964657363726963616F
      0100490000000100055749445448020002003C00026964040001000000000004
      6E6F6D650100490000000100055749445448020002001E000000}
    object detalharCDScampo: TStringField
      FieldName = 'campo'
      Size = 40
    end
    object detalharCDSdescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object detalharCDSid: TIntegerField
      FieldName = 'id'
    end
    object detalharCDSnome: TStringField
      FieldName = 'nome'
      Size = 30
    end
  end
  object qy: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DM.Conexao
    Left = 457
    Top = 157
  end
  object condicaoDS: TDataSource
    DataSet = condicaoCDS
    Left = 525
    Top = 109
  end
  object rv: TRvSystem
    TitleSetup = 'Op'#231#245'es de Sa'#237'da'
    TitleStatus = 'Report Status'
    TitlePreview = 'Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.GridPen.Color = clSilver
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
    Left = 280
    Top = 156
  end
  object RvPDF: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    EmbedFonts = False
    ImageQuality = 90
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Creator = 'Rave (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    Left = 153
    Top = 281
  end
  object rvGrafico: TRvSystem
    TitleSetup = 'Op'#231#245'es de Sa'#237'da'
    TitleStatus = 'Report Status'
    TitlePreview = 'Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.GridPen.Color = clSilver
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
    OnPrint = rvGraficoPrint
    OnBeforePrint = rvBeforePrint
    OnPrintHeader = rvGraficoPrintHeader
    OnPrintFooter = rvPrintFooter
    Left = 280
    Top = 216
  end
  object ordemCDS: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 525
    Top = 349
    Data = {
      4D0000009619E0BD0100000018000000020000000000030000004D000563616D
      706F0100490000000100055749445448020002002800047469706F0100490000
      0001000557494454480200020001000000}
    object ordemCDScampo: TStringField
      FieldName = 'campo'
      Size = 40
    end
    object ordemCDStipo: TStringField
      FieldName = 'tipo'
      Size = 1
    end
  end
end
