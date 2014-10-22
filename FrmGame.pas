unit FrmGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DateUtils,
  OtlParallel, OtlSync, OtlTask, OtlTaskControl, Vcl.ExtCtrls;

const
  UnreadyFontColour = clGray;
  ReadyFontColour = clBlack;

type
  TGameForm = class(TForm)
    procedure PanelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fReadyColour: TColor;
    fWorkingColour: TColor;
    fMaxTime: Integer;
    fGridWidth: integer;
    fGridHeight: integer;
    ButtonsDown: integer;
    StartTime: TDateTime;
    CancelToken: IOmniCancellationToken;
    procedure SleepPanel(Sender: TPanel);
    function NewPanel: TPanel;
    { Private declarations }
  public
    { Public declarations }
    property ReadyColour: TColor write fReadyColour;
    property WorkingColour: TColor write fWorkingColour;
    property MaxTime: integer write fMaxTime;
    property GridWidth: integer write fGridWidth;
    property GridHeight: integer write fGridHeight;
  end;

var
  GameForm: TGameForm;

implementation

{$R *.dfm}

procedure TGameForm.PanelClick(Sender: TObject);
begin
  SleepPanel(TPanel(Sender));
end;

procedure TGameForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CancelToken.Signal;
end;

procedure TGameForm.FormCreate(Sender: TObject);
begin
  fMaxTime := 9;
  fGridWidth := 9;
  fGridHeight := 9;
  fReadyColour := clBtnFace;
  fWorkingColour := clAppWorkSpace;
end;

function TGameForm.NewPanel: TPanel;
begin
  Result := TPanel.Create(Self);
  Result.Width := 100;
  Result.Height := 100;
  Result.Caption := '1';
  Result.Parent := Self;
  Result.OnClick := PanelClick;
end;

procedure TGameForm.FormShow(Sender: TObject);
var
  C: TControl;
  I: Integer;
  X: Integer;
  Y: Integer;
  tmpPanel: TPanel;
begin
  CancelToken := CreateOmniCancellationToken;
  ButtonsDown := 0;
  StartTime := Now;
  Randomize;
  tmpPanel := nil;
  for X := 0 to fGridWidth - 1 do begin
    for Y := 0 to fGridHeight - 1 do begin
      tmpPanel := NewPanel;
      tmpPanel.Top := Y*tmpPanel.Height;
      tmpPanel.Left := X*tmpPanel.Width;
    end;
  end;
  if tmpPanel = nil then begin
    ShowMessage('You are going to need *something* to click...');
    Close;
  end;
  ClientWidth := tmpPanel.Width*fGridWidth;
  ClientHeight := tmpPanel.Height*fGridHeight;
  for I := 0 to ControlCount - 1do begin
    C := Controls[I];
    if (C is TPanel) then begin
      TPanel(C).Color := fReadyColour;
      TPanel(C).Font.Color := ReadyFontColour;
      TPanel(C).Caption := IntToStr(Random(fMaxTime)+1);
    end;
  end;
end;

procedure TGameForm.SleepPanel(Sender: TPanel);
var
  SleepTime: Integer;
begin
  if Sender.Color = fWorkingColour then
    exit;
  Sender.Color := fWorkingColour;
  Sender.Font.Color := UnreadyFontColour;
  Inc(ButtonsDown);
  if ButtonsDown >= fGridWidth*fGridHeight then begin
    // We won!
    CancelToken.Signal;
    ShowMessage(Format('You won!  It only took %d seconds!', [SecondsBetween(Now, StartTime)]));
    Close;
    exit;
  end;
  SleepTime := StrToIntDef(Sender.Caption, 1);
  Parallel.Async(procedure(const task: IOmniTask)
  var
    I: Integer;
  begin
    I := 0;
    while not Task.CancellationToken.IsSignalled and (I <= SleepTime*10) do begin
      Sleep(100);
      Inc(I);
    end;
  end, Parallel.TaskConfig.CancelWith(CancelToken)
    .OnTerminated(procedure(const task: IOmniTaskControl) begin
      if not Task.CancellationToken.IsSignalled then begin
        Sender.Color := fReadyColour;
        Sender.Font.Color := ReadyFontColour;
        Sender.Caption := IntToStr(Random(fMaxTime)+1);
        Dec(ButtonsDown);
      end;
    end));
end;

end.
