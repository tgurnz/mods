unit Inst;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Dialogs;

type
  TInstDlg = class(TForm)
    Bevel1: TBevel;
    RadioButton1: TRadioButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel2: TBevel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Edit2: TEdit;
    RadioButton5: TRadioButton;
    Label6: TLabel;
    ComboBox3: TComboBox;
    RadioButton6: TRadioButton;
    Edit3: TEdit;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    sd:char;
    ss:string;
    function getcfs(b:boolean):string;
  end;

implementation

uses Utils,XDIO32;

{$R *.DFM}

procedure TInstDlg.FormCreate(Sender: TObject);
var pl:pplst_t; wd:array [0..MAX_PATH-1] of char; i:integer;
begin
 pl:=ph;
 while (pl<>nil) do
  begin
   if (pl.sp<4) and (pl.ld<>0) and (pl.fs<>7) then
    ComboBox1.Items.AddObject(GetPName(pl),TObject(pl));
   pl:=pl.nx;
  end;
 RadioButton1Click(nil);
 GetWindowsDirectory(wd,sizeof(wd));
 sd:=wd[0];
 for i:=2 to 25 do
  if (i=ord(sd)-65) or (dm and (1 shl i)<>0) then ComboBox2.Items.Add(char(65+i));
 ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf(sd);
 ComboBox3.ItemIndex:=0;
end;

function TInstDlg.getcfs(b:boolean):string;
var i,mi:integer; s,t:string; sl,cl:TStringList; gg,mm:boolean;

procedure dsec(p:integer);
var s:string;
begin
 repeat
  sl.Delete(p);
  if sl.Count<=p then break;
  s:=trim(sl.Strings[p]);
  if s='' then s:=' ';
 until (s[1]='[') and (s[length(s)]=']');
end;

