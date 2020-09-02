unit UProcedures;



interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  procedure P_Novo(dsDataSourse : TDataSource;Formulario : TForm);
  procedure P_Alterar(dsDataSourse : TDataSource;Formulario : TForm);
  procedure P_Excluir(dsDataSourse : TDataSource);
  procedure P_Salvar(dsDataSourse : TDataSource;Formulario : TForm);
  procedure P_Cancelar(dsDataSourse : TDataSource;Formulario : TForm);
  procedure P_LiberaBloqueiaEdits(Formulario : TForm;Direcao : String);
  procedure P_EncontraRegistroEdicao(Sql : string;ID : integer; PrimaryKey : String ; queryCadastro :TFDQuery);
  procedure P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton;Precionado : String;Formulario : TForm);
  function  iif(Condicao: Boolean; Value1, Value2 : Variant) : Variant;
  function  ConverteData(Data : Tdate) : String;
  function  TrocaVirgulaPorPonto(AString: string): String;
  procedure P_AtivarQuerys(dataModule : TDataModule);


implementation

procedure P_AtivarQuerys(dataModule : TDataModule);
var
  i: Integer;
begin
  for i := dataModule.ComponentCount -1 downto 0 do
  begin
    if (dataModule.Components[i] is TFDQuery) then
    begin
     // (dataModule.Components[i] as TFDQuery).ConnectionName := 'dmPrincipal.fdConexaoPrincipal';
      Try
        if (dataModule.Components[i] as TFDQuery).Active = False then
          (dataModule.Components[i] as TFDQuery).Active := True;
      Except
        ShowMessage('Erro ao ativar as querys o banco de dados pode estar incorreto');
      End;
    end;
  end;
end;


function TrocaVirgulaPorPonto(AString: string): String;
var
  I : Integer;
  S : string;
begin
  S := '';
  for I := 1 to Length(AString) do
    if  AString[I] = ',' then
      S := S + '.'
    else
      S := S + AString[I];
  Result := S;
end;

function ConverteData(Data : Tdate) : String;
begin
  result := copy(DateToStr(Data),7,4) +'-'+ copy(DateToStr(Data),4,2) +'-'+ copy(DateToStr(Data),1,2);
end;

function iif(Condicao: Boolean; Value1, Value2 : Variant) : Variant;
begin
  if (Condicao) then
    Result := Value1
  else
    Result := Value2
end;

procedure P_EncontraRegistroEdicao(Sql : string;ID : integer; PrimaryKey : String ; queryCadastro :TFDQuery);
begin
   queryCadastro.Close;
   queryCadastro.SQL.Text := Sql + #13 + 'Where  ' + PrimaryKey + ' = ' + QuotedStr(id.ToString);
   queryCadastro.Open;

end;

procedure P_ControleDeBotoes(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton;Precionado : String;Formulario : TForm);

  procedure  P_bloqueiaNoSalvar(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton);
  begin
    btNovo.Enabled := True;
    btAlterar.Enabled := True;
    btExcluir.Enabled := True;
    btSalvar.Enabled := False;
    btCancelar.Enabled := False;
    P_LiberaBloqueiaEdits(Formulario,'B');
  end;

  procedure  P_bloqueiaNoInserir(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton);
  begin
    btNovo.Enabled := False;
    btAlterar.Enabled := False;
    btExcluir.Enabled := False;
    btSalvar.Enabled := True;
    btCancelar.Enabled := True;
  end;

  procedure  P_bloqueiaNoAlterar(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton);
  begin
    btNovo.Enabled := False;
    btAlterar.Enabled := False;
    btExcluir.Enabled := False;
    btSalvar.Enabled := True;
    btCancelar.Enabled := True;
    P_LiberaBloqueiaEdits(Screen.Forms[0],'L');
  end;

  procedure  P_bloqueiaNoExcluir(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton);
  begin
    btNovo.Enabled := True;
    btAlterar.Enabled := True ;
    btExcluir.Enabled := True;
    btSalvar.Enabled := False;
    btCancelar.Enabled := False;
  end;

  procedure  P_bloqueiaNoCancelar(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton);
  begin
    btNovo.Enabled := True;
    btAlterar.Enabled := True ;
    btExcluir.Enabled := True;
    btSalvar.Enabled := False;
    btCancelar.Enabled := False;
    P_LiberaBloqueiaEdits(Screen.Forms[0],'B');
  end;

  procedure P_bloqueiaNaEntrada(btNovo,btAlterar,btExcluir,btSalvar,btCancelar : TButton);
  begin
    btNovo.Enabled := True;
    btAlterar.Enabled := True ;
    btExcluir.Enabled := True;
    btSalvar.Enabled := False;
    btCancelar.Enabled := False;
    P_LiberaBloqueiaEdits(Screen.Forms[0],'B');
  end;

