<h1><img src="resources/icon.png"/> BusyBox</h1>

simply added a proper manifest.

<hr/>

What is busybox: https://en.wikipedia.org/wiki/BusyBox 

<hr/>

this is version 1.29 (May 13<sup><em>th</em></sup>, 2018), <br/>
https://frippery.org/files/busybox/busybox-w32-FRP-2187-g28ade29e9.exe <br/>

which is the currently most updated version, I'm using the x86 (32 bit) version since it has no major differences vs. the x64 one, <br/>
and this one has wider support for older systems.<br/>
You can download other versions for Windows from: https://frippery.org/files/busybox/?C=M;O=D <br/>
Best to avoid the ones with 'glob' in their names, they have native support for the <code>*</code>-character, <br/>
for Windows, which seems useful - but will often get process twice by Windows and the script itself, in an unexpected ways...

<hr/>

Here is the console-'help':

<pre>
BusyBox v1.29.0-FRP-2187-g28ade29e9 (2018-05-13 08:59:14 BST) multi-call binary
(mingw32-gcc 7.2.0-1.fc28; mingw32-crt 5.0.2-2.fc27)

BusyBox is copyrighted by many authors between 1998-2018.
Licensed under GPLv2. See source distribution for detailed
copyright notices.

Usage: busybox [function [arguments]...]
   or: busybox --list[-full]
   or: busybox --install [DIR]
   or: function [arguments]...

	BusyBox is a multi-call binary that combines many common Unix
	utilities into a single executable.  The shell in this build
	is configured to run built-in utilities without $PATH search.
	You don't need to install a link to busybox for each utility.
	To run external program, use full path (/sbin/ip instead of ip).

Currently defined functions:
	[, [[, ar, arch, ash, awk, base64, basename, bash, bunzip2, busybox, bzcat, bzip2,
	cal, cat, chmod, cksum, clear, cmp, comm, cp, cpio, cut, date, dc, dd, df, diff,
	dirname, dos2unix, dpkg-deb, du, echo, ed, egrep, env, expand, expr, factor, false,
	fgrep, find, fold, fsync, ftpget, ftpput, getopt, grep, groups, gunzip, gzip, hd,
	head, hexdump, id, ipcalc, kill, killall, less, link, ln, logname, ls, lzcat, lzma,
	lzop, lzopcat, man, md5sum, mkdir, mktemp, mv, nc, nl, od, paste, patch, pgrep, pidof,
	pipe_progress, pkill, printenv, printf, ps, pwd, rev, rm, rmdir, rpm, rpm2cpio, sed,
	seq, sh, sha1sum, sha256sum, sha3sum, sha512sum, shred, shuf, sleep, sort, split,
	ssl_client, stat, strings, sum, tac, tail, tar, tee, test, timeout, touch, tr, true,
	truncate, ttysize, uname, uncompress, unexpand, uniq, unix2dos, unlink, unlzma,
	unlzop, unxz, unzip, usleep, uudecode, uuencode, vi, watch, wc, wget, which, whoami,
	whois, xargs, xxd, xz, xzcat, yes, zcat
</pre>

<hr/>

here is the full list of commands contained, <br/>
(using <code>busybox.exe --list-full</code>):

<pre>
NOFORK  [
NOFORK  [[
        ar
NOFORK  arch
        ash
noexec  awk
        base64
NOFORK  basename
        bash
        bunzip2
        busybox
        bzcat
        bzip2
noexec  cal
        cat
noexec  chmod
noexec  cksum
NOFORK  clear
        cmp
        comm
noexec  cp
        cpio
noexec  cut
noexec  date
        dc
noexec  dd
noexec  df
        diff
NOFORK  dirname
noexec  dos2unix
        dpkg-deb
        du
NOFORK  echo
        ed
        egrep
noexec  env
        expand
noexec  expr
        factor
NOFORK  false
        fgrep
noexec  find
noexec  fold
NOFORK  fsync
        ftpget
        ftpput
noexec  getopt
        grep
noexec  groups
        gunzip
        gzip
noexec  hd
noexec  head
noexec  hexdump
noexec  id
noexec  ipcalc
NOFORK  kill
NOFORK  killall
        less
NOFORK  link
noexec  ln
NOFORK  logname
noexec  ls
        lzcat
        lzma
        lzop
        lzopcat
        man
noexec  md5sum
NOFORK  mkdir
noexec  mktemp
noexec  mv
        nc
        nl
        od
noexec  paste
        patch
        pgrep
        pidof
        pipe_progress
        pkill
NOFORK  printenv
NOFORK  printf
noexec  ps
NOFORK  pwd
        rev
noexec  rm
NOFORK  rmdir
        rpm
        rpm2cpio
        sed
noexec  seq
        sh
noexec  sha1sum
noexec  sha256sum
noexec  sha3sum
noexec  sha512sum
        shred
noexec  shuf
        sleep
noexec  sort
        split
        ssl_client
noexec  stat
        strings
        sum
noexec  tac
        tail
        tar
        tee
NOFORK  test
        timeout
NOFORK  touch
        tr
NOFORK  true
NOFORK  truncate
NOFORK  ttysize
NOFORK  uname
        uncompress
        unexpand
        uniq
noexec  unix2dos
NOFORK  unlink
        unlzma
        unlzop
        unxz
        unzip
NOFORK  usleep
        uudecode
        uuencode
        vi
        watch
        wc
        wget
NOFORK  which
NOFORK  whoami
        whois
noexec  xargs
noexec  xxd
        xz
        xzcat
noexec  yes
        zcat
</pre>