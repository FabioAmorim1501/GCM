object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sisterma GCM'
  ClientHeight = 229
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnFeedDB: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Alimentar BD'
    TabOrder = 0
    OnClick = btnFeedDBClick
  end
  object btnShowData: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 38
    Caption = '&Carregar dados do BD'
    TabOrder = 1
    WordWrap = True
    OnClick = btnShowDataClick
  end
  object btnDelete: TButton
    Left = 8
    Top = 83
    Width = 75
    Height = 50
    Caption = '&Deletar Registro'
    TabOrder = 2
    WordWrap = True
    OnClick = btnDeleteClick
  end
  object grdDados: TDBGrid
    Left = 89
    Top = 0
    Width = 546
    Height = 229
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsDados
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USERNAME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STREET'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUITE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CITY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ZIPCODE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAT'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LNG'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WEBSITE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPANY_NAME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPANY_CATCHPHRASE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPANY_BS'
        Visible = True
      end>
  end
  object btnInsert: TButton
    Left = 8
    Top = 139
    Width = 75
    Height = 38
    Caption = '&Inserir Registro'
    TabOrder = 4
    WordWrap = True
    OnClick = btnInsertClick
  end
  object btnUpdate: TButton
    Left = 8
    Top = 183
    Width = 75
    Height = 38
    Caption = 'A&lterar Registro'
    TabOrder = 5
    WordWrap = True
    OnClick = btnUpdateClick
  end
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    AfterPost = cdsDadosAfterPost
    Left = 516
    Top = 188
    object cdsDadosID: TIntegerField
      FieldName = 'ID'
    end
    object cdsDadosNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 100
    end
    object cdsDadosUSERNAME: TStringField
      FieldName = 'USERNAME'
      Required = True
      Size = 64
    end
    object cdsDadosEMAIL: TStringField
      FieldName = 'EMAIL'
      Required = True
      Size = 64
    end
    object cdsDadosSTREET: TStringField
      FieldName = 'STREET'
      Size = 200
    end
    object cdsDadosSUITE: TStringField
      FieldName = 'SUITE'
      Size = 100
    end
    object cdsDadosCITY: TStringField
      FieldName = 'CITY'
      Size = 100
    end
    object cdsDadosZIPCODE: TStringField
      FieldName = 'ZIPCODE'
      Size = 15
    end
    object cdsDadosLAT: TStringField
      FieldName = 'LAT'
    end
    object cdsDadosLNG: TStringField
      FieldName = 'LNG'
    end
    object cdsDadosPHONE: TStringField
      FieldName = 'PHONE'
      Size = 64
    end
    object cdsDadosWEBSITE: TStringField
      FieldName = 'WEBSITE'
      Size = 64
    end
    object cdsDadosCOMPANY_NAME: TStringField
      FieldName = 'COMPANY_NAME'
      Size = 100
    end
    object cdsDadosCOMPANY_CATCHPHRASE: TStringField
      FieldName = 'COMPANY_CATCHPHRASE'
      Size = 200
    end
    object cdsDadosCOMPANY_BS: TStringField
      FieldName = 'COMPANY_BS'
      Size = 100
    end
  end
  object dsDados: TDataSource
    DataSet = cdsDados
    Left = 580
    Top = 180
  end
  object rstUsers: TRESTClient
    Accept = 'application/json, text/json'
    AcceptCharset = 'utf-8'
    BaseURL = 'https://jsonplaceholder.typicode.com'
    Params = <>
    Left = 324
    Top = 168
  end
  object rrqUsers: TRESTRequest
    Client = rstUsers
    Params = <>
    Resource = 'users'
    Left = 324
    Top = 128
  end
end
