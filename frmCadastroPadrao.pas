unit frmCadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfrCadastroPadrao = class(TForm)
    pgCadastro: TPageControl;
    tsCadastro: TTabSheet;
    tsConsulta: TTabSheet;
    pnTopoCadastro: TPanel;
    gbTelaCadastro: TGroupBox;
    sbRodapeCadastro: TStatusBar;
    pnTitulo: TPanel;
    gbConsulta: TGroupBox;
    StatusBar1: TStatusBar;
    dsCadastro: TDataSource;
    dsConsulta: TDataSource;
    dbgListaCadastros: TDBGrid;
    gbBotoes: TGroupBox;
    dbtTitulo: TDBText;
    btNovo: TButton;
    btExcluir: TButton;
    btCancelar: TButton;
    btGravar: TButton;
    btAlterar: TButton;
    procedure btNovoClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frCadastroPadrao: TfrCadastroPadrao;
  Formulario : TForm;

implementation




{$R *.dfm}

uses uProcedures;

procedure TfrCadastroPadrao.btAlterarClick(Sender: TObject);
begin
  P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btGravar,btCancelar,'Alterar',Formulario);
  P_Alterar(dsCadastro,Formulario);
end;


procedure TfrCadastroPadrao.btCancelarClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja cancelar as alterações do registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    P_Cancelar(dsCadastro,Formulario);
    P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btGravar,btCancelar,'Cancelar',Formulario);
  end;
end;

procedure TfrCadastroPadrao.btExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    P_Excluir(dsCadastro);
    P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btGravar,btCancelar,'Excluir',Formulario);
  end;
end;

procedure TfrCadastroPadrao.btGravarClick(Sender: TObject);
begin
  P_Salvar(dsCadastro,Formulario);
  P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btGravar,btCancelar,'Gravar',Formulario);
end;

procedure TfrCadastroPadrao.btNovoClick(Sender: TObject);
begin
  P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btGravar,btCancelar,'Inserir',Formulario);
  P_Novo(dsCadastro,Formulario);
end;

procedure TfrCadastroPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
  frCadastroPadrao := nil;
end;

procedure TfrCadastroPadrao.FormShow(Sender: TObject);
begin
  Formulario :=  (Screen.Forms[0]);
  P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btGravar,btCancelar,'Entrada',Formulario);
  tsCadastro.Show;

end;

end.
