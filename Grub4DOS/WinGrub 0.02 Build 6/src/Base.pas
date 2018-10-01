unit Base;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, FileCtrl;

type
  TBaseDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ListBox1: TListBox;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1DblClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    cd,nd:integer;
  end;

implementation

uses Utils,ShellAPI, Main;

{$R *.DFM}

{
procedure TBdirDlg.OKBtnClick(Sender: TObject);
var fop:TSHFileOpStruct; src,dst:string;
begin
 if (nd=-1) and (cd=-1) then
 if ListBox1.ItemIndex<>-1 then nd:=integer(ListBox1.Items.Objects[ListBox1.ItemIndex]) else
  begin
   ShowErr('Please choose a default drive');
   exit;
  end;
 if (nd<>-1) or (cd<>-1) and CheckBox1.Checked then
  begin
   with fop do
    begin
     Wnd:=self.handle;
     wFunc:=FO_COPY;
     if (cd=-1) or CheckBox1.Checked then src:=ap+'grub\*.*'+#0 else src:=char(65+cd)+':\boot\grub\*.*'+#0;
     if (nd<>-1) then dst:=char(65+nd)+':\boot\grub'+#0 else dst:=char(65+cd)+':\boot\grub'+#0;
     ForceDirectories(dst);
     pFrom:=Pchar(src);
     pTo:=Pchar(dst);
     fFlags:=FOF_NOCONFIRMATION;
    end;
   if (ShFileOperation(fop)=0) then
    begin
     if (cd=-1) then CopyFile(pchar(ap+'default.lst'),pchar(char(65+nd)+':\boot\grub\menu.lst'),false) else
     if (nd<>-1) and CheckBox1.Checked then
      CopyFile(pchar(char(65+cd)+':\boot\grub\menu.lst'),pchar(char(65+nd)+':\boot\grub\menu.lst'),false);
     if (cd=-1) or (nd=-1) then dst:='' else dst:=char(65+cd)+':\boot\grub'+#0;
     if nd<>-1 then
      begin
       with MainForm do
        if Uppercase(ExtractFilePath(fn))=char(65+cd)+':\BOOT\GRUB\' then
         setcfn(char(65+nd)+':\boot\grub\'+copy(fn,14,length(fn)));
       cd:=nd;
       lp:=char(65+cd)+':\boot\grub\';
      end;
    end;
   if dst<>'' then
    begin
     with fop do
      begin
       Wnd:=self.handle;
       wFunc:=FO_DELETE;
       pFrom:=Pchar(dst);
       pTo:=nil;
       fFlags:=FOF_NOCONFIRMATION;
      end;
     ShFileOperation(fop);
     RemoveDir(copy(dst,1,7));
    end;
  end;
 if cd=-1 then exit;
 nd:=cd;
 if CheckBox2.Checked and (ComboBox1.ItemIndex<>-1) then
  nd:=integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
 if RadioButton2.Checked then
  begin
   CopyFile(Pchar(ap+'GRLDR'),Pchar(char(65+nd)+':\GRLDR'),false);
   CopyFile(Pchar(ap+'GRUB.EXE'),Pchar(char(65+nd)+':\GRUB.EXE'),false);
   if (nd<>2) then CopyFile(Pchar(ap+'GRLDR'),Pchar('C:\GRLDR'),false);
  end;
 ModalResult:=mrOK;
end;
}

procedure TBaseDlg.FormCreate(Sender: TObject);
var
 dn:array [0..3] of char;
 c:char;
 t:dword;
 fa,ts,fs:int64;
 s:string;
begin
 cd:=-1;
 nd:=-1;
 if (lp<>'') then cd:=ord(lp[1])-65;
 if cd=-1 then CheckBox2.Checked:=false;
 StrCopy(dn,'A:\');
 for c:='C' to 'Z' do
  begin
   dn[0]:=c;
   t:=GetDriveType(@dn);
   if (t=DRIVE_FIXED) or (t=DRIVE_REMOVABLE) then
    begin
     GetDiskFreeSpaceEx(@dn,fa,ts,@fs);
     s:=c+' - Free : '+IntToStr((fs+1024*512) shr 20)+'M , Total : '+IntToStr((ts+1024*512) shr 20)+'M';
     ListBox1.Items.AddObject(s,TObject(ord(c)-65));
    end;
  end;
end;

procedure TBaseDlg.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var d:integer; s:string;
begin
 ListBox1.Canvas.FillRect(Rect);
 s:=ListBox1.Items[index];
 d:=integer(ListBox1.Items.Objects[index]);
 if d=cd then s:=s+' (Cur)' else
 if d=nd then s:=s+' (New)';
 DrawText(ListBox1.Canvas.Handle,Pchar(s),length(s),Rect,dt_Left or dt_VCenter);
end;

procedure TBaseDlg.ListBox1DblClick(Sender: TObject);
begin
 if ListBox1.ItemIndex=-1 then ShowErr('No item is selected') else
  begin
   nd:=integer(ListBox1.Items.Objects[ListBox1.ItemIndex]);
   if nd=cd then nd:=-1;
   ListBox1.Invalidate;
  end;
end;

procedure TBaseDlg.OKBtnClick(Sender: TObject);
var fop:TSHFileOpStruct; s:string; i:integer; f:TSearchRec;
begin
 if (nd=-1) and (cd=-1) then
 if ListBox1.ItemIndex<>-1 then nd:=integer(ListBox1.Items.Objects[ListBox1.ItemIndex]) else
  begin
   ShowErr('Please choose a default drive');
   exit;
  end;
 if (nd<>-1) then
  begin
   if (cd<>-1) then
    begin
     s:=lowercase(copy(lp,1,length(lp)-1));
     if (s<>char(ord('a')+cd)+':\boot\grub') and (s<>char(ord('a')+cd)+':\grub') then ShowErr('Current base directory is neither \boot\grub nor \grub') else
      begin
       with fop do
        begin
         Wnd:=self.handle;
         if CheckBox2.Checked then wFunc:=FO_COPY else wFunc:=FO_MOVE;
         pFrom:=Pchar(s+#0);
         if DirectoryExists(chr(65+nd)+':\boot\grub') then pTo:=pchar(chr(65+nd)+':\boot'+#0) else
          pTo:=pchar(chr(65+nd)+':\'+#0);
         fFlags:=FOF_NOCONFIRMATION;
        end;
       if ShFileOperation(fop)<>0 then exit;
       if (CheckBox2.Checked) then
        begin
         for i:=0 to $FFF do
          if not FileExists(s+'.'+IntToHex(i,3)) and not DirectoryExists(s+'.'+IntToHex(i,3))
              and MoveFile(Pchar(s),Pchar(s+'.'+IntToHex(i,3))) then break;
          if (i>$FFF) then ShowErr('Too many backup copies');
        end else
       if (s=char(ord('a')+cd)+':\boot\grub') then RemoveDir(char(ord('a')+cd)+':\boot');
      end;
    end else
    begin
     CreateDir(chr(65+nd)+':\Grub');
     CopyFile(pchar(ap+'prof\DEFAULT.LST'),pchar(chr(65+nd)+':\Grub\MENU.LST'),true);
    end;
   cd:=nd;
   lp:=char(65+cd)+':\Grub\';
   ModalResult:=mrOK;
  end else ModalResult:=mrCancel;
  {
  if CheckBox1.Checked and DirectoryExists(ap+'stages') then
   begin
    with fop do
     begin
      Wnd:=self.handle;
      wFunc:=FO_COPY;
      pFrom:=Pchar(ap+'stages\*.*'+#0);
      pTo:=Pchar(char(65+cd)+':\Grub'+#0);
      fFlags:=FOF_NOCONFIRMATION;
     end;
    ShFileOperation(fop);
   end;
  }
  if CheckBox1.Checked then
   begin
    CopyGrubFile('stage2',lp);
    s:=FindGrubFile('stage1');
    if s<>'' then
     begin
      CopyFile(pchar(ap+'grub\'+s),pchar(lp+'stage1'),true);
      s:=copy(s,7,length(s)-6);
      if FindFirst(ap+'grub\*stage1_5'+s,0,f)=0 then
        begin
         repeat
          if f.Attr and faDirectory=0 then
           CopyFile(pchar(ap+'grub\'+f.Name),pchar(lp+copy(f.name,1,length(f.name)-length(s))),true);
         until FindNext(f)<>0;
         FindClose(f);
        end;
     end;
   end;
end;

end.
