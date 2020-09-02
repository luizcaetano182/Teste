unit UProjetoAgrotis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.ComCtrls;

type
  TfmPrincipal = class(TForm)
    mmPrincipal: TMainMenu;
    acPrincipal: TActionList;
    acProdutos: TAction;
    acPedidos: TAction;
    mmiCadastros: TMenuItem;
    mmiVendas: TMenuItem;
    Produtos1: TMenuItem;
    Vendas1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure acProdutosExecute(Sender: TObject);
    procedure acPedidosExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrincipal: TfmPrincipal;

implementation

{$R *.dfm}

uses frmuCadastroProdutos, frmuCadastroVendas,UProcedures, udmuProdutos,
  udmuPedido;

procedure TfmPrincipal.acProdutosExecute(Sender: TObject);
begin
 if frCadastroProdutos <> nil then
 begin
    frCadastroProdutos := nil;
    frCadastroProdutos := tfrCadastroProdutos.Create(Application);
 end else
    frCadastroProdutos := tfrCadastroProdutos.Create(Application);
  frCadastroProdutos.show;

end;

procedure TfmPrincipal.FormCreate(Sender: TObject);
begin
  P_AtivarQuerys(dmProdutos);
  P_AtivarQuerys(dmPedido);
end;

procedure TfmPrincipal.acPedidosExecute(Sender: TObject);
begin
  if frCadastroPedidos <> nil then
  begin
    frCadastroPedidos := nil;
    frCadastroPedidos := tfrCadastroPedidos.Create(Application);
  end
  else
    frCadastroPedidos := tfrCadastroPedidos.Create(Application);
  frCadastroPedidos.show;

end;

end.
