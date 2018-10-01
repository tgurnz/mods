unit Grub;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Menus, Dialogs;

type
  TGrubDlg = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label4: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Export1: TMenuItem;
    Delete1: TMenuItem;
    Output1: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    Import1: TMenuItem;
    Delete2: TMenuItem;
    Output2: TMenuItem;
    Nostage2: TMenuItem;
    Nostage1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Move1: TMenuItem;
    Default1: TMenuItem;
    Move2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1Key(Sender:TObject);
    procedure ListBox2Key(Sender:TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    fn:string;
    procedure SetMenuState(bb:boolean);
  public
  end;

implementation

{$R *.DFM}
uses Utils,IniFiles;

const
 FG_SRC         = 1;
 FG_DST         = 2;
 FG_NST         = 4;

function CopyGrubList(key,src,dst:string;flg:integer):boolean;

function GetName(fn:string;bb:integer):string;
begin
 if bb<>0 then
  begin
   if lowercase(fn)='grub.exe' then result:='grexe' else result:=fn;
   result:=result+'_'+key;
  end else
 if lowercase(fn)='grexe' then result:='GRUB.EXE' else result:=fn;
end;

procedure CpyFile(fn:string);
var s,d:string;
begin
 if fn='' then exit;
 s:=GetName(fn,flg and FG_SRC);
 if dst='' then DeleteFile(src+s) else
  begin
   d:=GetName(fn,flg and FG_DST);
   CopyFile(pchar(src+s),pchar(dst+d),true);
  end;
end;

procedure FndFile(fn:string);
var f:TSearchRec; s:string;
begin
 if FindFirst(src+GetName(fn,flg and FG_SRC),0,f)=0 then
  begin
   repeat
    if f.Attr and faDirectory=0 then
     begin
      if flg and FG_SRC<>0 then s:=copy(f.Name,1,length(f.name)-length(key)-1) else s:=f.name;
      CpyFile(s);
     end;
   until FindNext(f)<>0;
   FindClose(f);
  end;
end;

begin
 result:=false;
 if key='' then ShowErr('Key can''t be empty') else
 if src=dst then ShowErr('Source and destination must be different') else
  begin
   FndFile('gr*');
   FndFile('*grub.');
   if flg and FG_NST=0 then FndFile('*stage*');
   result:=true;
  end;
end;

procedure TGrubDlg.FormCreate(Sender: TObject);
var ini:TIniFile;
begin
 ini:=TIniFile.Create(ap+'WINGRB.INI');
 ini.ReadSectionValues('GrubList',ListBox1.Items);
 ini.Free;
 SetMenuState(false);
end;

procedure TGrubDlg.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var k,v:string; lb:TListBox;
begin
 lb:=TListBox(Control);
 lb.Canvas.FillRect(Rect);
 v:=lb.Items[index];
 k:=popstr(v,'=');
 if (lb=ListBox1) and (k=cg) then v:='<'+v+'>';
 DrawText(lb.Canvas.Handle,Pchar(v),length(v),Rect,dt_Left or dt_VCenter);
end;

procedure TGrubDlg.ListBox1Key(Sender: TObject);
var
 key:Word; shift:TShiftState; i,fg:integer; s,v:string; ini:TIniFile;
begin
 ShortCutToKey(TMenuItem(sender).ShortCut,key,shift);
 if NoStage1.Checked then fg:=FG_NST else fg:=0;
 if (key=ord('M')) or (key=ord('E')) then
  begin
   if ListBox1.SelCount=0 then
    begin
     ShowErr('No item selected');
     exit;
    end;
   ListBox2.Items.BeginUpdate;
   for i:=0 to ListBox1.Items.Count-1 do
    if ListBox1.Selected[i] then
     begin
      v:=ListBox1.Items[i];
      s:=popstr(v,'=');
      if CopyGrubList(s,ap+'grub\',ExtractFilePath(fn),fg or FG_SRC or FG_DST) then
       ListBox2.Items.Values[s]:=v else break;
     end;
   ListBox2.Items.EndUpdate;
   ListBox2.Items.SaveToFile(fn);
  end;
 if (key=ord('M')) or (key=VK_DELETE) then
  begin
   if ListBox1.SelCount=0 then
    begin
     ShowErr('No item selected');
     exit;
    end;
   if ListBox1.SelCount=ListBox1.Items.Count then
    begin
     ShowErr('You can''t delete all items');
     exit;
    end;
   if not confirm('Do you really want to delete them') then exit;
   ini:=TIniFile.Create(ap+'WINGRB.INI');
   ListBox1.Items.BeginUpdate;
   for i:=ListBox1.Items.Count-1 downto 0 do
    if ListBox1.Selected[i] then
     begin
      v:=ListBox1.Items[i];
      s:=popstr(v,'=');
      if s=cg then cg:='';
      if CopyGrubList(s,ap+'grub\','',FG_SRC) then
       begin
        ListBox1.Items.Delete(i);
        ini.DeleteKey('GrubList',s);
       end else break;
     end;
   if (cg='') and (ListBox1.Items.Count<>0) then
    begin
     cg:=ListBox1.Items.Names[0];
     SaveParm('CurrGrub',cg);
    end;
   ListBox1.Items.EndUpdate;
   ini.Free;
  end;
 if key=VK_SPACE then
  begin
   if ListBox1.SelCount<>1 then ShowErr('No item or more than one item selected') else
    begin
     v:=ListBox1.Items[ListBox1.ItemIndex];
     cg:=popstr(v,'=');
     SaveParm('CurrGrub',cg);
     ListBox1.Invalidate;
    end;
  end else
 if key=ord('P') then
  begin
   if ListBox1.SelCount<>1 then ShowErr('No item or more than one item selected') else
    begin
     s:=BrowseFolder;
     v:=ListBox1.Items[ListBox1.ItemIndex];
     if s<>'' then CopyGrubList(popstr(v,'='),ap+'grub\',s,fg or FG_SRC);
    end;
  end else
 if key=ord('N') then NoStage1.Checked:=not NoStage1.Checked;
end;

procedure TGrubDlg.ListBox2Key(Sender: TObject);
var
 key:Word; shift:TShiftState; s,v:string; i,fg:integer; ini:TIniFile;
begin
 ShortCutToKey(TMenuItem(sender).ShortCut,key,shift);
 if NoStage2.Checked then fg:=FG_NST else fg:=0;
 if (key=ord('M')) or (key=ord('I')) then
  begin
   if ListBox2.SelCount=0 then
    begin
     ShowErr('No item selected');
     exit;
    end;
   ini:=TIniFile.Create(ap+'WINGRB.INI');
   ListBox1.Items.BeginUpdate;
   for i:=0 to ListBox2.Items.Count-1 do
    if ListBox2.Selected[i] then
     begin
      v:=ListBox2.Items[i];
      s:=popstr(v,'=');
      if CopyGrubList(s,ExtractFilePath(fn),ap+'grub\',fg or FG_SRC or FG_DST) then
       begin
        ListBox1.Items.Values[s]:=v;
        ini.WriteString('GrubList',s,v);
       end else break;
     end;
   ListBox1.Items.EndUpdate;
  ini.Free;
  end;
 if (key=ord('M')) or (key=VK_DELETE) then
  begin
   if ListBox2.SelCount=0 then
    begin
     ShowErr('No item selected');
     exit;
    end;
   if not confirm('Do you really want to delete them') then exit;
   ListBox2.Items.BeginUpdate;
   for i:=ListBox2.Items.Count-1 downto 0 do
    if ListBox2.Selected[i] then
     begin
      v:=ListBox2.Items[i];
      s:=popstr(v,'=');
      if CopyGrubList(s,ExtractFilePath(fn),'',FG_SRC) then ListBox2.Items.Delete(i) else break;
     end;
   ListBox2.Items.EndUpdate;
   ListBox2.Items.SaveToFile(fn);
  end;
 if key=ord('O') then
  begin
   if OpenDialog1.Execute then
    begin
     fn:=OpenDialog1.FileName;
     if FileExists(fn) then ListBox2.Items.LoadFromFile(fn)
      else ListBox2.Clear;
     SetMenuState(true);
    end;
  end else
 if key=ord('C') then
  begin
   fn:='';
   ListBox2.Clear;
   SetMenuState(false);
  end else
 if key=ord('P') then
  begin
   if ListBox2.SelCount<>1 then ShowErr('No item or more than one item selected') else
    begin
     s:=BrowseFolder;
     v:=ListBox2.Items[ListBox2.ItemIndex];
     if s<>'' then CopyGrubList(popstr(v,'='),ExtractFilePath(fn),s,fg or FG_SRC);
    end;
  end else
 if key=ord('N') then NoStage2.Checked:=not NoStage2.Checked;
end;

procedure TGrubDlg.SetMenuState(bb: boolean);
var i:integer;
begin
 Export1.Enabled:=bb;
 Move1.Enabled:=bb;
 for i:=1 to PopupMenu2.Items.Count-1 do
  PopupMenu2.Items[i].Enabled:=bb;
 Button2.Enabled:=bb;
end;

procedure TGrubDlg.SpeedButton1Click(Sender: TObject);
var s:string;
begin
 s:=BrowseFolder();
 if s<>'' then Edit3.Text:=s;
end;

procedure TGrubDlg.Button1Click(Sender: TObject);
var s:string; ini:TIniFile; fg:integer;
begin
 if (Edit1.Text='') or (Edit3.Text='') then
  begin
   ShowErr('Key or directory not specified');
   exit;
  end;
 s:=Edit2.Text;
 if s='' then s:=Edit1.Text;
 if CheckBox1.Checked then fg:=FG_NST else fg:=0;
 if CopyGrubList(Edit1.Text,Edit3.Text,ap+'grub\',fg or FG_DST) then
  begin
   ini:=TIniFile.Create(ap+'WINGRB.INI');
   ListBox1.Items.Values[Edit1.Text]:=s;
   ini.WriteString('GrubList',Edit1.Text,s);
   ini.Free;
  end;
end;

procedure TGrubDlg.Button2Click(Sender: TObject);
var s:string; fg:integer;
begin
 if (Edit1.Text='') or (Edit3.Text='') then
  begin
   ShowErr('Key or directory not specified');
   exit;
  end;
 s:=Edit2.Text;
 if s='' then s:=Edit1.Text;
 if CheckBox1.Checked then fg:=FG_NST else fg:=0;
 if CopyGrubList(Edit1.Text,Edit3.Text,ExtractFilePath(fn),fg or FG_DST) then
  begin
   ListBox2.Items.Values[Edit1.Text]:=s;
   ListBox2.Items.SaveToFile(fn);
  end;
end;

procedure TGrubDlg.Button3Click(Sender: TObject);
var s:string; fg:integer;
begin
 if (Edit3.Text='') then
  begin
   ShowErr('Directory not specified');
   exit;
  end;
 s:=BrowseFolder();
 if CheckBox1.Checked then fg:=FG_NST else fg:=0;
 CopyGrubList('key',Edit3.Text,s,fg);
end;

end.
