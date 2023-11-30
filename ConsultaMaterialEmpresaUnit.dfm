inherited ConsultaMaterialEmpresaForm: TConsultaMaterialEmpresaForm
  Caption = 'Consulta Material Empresa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    inherited Grid: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'CD_EMPRESA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CD_MATERIAL'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DS_MATERIAL'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CD_UNIDADE_MEDIDA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QT_ESTOQUE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VL_ESTOQUE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VL_ULTIMA_ENTRADA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VL_CUSTO_MEDIO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FL_ATIVO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FL_PERMITE_ESTOQUE_NEGATIVO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_ULTIMA_ENTRADA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_ULTIMA_SAIDA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FL_CONTROLA_ESTOQUE'
          Visible = True
        end>
    end
  end
  inherited IBQy: TSQLQuery
    MaxBlobSize = -1
    SQL.Strings = (
      'select me.*, m.ds_material, m.cd_unidade_medida'
      'from tb_material_empresa me'
      'inner join tb_material m on ( me.cd_material = m.cd_material )')
    SQLConnection = dm.conexao
  end
  inherited CDSQy: TClientDataSet
    object CDSQyCD_EMPRESA: TIntegerField
      DisplayLabel = 'Empresa'
      FieldName = 'CD_EMPRESA'
      Origin = 'me.CD_EMPRESA'
      Required = True
    end
    object CDSQyCD_MATERIAL: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_MATERIAL'
      Origin = 'me.CD_MATERIAL'
      Required = True
    end
    object CDSQyDS_MATERIAL: TStringField
      DisplayLabel = 'Descri'#231#227'o Material'
      FieldName = 'DS_MATERIAL'
      Origin = 'm.DS_MATERIAL'
      Required = True
      Size = 60
    end
    object CDSQyCD_UNIDADE_MEDIDA: TStringField
      DisplayLabel = 'Un'
      FieldName = 'CD_UNIDADE_MEDIDA'
      Origin = 'm.CD_UNIDADE_MEDIDA'
      Required = True
      FixedChar = True
      Size = 3
    end
    object CDSQyQT_ESTOQUE: TFMTBCDField
      DisplayLabel = 'Qtd Estoque'
      FieldName = 'QT_ESTOQUE'
      Origin = 'me.QT_ESTOQUE'
      Required = True
      Precision = 15
      Size = 8
    end
    object CDSQyVL_ESTOQUE: TFMTBCDField
      DisplayLabel = 'Vlr Estoque'
      FieldName = 'VL_ESTOQUE'
      Origin = 'me.VL_ESTOQUE'
      Required = True
      Precision = 15
      Size = 2
    end
    object CDSQyVL_ULTIMA_ENTRADA: TFMTBCDField
      DisplayLabel = 'Vlr '#218'ltima Entrada'
      FieldName = 'VL_ULTIMA_ENTRADA'
      Origin = 'me.VL_ULTIMA_ENTRADA'
      Required = True
      Precision = 15
      Size = 8
    end
    object CDSQyVL_CUSTO_MEDIO: TFMTBCDField
      DisplayLabel = 'Vlr Custo M'#233'dio'
      FieldName = 'VL_CUSTO_MEDIO'
      Origin = 'me.VL_CUSTO_MEDIO'
      Required = True
      Precision = 15
      Size = 8
    end
    object CDSQyFL_ATIVO: TStringField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
      Origin = 'me.FL_ATIVO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CDSQyFL_PERMITE_ESTOQUE_NEGATIVO: TStringField
      DisplayLabel = 'Permite Estoque Negativo'
      FieldName = 'FL_PERMITE_ESTOQUE_NEGATIVO'
      Origin = 'me.FL_PERMITE_ESTOQUE_NEGATIVO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CDSQyDT_ULTIMA_ENTRADA: TDateField
      DisplayLabel = 'Ultima Entrada'
      FieldName = 'DT_ULTIMA_ENTRADA'
      Origin = 'me.DT_ULTIMA_ENTRADA'
    end
    object CDSQyDT_ULTIMA_SAIDA: TDateField
      DisplayLabel = #218'ltima Sa'#237'da'
      FieldName = 'DT_ULTIMA_SAIDA'
      Origin = 'me.DT_ULTIMA_SAIDA'
    end
    object CDSQyFL_CONTROLA_ESTOQUE: TStringField
      DisplayLabel = 'Controla Estoque'
      FieldName = 'FL_CONTROLA_ESTOQUE'
      Required = True
      FixedChar = True
      Size = 1
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
