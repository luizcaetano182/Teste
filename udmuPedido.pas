unit udmuPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.Dialogs;

type
  TdmPedido = class(TDataModule)
    qryPedidos: TFDQuery;
    qryRelItensPedido: TFDQuery;
    qryRelParcelas: TFDQuery;
    qryRelClientes: TFDQuery;
    qryRelClientesIDCLIENTE: TIntegerField;
    qryRelClientesNOMECLIENTE: TStringField;
    qryRelParcelasIDPARCELA: TIntegerField;
    qryRelParcelasIDPEDIDO: TIntegerField;
    qryRelParcelasNUMEROPARCELA: TIntegerField;
    qryRelParcelasFORMAPAGAMENTO: TStringField;
    qryRelParcelasDATAVENCIMENTO: TDateField;
    qryRelParcelasVALORPARCELA: TFloatField;
    qryRelItensPedidoIDITEMPEDIDO: TIntegerField;
    qryRelItensPedidoIDPEDIDO: TIntegerField;
    qryRelItensPedidoNUMEROITEMPEDIDO: TIntegerField;
    qryRelItensPedidoIDPRODUTOITEMPEDIDO: TIntegerField;
    qryRelItensPedidoQUANTIDADEITEMPEDIDO: TSingleField;
    qryRelItensPedidoVALORUNITARIOITEMPEDIDO: TFloatField;
    qryRelItensPedidoVALORTOTALITEMPEDIDO: TFloatField;
    qryRelItensPedidoDESCRICAOPRODUTO: TStringField;
    qryRelProdutos: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    qryRelPedidos: TFDQuery;
    qryRelPedidosIDPEDIDO: TIntegerField;
    qryRelPedidosNPEDIDO: TIntegerField;
    qryRelPedidosDATAEMISSAO: TDateField;
    qryRelPedidosNOMECLIENTE: TStringField;
    qryRelPedidosTOTALPEDIDO: TFloatField;
    qryPedidosIDPEDIDO: TIntegerField;
    qryPedidosREFERENCIA: TStringField;
    qryPedidosNPEDIDO: TIntegerField;
    qryPedidosDATAEMISSAO: TDateField;
    qryPedidosIDCLIENTE: TIntegerField;
    qryPedidosTOTALPEDIDO: TFloatField;
    qryListaProdutosProdutos: TFDQuery;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    FloatField2: TFloatField;
    qryPedidosTIPOOPERACAO: TStringField;
    qryRelPedidosTIPOOPERACAO: TStringField;
    procedure P_InserirParcelas(IDPedido,numeroParcela,FormaPagamento,DataVencimento,ValorParcela,TotalPedido : String);
    procedure P_InserirItemPedido(IDPedido,NumeroItemPedido,IDProduto,Qtde,ValorUnitario,ValorTotalItem : String);
    procedure P_AlterarParcelas(IDParcela, FormaPagamento,DataVencimento, ValorParcela,ValorAnteriorParcela,TotalPedido: String);
    procedure P_AlterarItemPedido(IDItemPedido, IDProduto,Qtde, ValorUnitario, ValorTotalItem : String);
    function  F_ValidarNovaParcela(IDPedido : Integer;Alterando: String; ValorAlterior,NovoValor,TotalPedido: Real): String;
    procedure P_AtualizarItensPedido(IDPedido : Integer);
    procedure P_AtualizarParcelaPedido(IDPedido : Integer);
    function  F_ProximoPedido : Integer;
    procedure qryPedidosAfterInsert(DataSet: TDataSet);
    procedure P_AtualizarTotalPedido;
    procedure P_ConsultaPedidos(Campo,Valor : String;Incremental  : String = '');
    procedure p_RemoverItemPedido(IDItemPedido : Integer);
    procedure P_RemoverParcelaPedido(IDParcela : Integer);
    procedure DataModuleCreate(Sender: TObject);
    procedure P_ApagarParcelasPedido(IDPedido : Integer);
    procedure P_ApagarItensPedido(IDPedido : Integer);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPedido: TdmPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmuPrincipal,UProcedures, frmuCadastroVendas;

{$R *.dfm}

{ TdmPedido }



procedure TdmPedido.P_ConsultaPedidos(Campo,Valor : String;Incremental  : String = '');
var
  Sql,Where : string;
