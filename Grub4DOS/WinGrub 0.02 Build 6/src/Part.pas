unit Part;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls, Menus;

type

  TPartDlg = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    ListBox1: TListBox;
    HeaderControl1: THeaderControl;
    Bevel2: TBevel;
    PopupMenu1: TPopupMenu;
    Reset1: TMenuItem;
    Up1: TMenuItem;
    Top1: TMenuItem;
    Down1: TMenuItem;
    Bottom1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1Key(Sender:TObject);
    procedure HeaderControl1SectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
  private
    { Private declarations }
  public
    procedure SortDisk;
  end;

implementation

uses Utils;

{$R *.DFM}

function GetFSLabel(id:integer):string;
type
 fstab=record id:integer;str:string;end;
const
 ft:array[0..19] of fstab=
 ((id:$E0;str:'VFS'),(id:5;str:'Extended'),(id:$F;str:'ExtendedX'),
 (id:1;str:'FAT12'),(id:4;str:'FAT16'),(id:6;str:'FAT16B'),
 (id:$B;str:'FAT32'),(id:$C;str:'FAT32X'),(id:7;str:'NTFS'),(id:$E;str:'FAT16X'),
 (id:$11;str:'(H)FAT12'),(id:$14;str:'(H)FAT16'),(id:$16;str:'(H)FAT16B'),
 (id:$1B;str:'(H)FAT32'),(id:$1C;str:'(H)FAT32X'),(id:$17;str:'(H)NTFS'),(id:$E;str:'(H)FAT16X'),
 (id:$A5;str:'FreeBSD'),(id:$83;str:'Linux Ext2'),(id:$82;str:'Linux Swap'));
var
 i:integer;
begin
 if id=0 then result:='Free' else
  begin
   result:='Unknown';
   for i:=LOW(ft) to HIGH(ft) do
   if ft[i].id=id then
    begin
     result:=ft[i].str;
     break;
    end;
   result:=result+'('+IntToHex(id,2)+')';
  end;
end;

procedure TPartDlg.FormCreate(Sender: TObject);
begin
 SortDisk;
end;

procedure TPartDlg.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var s:string;
begin
 ListBox1.Canvas.FillRect(Rect);
 with pplst_t(ListBox1.Items.Objects[index])^ do
  begin
   s:=GetPName(pplst_t(ListBox1.Items.Objects[index]));
   DrawText(ListBox1.Canvas.Handle,Pchar(s),length(s),Rect,dt_Left or dt_VCenter);
   Rect.Left:=Rect.Left+HeaderControl1.Sections[0].Width;
   if (ld=0) then s:='-' else s:=char(65+ld);
   DrawText(ListBox1.Canvas.Handle,Pchar(s),length(s),Rect,dt_Left or dt_VCenter);
   Rect.Left:=Rect.Left+HeaderControl1.Sections[1].Width;
   s:=GetFSLabel(fs);
   DrawText(ListBox1.Canvas.Handle,Pchar(s),length(s),Rect,dt_Left or dt_VCenter);
   Rect.Left:=Rect.Left+HeaderControl1.Sections[2].Width;
   Rect.Right:=Rect.Left+HeaderControl1.Sections[3].Width;
   s:=IntToHex(bs,8);
   DrawText(ListBox1.Canvas.Handle,Pchar(s),length(s),Rect,dt_Right or dt_VCenter);
   Rect.Left:=Rect.Right;
   Rect.Right:=ListBox1.ClientWidth;
   s:=IntToStr(ln)+' ('+IntToStr((ln +1024) shr 11)+'M)  ';
   DrawText(ListBox1.Canvas.Handle,Pchar(s),length(s),Rect,dt_Right or dt_VCenter);   
  end;
end;

procedure TPartDlg.SortDisk;
var ds:array [LOW(mp)..HIGH(mp),0..1] of pplst_t; pp,cc:pplst_t; hh:byte; i:integer;
begin
 fillchar(ds,sizeof(ds),0);
 hh:=$FF;
 pp:=nil;
 cc:=ph;
 while (cc<>nil) do
  begin
   if (cc^.hd<>hh) then
    begin
     if (hh<>$FF) then ds[mp[hh],1]:=pp;
     hh:=cc^.hd;
     ds[mp[hh],0]:=cc;
    end;
   pp:=cc;
   cc:=cc.nx;
  end;
 if hh<>$FF then ds[mp[hh],1]:=pp;
 pp:=nil;
 for i:=LOW(mp) to HIGH(mp) do
  if ds[i,0]<>nil then
   begin
    if pp=nil then ph:=ds[i,0] else pp.nx:=ds[i,0];
    pp:=ds[i,1];
   end;
 if pp<>nil then pp.nx:=nil;
 ListBox1.Clear;
 cc:=ph;
 while cc<>nil do
  begin
   ListBox1.Items.AddObject('',TObject(cc));
   cc:=cc.nx;
  end;
end;

procedure TPartDlg.ListBox1Key(Sender: TObject);
var
 key:Word; shift:TShiftState;
 pl:pplst_t; i,j,t:integer; tt:array [LOW(mp)..HIGH(mp)] of integer; s:string;
begin
 ShortCutToKey(TMenuItem(sender).ShortCut,key,shift);
 if (ListBox1.ItemIndex=-1) or (Key<>Ord('U')) and (Key<>Ord('D')) and (Key<>Ord('T')) and (Key<>Ord('B')) and (Key<>Ord('R')) then exit;
 pl:=pplst_t(ListBox1.Items.Objects[ListBox1.ItemIndex]);
 if (Key=Ord('R')) then
  begin
   for i:=LOW(mp) to HIGH(mp) do mp[i]:=i;
  end else
  begin
   if (mp[pl.hd]=LOW(mp)) and ((Key=Ord('P')) or (Key=Ord('T'))) or
      (mp[pl.hd]=HIGH(mp)) and ((Key=Ord('N')) or (Key=Ord('B'))) then exit;
   for i:=LOW(mp) to HIGH(mp) do tt[mp[i]]:=i;
   j:=mp[pl.hd];
   t:=tt[j];
   if (Key=Ord('U')) then begin tt[j]:=tt[j-1]; tt[j-1]:=t; end else
   if (Key=Ord('D')) then begin tt[j]:=tt[j+1]; tt[j+1]:=t; end else
   if (Key=Ord('T')) then
    begin
     for i:=j-1 downto LOW(mp) do tt[i+1]:=tt[i];
     tt[LOW(mp)]:=t;
    end else
   if (Key=Ord('B')) then
    begin
     for i:=j+1 to HIGH(mp) do tt[i-1]:=tt[i];
     tt[HIGH(mp)]:=t;
    end;
   for i:=LOW(mp) to HIGH(mp) do mp[tt[i]]:=i;
  end;
 s:='';
 for i:=LOW(mp) to HIGH(mp) do s:=s+chr(ord('0')+mp[i]);
 SaveParm('DiskMaps',s);
 ListBox1.Items.BeginUpdate;
 SortDisk();
 for i:=0 to ListBox1.Items.Count-1 do
 if pl=pplst_t(ListBox1.Items.Objects[i]) then
  begin
   ListBox1.ItemIndex:=i;
   break;
  end;
 ListBox1.Items.EndUpdate;
end;

procedure TPartDlg.HeaderControl1SectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
 ListBox1.Invalidate;
end;

end.
