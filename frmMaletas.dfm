object fMaletas: TfMaletas
  Left = 0
  Top = 0
  Caption = 'fMaletas'
  ClientHeight = 390
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 112
    Width = 410
    Height = 270
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 112
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object dspPayroll: TDataSetProvider
    DataSet = dm.tPayrolls
    Left = 208
    Top = 16
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPayroll'
    OnNewRecord = ClientDataSet1NewRecord
    Left = 240
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 280
    Top = 16
  end
end