begin
  Sql :=
    'select '  +#13+
    '  IDPedido     ,  '  +#13+
    '  NPedido       ,  '  +#13+
    '  DataEmissao   , '  +#13+
    '  Clientes.NOMECLIENTE,  ' +#13+
    '  TipoOperacao  , '  +#13+
    '  TotalPedido  '    +#13+
    'from     '   +#13+
    '  Pedido   '   +#13+
    '  inner join  ' +#13+
    '    Clientes on Clientes.IDCliente = Pedido.IDCliente  ';

   if Valor <> '' then
     where :=
       #13 + 'Where ' + Campo +  iif( Incremental = '',' = ' + Valor,' like ' + QuotedStr('%'+ valor +'%'))
   else
     where :=
       #13 + 'Where 1<>1' ;
   qryRelPedidos.Close;
   qryRelPedidos.SQL.Text :=
   Sql + Where;
   qryRelPedidos.Open;
end;

procedure TdmPedido.DataModuleCreate(Sender: TObject);
begin
   FormatSettings.DecimalSeparator := ',';
end;

function TdmPedido.F_ProximoPedido: Integer;
var
  Sql : string;
begin
  Sql :=
    'select gen_id(GEN_PEDIDO_ID,1) as Retorno from rdb$database' ;
  Result := dmPrincipal.F_ExecutarComRetorno(Sql);
end;

function TdmPedido.F_ValidarNovaParcela(IDPedido : Integer;Alterando: String; ValorAlterior,
  NovoValor,TotalPedido : Real): String;
var
  SqlValidar : string;
  Valor : Real;
begin
  Valor := iif(Alterando = 'S',(ValorAlterior - NovoValor),NovoValor );
  SqlValidar  :=
    'select  '  +#13+
    '  case when     '  +#13+
    '    coalesce(sum(Parcelas.valorparcela),0)+  '  +#13+
         FloatToStr(Valor) +#13+
    '      >   '  +#13+
          FloatToStr(TotalPedido)  +#13+
    '  then  '  +#13+
    '    ''NPermitido''  ' +#13+
    '  else     '   +#13+
    '    ''Permitido''    '  +#13+
    '  end as Retorno   '    +#13+
    'from      '   +#13+
    '  Parcelas  ' +#13+
    'where   '  +#13+
    '  Parcelas.idpedido = ' + QuotedStr(IDPedido.ToString) ;

    Result := dmPrincipal.F_ExecutarComRetorno(SqlValidar);

end;

procedure TdmPedido.P_AlterarItemPedido(IDItemPedido, IDProduto,
  Qtde, ValorUnitario, ValorTotalItem : String);
var
  Sql : string;
begin
  Sql :=
    'update   ' + #13+
    '  ItemPedido ' + #13+
    'set   ' + #13+
    ' IDProdutoItemPedido= ' + QuotedStr(IDProduto) + #13+
    ' , QuantidadeItemPedido=' + QuotedStr(TrocaVirgulaPorPonto(Qtde)) + #13+
    ', ValorUnitarioItemPedido= '  + QuotedStr(TrocaVirgulaPorPonto(ValorUnitario)) +   #13+
    ', ValorTotalItemPedido= ' +  QuotedStr(TrocaVirgulaPorPonto(ValorTotalItem))  +   #13+
    'Where IDItemPedido= ' + QuotedStr(IDItemPedido) ;

  dmPrincipal.P_ExecutarSemRetorno(Sql);
  P_AtualizarItensPedido(qryPedidosIDPEDIDO.Value);
  P_AtualizarTotalPedido;
end;

procedure TdmPedido.P_AlterarParcelas(IDParcela, FormaPagamento,
  DataVencimento, ValorParcela,ValorAnteriorParcela,TotalPedido : String);
var
  Sql : string;
