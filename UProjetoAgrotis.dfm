object fmPrincipal: TfmPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste Agrotis'
  ClientHeight = 383
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 364
    Width = 607
    Height = 19
    Panels = <>
  end
  object mmPrincipal: TMainMenu
    Left = 40
    Top = 64
    object mmiCadastros: TMenuItem
      Caption = 'Cadastros'
      object Produtos1: TMenuItem
        Action = acProdutos
      end
    end
    object mmiVendas: TMenuItem
      Caption = 'Pedidos'
      object Vendas1: TMenuItem
        Action = acPedidos
      end
    end
  end
  object acPrincipal: TActionList
    Left = 312
    Top = 88
    object acProdutos: TAction
      Category = 'accCadastros'
      Caption = 'Produtos'
      OnExecute = acProdutosExecute
    end
    object acPedidos: TAction
      Category = 'accPedidos'
      Caption = 'Pedidos'
      OnExecute = acPedidosExecute
    end
  end
end
