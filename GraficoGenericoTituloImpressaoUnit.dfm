inherited graficoGenericoTituloImpressaoForm: TgraficoGenericoTituloImpressaoForm
  Left = 188
  Top = 210
  VertScrollBar.Range = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'T'#237'tulo'
  ClientHeight = 97
  ClientWidth = 523
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainPanel: TPanel
    Width = 523
    Height = 53
    object tituloEdit: TLabeledEdit
      Left = 8
      Top = 24
      Width = 509
      Height = 21
      EditLabel.Width = 108
      EditLabel.Height = 13
      EditLabel.Caption = 'T'#237'tulo do Relat'#243'rio'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'MS Sans Serif'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      TabOrder = 0
    end
  end
  inherited BottomPanel: TPanel
    Top = 53
    Width = 523
    object okButton: TBitBtn
      Left = 365
      Top = 6
      Width = 75
      Height = 33
      Hint = 'Confirma as Altera'#231#245'es'
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004EAB004EAB004EAB004E
        AB004EAB004EABFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0077F1006DE40063D8
        005FCD0060C8005CC10054B7004EAB004794003A76FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF007DFD0077F800
        75F32988ED67A9EC91C1F0A3CAF1A2C9F18BBCEC5C9DE01C73CD0053B3004797
        003D7CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF007C
        FF0078FF3597FDAAD3FCF4F9FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEA
        F3FD93BFED2274CB004CA7003C7BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF027FFF0982FF8EC5FFF5FAFFFFFFFFFFFFFFFFFFFFFFFFFFF5FAFFFAFD
        FFFFFFFFFFFFFFFFFFFFFFFFFFE7F1FC6CA5E00054B1003D7EFF00FFFF00FFFF
        00FFFF00FFFF00FF0A84FF0A84FFA6D2FFFFFFFFFFFFFFFFFFFFE3F1FF8CC2FB
        479AF4489BF13A93EF56A1F199C7F7EEF7FFFFFFFFFFFFFFFFFFFF72A8E1004E
        AB003E7EFF00FFFF00FFFF00FFFF00FF0380FF7CBDFFFFFFFFFFFFFFFFFFFFA1
        CFFF1B89FE006BF8248AF5C5E0FC298BEE0066E5006DE72988EDB7D9FBFFFFFF
        FFFFFFF3F8FC2F7DCC004DA5FF00FFFF00FFFF00FF0F86FF2390FFE6F3FFFFFF
        FFFFFFFF95C9FF017FFF0075FF3D9DFFE5F2FFFFFFFF79B8F8006DEA0073E800
        6DE70874E9ADD3FAFFFFFFFFFFFFB6D2EE025ABA0053A9FF00FFFF00FF0A84FF
        79BBFFFFFFFFFFFFFFC7E3FF1087FF007CFF53A8FFEEF7FFFFFFFFFFFFFFCAE5
        FF0379F20073EB0073E8006DE7147DEBDCEDFDFFFFFFFDFDFD3F89D40058BEFF
        00FF1B8CFF188BFFC5E1FFFFFFFFFEFFFF5AACFF027FFF69B3FFF7FBFFFFFFFF
        FFFFFFFFFFFFFCFEFF3597F90073F20075ED0073E8006AE66BAFF4FFFFFFFFFF
        FF91BDE90061CF0053A91B8CFF3097FFF1F8FFFFFFFFDFEFFF2792FF81BFFFFC
        FEFFFFFFFFFFFFFF93C8FF7DBEFFFFFFFF8BC4FE0074F90078F50076EE0070E9
        1C83ECF3F9FFFFFFFFC9DFF60470DE0069D71D8DFF52A7FFFCFDFFFFFFFFB8DB
        FF2A94FFCEE6FFFFFFFFF9FCFF7CBDFF0681FF1087FFDBEDFFE5F2FF0B83FF00
        79FA0078F50075EF0477ECD2E6FCFFFFFFEAF3FD0E7CEC0073ED2591FF70B7FF
        FEFFFFFFFFFFB4D9FF2591FF49A3FFC7E3FF65B2FF1087FF168AFF0782FF5AAC
        FFFFFFFF57AAFF0078FF007DFB0079F70379F1C8E1FBFFFFFFF1F8FF1081F400
        77F12E95FF82C0FFFFFFFFFFFFFFC1E0FF3097FF2D95FF2E96FF218FFF2390FF
        1F8EFF188BFF0C85FFB5DAFFC1E0FF027FFF017FFF007BFC067EF8D7EBFDFFFF
        FFE8F4FF0D82F70078F53297FF86C2FFFAFDFFFFFFFFE8F3FF3D9DFF3097FF30
        97FF2E96FF2A94FF2591FF218FFF1388FF2E96FFDFEFFF3D9DFF017FFF007CFF
        2791FFF7FBFFFFFFFFC7E3FF047DFA0079F757AAFF75BAFFEEF7FFFFFFFFFFFF
        FF79BBFF2792FF3398FF3398FF3097FF2B93FF2591FF218FFF0F86FF6DB5FF99
        CCFF0480FF007AFF82C0FFFFFFFFFFFFFF8CC5FF0076FD0079F7FF00FF58ABFF
        D9ECFFFFFFFFFFFFFFDCEDFF3D9DFF2D95FF3398FF3398FF3097FF2D95FF2792
        FF218FFF188BFF82C0FF2D95FF2D95FFECF5FFFFFFFFFCFEFF389BFF007AFFFF
        00FFFF00FF5DADFFACD5FFFEFFFFFFFFFFFFFFFFBDDEFF3699FF2993FF3297FF
        3398FF3297FF2E95FF2993FF1E8DFF1F8EFF58ABFFCAE5FFFFFFFFFFFFFFACD5
        FF017FFF017FFFFF00FFFF00FFFF00FF6FB7FFE8F4FFFFFFFFFFFFFFFFFFFFCC
        E5FF5AACFF2D95FF2591FF2993FF2792FF218FFF2792FF5EAEFFD9EBFFFFFFFF
        FFFFFFEDF6FF2A94FF027FFFFF00FFFF00FFFF00FFFF00FF77BAFFA3D0FFFAFD
        FFFFFFFFFFFFFFFFFFFFFAFDFFC0DFFF8FC6FF7BBCFF7CBDFF95C9FFCAE5FFFF
        FFFFFFFFFFFFFFFFFCFEFF64B1FF017FFF0A84FFFF00FFFF00FFFF00FFFF00FF
        FF00FF76B9FFAFD7FFF5FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFDCEDFF60AFFF0782FF0F86FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF79BBFF91C8FFDBEDFFFAFDFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDF6FFA1CFFF3599FF0E85FF1489FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF97CAFF75B9FF9E
        CEFFCAE5FFE3F1FFEDF6FFEDF6FFE6F3FFD4E9FFABD4FF6DB5FF3097FF1D8DFF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF95C9FF75B9FF75B9FF7BBCFF7BBCFF6DB5FF58ABFF44A1FF2D
        95FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object fecharButton: TBitBtn
      Left = 443
      Top = 6
      Width = 75
      Height = 33
      Hint = 'Fecha o Formul'#225'rio'
      Anchors = [akTop, akRight]
      Caption = '&Fechar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = fecharButtonClick
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
    end
  end
end