begin
  Sql :=
    'update   ' + #13+
    '  PARCELAS ' + #13+
    'set   ' + #13+
    '  FORMAPAGAMENTO= '  + QuotedStr(FormaPagamento) +   #13+
    ', DATAVENCIMENTO= ' +  QuotedStr(DataVencimento) +   #13+
    '  IDPARCELA= ' +  QuotedStr(ValorParcela) +  #13+
    'Where ' +#13+
    '  IDParcela = ' + QuotedStr(IDParcela);

    if F_ValidarNovaParcela(qryPedidosIDPEDIDO.Value,'S',ValorAnteriorParcela.ToDouble,ValorParcela.ToDouble,TotalPedido.ToDouble) = 'Permitido' then
    begin
      try
        dmPrincipal.P_ExecutarSemRetorno(Sql);
        P_AtualizarParcelaPedido(qryPedidosIDPEDIDO.Value);
        ShowMessage('Registro Alterado');
      Except
        ShowMessage('Erro ao alterar Registro');
      end;
    end
    else if F_ValidarNovaParcela(qryPedidosIDPEDIDO.Value,'S',ValorAnteriorParcela.ToDouble,ValorParcela.ToDouble,TotalPedido.ToDouble) =  'NPermitido' then
    begin
      ShowMessage('Este Valor Ultrapassa o valor Total da Venda');
      Exit;
    end;
end;

procedure TdmPedido.P_ApagarItensPedido(IDPedido: Integer);
var
  Sql : string;
begin
  Sql :=
    'delete ' +#13+
    'From ' +#13+
    '  ITEMPEDIDO  ' +#13+
    'Where ' +#13+
    '  ITEMPEDIDO.IDPedido='+IDPedido.ToString;
  Try
    dmPrincipal.P_ExecutarSemRetorno(Sql);
  except

  End;
end;

procedure TdmPedido.P_ApagarParcelasPedido(IDPedido: Integer);
var
  Sql : string;
begin
  Sql :=
    'Delete '  +#13+
    'From' +#13+
    ' Parcelas' +#13+
    'Where '  +#13+
    '  Parcelas.IDPedido=' + IDPedido.ToString;
  Try
    dmPrincipal.P_ExecutarSemRetorno(Sql);
  except

  End;
end;

procedure TdmPedido.P_AtualizarItensPedido(IDPedido: Integer);
begin
  qryRelItensPedido.Close;
  qryRelItensPedido.ParamByName('IDPedido').AsInteger := IDPedido;
  qryRelItensPedido.Open;
end;

procedure TdmPedido.P_AtualizarParcelaPedido(IDPedido: Integer);
begin
  qryRelParcelas.Close;
  qryRelParcelas.ParamByName('IDPedido').AsInteger := IDPedido;
  qryRelParcelas.Open;
end;

procedure TdmPedido.P_AtualizarTotalPedido;
var
  Sql : string;
begin
  Sql :=
    'select ' +#13+
    '  sum(ITEMPEDIDO.VALORTOTALITEMPEDIDO) as Retorno' +#13+
    'From' +#13+
    ' ITEMPEDIDO '  +#13+
    'where  ' +#13+
    '  ITEMPEDIDO.IDPEDIDO=' + IntToStr(dmPedido.qryPedidosIDPEDIDO.AsInteger);

  qryPedidosTOTALPEDIDO.AsFloat :=   dmPrincipal.F_ExecutarComRetorno(Sql);
  qryPedidos.Edit;
  qryPedidos.Post;
  qryPedidos.Edit;
  frCadastroPedidos.sbRodapeCadastro.Panels[1].Text :=  FormatFloat(',0.00', StrToFloat(qryPedidosTOTALPEDIDO.AsFloat.ToString));
end;

procedure TdmPedido.P_InserirItemPedido(IDPedido, NumeroItemPedido, IDProduto,
  Qtde, ValorUnitario, ValorTotalItem : String);
Var
  Sql : string;
begin
  FormatSettings.DecimalSeparator := ',';
  Sql :=
    'insert into  '  +#13+
    '  ItemPedido  '  +#13+
    '    (IDPedido, ' +#13+
    '     NumeroItemPedido, '+#13+
    '     IDProdutoItemPedido, ' +#13+
    '     QuantidadeItemPedido, ' +#13+
    '     ValorUnitarioItemPedido,' +#13+
    '     ValorTotalItemPedido) ' +#13+
    'values  ' +#13+
    '(' +
       QuotedStr(IDPedido) +','+#13+
       QuotedStr(NumeroItemPedido)+','+ #13+
       QuotedStr(IDProduto)+',' + #13+
       QuotedStr(TrocaVirgulaPorPonto(Qtde))+','+ #13+
       QuotedStr(TrocaVirgulaPorPonto(ValorUnitario))+','+#13+
       QuotedStr(TrocaVirgulaPorPonto(ValorTotalItem)) +  #13+
    ')';
    dmPrincipal.P_ExecutarSemRetorno(Sql);
    P_AtualizarItensPedido(IDPedido.ToInteger());
    P_AtualizarTotalPedido;
