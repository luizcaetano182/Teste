unit frmuCadastroVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmCadastroPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Mask;

type
  TfrCadastroPedidos = class(TfrCadastroPadrao)
    gbParcelas: TGroupBox;
    gbItensPedido: TGroupBox;
    GroupBox2: TGroupBox;
    gbSelecionaCliente: TGroupBox;
    GroupBox3: TGroupBox;
    sbInsereProdutoPedido: TSpeedButton;
    sbRemoveProdutoPedido: TSpeedButton;
    gdItensPedidos: TDBGrid;
    GroupBox4: TGroupBox;
    sbInsereParcelaPedido: TSpeedButton;
    sbRemoveParcelaPedido: TSpeedButton;
    gdParcelas: TDBGrid;
    cbListaClientes: TDBLookupComboBox;
    lbSelecionaCliente: TLabel;
    lbValorPedido: TLabel;
    dsRelClientes: TDataSource;
    dsItensPedido: TDataSource;
    dsParcelas: TDataSource;
    lbPedido: TLabel;
    gbAddProdutos: TGroupBox;
    gbAddParcelas: TGroupBox;
    cbDescricaoProduto: TDBLookupComboBox;
    edValorProduto: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Valor: TLabel;
    Quantidade: TLabel;
    cbCodigoProduto: TDBLookupComboBox;
    edQtdeItemPedido: TEdit;
    btGravarItemPedido: TButton;
    cbFormaPagamento: TComboBox;
    lbFormaPagamento: TLabel;
    dtpVencimentoParcela: TDateTimePicker;
    cbVencimento: TLabel;
    edValorParcela: TLabeledEdit;
    btGravarParcelaPedido: TButton;
    dsRelProdutos: TDataSource;
    lbReferencia: TLabel;
    dbReferencia: TDBEdit;
    lbTipoOperacao: TLabel;
    edValorPedido: TDBText;
    edBuscaNumeroPedido: TLabeledEdit;
    edNumeroPedido: TDBEdit;
    Label1: TLabel;
    btCancelarParcela: TButton;
    btCancelarItem: TButton;
    lbEmissao: TLabel;
    dbtEmissao: TDBText;
    lbValorTotalItem: TLabel;
    lbDescricaoValorTotalItem: TLabel;
    lbValorRestante: TLabel;
    lbDescricaoValorRestante: TLabel;
    sbBuscarProdutoPedido: TSpeedButton;
    cbTipoOperacao: TDBComboBox;
    procedure sbInsereProdutoPedidoClick(Sender: TObject);
    procedure btGravarItemPedidoClick(Sender: TObject);
    procedure sbInsereParcelaPedidoClick(Sender: TObject);
    procedure btGravarParcelaPedidoClick(Sender: TObject);
    procedure cbCodigoProdutoCloseUp(Sender: TObject);
    procedure cbDescricaoProdutoCloseUp(Sender: TObject);
    procedure cbCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbDescricaoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btNovoClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure AtivarDesativarBotoesInsercaoRemocao(Opcao : String);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgListaCadastrosDblClick(Sender: TObject);
    procedure edBuscaNumeroPedidoChange(Sender: TObject);
    procedure sbRemoveProdutoPedidoClick(Sender: TObject);
    procedure sbRemoveParcelaPedidoClick(Sender: TObject);
    procedure gdItensPedidosDblClick(Sender: TObject);
    procedure PreencheItemPedidoAlteracao;
    procedure preencheParcelaPedidoAlteracao;
    procedure gdParcelasDblClick(Sender: TObject);
    procedure edQtdeItemPedidoExit(Sender: TObject);
    function  P_CalculoValorRestanteParcelamento(IDPedido : integer) : string;
    procedure btCancelarItemClick(Sender: TObject);
    procedure btCancelarParcelaClick(Sender: TObject);
    procedure edQtdeItemPedidoEnter(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure sbBuscarProdutoPedidoClick(Sender: TObject);
    procedure edQtdeItemPedidoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frCadastroPedidos: TfrCadastroPedidos;
  AlterandoParcela : Boolean = False;
  AlterandoItem : Boolean = False;

implementation

{$R *.dfm}

uses udmuPedido,UProcedures, dmuPrincipal, ufrmBuscarProdutosPedido,
  udmuProdutos;

procedure TfrCadastroPedidos.AtivarDesativarBotoesInsercaoRemocao(
  Opcao: String);
begin
  if Opcao = 'Ativar' then
  begin
    sbInsereProdutoPedido.Enabled := True;
    sbInsereParcelaPedido.Enabled := True;
    sbRemoveProdutoPedido.Enabled := True;
    sbRemoveParcelaPedido.Enabled := True;
    cbListaClientes.Enabled := True;
    cbTipoOperacao.Enabled := True;
    gbParcelas.Enabled := True;
    gbItensPedido.Enabled := True;
  end
  else if Opcao = 'Desativar' then
  begin
    sbInsereProdutoPedido.Enabled := False;
    sbInsereParcelaPedido.Enabled := False;
    sbRemoveProdutoPedido.Enabled := False;
    sbRemoveParcelaPedido.Enabled := False;
    cbListaClientes.Enabled := False;
    cbTipoOperacao.Enabled := False;
    gbParcelas.Enabled := False;
    gbItensPedido.Enabled := False;
  end;

end;

procedure TfrCadastroPedidos.btAlterarClick(Sender: TObject);
begin
  inherited;
  AtivarDesativarBotoesInsercaoRemocao('Ativar');
end;

procedure TfrCadastroPedidos.btCancelarClick(Sender: TObject);
begin
  inherited;
  AtivarDesativarBotoesInsercaoRemocao('Desativar');
end;

procedure TfrCadastroPedidos.btCancelarItemClick(Sender: TObject);
begin
  inherited;
  gbAddProdutos.Hide;
end;

procedure TfrCadastroPedidos.btCancelarParcelaClick(Sender: TObject);
begin
  inherited;
  gbAddParcelas.Hide;
end;

procedure TfrCadastroPedidos.btExcluirClick(Sender: TObject);
begin
  dmPedido.P_ApagarParcelasPedido(dmPedido.qryPedidosIDPEDIDO.AsInteger);
  dmPedido.P_ApagarItensPedido(dmPedido.qryPedidosIDPEDIDO.AsInteger);
  inherited;
end;

procedure TfrCadastroPedidos.btGravarClick(Sender: TObject);
begin
  dmPedido.qryPedidos.Edit;
  inherited;
  AtivarDesativarBotoesInsercaoRemocao('Desativar');
end;

procedure TfrCadastroPedidos.btGravarItemPedidoClick(Sender: TObject);
begin
  inherited;
  if edQtdeItemPedido.Text = '' then
  begin
    ShowMessage('È Necessário informar uma quantidade para o item');
    edQtdeItemPedido.SetFocus;
    edQtdeItemPedido.Text :='1';
    Exit;
  end;
  if (edQtdeItemPedido.Text = '0') or (edQtdeItemPedido.Text = '0.00') then
  begin
    ShowMessage('È Necessário a qtde ser maior que zero');
    edQtdeItemPedido.SetFocus;
    edQtdeItemPedido.Text :='1';
    Exit;
  end;
  if (cbCodigoProduto.KeyValue  = Null)  then
  begin
    ShowMessage('È Necessário selecionar um produto');
    cbCodigoProduto.SetFocus;
    Exit;
  end;
  if AlterandoItem = False then
  begin
    dmPedido.P_InserirItemPedido(
      dmPedido.qryPedidosIDPEDIDO.AsInteger.ToString,(dmPedido.qryRelItensPedido.RecordCount + 1).ToString,
      dmPedido.qryRelProdutos.FieldByName('IDProduto').AsString,edQtdeItemPedido.Text,
      dmPedido.qryRelProdutos.FieldByName('VALORPRODUTO').AsString,
      FloatToStr(dmPedido.qryRelProdutos.FieldByName('VALORPRODUTO').AsString.ToDouble * StrToFloatDef(edQtdeItemPedido.Text,2)));
    gbAddProdutos.Hide;
  end else
  if AlterandoItem then
  begin
    dmPedido.P_AlterarItemPedido(
      (dmPedido.qryRelItensPedidoIDITEMPEDIDO.AsInteger).ToString,
      dmPedido.qryRelProdutos.FieldByName('IDProduto').AsString,edQtdeItemPedido.Text,
      dmPedido.qryRelProdutos.FieldByName('VALORPRODUTO').AsString,
      FloatToStr(dmPedido.qryRelProdutos.FieldByName('VALORPRODUTO').AsString.ToDouble * Strtofloat(edQtdeItemPedido.Text)));
    gbAddProdutos.Hide;
  end;
end;

procedure TfrCadastroPedidos.btGravarParcelaPedidoClick(Sender: TObject);
begin
  inherited;
  if dtpVencimentoParcela.Date < date then
  begin
    ShowMessage('È necessário escolher uma data igual ou posterior a data atual');
    dtpVencimentoParcela.SetFocus;
    Exit;
  end else if edValorParcela.Text = '' then
  begin
    ShowMessage('È necessário informar um valor para a parcela');
    edValorParcela.SetFocus;
    Exit;
  end else if (edValorParcela.Text = '0') or (edValorParcela.Text = '0.00') then
  begin
    ShowMessage('Não é possivel criar parcelas com o valor zero');
    edValorParcela.SetFocus;
    Exit;
  end;
  if AlterandoParcela = False then
  begin
    dmPedido.P_InserirParcelas(
      dmPedido.qryPedidosIDPEDIDO.AsInteger.ToString,IntToStr(dmPedido.qryRelParcelas.RecordCount+1),
      cbFormaPagamento.Text,DateToStr(dtpVencimentoParcela.Date),edValorParcela.Text,dmPedido.qryPedidosTOTALPEDIDO.AsString );
  end
  else if AlterandoParcela then
  begin
    dmPedido.P_AlterarParcelas(
        IntToStr(dmPedido.qryRelParcelasIDPARCELA.AsInteger),
        cbFormaPagamento.Text,DateToStr(dtpVencimentoParcela.Date),edValorParcela.Text,dmPedido.qryPedidosTOTALPEDIDO.AsString,dmPedido.qryRelParcelasVALORPARCELA.Value.ToString);
  end;


end;

procedure TfrCadastroPedidos.btNovoClick(Sender: TObject);
begin
  inherited;
  AtivarDesativarBotoesInsercaoRemocao('Ativar');
  dmPedido.P_AtualizarItensPedido(dmPedido.qryPedidosIDPEDIDO.AsInteger);
  dmPedido.P_AtualizarParcelaPedido(dmPedido.qryPedidosIDPEDIDO.AsInteger);
  cbTipoOperacao.Text := 'Saida';
end;

procedure TfrCadastroPedidos.cbCodigoProdutoCloseUp(Sender: TObject);
begin
  inherited;
  cbDescricaoProduto.KeyValue := cbCodigoProduto.KeyValue;
  edQtdeItemPedido.SetFocus;
end;

procedure TfrCadastroPedidos.cbCodigoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  cbDescricaoProduto.KeyValue := cbCodigoProduto.KeyValue;
end;

procedure TfrCadastroPedidos.cbDescricaoProdutoCloseUp(Sender: TObject);
begin
  inherited;
  cbCodigoProduto.KeyValue := cbDescricaoProduto.KeyValue;
  edQtdeItemPedido.Text :='1';
  edQtdeItemPedido.SetFocus;
end;

procedure TfrCadastroPedidos.cbDescricaoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  cbCodigoProduto.KeyValue := cbDescricaoProduto.KeyValue;
end;

procedure TfrCadastroPedidos.dbgListaCadastrosDblClick(Sender: TObject);
var
  Sql : string;
begin
  Sql :=
    'select ' +#13+
    '  First 1  ' +#13+
    '  IDPedido     ,  ' +#13+
    '  Referencia     , ' +#13+
    '  NPedido       ,  ' +#13+
    '  DataEmissao   ,  ' +#13+
    '  IDCliente     ,  ' +#13+
    '  TipoOperacao  ,  ' +#13+
    '  TotalPedido   ' +#13+
    'from       ' +#13+
    '  Pedido   ';

  P_EncontraRegistroEdicao(Sql,dsConsulta.DataSet.FieldByName('IDPedido').AsInteger,'IDPedido',dmPedido.qryPedidos);
  dmPedido.P_AtualizarItensPedido(dsConsulta.DataSet.FieldByName('IDPedido').AsInteger);
  dmPedido.P_AtualizarParcelaPedido(dsConsulta.DataSet.FieldByName('IDPedido').AsInteger);
  frCadastroPedidos.sbRodapeCadastro.Panels[1].Text :=  FormatFloat(',0.00', StrToFloat(dmPedido.qryPedidosTOTALPEDIDO.AsFloat.ToString));
  tsCadastro.Show;
end;
procedure TfrCadastroPedidos.edBuscaNumeroPedidoChange(Sender: TObject);
begin
  if edBuscaNumeroPedido.Text <> '' then
  begin
    dmPedido.P_ConsultaPedidos('IDPedido',edBuscaNumeroPedido.Text,'')
  end;
end;

procedure TfrCadastroPedidos.edQtdeItemPedidoEnter(Sender: TObject);
begin
  inherited;
    if ((edQtdeItemPedido.Text = '') or (edQtdeItemPedido.Text = '0')) then
      edQtdeItemPedido.Text := '1';
    lbDescricaoValorTotalItem.Caption :=
    FormatFloat(',0.00', StrToFloat(FloatToStr(dmPedido.qryRelProdutos.FieldByName('VALORPRODUTO').AsString.ToDouble
    * StrToFloatDef(edQtdeItemPedido.Text,2))));
end;

procedure TfrCadastroPedidos.edQtdeItemPedidoExit(Sender: TObject);
begin
  inherited;
  lbDescricaoValorTotalItem.Caption :=
  FormatFloat(',0.00', StrToFloat(FloatToStr(dmPedido.qryRelProdutos.FieldByName('VALORPRODUTO').AsString.ToDouble
  * StrToFloatDef(edQtdeItemPedido.Text,2))));
end;

procedure TfrCadastroPedidos.edQtdeItemPedidoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  Begin
    lbDescricaoValorTotalItem.Caption :=
    FormatFloat(',0.00', StrToFloat(FloatToStr(dmPedido.qryRelProdutos.FieldByName('VALORPRODUTO').AsString.ToDouble
    * StrToFloatDef(edQtdeItemPedido.Text,2))));
  End;
end;

procedure TfrCadastroPedidos.FormShow(Sender: TObject);
begin
  inherited;
  AtivarDesativarBotoesInsercaoRemocao('Desativar');
  dtpVencimentoParcela.Date := Date;
end;

procedure TfrCadastroPedidos.gdItensPedidosDblClick(Sender: TObject);
begin
  inherited;
  AlterandoItem := True;
  PreencheItemPedidoAlteracao;
  gbAddProdutos.Show;
end;

procedure TfrCadastroPedidos.gdParcelasDblClick(Sender: TObject);
begin
  inherited;
  AlterandoParcela := True;
  gbAddParcelas.Show;
  lbDescricaoValorRestante.Caption :=
  FormatFloat(',0.00', StrToFloat(p_CalculoValorRestanteParcelamento(dmPedido.qryPedidosIDPEDIDO.AsInteger)));
  preencheParcelaPedidoAlteracao;
end;

procedure TfrCadastroPedidos.PreencheItemPedidoAlteracao;
begin
  cbCodigoProduto.KeyValue := dmPedido.qryRelItensPedidoIDPRODUTOITEMPEDIDO.Value;
  cbDescricaoProduto.KeyValue := dmPedido.qryRelItensPedidoIDPRODUTOITEMPEDIDO.Value;
  edValorProduto.Text := dmPedido.qryRelItensPedidoVALORUNITARIOITEMPEDIDO.Value.ToString;
  edQtdeItemPedido.Text := dmPedido.qryRelItensPedidoQUANTIDADEITEMPEDIDO.Value.ToString;
end;

procedure TfrCadastroPedidos.preencheParcelaPedidoAlteracao;
begin
  cbFormaPagamento.Text := dmPedido.qryRelParcelasFORMAPAGAMENTO.Value;
  dtpVencimentoParcela.Date := dmPedido.qryRelParcelasDATAVENCIMENTO.Value;
  edValorParcela.Text := dmPedido.qryRelParcelasVALORPARCELA.Value.ToString;
end;

function TfrCadastroPedidos.p_CalculoValorRestanteParcelamento(
  IDPedido: integer): string;
var
  Sql : string;
begin
  Sql :=
    'select '   +#13+
    '  coalesce(Pedido.totalpedido,0) -   '  +#13+
    '  (select coalesce(sum(parcelas.valorparcela),0)  '  +#13+
    '   from   '   +#13+
    '     parcelas  '   +#13+
    '   where  '   +#13+
    '     Parcelas.idpedido = pedido.idpedido) as Retorno  '   +#13+
    'from   ' +#13+
    '  Pedido ' +#13+
    'where   ' +#13+
    ' Pedido.IDPedido =' + QuotedStr(IDPedido.ToString);
  Result := dmprincipal.F_ExecutarComRetorno(Sql);
end;

procedure TfrCadastroPedidos.sbBuscarProdutoPedidoClick(Sender: TObject);
begin
  if frmBuscarProdutosPedido <> nil then
  begin
    frmBuscarProdutosPedido := nil;
    frmBuscarProdutosPedido := tfrmBuscarProdutosPedido.Create(Application);
  end
  else
    frmBuscarProdutosPedido := tfrmBuscarProdutosPedido.Create(Application);
  frmBuscarProdutosPedido.show;

end;

procedure TfrCadastroPedidos.sbInsereParcelaPedidoClick(Sender: TObject);
begin
  inherited;
  if dmPedido.qryPedidosTOTALPEDIDO.Value = 0 then
  begin
    ShowMessage('O total da Venda é 0 não tem oque parcelar insira algum item');
    Exit;
  end;
  AlterandoParcela := False;
  cbFormaPagamento.Text := 'A Vista';
  edValorParcela.Text :='0';
  lbDescricaoValorRestante.Caption := '0';
  gbAddParcelas.Show;
  lbDescricaoValorRestante.Caption :=
  FormatFloat(',0.00', StrToFloat(p_CalculoValorRestanteParcelamento(dmPedido.qryPedidosIDPEDIDO.AsInteger)));
end;

procedure TfrCadastroPedidos.sbInsereProdutoPedidoClick(Sender: TObject);
begin
  inherited;
  AlterandoItem := False;
  cbCodigoProduto.KeyValue := -1;
  cbDescricaoProduto.KeyValue := -1;
  edValorProduto.Text :='0';
  edQtdeItemPedido.Text :='1';
  lbDescricaoValorTotalItem.Caption:='0.00';
  gbAddProdutos.Show;
end;

procedure TfrCadastroPedidos.sbRemoveParcelaPedidoClick(Sender: TObject);
begin
  inherited;
  dmPedido.P_RemoverParcelaPedido(dmPedido.qryRelParcelasIDPARCELA.AsInteger);
end;

procedure TfrCadastroPedidos.sbRemoveProdutoPedidoClick(Sender: TObject);
begin
  inherited;
  dmPedido.p_RemoverItemPedido(dmPedido.qryRelItensPedidoIDITEMPEDIDO.AsInteger);
end;

end.
