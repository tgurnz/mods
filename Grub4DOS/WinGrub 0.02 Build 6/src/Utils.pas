unit Utils;

interface

uses Controls,XDIO32;

const
 SEF_WAIT       = 1;
 SEF_HIDE       = 2;
 SEF_SAPP       = 4;
 SEF_DAPP       = 8;

 DEF_GSEC       = 5;

type
 pplst_t=^plst_t;

 plst_t=packed record
  nx:pplst_t;
  hd,sp,ld,fs:byte;
  bs,ln:longword;
 end;

var
 lp,ap,cg:string;
 ph:pplst_t;
 dm:longword;
 mp:array [0..MAX_DKNO-1] of integer;

procedure ShowErr(msg:string);
function Confirm(msg:string):boolean;
function ShellExec(const name,para:string;flag:integer):longword;
procedure EnableControl(b:boolean;a:array of TControl);
function BrowseFolder:string;
function GetPName(pl:pplst_t):string;
function G2LName(fn,ex:string):string;
function L2GName(fn,ex:string):string;
function EditString(var s:string):boolean;
function ReadString(name:string):string;
function SaveString(name:string;s:string):boolean;
function ReadData(fn:string;var buf;len:integer):boolean;
function SaveData(fn:string;var buf;len:integer):boolean;
function ReadParm(nn:string):string;
function SaveParm(nn,vv:string):boolean;
function popstr(var s:string;c:string):string;
function FindGrubFile(const fn:string):string;
function CopyGrubFile(const fn,dd:string):boolean;

implementation

uses Forms,Windows,Graphics,Stdctrls,Sysutils,ActiveX,ShellAPI,ShlObj,IniFiles,Edit;

procedure GetPList;
var
 cc,nn:pplst_t; xw:xdw_t; i:integer;
begin
 if ph<>nil then
  begin
   cc:=ph;
   while (cc<>nil) do
    begin
     nn:=cc;
     cc:=cc.nx;
     dispose(nn);
    end;
   ph:=nil;
  end;
 cc:=nil;
 dm:=0;
 xw.map:=$FFFFFFFF;
 i:=_xd_walk(xw);
 while (i=0) or (i>1) do
  begin
   new(nn);
   nn^.hd:=xw.xd0.drv and $7F;
   nn^.sp:=xw.xde.cur;
   nn^.ld:=i;
   nn^.fs:=xw.xde.dfs;
   nn^.bs:=xw.xde.bse;
   nn^.ln:=xw.xde.len;
   if (i<>0) then dm:=dm or (1 shl i);
   if cc=nil then begin cc:=nn; ph:=nn; end else begin cc^.nx:=nn; cc:=nn; end;
   i:=_xd_walk(xw);
  end;
 if cc<>nil then cc^.nx:=nil;
end;

function GetPName(pl:pplst_t):string;
begin
 result:='(hd'+IntToStr(mp[pl.hd])+','+IntToStr(pl.sp)+')';
end;

procedure AppInit;
var i,n:integer; s:string; ss:set of LOW(mp)..HIGH(mp);
begin
 if (_xd_init()<>0) then
  begin
   ShowErr('XDIO32 initialization fails');
   Halt(0);
  end;
 ap:=ExtractFilePath(Application.ExeName);
 cg:=ReadParm('CurrGrub');
 ss:=[];
 s:=ReadParm('DiskMaps');
 if Length(s)<>HIGH(mp)+1 then i:=0 else
 for i:=0 to Length(s)-1 do
  begin
   n:=ord(s[i+1])-ord('0');
   if (n<LOW(mp)) or (n>HIGH(mp)) or (n in ss) then break;
   mp[i]:=n;
   ss:=ss+[n];
  end;
 if i<>HIGH(mp)+1 then for i:=LOW(mp) to HIGH(mp) do mp[i]:=i;
 GetPList;
end;

procedure AppExit;
begin
 _xd_exit();
end;

procedure ShowErr(msg:string);
begin
 MessageBox(0,PCHAR(msg),'Error',MB_OK or MB_ICONWARNING);
end;

function Confirm(msg:string):boolean;
begin
 result:=(MessageBox(0,Pchar(msg),'Confirm',MB_YESNO or MB_ICONQUESTION)=IDYES);