end;

procedure TdmPedido.P_InserirParcelas(IDPedido, numeroParcela, FormaPagamento,
  DataVencimento, ValorParcela,TotalPedido : String);
Var
  Sql : string;
begin
  Sql :=
    'insert into  '  +#13+
    '  PARCELAS  '  +#13+
    '    (IDPEDIDO, ' +#13+
    '     NUMEROPARCELA, '+#13+
    '     FORMAPAGAMENTO, ' +#13+
    '     DATAVENCIMENTO, ' +#13+
    '     VALORPARCELA)' +#13+
    'values  ' +#13+
    '(' +
       QuotedStr(IDPedido) +','+ #13+
       QuotedStr(numeroParcela)+','+  #13+
       QuotedStr(FormaPagamento)+',' + #13+
       QuotedStr(ConverteData(StrToDate(DataVencimento)))+','+ #13+
       QuotedStr(ValorParcela)+
    ')';

    if F_ValidarNovaParcela(dmPedido.qryPedidosIDPEDIDO.AsInteger,'N',0,ValorParcela.ToDouble,TotalPedido.ToDouble()) = 'Permitido' then
    begin
      try
        dmPrincipal.P_ExecutarSemRetorno(Sql);
        P_AtualizarParcelaPedido(IDPedido.ToInteger());
        ShowMessage('Registro Inserido');
        frCadastroPedidos.gbAddParcelas.Hide;
      Except
        ShowMessage('Erro ao inserir o Registro');
      end;
    end
    else if F_ValidarNovaParcela(dmPedido.qryPedidosIDPEDIDO.AsInteger,'N',0,ValorParcela.ToDouble,TotalPedido.ToDouble) =  'NPermitido' then
    begin
      ShowMessage('Este Valor Ultrapassa o valor Total da Venda');
      frCadastroPedidos.edValorParcela.SetFocus;
      frCadastroPedidos.edValorParcela.Clear;
      Exit;
    end;
end;

procedure TdmPedido.p_RemoverItemPedido(IDItemPedido: Integer);
var
  Sql : string;
begin
  Sql :=
    'delete ' +#13+
    'From ' +#13+
    '  ITEMPEDIDO  ' +#13+
    'Where ' +#13+
    '  ITEMPEDIDO.IDItemPedido='+IDItemPedido.ToString;
  Try
    dmPrincipal.P_ExecutarSemRetorno(Sql);
    ShowMessage('Registro removido com sucesso');
    dmPedido.P_AtualizarItensPedido(dmPedido.qryPedidosIDPEDIDO.AsInteger);
    dmPedido.P_AtualizarTotalPedido;
  except
    ShowMessage('Erro ao excluir o Registro');

  End;

end;

procedure TdmPedido.P_RemoverParcelaPedido(IDParcela: Integer);
var
  Sql : string;
begin
  Sql :=
    'Delete '  +#13+
    'From' +#13+
    ' Parcelas' +#13+
    'Where '  +#13+
    '  Parcelas.IDParcela=' + IDParcela.ToString;
  Try
    dmPrincipal.P_ExecutarSemRetorno(Sql);
    ShowMessage('Registro removido com sucesso');
    dmPedido.P_AtualizarTotalPedido;
    dmPedido.P_AtualizarParcelaPedido(dmPedido.qryPedidosIDPEDIDO.AsInteger);
  except
    ShowMessage('Erro ao Remover o Registro');
  End;
end;

procedure TdmPedido.qryPedidosAfterInsert(DataSet: TDataSet);
begin
  qryPedidosIDCLIENTE.AsInteger := 1;
  qryPedidosTOTALPEDIDO.Value := 0;
  qryPedidosDATAEMISSAO.Value := Date;
  frCadastroPedidos.sbRodapeCadastro.Panels[1].Text := '0.00' ;
  qryPedidosIDPEDIDO.AsInteger := dmPedido.F_ProximoPedido;
  qryPedidos.Post;
  qryPedidos.Edit;

end;

end.
