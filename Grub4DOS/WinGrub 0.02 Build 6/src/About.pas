unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TAboutDlg = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Label6Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Utils;

{$R *.DFM}

const
 VER_MAJOR      = 0;
 VER_MINOR      = 2;
 VER_BUILD      = 6;

procedure TAboutDlg.Label6Click(Sender: TObject);
begin
 ShellExec('mailto://'+Label6.Caption,'',SEF_SAPP);
end;

procedure TAboutDlg.Label8Click(Sender: TObject);
begin
 ShellExec(Label8.Caption,'',SEF_SAPP);
end;

procedure TAboutDlg.FormCreate(Sender: TObject);
begin
 Label2.Caption:=Format('%d.%.2d Build %d',[VER_MAJOR,VER_MINOR,VER_BUILD]);
end;

end.
