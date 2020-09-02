object frCadastroPadrao: TfrCadastroPadrao
  Left = 0
  Top = 0
  Caption = 'frCadastroPadrao'
  ClientHeight = 487
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgCadastro: TPageControl
    Left = 0
    Top = 0
    Width = 693
    Height = 487
    ActivePage = tsCadastro
    Align = alClient
    TabOrder = 0
    object tsCadastro: TTabSheet
      Caption = 'Cadastro'
      object pnTopoCadastro: TPanel
        Left = 0
        Top = 0
        Width = 685
        Height = 41
        Align = alTop
        TabOrder = 0
        object dbtTitulo: TDBText
          Left = 16
          Top = 8
          Width = 42
          Height = 13
          AutoSize = True
        end
      end
      object gbTelaCadastro: TGroupBox
        Left = 0
        Top = 41
        Width = 685
        Height = 399
        Align = alClient
        Caption = 'Cadastro'
        TabOrder = 1
        object gbBotoes: TGroupBox
          Left = 576
          Top = 15
          Width = 107
          Height = 382
          Align = alRight
          TabOrder = 0
          object btNovo: TButton
            Left = 19
            Top = 24
            Width = 75
            Height = 25
            Hint = 'Clique para inserir um novo registro'
            Caption = 'Novo'
            TabOrder = 0
            OnClick = btNovoClick
          end
          object btExcluir: TButton
            Left = 19
            Top = 86
            Width = 75
            Height = 25
            Hint = 'Clique para excluir o registro'
            Caption = 'Excluir'
            TabOrder = 1
            OnClick = btExcluirClick
          end
          object btCancelar: TButton
            Left = 19
            Top = 148
            Width = 75
            Height = 25
            Hint = 'Clique para Cancelar a edi'#231#227'o do registro'
            Caption = 'Cancelar'
            TabOrder = 2
            OnClick = btCancelarClick
          end
          object btGravar: TButton
            Left = 19
            Top = 117
            Width = 75
            Height = 25
            Hint = 'Clique para salvar o registro'
            Caption = 'Salvar'
            TabOrder = 3
            OnClick = btGravarClick
          end
          object btAlterar: TButton
            Left = 19
            Top = 55
            Width = 75
            Height = 25
            Hint = 'Clique para Editar o registro'
            Caption = 'Alterar'
            TabOrder = 4
            OnClick = btAlterarClick
          end
        end
      end
      object sbRodapeCadastro: TStatusBar
        Left = 0
        Top = 440
        Width = 685
        Height = 19
        Panels = <>
      end
    end
    object tsConsulta: TTabSheet
      Caption = 'Consulta'
      ImageIndex = 1
      object pnTitulo: TPanel
        Left = 0
        Top = 0
        Width = 685
        Height = 41
        Align = alTop
        TabOrder = 0
      end
      object gbConsulta: TGroupBox
        Left = 0
        Top = 41
        Width = 685
        Height = 399
        Align = alClient
        Caption = 'Consultas'
        TabOrder = 1
        object dbgListaCadastros: TDBGrid
          Left = 2
          Top = 15
          Width = 681
          Height = 382
          Align = alClient
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
      object StatusBar1: TStatusBar
        Left = 0
        Top = 440
        Width = 685
        Height = 19
        Panels = <>
      end
    end
  end
  object dsCadastro: TDataSource
    Left = 412
    Top = 81
  end
  object dsConsulta: TDataSource
    Left = 404
    Top = 169
  end
end