end;

function ShellExec(const name,para:string;flag:integer):longword;
var ei:TShellExecuteInfo;
begin
 With ei do
  begin
   cbSize:=SizeOf(TShellExecuteInfo);
   fMask:=SEE_MASK_NOCLOSEPROCESS;
   Wnd:=0;
   lpVerb:='open';
   if (flag and SEF_SAPP<>0) then lpFile:=Pchar(name) else
    lpFile:=Pchar(ap+name);
   lpParameters:=Pchar(para);
   lpDirectory:='';
   if (flag and SEF_HIDE<>0) then nShow:=SW_HIDE else
    nShow:=SW_NORMAL;
  end;
 if not ShellExecuteEx(@ei) then RaiseLastWin32Error;
 if (flag and SEF_WAIT<>0) then WaitForSingleObject(ei.hProcess,INFINITE);
 GetExitCodeProcess(ei.hProcess,result);
 if (flag and SEF_DAPP<>0) then result:=result and $FF;
end;

procedure EnableControl(b:boolean;a:array of TControl);
var i:integer; c:TColor;
begin
 if (b) then c:=clWindow else c:=clBtnFace;
 for i:=0 to High(a) do
  begin
   if a[i] is TEdit then TEdit(a[i]).Color:=c else
   if a[i] is TComboBox then TComboBox(a[i]).Color:=c;
   a[i].Enabled:=b;
  end;
end;

function BrowseFolder:string;
var
 bi:BROWSEINFO;
 pidl:PItemIDList;
 buf:array [0..MAX_PATH-1] of char;
 im:IMalloc;
begin
 result:='';
 if SHGetMalloc(im)=E_FAIL then exit;
 fillchar(bi,sizeof(bi),0);
 bi.lpszTitle:='Select a folder';
 bi.ulFlags:=0;
 pidl:=SHBrowseForFolder(bi);
 if (pidl<>nil) then
  begin
   SHGetPathFromIDList(pidl,buf);
   result:=string(buf);
   if result[length(result)]<>'\' then result:=result+'\';
   im.Free(pidl);
  end;
end;

function G2LName(fn,ex:string):string;
var i:integer; s:string; pl:pplst_t;
begin
 result:=fn;
 i:=pos('/',fn);
 if i=0 then exit;
 s:=copy(fn,1,i-1);
 pl:=ph;
 while (pl<>nil) do
  begin
   if s=GetPName(pl) then break;
   pl:=pl.nx;
  end;
 if (pl=nil) or (pl.ld=0) then exit;
 s:=char(65+pl.ld)+':'+copy(fn,i,length(fn));
 for i:=1 to length(s) do
  if s[i]='/' then s[i]:='\';
 if Lowercase(ExtractFilePath(s))=Lowercase(lp) then
  begin
   s:=ExtractFileName(s);
   if (ex<>'') and (Pos(ex,Lowercase(s))=Length(s)-length(ex)+1) then s:=copy(s,1,Length(s)-length(ex));
   if s<>'' then result:=s;
  end;
end;

function L2GName(fn,ex:string):string;
var s:string; pl:pplst_t; d,i:integer;
begin
 result:=fn;
 d:=ord(UpCase(lp[1]))-65;
 if (lp='') or (pos('/',fn)<>0) or (dm and (1 shl d)=0) then exit;
 pl:=ph;
 while (pl<>nil) do
  begin
   if pl.ld=d then break;
   pl:=pl.nx;
  end;
 if pl=nil then exit;
 s:=GetPName(pl)+copy(lp,3,length(lp));
 for i:=1 to length(s) do
  if s[i]='\' then s[i]:='/';
 s:=s+fn;
 if (ex<>'') and (ExtractFileExt(s)='') then s:=s+ex;
 result:=s;
end;

function EditString(var s:string):boolean;
var EdtDlg:TEditDlg;
begin
 EdtDlg:=TEditDlg.Create(nil);
 EdtDlg.Memo1.Text:=s;
 result:=(EdtDlg.ShowModal=mrOK);
 if result then s:=EdtDlg.Memo1.Text;
 EdtDlg.Release();
end;

