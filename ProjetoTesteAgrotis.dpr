program ProjetoTesteAgrotis;

uses
  Vcl.Forms,
  UProjetoAgrotis in 'UProjetoAgrotis.pas' {fmPrincipal},
  dmuPrincipal in 'dmuPrincipal.pas' {dmPrincipal: TDataModule},
  UProcedures in 'UProcedures.pas',
  frmuCadastroProdutos in 'Cadastros\frmuCadastroProdutos.pas' {frCadastroProdutos},
  udmuProdutos in 'udmuProdutos.pas' {dmProdutos: TDataModule},
  frmCadastroPadrao in 'frmCadastroPadrao.pas' {frCadastroPadrao},
  frmuCadastroVendas in 'Cadastros\frmuCadastroVendas.pas' {frCadastroPedidos},
  udmuPedido in 'udmuPedido.pas' {dmPedido: TDataModule},
  ufrmBuscarProdutosPedido in 'ufrmBuscarProdutosPedido.pas' {frmBuscarProdutosPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmProdutos, dmProdutos);
  Application.CreateForm(TdmPedido, dmPedido);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfmPrincipal, fmPrincipal);
  Application.Run;
end.
