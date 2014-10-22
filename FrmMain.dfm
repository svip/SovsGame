object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 202
  ClientWidth = 198
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 95
    Top = 35
    Width = 9
    Height = 16
    Caption = #215
  end
  object Label2: TLabel
    Left = 8
    Top = 10
    Width = 54
    Height = 16
    Caption = 'Grid size:'
  end
  object Label3: TLabel
    Left = 8
    Top = 62
    Width = 48
    Height = 16
    Caption = 'Colours:'
  end
  object TLabel
    Left = -24
    Top = 296
    Width = 4
    Height = 16
  end
  object Label4: TLabel
    Left = 8
    Top = 84
    Width = 35
    Height = 16
    Caption = 'Ready'
  end
  object Label5: TLabel
    Left = 8
    Top = 112
    Width = 47
    Height = 16
    Caption = 'Working'
  end
  object gridWidth: TEdit
    Left = 8
    Top = 32
    Width = 81
    Height = 24
    Alignment = taRightJustify
    TabOrder = 0
    Text = '3'
  end
  object GridHeight: TEdit
    Left = 110
    Top = 32
    Width = 81
    Height = 24
    Alignment = taRightJustify
    TabOrder = 1
    Text = '3'
  end
  object ReadyColourBox: TColorBox
    Left = 71
    Top = 81
    Width = 119
    Height = 22
    DefaultColorColor = clBtnFace
    NoneColorColor = clBtnFace
    Selected = clBtnFace
    TabOrder = 2
  end
  object WorkingColourBox: TColorBox
    Left = 72
    Top = 109
    Width = 119
    Height = 22
    DefaultColorColor = clAppWorkSpace
    NoneColorColor = clAppWorkSpace
    Selected = clAppWorkSpace
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 144
    Width = 182
    Height = 49
    Caption = 'Start'
    TabOrder = 4
    OnClick = Button1Click
  end
end
