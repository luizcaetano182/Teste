object dmProdutos: TdmProdutos
  OldCreateOrder = False
  Height = 267
  Width = 360
  object qryProdutos: TFDQuery
    AfterInsert = qryProdutosAfterInsert
    Indexes = <
      item
      end>
    Connection = dmPrincipal.fdConexaoPrincipal
    UpdateTransaction = dmPrincipal.fdTransactionPrincipal
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvGeneratorName, uvAutoCommitUpdates]
    UpdateOptions.GeneratorName = 'GEN_PRODUTO_ID'
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'IDPRODUTO'
    SQL.Strings = (
      'select'
      '  First 1'
      '  IDProduto,'
      '  DescricaoProduto,'
      '  ValorProduto'
      'from'
      '  Produto'
      '')
    Left = 32
    Top = 24
    object qryProdutosDESCRICAOPRODUTO: TStringField
      FieldName = 'DESCRICAOPRODUTO'
      Origin = 'DESCRICAOPRODUTO'
      Size = 200
    end
    object qryProdutosVALORPRODUTO: TFloatField
      FieldName = 'VALORPRODUTO'
      Origin = 'VALORPRODUTO'
      currency = True
    end
    object qryProdutosIDPRODUTO: TIntegerField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object qryRelProdutos: TFDQuery
    Connection = dmPrincipal.fdConexaoPrincipal
    SQL.Strings = (
      'select'
      '  IDProduto,'
      '  DescricaoProduto,'
      '  ValorProduto'
      'from'
      '  Produto'
      'where'
      '    1 <> 1')
    Left = 32
    Top = 88
    object IntegerField1: TIntegerField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
    end
    object StringField1: TStringField
      FieldName = 'DESCRICAOPRODUTO'
      Origin = 'DESCRICAOPRODUTO'
      Size = 200
    end
    object FloatField1: TFloatField
      FieldName = 'VALORPRODUTO'
      Origin = 'VALORPRODUTO'
      currency = True
    end
  end
end
