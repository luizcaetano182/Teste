unit dmuPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IB, FireDAC.Phys.IBDef, Vcl.Dialogs;

type
  TdmPrincipal = class(TDataModule)
    fdConexaoPrincipal: TFDConnection;
    fdTransactionPrincipal: TFDTransaction;
    qryExecutar: TFDQuery;
    procedure P_ExecutarSemRetorno(Sql : String);
    function  F_ExecutarComRetorno(Sql: String) : Variant;
    procedure P_LeArquivoConexaoSetar(Arquivo : String);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UProcedures, udmuProdutos, udmuPedido;

{$R *.dfm}

{ TdmPrincipal }

procedure TdmPrincipal.P_ExecutarSemRetorno(Sql: String);
begin
  qryExecutar.ExecSQL(Sql);
end;

procedure TdmPrincipal.P_LeArquivoConexaoSetar(Arquivo: String);
var
  f:TextFile;
  linha:String;
begin
   AssignFile(f,Arquivo);
   Reset(f);
   While not eof(f) do
   begin
     Readln(f,linha);
     dmPrincipal.fdConexaoPrincipal.Connected := False;
     dmPrincipal.fdConexaoPrincipal.Params.Database := linha;
     try
       dmPrincipal.fdConexaoPrincipal.Connected := True;
     Except
       ShowMessage('Erro ao Conectar o Banco de dados verifique o arquivo conexao.ini');
     end;
   End;
   Closefile(f);
end;

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
  P_LeArquivoConexaoSetar('Conexao.ini');
end;

function TdmPrincipal.F_ExecutarComRetorno(Sql: String) : Variant;
begin
  qryExecutar.Close;
  qryExecutar.SQL.Text := Sql;
  qryExecutar.open;
  Result := qryExecutar.FieldByName('Retorno').Value;
end;

end.
