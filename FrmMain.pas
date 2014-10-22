unit FrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    gridWidth: TEdit;
    GridHeight: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ReadyColourBox: TColorBox;
    Label4: TLabel;
    WorkingColourBox: TColorBox;
    Label5: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  FrmGame;

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
var
  GameFrm: TGameForm;
begin
  GameFrm := TGameForm.Create(self);
  try
    GameFrm.Position := poOwnerFormCenter;
    GameFrm.ReadyColour := ReadyColourBox.Selected;
    GameFrm.WorkingColour := WorkingColourBox.Selected;
    GameFrm.GridWidth := StrToIntDef(GridWidth.Text, 3);
    GameFrm.GridHeight := StrToIntDef(GridHeight.Text, 3);
    GameFrm.MaxTime := ((StrToIntDef(GridWidth.Text, 3) * StrToIntDef(GridHeight.Text, 3)) div 4)*3;
    GameFrm.ShowModal;
  finally
    GameFrm.Free;
  end;
end;

end.