function ReadString(name:string):string;
var f:TextFile; s:string;
begin
 result:='';
 if (name='') or not FileExists(name) then exit;
 AssignFile(f,name);
 try
  reset(f);
  while not eof(f) do
   begin
    readln(f,s);
    result:=result+s+#13#10;
   end;
  CloseFile(f);
 except
  on e:Exception do result:='';
 end;
end;

function SaveString(name:string;s:string):boolean;
var f:TextFile; a:integer;
begin
 result:=true;
 if FileExists(name) then
  begin
   a:=FileGetAttr(name);
   FileSetAttr(name,0);
  end else a:=0;
 AssignFile(f,name);
 try
  rewrite(f);
  write(f,s);
 except
  on e:Exception do begin ShowErr(e.Message); result:=false;end;
 end;
 CloseFile(f);
 FileSetAttr(name,a);
end;

function ReadData(fn:string;var buf;len:integer):boolean;
var hd,nr:dword;
begin
 result:=false;
 hd:=CreateFile(pchar(fn),GENERIC_READ,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
 if (hd=INVALID_HANDLE_VALUE) then exit;
 result:=ReadFile(hd,buf,len,nr,nil) and (dword(len)=nr);
 CloseHandle(hd);
end;

function SaveData(fn:string;var buf;len:integer):boolean;
var hd,nr:dword;
begin
 result:=false;
 hd:=CreateFile(pchar(fn),GENERIC_READ or GENERIC_WRITE	,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_ALWAYS,0,0);
 if (hd=INVALID_HANDLE_VALUE) then exit;
 result:=WriteFile(hd,buf,len,nr,nil) and (dword(len)=nr);
 CloseHandle(hd);
end;

{
function ReadParm(nn:string):string;
var reg:TRegistry;
begin
 reg:=TRegistry.Create;
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 if reg.OpenKey('Software\WinGrub',true) then Result :=reg.ReadString(nn) else result:='';
 reg.CloseKey;
 reg.Free;
end;

function SaveParm(nn,vv:string):boolean;
var reg:TRegistry;
begin
 reg:=TRegistry.Create;
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 if reg.OpenKey('Software\WinGrub',true) then
  begin
   try
    reg.WriteString(nn,vv);
    result:=true;
   except
    result:=false;
   end
  end else result:=false;
 reg.CloseKey;
 reg.Free;
end;
}

function ReadParm(nn:string):string;
var ini:TIniFile;
begin
 if FileExists(ap+'WINGRB.INI') then
  begin
   ini:=TiniFile.Create(ap+'WINGRB.INI');
   result:=ini.ReadString('General',nn,'');
   ini.Free;
  end else result:='';
end;

function SaveParm(nn,vv:string):boolean;
var ini:TIniFile;
begin
 try
  ini:=TiniFile.Create(ap+'WINGRB.INI');
  if vv<>'' then ini.WriteString('General',nn,vv) else ini.DeleteKey('General',nn);
  ini.Free;
  result:=true;
 except
  result:=false;
 end;
end;

function popstr(var s:string;c:string):string;
var i:integer;
begin
 i:=pos(c,s);
 if i=0 then begin result:=s; s:='';end else
  begin
   result:=copy(s,1,i-1);
   i:=i+length(c);
   if c=' ' then
    while (i<=length(s)) and (s[i]=' ') do inc(i);
   s:=copy(s,i,length(s));
  end;
end;

function FindGrubFile(const fn:string):string;
var s:string; i:integer;
begin
 result:='';
 if FileExists(ap+'grub\'+fn+'_'+cg) then result:=fn+'_'+cg else
 for i:=length(cg)-1 downto 2 do
  begin
   s:=fn+'_'+copy(cg,1,i-1);
   if FileExists(ap+'grub\'+s) then
    begin
     result:=s;
     break;
    end
  end;
end;

function CopyGrubFile(const fn,dd:string):boolean;
var s:string;
begin
 if fn='GRUB.EXE' then s:='grexe' else s:=fn;
 s:=FindGrubFile(s);
 result:=(s<>'') and (CopyFile(pchar(ap+'grub\'+s),pchar(dd+fn),true));
end;

initialization
 AppInit();

finalization
 AppExit();

end.
