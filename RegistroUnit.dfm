object RegistroForm: TRegistroForm
  Left = 421
  Top = 149
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registro do Sistema'
  ClientHeight = 141
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 297
    Height = 141
    Align = alClient
    TabOrder = 0
    DesignSize = (
      297
      141)
    object ChaveEdit: TLabeledEdit
      Left = 8
      Top = 20
      Width = 281
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Chave'
      ReadOnly = True
      TabOrder = 0
    end
    object RegistroEdit: TLabeledEdit
      Left = 8
      Top = 60
      Width = 281
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = 'Registro'
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 1
      Top = 90
      Width = 295
      Height = 50
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        295
        50)
      object RegistroButton: TBitBtn
        Left = 104
        Top = 9
        Width = 89
        Height = 33
        Anchors = [akTop, akRight]
        Caption = '&Registrar'
        DoubleBuffered = True
        Glyph.Data = {
          C6050000424DC605000000000000360400002800000014000000140000000100
          08000000000090010000400B0000400B00000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600D3F0FF00B1E2FF008ED3FF006BC6FF0048B8FF0024AAFF0000AAFF000092
          DC000079B900006196000049730000325000D3E3FF00B1C7FF008EABFF006B8F
          FF004873FF002457FF000055FF000049DC00003CB90000309600002473000019
          5000D3D3FF00B1B1FF008E8EFF006B6BFF004848FF002424FF000000FE000000
          DC000000B900000096000000730000005000E3D3FF00C7B1FF00AB8EFF008F6B
          FF007348FF005724FF005500FF004900DC003C00B90030009600240073001900
          5000F0D3FF00E2B1FF00D38EFF00C66BFF00B848FF00AA24FF00AA00FF009200
          DC007900B900610096004900730032005000FFD3FF00FFB1FF00FF8EFF00FF6B
          FF00FF48FF00FF24FF00FE00FE00DC00DC00B900B90096009600730073005000
          5000FFD3F000FFB1E200FF8ED300FF6BC600FF48B800FF24AA00FF00AA00DC00
          9200B9007900960061007300490050003200FFD3E300FFB1C700FF8EAB00FF6B
          8F00FF487300FF245700FF005500DC004900B9003C0096003000730024005000
          1900FFD3D300FFB1B100FF8E8E00FF6B6B00FF484800FF242400FE000000DC00
          0000B9000000960000007300000050000000FFE3D300FFC7B100FFAB8E00FF8F
          6B00FF734800FF572400FF550000DC490000B93C000096300000732400005019
          0000FFF0D300FFE2B100FFD38E00FFC66B00FFB84800FFAA2400FFAA0000DC92
          0000B9790000966100007349000050320000FFFFD300FFFFB100FFFF8E00FFFF
          6B00FFFF4800FFFF2400FEFE0000DCDC0000B9B9000096960000737300005050
          0000F0FFD300E2FFB100D3FF8E00C6FF6B00B8FF4800AAFF2400AAFF000092DC
          000079B90000619600004973000032500000E3FFD300C7FFB100ABFF8E008FFF
          6B0073FF480057FF240055FF000049DC00003CB9000030960000247300001950
          0000D3FFD300B1FFB1008EFF8E006BFF6B0048FF480024FF240000FE000000DC
          000000B90000009600000073000000500000D3FFE300B1FFC7008EFFAB006BFF
          8F0048FF730024FF570000FF550000DC490000B93C0000963000007324000050
          1900D3FFF000B1FFE2008EFFD3006BFFC60048FFB80024FFAA0000FFAA0000DC
          920000B97900009661000073490000503200D3FFFF00B1FFFF008EFFFF006BFF
          FF0048FFFF0024FFFF0000FEFE0000DCDC0000B9B90000969600007373000050
          5000F2F2F200E6E6E600DADADA00CECECE00C2C2C200B6B6B600AAAAAA009E9E
          9E009292920086868600797979006E6E6E006161610056565600494949003E3E
          3E0032323200262626001A1A1A000E0E0E00F0FBFF00A3A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00010101010101
          0101010101010101010101010101010101010101010101010101010101010101
          0101010101010101010101010101010101010101010101010101100101010101
          01010101010101010101010101100D100101ECEEEEEEEEEE0101010101010101
          0110FB10ECECF00000000000EEEEEEEEEE0101010110FB1400F300EEF0F0F000
          0000000000EE01EE1212DF1400F1F3F0EEF0EE00D7DCDDDE00EEEE0000000000
          F3F0F0F0ECF0EC000000000000EEEE00F0F0F0F0F0F0ECF0EAF0EA0000EBEBEB
          EB01EE00E7E9EBECECF0EAF0EAF0EA0000EBEBEBEB01EE0000000000F3F0F0F0
          E9F0E9000000000000EE011311EEEEEE00F1F3F0F0F0F000D7DCDDDE00EE1110
          DDDDFBDF00F300E9ECEDEE000000000000EEFBFBFBFFFFFBDF14F00000000000
          EEEEEEEEEE011110DDFBFFDDDD1014EEEEEEEEEE010101010101011110DDFBDD
          10110101010101010101010101010101110DFB0D110101010101010101010101
          0101010101110D11010101010101010101010101010101010101110101010101
          01010101010101010101}
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = RegistroButtonClick
      end
      object CancelarButton: TBitBtn
        Left = 199
        Top = 9
        Width = 89
        Height = 33
        Anchors = [akTop, akRight]
        Caption = '&Cancelar'
        DoubleBuffered = True
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
          FF00FF027FFF0982FF8EC5FFF5FAFFFFFFFFFFFFFFD8E8FBD8E8FBC2DCFACEE2
          FAD8E7FBD8E7FBFFFFFFFFFFFFE7F1FC6CA5E00054B1003D7EFF00FFFF00FFFF
          00FFFF00FFFF00FF0A84FF0A84FFA6D2FFFFFFFFFFFFFFE1EDFDB0D3FA1577EB
          086DE8076CE7056AE70469E61876E8C2DCFAFFFFFFFFFFFFFFFFFF72A8E1004E
          AB003E7EFF00FFFF00FFFF00FFFF00FF0380FF7CBDFFFFFFFFFFFFFFE2EEFD5A
          A4F70F75EC0D72EB0C70EA1375EA086DE8076CE7056AE7056AE66EABF2E0ECFC
          FFFFFFF3F8FC2F7DCC004DA5FF00FFFF00FFFF00FF0F86FF2390FFE6F3FFFFFF
          FFE2EFFD52A0F7167AEF1378EE1478EE0E74EC0C72EA0D71E9096EE9076CE706
          6BE70569E661A4F1E0ECFCFFFFFFB6D2EE025ABA0053A9FF00FFFF00FF0A84FF
          79BBFFFFFFFFFFFFFF8CC2FB1B80F39EC8F9FDFEFF8DBEF71277ED1074EC197A
          EC1A79EB9EC6F6E7F1FD066BE8056AE7A4CBF7FFFFFFFDFDFD3F89D40058BEFF
          00FF1B8CFF188BFFC5E1FFFFFFFFFEFFFF2287F61F84F54A9CF7CDE3FCFFFFFF
          68AAF51478EE1277EDAACEF8FFFFFFA1C8F70A6EE9076DE8247FEBE0ECFCFFFF
          FF91BDE90061CF0053A91B8CFF3097FFF1F8FFFFFFFFC4E1FE268AF7278AF620
          86F53690F5C5DFFCF5FAFE6AACF67BB4F6FFFFFFA7CCF81D7CEC0C71EB0A6FEA
          086EE9CAE1FBFFFFFFC9DFF60470DE0069D71D8DFF52A7FFFCFDFFFFFFFF83BF
          FE298EF92F91F8248AF82287F63893F7C3DEFCF6FAFEEDF5FE7DB5F6197DEE11
          76ED0F75EC0D72EB0B70EA96C3F6FFFFFFEAF3FD0E7CEC0073ED2591FF70B7FF
          FEFFFFFFFFFF7FBDFE2C91FC298FFA3393F92A8DF82388F7B3D6FCFFFFFFFCFE
          FF65A9F6197FF1157AEF1377EE1075EC0E73EC89BBF6FFFFFFF1F8FF1081F400
          77F12E95FF82C0FFFFFFFFFFFFFF94C8FF2F94FD2D92FC2B90FB3092FA8AC1FC
          F4F9FFB6D8FCC8E1FDF4F9FE6BACF71D81F1177CF01479EF1277ED9FCAF8FFFF
          FFE8F4FF0D82F70078F53297FF86C2FFFAFDFFFFFFFFD8EBFF3196FD3095FD43
          9EFDB2D7FEFFFFFF8FC4FC268BF83592F8CBE3FDFFFFFF92C3FA1A7FF2187DF1
          177BF0D3E6FCFFFFFFC7E3FF047DFA0079F757AAFF75BAFFEEF7FFFFFFFFFFFF
          FF45A1FF3297FEA0CFFEFFFFFFB4D8FE2C90FB298FFA288DF93A95F9D1E6FDFF
          FFFF1E83F41B81F24297F6FFFFFFFFFFFF8CC5FF0076FD0079F7FF00FF58ABFF
          D9ECFFFFFFFFFFFFFFC1E0FF3398FF5DADFE9DCEFF439FFD2F93FC2D91FB2A90
          FB288DFA469CFAA7D0FC2287F62185F6C3DEFDFFFFFFFCFEFF389BFF007AFFFF
          00FFFF00FF5DADFFACD5FFFEFFFFFFFFFFFFFFFF8EC6FF3398FF3398FF3297FF
          3195FE3095FD2E92FC2C91FB298FFA288CF9288CF7CAE5FFFFFFFFFFFFFFACD5
          FF017FFF017FFFFF00FFFF00FFFF00FF6FB7FFE8F4FFFFFFFFFFFFFFFFFFFFA5
          D1FF3599FF3398FF3398FF3296FE3095FE2F93FD2C92FB2F92FBB9DAFEFFFFFF
          FFFFFFEDF6FF2A94FF027FFFFF00FFFF00FFFF00FFFF00FF77BAFFA3D0FFFAFD
          FFFFFFFFFFFFFFFFFFFFFAFDFF92C8FF56AAFF46A2FF46A1FE5BACFEA1CFFEFF
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
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = CancelarButtonClick
      end
    end
  end
end
