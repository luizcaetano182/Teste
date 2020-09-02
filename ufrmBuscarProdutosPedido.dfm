object frmBuscarProdutosPedido: TfrmBuscarProdutosPedido
  Left = 0
  Top = 0
  Caption = 'Lista de Produtos'
  ClientHeight = 272
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnTitulo: TPanel
    Left = 0
    Top = 0
    Width = 395
    Height = 50
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -365
    ExplicitWidth = 685
    object edBuscaCodigoProduto: TLabeledEdit
      Left = 5
      Top = 19
      Width = 121
      Height = 24
      EditLabel.Width = 43
      EditLabel.Height = 16
      EditLabel.Caption = 'Codigo'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnChange = edBuscaCodigoProdutoChange
    end
    object edBuscaDescricaoProduto: TLabeledEdit
      Left = 148
      Top = 19
      Width = 221
      Height = 24
      CharCase = ecUpperCase
      EditLabel.Width = 63
      EditLabel.Height = 16
      EditLabel.Caption = 'Descri'#231#227'o'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edBuscaDescricaoProdutoChange
    end
  end
  object gbConsulta: TGroupBox
    Left = 0
    Top = 50
    Width = 395
    Height = 222
    Align = alClient
    Caption = 'Consultas'
    TabOrder = 1
    ExplicitLeft = -365
    ExplicitTop = -118
    ExplicitWidth = 685
    ExplicitHeight = 390
    object dbgListaCadastros: TDBGrid
      Left = 2
      Top = 15
      Width = 391
      Height = 205
      Align = alClient
      DataSource = dsListaProdutos
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbgListaCadastrosDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'IDPRODUTO'
          Title.Caption = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAOPRODUTO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORPRODUTO'
          Title.Caption = 'Valor'
          Width = 81
          Visible = True
        end>
    end
  end
  object dsListaProdutos: TDataSource
    DataSet = dmPedido.qryListaProdutosProdutos
    Left = 144
    Top = 130
  end
end
