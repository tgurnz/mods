unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, XDIO32,
  Menus, StdCtrls, ExtCtrls, Buttons,  FileCtrl;

type
  mitem=record
   title:string;
   value:string;
  end;

  pitem=^mitem;

  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Tools1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    BootDirectory1: TMenuItem;
    InstallGrub1: TMenuItem;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    ListBox1: TListBox;
    Edit2: TEdit;
    Label5: TLabel;
    ListBox2: TListBox;
    Label7: TLabel;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel3: TPanel;
    ColorDialog1: TColorDialog;
    ComboBox2: TComboBox;
    OpenDialog2: TOpenDialog;
    Label9: TLabel;
    SpeedButton4: TSpeedButton;
    PartitionList1: TMenuItem;
    Label4: TLabel;
    Edit3: TEdit;
    CheckBox2: TCheckBox;
    Label6: TLabel;
    Edit4: TEdit;
    SpeedButton5: TSpeedButton;
    GrubFiles1: TMenuItem;
    SpeedButton6: TSpeedButton;
    ReadPresetMenu1: TMenuItem;
    Save2: TMenuItem;
    PopupMenu1: TPopupMenu;
    Insert1: TMenuItem;
    Clone1: TMenuItem;
    Delete1: TMenuItem;
    SetDefault1: TMenuItem;
    Edit5: TMenuItem;
    Previous1: TMenuItem;
    Next1: TMenuItem;
    Top1: TMenuItem;
    Bottom1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Delete2: TMenuItem;
    Edit6: TMenuItem;
    Save3: TMenuItem;
    Reset1: TMenuItem;
    OpenDialog3: TOpenDialog;
    SaveDialog2: TSaveDialog;
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Panel3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1Key(Sender:TObject);
    procedure ListBox2Key(Sender:TObject);
    procedure PartitionList1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure InstallGrub1Click(Sender: TObject);
    procedure BootDirectory1Click(Sender: TObject);
    procedure GrubFiles1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ReadPresetMenu1Click(Sender: TObject);
    procedure Save2Click(Sender: TObject);
  private
    { Private declarations }
  public
    fg1,bg1,fg2,bg2,df:integer;
    fg3,bg3:TColor;
    fn,ex,pw,fp:string;
    procedure clrlst;
    procedure clrcfs;
    procedure setcfn(n:string);
    procedure getcfg(n:string);
    procedure setcfg(n:string);
    procedure getcfs(s:string);
    function setcfs:string;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses About, Color, Utils, Inst, Base, Part, Grub , md5;

const
 b64t='./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

function md5_password(key,crypted:pchar;check:boolean):boolean;
var
 salt,p,e:pchar;
 keylen,saltlen,i,n:integer;
 digest,alt_result:MD5_DIGEST;
 ctx:MD5_CTX;
 w:longword;
