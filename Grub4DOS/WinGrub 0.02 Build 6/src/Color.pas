unit Color;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ColorGrd;

type
  TColorDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ColorGrid1: TColorGrid;
    Panel1: TPanel;
    procedure ColorGrid1Change(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ChooseColor(var fg,bg:integer):boolean;
procedure SetPanelColor(pn:TPanel;fg,bg:integer);
procedure SetPanelColor1(pn:TPanel;fg,bg:TColor);

implementation

uses Utils;

{$R *.DFM}

function ChooseColor(var fg,bg:integer):boolean;
var ColorDlg:TColorDlg;
begin
 ColorDlg:=TColorDlg.Create(nil);
 ColorDlg.ColorGrid1.ForegroundIndex:=fg;
 ColorDlg.ColorGrid1.BackgroundIndex:=bg;
 ColorDlg.ColorGrid1Change(nil);
 if ColorDlg.ShowModal=mrOK then
  begin
   fg:=ColorDlg.ColorGrid1.ForegroundIndex;
   bg:=ColorDlg.ColorGrid1.BackgroundIndex and 7;
   result:=true;
  end else result:=false;
 ColorDlg.Release;
end;

function GetColor(n:integer):TColor;
begin
 case n of
  0:result:=clBlack;
  1:result:=clMaroon;
  2:result:=clGreen;
  3:result:=clOlive;
  4:result:=clNavy;
  5:result:=clPurple;
  6:result:=clTeal;
  7:result:=clSilver;
  8:result:=clGray;
  9:result:=clRed;
  10:result:=clLime;
  11:result:=clYellow;
  12:result:=clBlue;
  13:result:=clFuchsia;
  14:result:=clAqua;
  15:result:=clWhite;
 else
  result:=0;
 end;
end;

procedure SetPanelColor(pn:TPanel;fg,bg:integer);
begin
 pn.Color:=GetColor(bg);
 pn.Font.Color:=GetColor(fg);
end;

procedure SetPanelColor1(pn:TPanel;fg,bg:TColor);
begin
 pn.Color:=bg;
 pn.Font.Color:=fg;
end;

procedure TColorDlg.ColorGrid1Change(Sender: TObject);
begin
 SetPanelColor(Panel1,ColorGrid1.ForegroundIndex,ColorGrid1.BackgroundIndex and 7);
end;

procedure TColorDlg.OKBtnClick(Sender: TObject);
begin
 if ColorGrid1.ForegroundIndex=ColorGrid1.BackgroundIndex and 7 then
  ShowErr('Foregroud equals backgroud') else ModalResult:=mrOK;
end;

end.