begin
  if Precionado = 'Inserir' then
    P_bloqueiaNoInserir(btNovo,btAlterar,btExcluir,btSalvar,btCancelar);
  if Precionado = 'Gravar' then
    P_bloqueiaNoSalvar(btNovo,btAlterar,btExcluir,btSalvar,btCancelar);
  if Precionado = 'Excluir' then
    P_bloqueiaNoExcluir(btNovo,btAlterar,btExcluir,btSalvar,btCancelar);
  if Precionado = 'Cancelar' then
    P_bloqueiaNoCancelar (btNovo,btAlterar,btExcluir,btSalvar,btCancelar);
  if Precionado = 'Alterar' then
    P_bloqueiaNoAlterar(btNovo,btAlterar,btExcluir,btSalvar,btCancelar);
  if Precionado = 'Entrada' then
    P_bloqueiaNaEntrada(btNovo,btAlterar,btExcluir,btSalvar,btCancelar);



end;



procedure P_Novo(dsDataSourse : TDataSource;Formulario : TForm);
begin
  try
    dsDataSourse.DataSet.Insert;
    P_LiberaBloqueiaEdits(Formulario,'L');
  Except
    ShowMessage('Erro ao iniciar novo registro');
    Exit;
  end;

end;

procedure P_Alterar(dsDataSourse : TDataSource;Formulario : TForm);
begin
  try
    dsDataSourse.DataSet.Edit;
  Except
    ShowMessage('Erro ao Editar Registro');
    Exit;
  end;

end;

procedure P_Excluir(dsDataSourse : TDataSource);
begin
  try
    dsDataSourse.DataSet.Delete;
    ShowMessage('Exclusão Concluida');
  except
    ShowMessage('Erro ao excluir o registro');
    Exit;
  end;

end;

procedure P_Salvar(dsDataSourse : TDataSource;Formulario : TForm);
begin
  try
    dsDataSourse.DataSet.Post;
    ShowMessage('Gravação Concluida');
  except
    ShowMessage('Erro ao Gravar o registro');
    Exit;
  end;

end;

procedure P_Cancelar(dsDataSourse : TDataSource;Formulario : TForm);
begin
  try
    dsDataSourse.DataSet.Cancel;
  except
    ShowMessage('Erro ao cancelar a edição do registro');
  end;

end;



procedure P_LiberaBloqueiaEdits(Formulario : TForm;Direcao : String);

  procedure P_LiberarEdits(Formulario : TForm);
  var
    i: Integer;
  begin
    for i := Formulario.ComponentCount -1 downto 0 do
    begin
      if (Formulario.Components[i] is TDBEdit) then
         (Formulario.Components[i] as TDBEdit).Enabled := True;
    end;
  end;

  procedure P_BloquearEdits(Formulario : TForm);
  var
    i: Integer;
  begin
    for i := Formulario.ComponentCount -1 downto 0 do
    begin
      if (Formulario.Components[i] is TDBEdit) then
         (Formulario.Components[i] as TDBEdit).Enabled := False;
    end;
  end;

begin
  if Direcao = 'L' then
    P_LiberarEdits(Formulario);
  if Direcao = 'B' then
    P_BloquearEdits(Formulario);
end;

end.