begin
 result:='';
 if RadioButton2.Checked then
  begin
   s:=ReadString(sd+':\BOOT.INI');
   sl:=TStringList.Create;
   sl.Text:=s;
   s:=sd+':\GRLDR=';
   if Edit1.Text='' then s:=s+'"Start Grub"' else s:=s+'"'+Edit1.Text+'"';
   if sl.Count=0 then begin if b then sl.Add(s); end else
   for i:=0 to sl.Count-1 do
    if Pos('grldr',Lowercase(sl.Strings[i]))<>0 then
     begin
      sl.Delete(i);
      break;
     end;
   if b then sl.Add(s);
   result:=sl.Text;
   sl.Free;
  end else
 if RadioButton3.Checked then
  begin
   s:=ReadString(sd+':\CONFIG.SYS');
   sl:=TStringList.Create;
   sl.Text:=s;
   cl:=TStringList.Create;
   t:='';
   mi:=-1;
   gg:=false;
   mm:=false;
   for i:=0 to sl.Count-1 do
    begin
     s:=lowercase(trim(sl.Strings[i]));
     if s='' then continue;
     if (s[1]='[') and (s[Length(s)]=']') then
      begin
       if (t<>'') then cl.Add(t);
       gg:=(s='[grb]');
       mm:=(s='[menu]');
       if mm then mi:=cl.Count;
       if gg then t:='' else t:=sl.Strings[i]+#13#10;
      end else
     if not gg and (not mm or (pos('menuitem=grb',s)=0)) then
      t:=t+sl.Strings[i]+#13#10;
    end;
   if t<>'' then cl.Add(t);
   if b then
    begin
     s:='install=grub.exe --config-file='+L2GName('MENU.LST','')+#13#10;
     cl.Add('[GRB]'#13#10+s);
     if (mi<>-1) then
      begin
       if Edit1.Text='' then s:='Start Grub' else s:=Edit1.Text;
       cl.Strings[mi]:=cl.Strings[mi]+'menuitem=GRB , '+s+#13#10;
      end else
      begin
       if (pos('[',cl.Strings[0])<>1) then cl.Strings[0]:='[ORG]'#13#10+cl.Strings[0];
       t:='[menu]'+#13#10;
       for i:=0 to cl.Count-1 do
        begin
         s:=copy(cl.Strings[i],2,pos(']',cl.Strings[i])-2);
         if s='' then continue;
         t:=t+'menuitem='+s+' , ';
         if s='ORG' then s:='Original Config' else
         if s='GRB' then if Edit1.Text='' then s:='Start Grub' else s:=Edit1.Text;
         t:=t+s+#13#10;
        end;
       cl.Insert(0,t);
      end;
    end else
   if (mi<>-1) and (cl.Count<=2) then
    begin
     cl.Delete(mi);
     s:=cl.Strings[0];
     if (cl.Count=1) and (pos('[',s)=1) then
      begin
       i:=pos(']'#13#10,s);
       if i<>0 then
        begin
         delete(s,1,i+2);
         cl.Strings[0]:=s;
        end;
      end;
    end;
   result:='';
   for i:=0 to cl.Count-1 do
    begin
     if i<>0 then result:=result+#13#10;
     result:=result+cl.Strings[i];
    end;
   sl.Free;
   cl.Free;
  end else
 if RadioButton4.Checked then
  begin
   s:=ReadString(sd+':\AUTOEXEC.BAT');
   sl:=TStringList.Create;
   sl.Text:=s;
   mm:=false;
   if (b) then
    begin
     i:=StrToIntDef(Edit2.Text,0);
     if i>0 then s:=IntToStr(i) else s:='20';
     result:='@REM GRUB START'#13#10'@CHOICE /TY,'+s;
     if Edit1.Text='' then s:='Start Grub' else s:=Edit1.Text;
     result:=result+' "'+s+' "'#13#10+
      '@IF ERRORLEVEL 2 GOTO SKIP_GRUB'#13#10+
      '@GRUB.EXE --config-file='+L2GName('MENU.LST','')+#13#10':SKIP_GRUB'#13#10'@REM GRUB END'#13#10;
    end else result:='';
   for i:=0 to sl.Count-1 do
    begin
     if (pos('GRUB START',sl.Strings[i])<>0) then mm:=true else
     if (pos('GRUB END',sl.Strings[i])<>0) then mm:=false else
     if not mm then result:=result+sl.strings[i]+#13#10;
    end;
   sl.Free;
  end;
end;

procedure TInstDlg.RadioButton1Click(Sender: TObject);
var bb:boolean;
begin
 bb:=RadioButton2.Checked or RadioButton3.Checked or RadioButton4.Checked;
 EnableControl(RadioButton1.Checked,[Label1,ComboBox1]);
 EnableControl(RadioButton5.Checked,[Label6,ComboBox3]);
 EnableControl(RadioButton6.Checked,[Edit3,SpeedButton1]);
 EnableControl(bb,[Label4,Label5,Edit1,Edit2]);
 ss:='';
 Button1.Enabled:=bb;
end;

procedure TInstDlg.Button1Click(Sender: TObject);
var bb:boolean;
begin
 bb:=(ss='');
 if bb then ss:=getcfs(true);
 if not EditString(ss) and bb then ss:='';
end;

var
 buf:array [0..DEF_GSEC*512-1] of char;

procedure TInstDlg.Button2Click(Sender: TObject);
label q1,q2;
var
 pl:pplst_t; xd:xd0_t;
 ok,bb,mm:boolean; s,t:string; n,o:integer;  c:char;
 bs1:array [0..$59-2] of char;
 bs2:array [0..$3d-2] of char absolute bs1;
 tab:array [0..16*4-1] of char absolute bs1;
begin
 if RadioButton1.Checked or RadioButton5.Checked or RadioButton6.Checked then
  begin
   ok:=false;
   bb:=false;
   pl:=nil;
   if RadioButton1.Checked then
    begin
     if ComboBox1.ItemIndex=-1 then
      begin
       ShowErr('Please choose a partition');
       exit;
      end;
     pl:=pplst_t(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
     s:='(hd'+IntToStr(pl.hd)+')';
     n:=DEF_GSEC;
    end else
   if RadioButton5.Checked then
    begin
     if ComboBox3.ItemIndex=-1 then
      begin
       ShowErr('Please choose a drive');
       exit;
      end;
     s:='(ld'+IntToStr(ComboBox3.ItemIndex)+')';
     n:=1;
    end else
    begin
     if Edit3.Text='' then
      begin
       ShowErr('Please choose a file');
       exit;
      end;
     if not FileExists(Edit3.Text) then
      begin
       ShowErr('File not exist');
       exit;
      end;
     s:=Edit3.Text;
     n:=DEF_GSEC;
    end;
   if _xd_open(xd,pchar(s),0)<>0 then goto q1;
   if _xd_read(xd,buf,n)<>n then goto q2;
   if RadioButton1.Checked then
    begin
     c:=char(pl.ld+65);
     t:=c+':\MBR.ORG';
     mm:=true;
     move(buf[$1BE],tab,sizeof(tab));
    end else
   if RadioButton5.Checked then
    begin
     c:=char(ComboBox3.ItemIndex+65);
     t:=c+':\BS.ORG';
     mm:=false;
     if (StrLComp(@buf[$52],'FAT',3)=0) then begin move(buf[2],bs1,sizeof(bs1)); bb:=true; end else
     if (StrLComp(@buf[$36],'FAT',3)=0) then begin move(buf[2],bs2,sizeof(bs2)); end else
      begin
       ShowErr('Not a FAT partition');
       ok:=true;
       goto q2;
      end;
    end else
    begin
     mm:=false;
     if (StrLComp(@buf[$52],'FAT',3)=0) then begin move(buf[2],bs1,sizeof(bs1)); bb:=true; end else
     if (StrLComp(@buf[$36],'FAT',3)=0) then begin move(buf[2],bs2,sizeof(bs2)); end else
     if (StrLComp(@buf[3],'NTFS',4)=0) then begin ShowErr('NTFS not supported'); ok:=true; goto q2; end else
      begin
       mm:=true;
       move(buf[$1BE],tab,sizeof(tab));
      end;
     if not mm then n:=1;
     OpenDialog2.FileName:=ChangeFileExt(Edit3.Text,'.org');
     if not OpenDialog2.Execute then begin ok:=true; goto q2; end;
     c:=#0;
     t:=OpenDialog2.FileName;
     {
     if (Sender=Button2) and FileExists(t) then
      if confirm('Overwrite the original file') then DeleteFile(t) else
       begin ok:=true; goto q2; end;
     }
    end;
   if (Sender=Button2) then
    begin
     if not FileExists(t) then SaveData(t,buf,n*512);
     s:=FindGrubFile('GRLDR');
     if s='' then
      begin
       ShowErr('No GRLDR');
       ok:=true;
       goto q2;
      end;
     s:=ap+'grub\'+s;
     o:=DEF_GSEC;
    end else
    begin
     if not FileExists(t) then
      begin
       ShowErr('No backup copy');
       ok:=true;
       goto q2;
      end;
     s:=t;
     o:=n;
    end;
   if not ReadData(s,buf,o*512) then goto q2;
   if mm then move(tab,buf[$1BE],sizeof(tab)) else
   if bb then
    begin
     if Sender=Button2 then move(buf[2*512],buf,512);
     move(bs1,buf[2],sizeof(bs1));
    end else
    begin
     if Sender=Button2 then move(buf[3*512],buf,512);
     move(bs2,buf[2],sizeof(bs2));
    end;
   ok:=(_xd_seek(xd,0,XDS_ZERO)=0) and (_xd_write(xd,buf,n)=n) and
       (not bb or (_xd_seek(xd,6,XDS_ZERO)=0) and (_xd_write(xd,buf,n)=n));
   if (Sender=Button2) then
    begin
     if c<>#0 then CopyGrubFile('GRLDR',c+':\');
    end else DeleteFile(t);
  q2:
   _xd_close(xd);
  q1:
   if not ok then ShowErr('Change boot sector fails');
  end else
  begin
   if ss='' then ss:=getcfs(Sender=Button2);
   if RadioButton2.Checked then s:='BOOT.INI' else
   if RadioButton3.Checked then s:='CONFIG.SYS' else s:='AUTOEXEC.BAT';
   SaveString(sd+':\'+s,ss);
   if Sender=Button2 then
    begin
     if RadioButton2.Checked then s:='GRLDR' else s:='GRUB.EXE';
     CopyGrubFile(s,sd+':\');
    end;
  end;
 ModalResult:=mrOK;
end;

procedure TInstDlg.ComboBox2Change(Sender: TObject);
begin
 if ComboBox2.ItemIndex<>-1 then sd:=ComboBox2.Text[1];
 ss:='';
end;

procedure TInstDlg.SpeedButton1Click(Sender: TObject);
begin
 if OpenDialog1.Execute then Edit3.Text:=OpenDialog1.FileName;
end;

end.
