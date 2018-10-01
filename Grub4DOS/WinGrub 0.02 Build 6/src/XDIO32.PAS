unit XDIO32;

interface

const
 MAX_DKNO	= 10;

 XDE_SUCC	= 0;
 XDE_GERR	= 1;
 XDE_SERR	= 2;
 XDE_TODO	= 3;
 XDE_PLAT	= 4;
 XDE_NDRV	= 5;
 XDE_BVER	= 6;
 XDE_NAME	= 7;
 XDE_OPEN	= 8;
 XDE_PARM	= 9;
 XDE_HUGE	= 10;
 XDE_EOEM	= 11;
 XDE_NMEM	= 12;

 XDE_RDWR	= -1;

 XDM_FDSK	= 1;
 XDM_HDSK	= 2;
 XDM_LDSK	= 4;
 XDM_UCHS	= 4;
 XDM_MASK	= 7;

 XDF_HUGE	= 8;
 XDF_BASE	= 16;
 XDF_LENG	= 32;
 XDF_CHAR	= 64;
 XDF_WPRO	= 128;
 XDF_MASK	= $F8;

 XDS_ZERO	= 0;
 XDS_CURR	= 1;
 XDS_BASE	= 2;

 XDL_UNLK	= 1;
 XDL_LVL0	= 0;
 XDL_LVL1	= (2*1);
 XDL_LVL2	= (2*2);
 XDL_LVL3	= (2*3);
 XDL_LLMK	= $E;
 XDL_LLSH	= 1;
 XDL_NWRI	= (16*1);
 XDL_NMAP	= (16*2);
 XDL_DFMT	= (16*4);
 XDL_LFMK	= $70;
 XDL_LFSH	= 4;

type

 xd0_t=packed record
  flg:byte;
  drv:byte;
  res:word;
  pos:longword;
 end;

 xd1_t=packed record
  flg:byte;
  drv:byte;
  res:word;
  ps0:longword;
  ps1:longword;
 end;

 xd2_t=packed record
  flg:byte;
  drv:byte;
  res:word;
  pos:longword;
  bse:longword;
 end;

 xd3_t=packed record
  flg:byte;
  drv:byte;
  res:word;
  ps0:longword;
  ps1:longword;
  bs0:longword;
  bs1:longword;
 end;

 xd4_t=packed record
  flg:byte;
  drv:byte;
  res:word;
  pos:longword;
  bse:longword;
  len:longword;
 end;

 xd5_t=packed record
  flg:byte;
  drv:byte;
  res:word;
  ps0:longword;
  ps1:longword;
  bs0:longword;
  bs1:longword;
  ln0:longword;
  ln1:longword;
 end;

 xds_t=packed record
  sz0:longword;
  sz1:longword;
  spt:longword;
  nhd:longword;
  ncy:longword;
 end;

 xde_t=packed record
  cur:byte;
  nxt:byte;
  res:byte;
  dfs:byte;
  bse:longword;
  len:longword;
  ebs:longword;
 end;

 xdw_t=packed record
  map:longword;
  csm:array[0..25] of longword;
  xd0:xd0_t;
  xde:xde_t;
 end;

function _xd_init():integer; cdecl; external;
function _xd_exit():integer; cdecl; external;
function _xd_open(var xd;fn:pchar;fg:integer):integer; cdecl; external;
function _xd_close(var xd):integer; cdecl; external;
function _xd_size(var xd;var xds:xds_t):integer; cdecl; external;
function _xd_seek(var xd;pos:longint;how:integer):integer; cdecl; external;
function _xd_lseek(var xd;ps0,ps1:longint;how:integer):integer; cdecl; external;
function _xd_cpos(var xd;var pos:longint):integer; cdecl; external;
function _xd_lcpos(var xd;var ps0,ps1:longint):integer; cdecl; external;
function _xd_read(var xd;buf:pchar;len:integer):integer; cdecl; external;
function _xd_write(var xd;buf:pchar;len:integer):integer; cdecl; external;
function _xd_lock(var xd;fg:integer):integer; cdecl; external;
function _xd_reset(var xd):integer; cdecl; external;
function _xd_enum(var xd;var xe:xde_t):integer; cdecl; external;
function _xd_walk(var xw:xdw_t):integer; cdecl; external;

function _xd_char(fg:integer;var buf;len:integer;var ps:longword):integer; cdecl; external;
function _xd_blck(fg:integer;var buf;len:integer;var ps:longword):integer; cdecl; external;
function _xd_gosp(var xd,sp:integer):integer; cdecl; external;

implementation

uses Windows;

{$L ..\dmk\xdfn32.obj}
{$L ..\dmk\xdio32.obj}

procedure _memset(buf:pchar;val:integer;len:integer); cdecl;
asm
 push   edi
 mov    ecx,len
 mov    edi,buf
 mov    eax,val
 cld
 rep    stosb
 pop    edi
end;

procedure _memcpy(dst:pchar;src:pchar;len:integer); cdecl;
asm
 push	edi
 push	esi
 mov	esi,src
 mov	edi,dst
 mov	ecx,len
 cld
 rep	movsb
 pop	esi
 pop    edi
end;

procedure __llmul; register;
asm
 push	edx
 push	eax
 mov	eax,[esp+10h]
 mul	dword ptr [esp]
 mov	ecx,eax
 mov	eax,[esp+4]
 mul	dword ptr [esp+0Ch]
 add	ecx,eax
 mov	eax,[esp]
 mul	dword ptr [esp+0Ch]
 add	edx,ecx
 pop	ecx
 pop	ecx
 ret	8
end;

end.