begin
 result:=false;
 keylen:=strlen(key);
 salt:=crypted + 3; { skip $1$ header }
 if (check) then
  begin
   { If our crypted password isn't 3 chars, then it can't be md5
     crypted. So, they don't match. }
   if (strlen(crypted) <= 3) then exit;
   e:=strpos (salt, '$');
   if e=nil then exit;
   saltlen:=e - salt;
  end else
  begin
   e:= strpos (salt, '$');
   if (e<>nil) and (e - salt < 8) then saltlen:= e - salt else saltlen:= 8;
   salt[saltlen]:= '$';
  end;
 md5_init(ctx);
 md5_update(ctx,key,keylen);
 md5_update(ctx,salt,saltlen);
 md5_update(ctx,key,keylen);
 md5_final (ctx,digest);
 move(digest,alt_result,16);
 md5_init(ctx);
 md5_update(ctx,key,keylen);
 md5_update(ctx,crypted,3 + saltlen); { include the $1$ header }
 i:=keylen;
 while (i>16) do
  begin
   md5_update (ctx,@alt_result,16);
   dec(i,16);
  end;
 md5_update(ctx,@alt_result,i);
 i:=keylen;
 while (i>0) do
  begin
   if (i and 1<>0) then md5_update(ctx,key+keylen,1) else md5_update(ctx,key,1);
   i:=i shr 1;
  end;
 md5_final(ctx,digest);
 for i:= 0 to 999 do
  begin
   move(digest,alt_result,16);
   md5_init(ctx);
   if (i and 1<>0) then	md5_update(ctx,key,keylen) else md5_update(ctx,@alt_result,16);
   if (i mod 3<>0) then	md5_update(ctx,salt,saltlen);
   if (i mod 7<>0) then	md5_update(ctx,key,keylen);
   if (i and 1<>0) then	md5_update(ctx,@alt_result,16) else md5_update(ctx,key,keylen);
   md5_final(ctx,digest);
  end;
 p:=salt+saltlen+1;
 for i:=0 to 4 do
  begin
   if (i=4) then w:=longword(digest[5]) or (longword(digest[6+i]) shl 8) or (longword(digest[i]) shl 16) else
    w:=longword(digest[12+i]) or (longword(digest[6+i]) shl 8) or (longword(digest[i]) shl 16);
   for n:=4 downto 1 do
    begin
     if (check) then
      begin
        if (p^<> b64t[(w and $3f)+1]) then exit;
      end else
      begin
       p^:=b64t[(w and $3f)+1];
      end;
      inc(p);
      w:=w shr 6;
     end;
  end;
 w:=digest[11];
 for n:=2 downto 1 do
  begin
   if (check) then
    begin
     if (p^<> b64t[(w and $3f)+1]) then exit;
    end	else
    begin
     p^:= b64t[(w and $3f)+1];
    end;
   inc(p);
   w:=w shr 6;
  end;
 if (not check) then p^:=#0;
 result:=(p^=#0);
end;

function md5_ckpwd(input,crypt:string):boolean;
begin
 result:=md5_password(pchar(input),pchar(crypt),true);
end;

function md5_mkpwd(key:string):string;
var
 crypted:array[0..35] of char;
 i:integer;
begin
 { First create a salt.  }

  { The magical prefix.  }
  fillchar(crypted,sizeof(crypted),0);
  strcopy(crypted,'$1$');

  {// Create the length of a salt.
  seed = currticks ();

   // Generate a salt.
  for (i = 0; i < 8 && seed; i++)
   begin
      /* FIXME: This should be more random.  */
      crypted[3 + i] = seedchars[seed & 0x3f];
      seed >>= 6;
   end;}
  for i:=0 to 7 do
   crypted[3+i]:=b64t[random($3F)+1];

  // A salt must be terminated with `$', if it is less than 8 chars.
  crypted[3+8]:= '$';
  md5_password (pchar(key),crypted,false);
  result:=string(crypted);
end;

procedure TMainForm.SpeedButton4Click(Sender: TObject);
var s:string; i:integer;
begin
 if OpenDialog2.Execute then
  begin
   s:=ExtractFileName(OpenDialog2.FileName);
   i:=pos('.',s);
   if (i>1) then s:=Copy(s,1,i-1);
   for i:=0 to ComboBox2.Items.Count-1 do
    if Lowercase(ComboBox2.Items[i])=Lowercase(s) then
     begin
      ComboBox2.ItemIndex:=i;
      exit;
     end;
   CopyFile(pchar(OpenDialog2.FileName),pchar(ap+'logo\'+s+'.xpm.gz'),true);
   ComboBox2.ItemIndex:=ComboBox2.Items.Add(s);
  end;
end;

procedure TMainForm.About1Click(Sender: TObject);
var AD:TAboutDlg;
begin
 AD:=TAboutDlg.Create(self);
 AD.ShowModal;
 AD.Release;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.New1Click(Sender: TObject);
begin
 clrcfs;
 setcfn('');
end;

procedure TMainForm.Panel1Click(Sender: TObject);
begin
 if ChooseColor(fg1,bg1) then SetPanelColor(Panel1,fg1,bg1);
end;

procedure TMainForm.Panel2Click(Sender: TObject);
begin
 if ChooseColor(fg2,bg2) then SetPanelColor(Panel2,fg2,bg2);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var f:TSearchRec; c:char;
begin
 Randomize;
 fn:=ReadParm('CurrFile');
 if fn<>'' then
  begin
   lp:=ExtractFilePath(fn);
   if not DirectoryExists(lp) then
    begin
     lp:='';
     fn:='';
    end;
  end;
 if lp='' then
  begin
   for c:='C' to 'Z' do
    if DirectoryExists(c+':\boot\grub') then
     begin
      lp:=c+':\boot\grub\';
      break;
     end;
   if lp='' then
   for c:='C' to 'Z' do
    if DirectoryExists(c+':\grub') then
     begin
      lp:=c+':\grub\';
      break;
     end;
  end;
 if lp='' then BootDirectory1Click(nil);
 if lp='' then New1Click(nil) else
  begin
   if fn='' then fn:=lp+'menu.lst';
   setcfn(fn);
   getcfg(fn);
  end;
 if FindFirst(ap+'prof\*.LST',0,f)=0 then
  begin
   repeat
    if Length(f.Name)>4 then ComboBox1.Items.Add(Copy(f.Name,1,Length(f.Name)-4));
   until FindNext(f)<>0;
   FindClose(f);
  end;
 if FindFirst(ap+'logo\*.xpm.gz',0,f)=0 then
  begin
   repeat
    if Length(f.Name)>7 then ComboBox2.Items.Add(Copy(f.Name,1,Length(f.Name)-7));
   until FindNext(f)<>0;
   FindClose(f);
  end;
 OpenDialog2.InitialDir:=ap+'logo';
 OpenDialog3.InitialDir:=ap+'grub';
 SaveDialog2.InitialDir:=ap+'grub';
end;

procedure TMainForm.setcfn(n:string);
begin
 fn:=n;
 if n='' then Caption:='WinGrub' else
  begin
   Caption:='WinGrub - '+fn;
   lp:=ExtractFilePath(n);
   SaveParm('CurrFile',n);
   OpenDialog1.InitialDir:=lp;
   SaveDialog1.InitialDir:=lp;
  end;
end;

procedure TMainForm.getcfg(n: string);
begin
 getcfs(ReadString(n));
end;

procedure TMainForm.setcfg(n: string);
begin
 SaveString(n,setcfs);
 if (ComboBox2.Text<>'') and (pos('/',ComboBox2.Text)=0) then
  CopyFile(pchar(ap+'logo\'+ComboBox2.Text+'.xpm.gz'),pchar(ExtractFilePath(n)+ComboBox2.Text+'.xpm.gz'),false);
 if CheckBox1.Checked and (fp='') then
  CopyFile(pchar(ap+'fonts'),pchar(ExtractFilePath(n)+'fonts'),false);
end;

function clr2int(s:string):integer;
begin
 if s='black' then result:=0 else
 if s='red' then result:=1 else
 if s='green' then result:=2 else
 if s='brown' then result:=3 else
 if s='blue' then result:=4 else
 if s='magenta' then result:=5 else
 if s='cyan' then result:=6 else
 if s='light-gray' then result:=7 else
 if s='dark-gray' then result:=8 else
 if s='light-red' then result:=9 else
 if s='light-green' then result:=10 else
 if s='yellow' then result:=11 else
 if s='light-blue' then result:=12 else
 if s='light-magenta' then result:=13 else
 if s='light-cyan' then result:=14 else
 if s='white' then result:=15 else result:=-1;
end;

function int2clr(c:integer):string;
begin
 if c=0 then result:='black' else
 if c=1 then result:='red' else
 if c=2 then result:='green' else
 if c=3 then result:='brown' else
 if c=4 then result:='blue' else
 if c=5 then result:='magenta' else
 if c=6 then result:='cyan' else
 if c=7 then result:='light-gray' else
 if c=8 then result:='dark-gray' else
 if c=9 then result:='light-red' else
 if c=10 then result:='light-green' else
 if c=11 then result:='yellow' else
 if c=12 then result:='light-blue' else
 if c=13 then result:='light-magenta' else
 if c=14 then result:='light-cyan' else
 if c=15 then result:='white' else result:='';
end;

procedure TMainForm.clrcfs;
begin
 df:=-1;
 ex:='';
 pw:='';
 fp:='';
 fg1:=7;
 bg1:=0;
 fg2:=0;
 bg2:=7;
 fg3:=clWhite;
 bg3:=clBlack;
 SetPanelColor(Panel1,fg1,bg1);
 SetPanelColor(Panel2,fg2,bg2);
 SetPanelColor1(Panel3,fg3,bg3);
 Edit1.Text:='';
 CheckBox1.Checked:=false;
 CheckBox2.Checked:=false;
 ComboBox2.Text:='';
 clrlst;
end;

procedure TMainForm.getcfs(s: string);
var sl:TStringList; i:integer; p:pitem; c,v:string;

{
procedure getcmd(s:string);
var i:integer;
begin
 i:=pos(' ',s);
 if i=0 then begin c:=s; v:=''; end else begin c:=copy(s,1,i-1); v:=copy(s,i+1,length(s)-i); end;
 c:=trim(lowercase(c));
 v:=trim(v);
end;
}

procedure getclr;
var i:integer; f1,b1,f2,b2:integer;
begin
 if v='' then exit;
 c:=lowercase(popstr(v,' '));
 i:=pos('/',c);
 if i=0 then exit;
 f1:=clr2int(copy(c,1,i-1));
 b1:=clr2int(copy(c,i+1,length(c)-i));
 if (f1=-1) or (b1=-1) then exit;
 if v='' then begin f2:=b1; b2:=f1; end else
  begin
   i:=pos('/',v);
   if i=0 then exit;
   f2:=clr2int(copy(v,1,i-1));
   b2:=clr2int(copy(v,i+1,length(v)-i));
   if (f2=-1) or (b2=-1) then exit;
  end;
 b1:=b1 and 7;
 b2:=b2 and 7;
 if (f1=f2) and (b1=b2) then exit;
 fg1:=f1;
 bg1:=b1;
 fg2:=f2;
 bg2:=b2;
 SetPanelColor(Panel1,fg1,bg1);
 SetPanelColor(Panel2,fg2,bg2);
end;

begin
 clrcfs();
 sl:=TStringList.Create;
 sl.Text:=s;
 ListBox1.Items.BeginUpdate;
 p:=nil;
 for i:=0 to sl.Count-1 do
  begin
   v:=trim(sl.Strings[i]);
   c:=lowercase(popstr(v,' '));
   if c='' then continue;
   if c='title' then
    begin
     new(p);
     p.title:=v;
     p.value:='';
     ListBox1.Items.AddObject('',TObject(p));
    end else
   if p<>nil then p.value:=p.value+sl.Strings[i]+#13#10 else
    begin
     if c='timeout' then Edit1.Text:=v else
     if c='default' then df:=StrToIntDef(v,-1) else
     if c='fontfile' then begin CheckBox1.Checked:=true; if G2LName(v,'')='fonts' then fp:='' else fp:=v; end else
     if c='splashimage' then ComboBox2.Text:=G2LName(v,'.xpm.gz') else
     if c='foreground' then begin fg3:=StrToIntDef('$'+v,clWhite); SetPanelColor1(Panel3,fg3,bg3); end else
     if c='background' then begin bg3:=StrToIntDef('$'+v,clBlack); SetPanelColor1(Panel3,fg3,bg3); end else
     if c='color' then getclr else
     if c='password' then
      begin
       CheckBox2.Checked:=false;
       c:=popstr(v,' ');
       if c='--md5' then c:=popstr(v,' ') else CheckBox2.Checked:=true;
       pw:=c;
       if CheckBox2.Checked then Edit3.Text:=pw else Edit3.Text:='';
       Edit4.Text:=popstr(v,' ');
      end else ex:=ex+sl.Strings[i]+#13#10;
    end;
  end;
 ListBox1.Items.EndUpdate;
 sl.Free;
end;

function TMainForm.setcfs:string;
var i:integer; p:pitem;
begin
 result:='';
 if df<>-1 then result:=result+'default '+IntToStr(df)+#13#10;
 if Edit1.Text<>'' then result:=result+'timeout '+Edit1.text+#13#10;
 if CheckBox1.Checked then if fp<>'' then result:=result+'fontfile '+fp+#13#10 else
  result:=result+'fontfile '+L2GName('fonts','')+#13#10;
 if ComboBox2.Text<>'' then result:=result+'splashimage '+L2GName(ComboBox2.Text,'.xpm.gz')+#13#10;
 if (Edit3.Text<>'') or not CheckBox2.Checked and (pw<>'') then
  begin
   result:=result+'password ';
   if CheckBox2.Checked then result:=result+Edit3.Text else
   if Edit3.Text='' then result:=result+'--md5 '+pw else
    result:=result+'--md5 '+md5_mkpwd(Edit3.Text);
   if Edit4.Text<>'' then result:=result+' '+Edit4.Text;
   result:=result+#13#10;
  end;
 if (fg1<>7) or (bg1<>0) or (fg2<>0) or (bg2<>7) then
  result:=result+'color '+int2clr(fg1)+'/'+int2clr(bg1)+' '+int2clr(fg2)+'/'+int2clr(bg2)+#13#10;
 if (fg3<>clWhite) then result:=result+'foreground '+lowercase(IntToHex(fg3,6))+#13#10;
 if (bg3<>clBlack) then result:=result+'background '+lowercase(IntToHex(bg3,6))+#13#10;
 result:=result+ex;
 for i:=0 to ListBox1.Items.Count-1 do
  begin
   p:=pitem(ListBox1.Items.Objects[i]);
   result:=result+#13#10+'title '+p.title+#13#10+p.value;
  end;
end;

procedure TMainForm.clrlst;
var i:integer; p:pitem;
begin
 for i:=0 to ListBox1.ItemIndex-1 do
  begin
   p:=pitem(ListBox1.Items.Objects[i]);
   p.title:='';
   p.value:='';
   dispose(p);
  end;
 ListBox1.Clear;
 Edit2.Text:='';
 ListBox2.Clear;
end;

procedure TMainForm.ListBox1Click(Sender: TObject);
var itm:pitem;
begin
 if ListBox1.ItemIndex=-1 then ShowErr('No item is selected') else
  begin
   itm:=pitem(ListBox1.Items.Objects[ListBox1.ItemIndex]);
   Edit2.Text:=itm.title;
   ListBox2.Items.Text:=itm.value;
  end;
end;

procedure TMainForm.ComboBox1Change(Sender: TObject);
begin
 if ComboBox1.Text<>'' then getcfg(ap+'prof\'+ComboBox1.Text+'.LST');
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 if ComboBox1.Text='' then SpeedButton2Click(nil) else SaveString(ap+'prof\'+ComboBox1.Text+'.LST',setcfs);
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
var s:string; i:integer;
begin
 SaveDialog1.InitialDir:=ap+'prof';
 if SaveDialog1.Execute then
  begin
   SaveString(SaveDialog1.FileName,setcfs);
   if (Uppercase(ap+'prof\')=Uppercase(ExtractFilePath(SaveDialog1.FileName))) and (Uppercase(ExtractFileExt(SaveDialog1.FileName))='.LST') then
    begin
     s:=ExtractFileName(SaveDialog1.FileName);
     s:=copy(s,1,length(s)-4);
     i:=ComboBox1.Items.IndexOf(s);
     if i=-1 then i:=ComboBox1.Items.Add(s);
     ComboBox1.ItemIndex:=i;
    end;
  end;
 SaveDialog1.InitialDir:=lp;
 SaveDialog1.FileName:='';
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
 if ComboBox1.ItemIndex=-1 then
  begin
   ShowErr('No profile to delete');
   exit;
  end;
 if Confirm('Do you really want to delete the profile') then
  begin
   DeleteFile(ap+'prof\'+ComboBox1.Text+'.LST');
   ComboBox1.Items.Delete(ComboBox1.ItemIndex);
  end;
end;

procedure TMainForm.Open1Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
  begin
   setcfn(OpenDialog1.FileName);
   getcfg(fn);
  end;
end;

procedure TMainForm.Save1Click(Sender: TObject);
begin
 if fn='' then SaveAs1Click(nil) else setcfg(fn);
end;

procedure TMainForm.SaveAs1Click(Sender: TObject);
begin
 if SaveDialog1.Execute then
  begin
   setcfn(SaveDialog1.FileName);
   setcfg(fn);
  end;
end;

procedure TMainForm.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var s:string;
begin
 ListBox1.Canvas.FillRect(Rect);
 s:=pitem(ListBox1.Items.Objects[index])^.title;
 if index=df then s:='<'+s+'>';
 DrawText(ListBox1.Canvas.Handle,Pchar(s),length(s),Rect,dt_Left or dt_VCenter);
end;

procedure TMainForm.Panel3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (Button<>mbLeft) and (Button<>mbRight) then exit;
 if Button=mbLeft then ColorDialog1.Color:=fg3 else ColorDialog1.Color:=bg3;
 if ColorDialog1.Execute then
  begin
   if Button=mbLeft then fg3:=ColorDialog1.Color else bg3:=ColorDialog1.Color;
   SetPanelColor1(Panel3,fg3,bg3);
  end;
end;

procedure TMainForm.InstallGrub1Click(Sender: TObject);
var ID:TInstDlg;
begin
 ID:=TInstDlg.Create(self);
 ID.ShowModal;
 ID.release;
end;

procedure TMainForm.BootDirectory1Click(Sender: TObject);
var BD:TBaseDlg;
begin
 BD:=TBaseDlg.Create(self);
 if BD.ShowModal=mrOK then setcfn(lp+ExtractFileName(fn));
 BD.release;
end;

procedure TMainForm.PartitionList1Click(Sender: TObject);
var PD:TPartDlg;
begin
 PD:=TPartDlg.Create(self);
 PD.ShowModal;
 PD.release;
end;

procedure TMainForm.GrubFiles1Click(Sender: TObject);
var GD:TGrubDlg;
begin
 GD:=TGrubDlg.Create(self);
 GD.ShowModal;
 GD.Release;
end;

procedure TMainForm.SpeedButton6Click(Sender: TObject);
begin
 Edit3.Text:='';
 Edit4.Text:='';
 pw:=''; 
end;

procedure TMainForm.SpeedButton5Click(Sender: TObject);
var s:string;
begin
 s:=ap+'logo\'+ComboBox2.Text+'.jpg';
 if (ComboBox2.Text<>'') and FileExists(s) then
  ShellExec(s,'',SEF_SAPP);
end;

procedure TMainForm.ListBox1Key(Sender: TObject);
var
 key:Word; shift:TShiftState;
 i:integer; p:pitem; s:string;
begin
 ShortCutToKey(TMenuItem(sender).ShortCut,key,shift);
 if (Key=VK_INSERT) or (Key=ord('C')) then
  begin
   i:=ListBox1.ItemIndex+1;
   if i=0 then i:=ListBox1.Items.Count;
   if (Key=VK_INSERT) then
    begin
     Edit2.Text:='New Item';
     ListBox2.Clear;
    end;
   new(p);
   p.title:=Edit2.Text;
   p.value:=ListBox2.Items.Text;
   ListBox1.Items.InsertObject(i,'',TObject(p));
   ListBox1.ItemIndex:=i;
  end else
 if (Key=VK_DELETE) then
  begin
   if ListBox1.ItemIndex=-1 then exit;
   p:=pitem(ListBox1.Items.Objects[ListBox1.ItemIndex]);
   p.title:='';
   p.value:='';
   dispose(p);
   ListBox1.Items.Delete(ListBox1.ItemIndex);
  end else
 if Key=VK_SPACE then
  begin
   if ListBox1.ItemIndex=-1 then exit;
   if df=ListBox1.ItemIndex then df:=-1 else df:=ListBox1.ItemIndex;
   ListBox1.Invalidate;
  end else
 if (Key=ord('E')) then
  begin
   s:=setcfs;
   if EditString(s) then getcfs(s);
  end else
 if (Key=ord('U')) or (Key=ord('D')) or (Key=ord('T')) or (Key=ord('B')) then
  begin
   if (ListBox1.ItemIndex=-1) or (ListBox1.ItemIndex=0) and ((Key=ord('U')) or (Key=ord('T')))
       or (ListBox1.ItemIndex=ListBox1.Items.Count-1) and ((Key=ord('D')) or (Key=ord('B'))) then exit;
   i:=ListBox1.ItemIndex;
   p:=pitem(ListBox1.Items.Objects[i]);
   ListBox1.Items.Delete(i);
   if Key=ord('U') then dec(i) else
   if Key=ord('D') then inc(i) else
   if Key=ord('T') then i:=0 else
   if Key=ord('B') then i:=ListBox1.Items.Count;
   ListBox1.Items.InsertObject(i,'',TObject(p));
   ListBox1.ItemIndex:=i;
  end;
end;

procedure TMainForm.ListBox2Key(Sender: TObject);
var
 key:Word; shift:TShiftState;
 s:string; var p:pitem; i:integer;
begin
 ShortCutToKey(TMenuItem(sender).ShortCut,key,shift);
 if Key=VK_DELETE then
  begin
   if ListBox2.ItemIndex<>-1 then
    begin
     if ListBox2.ItemIndex=ListBox2.Items.Count-1 then i:=ListBox2.ItemIndex-1 else i:=ListBox2.ItemIndex;
     ListBox2.Items.Delete(ListBox2.ItemIndex);
     ListBox2.ItemIndex:=i;
    end;
  end;
 if Key=ord('E') then
  begin
   s:=ListBox2.Items.Text;
   if EditString(s) then
    begin
     ListBox2.ItemIndex:=-1;
     ListBox2.Items.Text:=s;
    end;
  end else
 if Key=ord('S') then
  begin
   if ListBox1.ItemIndex=-1 then ShowErr('No item is selected') else
   if Edit2.Text='' then ShowErr('The title can''t be blank') else
    begin
     p:=pitem(ListBox1.Items.Objects[ListBox1.ItemIndex]);
     p.title:=Edit2.Text;
     p.value:=ListBox2.Items.Text;
     ListBox1.Invalidate;
    end;
  end else
 if Key=ord('R') then
  begin
   if ListBox1.ItemIndex=-1 then
    begin
     Edit2.Text:='';
     ListBox2.Clear;
    end else
    begin
     p:=pitem(ListBox1.Items.Objects[ListBox1.ItemIndex]);
     Edit2.Text:=p.title;
     ListBox2.Items.Text:=p.value;
    end;
  end;
end;

const
 BUF_SIZE       = 10240;

var
 buf:pchar;
 len,ps0,ps1:integer;

function FndStr(hd:dword;ss:string):integer;
var ps2:integer;
begin
 result:=-1;
 ps2:=1;
 repeat
  if ps1=0 then
   begin
    if not ReadFile(hd,buf^,BUF_SIZE,dword(len),nil) or (len=0) then exit;
   end;
  while (ps1<len) do
   begin
    if buf[ps1]=ss[ps2] then
     begin
      inc(ps2);
      if ps2>length(ss) then
       begin
        inc(ps1);
        result:=ps0+ps1;
        exit;
       end;
     end else ps2:=1;
    inc(ps1);
   end;
  inc(ps0,len);
  ps1:=0;
 until false;
end;

procedure TMainForm.ReadPresetMenu1Click(Sender: TObject);
var ok:boolean; p1,p2,nr:integer; hd:dword; s,k,v:string;
begin
 if not OpenDialog3.Execute then exit;
 hd:=CreateFile(pchar(OpenDialog3.FileName),GENERIC_READ,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
 if hd=INVALID_HANDLE_VALUE then
  begin
   ShowErr('Can''t open file');
   exit;
  end;
 ok:=false;
 try
  getmem(buf,BUF_SIZE);
  len:=BUF_SIZE;
  ps0:=0;
  ps1:=0;
  p1:=FndStr(hd,'# PRESET START'#10);
  if p1<>-1 then
   begin
    p2:=FndStr(hd,'# PRESET END');
    if (p2<>-1) and (p2-p1>12) then
     begin
      freemem(buf);
      getmem(buf,p2-p1-11);
      buf[p2-p1-12]:=#0;
      if (SetFilePointer(hd,p1,nil,FILE_BEGIN)<>$FFFFFFFF) and ReadFile(hd,buf^,p2-p1-12,dword(nr),nil) and (nr=p2-p1-12) then
       begin
        s:='';
        v:=string(buf);
        repeat
         k:=popstr(v,#10);
         if k<>'' then s:=s+k+#13#10;
        until v='';
        getcfs(s);
        ok:=true;
       end;
     end;
   end;
  freemem(buf);
 except
 end;
 CloseHandle(hd);
 if not ok then ShowErr('Preset menu signature not found');
end;

procedure TMainForm.Save2Click(Sender: TObject);
var s,k,v:string; ok:boolean; i,p1,p2:integer; hd:dword;
begin
 if not SaveDialog2.Execute then exit;
 hd:=CreateFile(pchar(SaveDialog2.FileName),GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
 if hd=INVALID_HANDLE_VALUE then
  begin
   ShowErr('Can''t open file');
   exit;
  end;
 ok:=false;
 try
  getmem(buf,BUF_SIZE);
  len:=BUF_SIZE;
  ps0:=0;
  ps1:=0;
  p1:=FndStr(hd,'# PRESET START'#10);
  if p1<>-1 then
   begin
    p2:=FndStr(hd,'# PRESET END');
    if (p2<>-1) then
     begin
      s:='';
      v:=setcfs;
      repeat
       k:=popstr(v,#13#10);
       if k<>'' then s:=s+k+#10;
      until v='';
      if s='' then ok:=true else
      if (length(s)>p2-p1-12) then begin ShowErr(IntToStr(length(s)-p2+p1+12)+' bytes overflown');ok:=true end else
       begin
        freemem(buf);
        getmem(buf,p2-p1-12);
        move(pchar(s)^,buf^,length(s));
        for i:=length(s) to p2-p1-13 do buf[i]:=#10;
        ok:=(SetFilePointer(hd,p1,nil,FILE_BEGIN)<>$FFFFFFFF) and WriteFile(hd,buf^,p2-p1-12,dword(i),nil) and (i=p2-p1-12);
       end;
     end;
   end;
  freemem(buf);
 except
 end;
 CloseHandle(hd);
 if not ok then ShowErr('Preset menu signature not found');
end;

end.
