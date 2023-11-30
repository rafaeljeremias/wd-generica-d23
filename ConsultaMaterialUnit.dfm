inherited ConsultaMaterialForm: TConsultaMaterialForm
  Caption = 'Consulta Material'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    inherited Grid: TDBGrid
      Top = 52
      Columns = <
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
          FieldName = 'CD_GRUPO_MATERIAL'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DS_GRUPO_MATERIAL'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FL_ATIVO'
          Visible = True
        end>
    end
  end
  inherited IBQy: TSQLQuery
    MaxBlobSize = -1
    SQL.Strings = (
      'select m.*, gm.ds_grupo_material'
      'from TB_MATERIAL m'
      
        'inner join TB_GRUPO_MATERIAL gm on ( m.cd_grupo_material = gm.cd' +
        '_grupo_material )')
    SQLConnection = dm.conexao
  end
  inherited CDSQy: TClientDataSet
    object CDSQyCD_MATERIAL: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_MATERIAL'
      Origin = 'm.CD_MATERIAL'
      Required = True
    end
    object CDSQyDS_MATERIAL: TStringField
      DisplayLabel = 'Descri'#231#227'o do Material'
      FieldName = 'DS_MATERIAL'
      Origin = 'm.DS_MATERIAL'
      Required = True
      Size = 60
    end
    object CDSQyCD_UNIDADE_MEDIDA: TStringField
      DisplayLabel = 'UN'
      FieldName = 'CD_UNIDADE_MEDIDA'
      Origin = 'm.CD_UNIDADE_MEDIDA'
      Required = True
      FixedChar = True
      Size = 3
    end
    object CDSQyCD_GRUPO_MATERIAL: TIntegerField
      DisplayLabel = 'Grupo'
      FieldName = 'CD_GRUPO_MATERIAL'
      Origin = 'gm.CD_GRUPO_MATERIAL'
      Required = True
    end
    object CDSQyDS_GRUPO_MATERIAL: TStringField
      DisplayLabel = 'Descri'#231#227'o Grupo'
      FieldName = 'DS_GRUPO_MATERIAL'
      Origin = 'gm.DS_GRUPO_MATERIAL'
      Required = True
      Size = 50
    end
    object CDSQyFL_ATIVO: TStringField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
      Origin = 'm.FL_ATIVO'
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
