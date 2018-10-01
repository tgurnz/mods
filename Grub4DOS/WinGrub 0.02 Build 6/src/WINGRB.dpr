program WINGRB;

uses
  Forms,
  Utils in 'Utils.pas',
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutDlg},
  Color in 'Color.pas' {ColorDlg},
  Edit in 'Edit.pas' {EditDlg},
  Base in 'Base.pas' {BaseDlg},
  Part in 'Part.pas' {PartDlg},
  Inst in 'Inst.pas' {InstDlg},
  Grub in 'Grub.pas' {GrubDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
