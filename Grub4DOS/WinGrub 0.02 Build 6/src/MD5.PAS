unit md5;

interface

const

 MD5_DIGEST_LENGTH=16;

type

 MD5_DIGEST = array [0..MD5_DIGEST_LENGTH-1] of byte;
 MD5_STATE = array[0..3] of longword;

 MD5_CTX = packed record
  state:MD5_STATE;
  count:array[0..1] of longword;
  buffer:array[0..63] of byte;
 end;

procedure md5_init(var ctx:MD5_CTX);
procedure md5_update(var ctx:MD5_CTX;input:pchar;length:longword);
procedure md5_final(var ctx:MD5_CTX;var digest:MD5_DIGEST);

implementation

uses Windows;

function F(x, y, z: DWORD): DWORD;
begin
	Result := (x and y) or ((not x) and z);
end;

function G(x, y, z: DWORD): DWORD;
begin
	Result := (x and z) or (y and (not z));
end;

function H(x, y, z: DWORD): DWORD;
begin
	Result := x xor y xor z;
end;

function I(x, y, z: DWORD): DWORD;
begin
	Result := y xor (x or (not z));
end;

procedure rot(var x: DWORD; n: BYTE);
begin
	x := (x shl n) or (x shr (32 - n));
end;

procedure FF(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, F(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

procedure GG(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, G(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

procedure HH(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, H(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

procedure II(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, I(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

// Encode Count bytes at Source into (Count / 4) DWORDs at Target
procedure Encode(Source, Target: pointer; Count: longword);
var
	S: PByte;
	T: PDWORD;
	I: longword;
begin
	S := Source;
	T := Target;
	for I := 1 to Count div 4 do begin
		T^ := S^;
		inc(S);
		T^ := T^ or (S^ shl 8);
		inc(S);
		T^ := T^ or (S^ shl 16);
		inc(S);
		T^ := T^ or (S^ shl 24);
		inc(S);
		inc(T);
	end;
end;

// Decode Count DWORDs at Source into (Count * 4) Bytes at Target
procedure Decode(Source, Target: pointer; Count: longword);
var
	S: PDWORD;
	T: PByte;
	I: longword;
begin
	S := Source;
	T := Target;
	for I := 1 to Count do begin
		T^ := S^ and $ff;
		inc(T);
		T^ := (S^ shr 8) and $ff;
		inc(T);
		T^ := (S^ shr 16) and $ff;
		inc(T);
		T^ := (S^ shr 24) and $ff;
		inc(T);
		inc(S);
	end;
end;

// Transform State according to first 64 bytes at Buffer
procedure Transform(Buffer: pointer; var State: MD5_STATE);
var
	a, b, c, d: DWORD;
	Block: array[0..15] of DWORD;
begin
	Encode(Buffer, @Block, 64);
	a := State[0];
	b := State[1];
	c := State[2];
	d := State[3];
	FF (a, b, c, d, Block[ 0],  7, $d76aa478);
	FF (d, a, b, c, Block[ 1], 12, $e8c7b756);
	FF (c, d, a, b, Block[ 2], 17, $242070db);
	FF (b, c, d, a, Block[ 3], 22, $c1bdceee);
	FF (a, b, c, d, Block[ 4],  7, $f57c0faf);
	FF (d, a, b, c, Block[ 5], 12, $4787c62a);
	FF (c, d, a, b, Block[ 6], 17, $a8304613);
	FF (b, c, d, a, Block[ 7], 22, $fd469501);
	FF (a, b, c, d, Block[ 8],  7, $698098d8);
	FF (d, a, b, c, Block[ 9], 12, $8b44f7af);
	FF (c, d, a, b, Block[10], 17, $ffff5bb1);
	FF (b, c, d, a, Block[11], 22, $895cd7be);
	FF (a, b, c, d, Block[12],  7, $6b901122);
	FF (d, a, b, c, Block[13], 12, $fd987193);
	FF (c, d, a, b, Block[14], 17, $a679438e);
	FF (b, c, d, a, Block[15], 22, $49b40821);
	GG (a, b, c, d, Block[ 1],  5, $f61e2562);
	GG (d, a, b, c, Block[ 6],  9, $c040b340);
	GG (c, d, a, b, Block[11], 14, $265e5a51);
	GG (b, c, d, a, Block[ 0], 20, $e9b6c7aa);
	GG (a, b, c, d, Block[ 5],  5, $d62f105d);
	GG (d, a, b, c, Block[10],  9,  $2441453);
	GG (c, d, a, b, Block[15], 14, $d8a1e681);
	GG (b, c, d, a, Block[ 4], 20, $e7d3fbc8);
	GG (a, b, c, d, Block[ 9],  5, $21e1cde6);
	GG (d, a, b, c, Block[14],  9, $c33707d6);
	GG (c, d, a, b, Block[ 3], 14, $f4d50d87);
	GG (b, c, d, a, Block[ 8], 20, $455a14ed);
	GG (a, b, c, d, Block[13],  5, $a9e3e905);
	GG (d, a, b, c, Block[ 2],  9, $fcefa3f8);
	GG (c, d, a, b, Block[ 7], 14, $676f02d9);
	GG (b, c, d, a, Block[12], 20, $8d2a4c8a);
	HH (a, b, c, d, Block[ 5],  4, $fffa3942);
	HH (d, a, b, c, Block[ 8], 11, $8771f681);
	HH (c, d, a, b, Block[11], 16, $6d9d6122);
	HH (b, c, d, a, Block[14], 23, $fde5380c);
	HH (a, b, c, d, Block[ 1],  4, $a4beea44);
	HH (d, a, b, c, Block[ 4], 11, $4bdecfa9);
	HH (c, d, a, b, Block[ 7], 16, $f6bb4b60);
	HH (b, c, d, a, Block[10], 23, $bebfbc70);
	HH (a, b, c, d, Block[13],  4, $289b7ec6);
	HH (d, a, b, c, Block[ 0], 11, $eaa127fa);
	HH (c, d, a, b, Block[ 3], 16, $d4ef3085);
	HH (b, c, d, a, Block[ 6], 23,  $4881d05);
	HH (a, b, c, d, Block[ 9],  4, $d9d4d039);
	HH (d, a, b, c, Block[12], 11, $e6db99e5);
	HH (c, d, a, b, Block[15], 16, $1fa27cf8);
	HH (b, c, d, a, Block[ 2], 23, $c4ac5665);
	II (a, b, c, d, Block[ 0],  6, $f4292244);
	II (d, a, b, c, Block[ 7], 10, $432aff97);
	II (c, d, a, b, Block[14], 15, $ab9423a7);
	II (b, c, d, a, Block[ 5], 21, $fc93a039);
	II (a, b, c, d, Block[12],  6, $655b59c3);
	II (d, a, b, c, Block[ 3], 10, $8f0ccc92);
	II (c, d, a, b, Block[10], 15, $ffeff47d);
	II (b, c, d, a, Block[ 1], 21, $85845dd1);
	II (a, b, c, d, Block[ 8],  6, $6fa87e4f);
	II (d, a, b, c, Block[15], 10, $fe2ce6e0);
	II (c, d, a, b, Block[ 6], 15, $a3014314);
	II (b, c, d, a, Block[13], 21, $4e0811a1);
	II (a, b, c, d, Block[ 4],  6, $f7537e82);
	II (d, a, b, c, Block[11], 10, $bd3af235);
	II (c, d, a, b, Block[ 2], 15, $2ad7d2bb);
	II (b, c, d, a, Block[ 9], 21, $eb86d391);
	inc(State[0], a);
	inc(State[1], b);
	inc(State[2], c);
	inc(State[3], d);
end;

// Initialize given Context
procedure md5_init(var ctx: MD5_CTX);
begin
 with ctx do
  begin
   state[0] := $67452301;
   state[1] := $efcdab89;
   state[2] := $98badcfe;
   state[3] := $10325476;
   count[0] := 0;
   count[1] := 0;
   fillchar(buffer,SizeOf(buffer),0);
  end;
end;

// Update given Context to include Length bytes of Input
procedure md5_update(var ctx:MD5_CTX;input:pchar;length:longword);
var
 index,partlen,i:longword;
begin
 with ctx do
  begin
   index := (count[0] shr 3) and $3f;
   inc(count[0], length shl 3);
   if count[0] < (length shl 3) then inc(count[1]);
   inc(count[1], length shr 29);
  end;
 partlen := 64 - index;
 if length >= partlen then
  begin
   move(input[0],ctx.buffer[index],partlen);
   Transform(@ctx.buffer, ctx.state);
   i := partlen;
   while i + 63 < length do
    begin
     Transform(@input[i], ctx.state);
     inc(i, 64);
    end;
   index := 0;
  end else i := 0;
 move(input[i],ctx.buffer[index],length - i);
end;

// Finalize given Context, create Digest and zeroize Context
procedure md5_final(var ctx:MD5_CTX;var digest:MD5_DIGEST);
var
 bits: array[0..7] of byte;
 idx: longword;
begin
 decode(@ctx.count, @bits, 2);
 idx := (ctx.count[0] shr 3) and $3f;
 ctx.buffer[idx]:=$80;
 inc(idx);
 if idx>56 then
  begin
   if (idx<>64) then fillchar(ctx.buffer[idx],64-idx,0);
   Transform(@ctx.buffer,ctx.state);
   idx:=0;
  end;
 if idx<>56 then fillchar(ctx.buffer[idx],56-idx,0);
 move(bits,ctx.buffer[56],8);
 Transform(@ctx.buffer,ctx.state);
 decode(@ctx.state, @digest, 4);
end;

end.

