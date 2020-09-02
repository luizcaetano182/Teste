unit udmuProdutos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,uProcedures;

type
  TdmProdutos = class(TDataModule)
    qryProdutos: TFDQuery;
    qryProdutosDESCRICAOPRODUTO: TStringField;
    qryProdutosVALORPRODUTO: TFloatField;
    qryRelProdutos: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    qryProdutosIDPRODUTO: TIntegerField;
    procedure P_ConsultaProdutos(Query : TFDQuery;Campo,Valor : String;Incremental  : String = '');
    procedure qryProdutosAfterInsert(DataSet: TDataSet);
    function F_ProximoProduto: Integer;

  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  dmProdutos: TdmProdutos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmuPrincipal;

{$R *.dfm}

function TdmProdutos.F_ProximoProduto: Integer;
var
  Sql : string;
begin
  Sql :=
    'select gen_id(gen_produto_id,1) as Retorno from rdb$database' ;
  Result := dmPrincipal.F_ExecutarComRetorno(Sql);
end;

procedure TdmProdutos.P_ConsultaProdutos(Query : TFDQuery;Campo,Valor : String;Incremental  : String = '');
var
  Sql,Where : string;
begin
  Sql :=
    'select ' +#13+
    '  IDProduto, ' +#13+
    '  DescricaoProduto, ' +#13+
    '  ValorProduto  '  +#13+
    'from  ' +#13+
    '  Produto ' ;
   if Valor <> '' then
     where :=
       #13 + 'Where ' + Campo +  iif( Incremental = '',' = ' + Valor,' like ' + QuotedStr('%'+ valor +'%'))
   else
     where :=
       #13 + 'Where 1<>1' ;
   Query.Close;
   Query.SQL.Text :=
   iif(Valor = '',Sql,Sql + Where);
   Query.Open;
end;

procedure TdmProdutos.qryProdutosAfterInsert(DataSet: TDataSet);
begin
   qryProdutosIDPRODUTO.AsInteger := F_ProximoProduto;
end;

end.
