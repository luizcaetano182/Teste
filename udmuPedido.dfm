object dmPedido: TdmPedido
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 220
  Width = 365
  object qryPedidos: TFDQuery
    AfterInsert = qryPedidosAfterInsert
    Connection = dmPrincipal.fdConexaoPrincipal
    UpdateTransaction = dmPrincipal.fdTransactionPrincipal
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_PEDIDO_ID'
    SQL.Strings = (
      'select'
      '  First 1'
      '  IDPedido     ,'
      '  Referencia     ,'
      '  NPedido       ,'
      '  DataEmissao   ,'
      '  IDCliente     ,'
      '  TipoOperacao  ,'
      '  TotalPedido'
      'from'
      '  Pedido')
    Left = 32
    Top = 24
    object qryPedidosIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
      Origin = 'IDPEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPedidosREFERENCIA: TStringField
      FieldName = 'REFERENCIA'
      Origin = 'REFERENCIA'
      Size = 200
    end
    object qryPedidosNPEDIDO: TIntegerField
      FieldName = 'NPEDIDO'
      Origin = 'NPEDIDO'
    end
    object qryPedidosDATAEMISSAO: TDateField
      FieldName = 'DATAEMISSAO'
      Origin = 'DATAEMISSAO'
    end
    object qryPedidosIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      Required = True
    end
    object qryPedidosTOTALPEDIDO: TFloatField
      FieldName = 'TOTALPEDIDO'
      Origin = 'TOTALPEDIDO'
      currency = True
    end
    object qryPedidosTIPOOPERACAO: TStringField
      FieldName = 'TIPOOPERACAO'
      Origin = 'TIPOOPERACAO'
    end
  end
  object qryRelItensPedido: TFDQuery
    Connection = dmPrincipal.fdConexaoPrincipal
    SQL.Strings = (
      'select'
      '  IDItemPedido            ,'
      '  IDPedido                 ,'
      '  NumeroItemPedido        ,'
      '  IDProdutoItemPedido      ,'
      '  QuantidadeItemPedido     ,'
      '  ValorUnitarioItemPedido   ,'
      '  ValorTotalItemPedido   ,'
      '  Produto.DescricaoProduto'
      'from'
      '  ItemPedido'
      '  Inner Join'
      
        '    Produto on Produto.IDProduto = ItemPedido.IDProdutoItemPedid' +
        'o'
      'where'
      '  ItemPedido.IDPedido =:IDPedido')
    Left = 32
    Top = 80
    ParamData = <
      item
        Name = 'IDPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryRelItensPedidoIDITEMPEDIDO: TIntegerField
      FieldName = 'IDITEMPEDIDO'
      Origin = 'IDITEMPEDIDO'
    end
    object qryRelItensPedidoIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
      Origin = 'IDPEDIDO'
    end
    object qryRelItensPedidoNUMEROITEMPEDIDO: TIntegerField
      FieldName = 'NUMEROITEMPEDIDO'
      Origin = 'NUMEROITEMPEDIDO'
    end
    object qryRelItensPedidoIDPRODUTOITEMPEDIDO: TIntegerField
      FieldName = 'IDPRODUTOITEMPEDIDO'
      Origin = 'IDPRODUTOITEMPEDIDO'
    end
    object qryRelItensPedidoQUANTIDADEITEMPEDIDO: TSingleField
      FieldName = 'QUANTIDADEITEMPEDIDO'
      Origin = 'QUANTIDADEITEMPEDIDO'
    end
    object qryRelItensPedidoVALORUNITARIOITEMPEDIDO: TFloatField
      FieldName = 'VALORUNITARIOITEMPEDIDO'
      Origin = 'VALORUNITARIOITEMPEDIDO'
      currency = True
    end
    object qryRelItensPedidoVALORTOTALITEMPEDIDO: TFloatField
      FieldName = 'VALORTOTALITEMPEDIDO'
      Origin = 'VALORTOTALITEMPEDIDO'
      currency = True
    end
    object qryRelItensPedidoDESCRICAOPRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAOPRODUTO'
      Origin = 'DESCRICAOPRODUTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
  end
  object qryRelParcelas: TFDQuery
    Connection = dmPrincipal.fdConexaoPrincipal
    SQL.Strings = (
      'select'
      '  IDParcela      ,'
      '  IDPedido       ,'
      '  NumeroParcela   ,'
      '  FormaPagamento  ,'
      '  DataVencimento  ,'
      '  ValorParcela'
      'from'
      '  Parcelas'
      'where'
      '  Parcelas.IDPedido =:IDPedido')
    Left = 32
    Top = 136
    ParamData = <
      item
        Name = 'IDPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryRelParcelasIDPARCELA: TIntegerField
      FieldName = 'IDPARCELA'
      Origin = 'IDPARCELA'
    end
    object qryRelParcelasIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
      Origin = 'IDPEDIDO'
    end
    object qryRelParcelasNUMEROPARCELA: TIntegerField
      FieldName = 'NUMEROPARCELA'
      Origin = 'NUMEROPARCELA'
    end
    object qryRelParcelasFORMAPAGAMENTO: TStringField
      FieldName = 'FORMAPAGAMENTO'
      Origin = 'FORMAPAGAMENTO'
      Size = 10
    end
    object qryRelParcelasDATAVENCIMENTO: TDateField
      FieldName = 'DATAVENCIMENTO'
      Origin = 'DATAVENCIMENTO'
      EditMask = '!99/99/00;1;_'
    end
    object qryRelParcelasVALORPARCELA: TFloatField
      FieldName = 'VALORPARCELA'
      Origin = 'VALORPARCELA'
      currency = True
    end
  end
  object qryRelClientes: TFDQuery
    Connection = dmPrincipal.fdConexaoPrincipal
    SQL.Strings = (
      'select'
      '  IDCliente,'
      '  NomeCliente'
      'from'
      '  Clientes')
    Left = 160
    Top = 80
    object qryRelClientesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
    end
    object qryRelClientesNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 200
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
      '  Produto')
    Left = 160
    Top = 140
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
  object qryRelPedidos: TFDQuery
    AfterInsert = qryPedidosAfterInsert
    Connection = dmPrincipal.fdConexaoPrincipal
    SQL.Strings = (
      'select'
      '  IDPedido     ,'
      '  NPedido       ,'
      '  DataEmissao   ,'
      '  Clientes.NOMECLIENTE,'
      '  TipoOperacao  ,'
      '  TotalPedido'
      'from'
      '  Pedido'
      '  inner join '
      '   Clientes on Clientes.IDCliente = Pedido.IDCliente'
      'where'
      '  1<>1')
    Left = 152
    Top = 24
    object qryRelPedidosIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
      Origin = 'IDPEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRelPedidosNPEDIDO: TIntegerField
      FieldName = 'NPEDIDO'
      Origin = 'NPEDIDO'
    end
    object qryRelPedidosDATAEMISSAO: TDateField
      FieldName = 'DATAEMISSAO'
      Origin = 'DATAEMISSAO'
    end
    object qryRelPedidosNOMECLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      ProviderFlags = []
      Size = 200
    end
    object qryRelPedidosTOTALPEDIDO: TFloatField
      FieldName = 'TOTALPEDIDO'
      Origin = 'TOTALPEDIDO'
      currency = True
    end
    object qryRelPedidosTIPOOPERACAO: TStringField
      FieldName = 'TIPOOPERACAO'
      Origin = 'TIPOOPERACAO'
    end
  end
  object qryListaProdutosProdutos: TFDQuery
    Connection = dmPrincipal.fdConexaoPrincipal
    SQL.Strings = (
      'select'
      '  IDProduto,'
      '  DescricaoProduto,'
      '  ValorProduto'
      'from'
      '  Produto')
    Left = 264
    Top = 25
    object IntegerField2: TIntegerField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
    end
    object StringField2: TStringField
      FieldName = 'DESCRICAOPRODUTO'
      Origin = 'DESCRICAOPRODUTO'
      Size = 200
    end
    object FloatField2: TFloatField
      FieldName = 'VALORPRODUTO'
      Origin = 'VALORPRODUTO'
      currency = True
    end
  end
end
