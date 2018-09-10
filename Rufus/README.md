<h1><img src="resources/icon.png" />Rufus Portable</h1>

an UnUPX version of <code>Rufus 2.18p</code> and <code>Rufus 3.0p</code>
the author <a href="https://github.com/pbatard/rufus/issues/1120#issuecomment-385928930">didn't agree to made one</a>,
so I've uncompressed both the main exe and the RCDATA (embedded) ones and re-integrated it with the main exe,
plus the manifest.

Original also here under resources folder, original is UnUPX without any embedded resources modified.

Download the latest binary-file (unmodified) from here: http://rufus.akeo.ie/downloads/
p is for portable.

source-code is here: https://github.com/pbatard/rufus
change-log is here: https://github.com/pbatard/rufus/blob/master/ChangeLog.txt

<hr/>

in-order to UnUPX it yourself, without re-compiling from source, 
you'll need <a href="https://en.wikipedia.org/wiki/UPX">UPX</a> binaries from here: https://github.com/upx/upx/releases/ (look for ones ending with 'w' such as 'upx394w.zip'),
<a href="https://en.wikipedia.org/wiki/Resource_Hacker">Resource-Hacker</a> from here: http://www.angusj.com/resourcehacker/resource_hacker.zip
and resource-compiler <a href="https://msdn.microsoft.com/en-us/library/windows/desktop/aa381055(v=vs.85).aspx">RC.exe</a> from here: https://github.com/eladkarako/rc-with-includes/archive/master.zip


assuming you'll download the latest version of Rufus, to that-point-in time you'll have: 'Rufus 2.18p.exe'
then you first run <code>upx -d "Rufus 2.18p.exe"</code> to uncompress it for Resource-Hacker.

then open-up resource-hacker select the RCDATA tree-node,
from the 'action' menu, choose 'Save RCDATA group to an .rc file',
create a new folder, and write down a name for the rc file (aaaa.rc should be fine),
uncompress 'rc-with-includes-master.zip' to a new folder and move 'aaaa.rc' and all the 'bin' file to the same folder,
along with 'rc.cmd'.
open up the 'aaaa.rc' and the move the top-most-line (the neutural language part) keeping just RCDATA lines.

open CMD in this folder, and run <code>upx -d * </code>
allow the entire process to finish, then drag and drop the aaaa.rc over rc.cmd,
it will compile it into aaaa.res file.

switch to resource-manager with Rufus opened from before,
choose from the 'action' menu 'add from a resource-file',
navigate to the newly compiled res file and open it.
choose the entire RCDATA choose overwrite and click import.
save the file and you should have it UPX free.

you can use https://github.com/eladkarako/manifest
to make it use a better manifest.

<hr/>

Or you can drag&amp;drop the exe of your choice over rcdata_unupx.cmd in the resources folder,
it will uncompress the main exe,
extract the resources using reshacker,
uncompress them too,
recompile them to res file, and create a new unupx file for you.

you can then rename it to your-liking and possibly manifest-patch it with https://github.com/eladkarako/manifest yourself.

<hr/>

you can find 'rufus-2.18p.exe' and 'rufus-3.0p' (unmodified) under the resources folder. it is UPX compressed (plus all its resources), and a fixed embedded (and external) manifest to work well with Windows 10.