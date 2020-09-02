unit ufrmBuscarProdutosPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmBuscarProdutosPedido = class(TForm)
    pnTitulo: TPanel;
    edBuscaCodigoProduto: TLabeledEdit;
    edBuscaDescricaoProduto: TLabeledEdit;
    gbConsulta: TGroupBox;
    dbgListaCadastros: TDBGrid;
    dsListaProdutos: TDataSource;
    procedure edBuscaCodigoProdutoChange(Sender: TObject);
    procedure edBuscaDescricaoProdutoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure P_PreencheItemVenda;
    procedure dbgListaCadastrosDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscarProdutosPedido: TfrmBuscarProdutosPedido;

implementation

uses
  udmuPedido, udmuProdutos, frmuCadastroVendas;

{$R *.dfm}


procedure TfrmBuscarProdutosPedido.dbgListaCadastrosDblClick(Sender: TObject);
begin
  P_PreencheItemVenda;
end;

procedure TfrmBuscarProdutosPedido.edBuscaCodigoProdutoChange(Sender: TObject);
begin
  dmProdutos.P_ConsultaProdutos(dmPedido.qryListaProdutosProdutos,'IDProduto',edBuscaCodigoProduto.Text,'');
end;

procedure TfrmBuscarProdutosPedido.edBuscaDescricaoProdutoChange(
  Sender: TObject);
begin
  dmProdutos.P_ConsultaProdutos(dmPedido.qryListaProdutosProdutos,'DESCRICAOPRODUTO',edBuscaDescricaoProduto.Text,'Sim');
end;

procedure TfrmBuscarProdutosPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmBuscarProdutosPedido := nil;
end;

procedure TfrmBuscarProdutosPedido.P_PreencheItemVenda;
begin
  frCadastroPedidos.cbCodigoProduto.KeyValue := dmPedido.qryListaProdutosProdutos.FieldByName('IDProduto').Value ;
  frCadastroPedidos.cbDescricaoProduto.KeyValue := dmPedido.qryListaProdutosProdutos.FieldByName('IDProduto').Value ;
  frCadastroPedidos.edQtdeItemPedido.Text :='1';
  frCadastroPedidos.edQtdeItemPedido.SetFocus;
  Close;
end;
end.
