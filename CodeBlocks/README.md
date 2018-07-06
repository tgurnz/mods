<h1><img src="resources/icon.png"/> CodeBlocks <em>with MingW</em> - Portable!</h1>

This is a mod to make CodeBlocks fully portable, and movable, 
running perfectly using its built-in MingW.

<h3>1<sup>st</sup> modification: fully portable.</h3>

CodeBlocks is "almost" portable,
but even if you'll follow <a href="http://wiki.codeblocks.org/index.php/FAQ-Settings#Q:_Where_does_C::B.27s_configuration_file_store.3F_How_do_I_make_Code::Blocks_portable.3F">their instruction on how to make it "portable"</a>,
which is mostly just moving some INI files from <code>&percnt;AppData&percnt;\CodeBlocks\</code> to the exe-folder. 

<code>default.conf</code> and <code>codesnippets.ini</code> will still include the path to MingW, <strong>hard-coded</strong>.

launching CodeBlocks with <code>_start.cmd</code>, will update them both, with the current path,
so the local-WingW folder will work. This makes things slightly more portable..
you can place the entire folder on your flash-drive (or whatever..) and it will work just fine.



<h3>2<sup>nd</sup> modification: proper manifest.</h3>
every exe and dll in the CodeBlocks folder and MingW got the <a href="https://github.com/eladkarako/manifest/">proper manifest</a>, 
so everything should run fine on Windows-10 too.

<hr/>

You can update the CodeBlocks by placing it all in the program folder.

If you wish to use your own <code>default.conf</code> and <code>codesnippets.ini</code>, 
copy them and rename them to <code>default.conf.origin</code> and <code>codesnippets.ini.origin</code>, 
edit them so the <code>C:\Program Files\CodeBlocks\MingW</code> line will be <code>##HOME##\MingW</code>,
and place them instead of the current <code>default.conf.origin</code> and <code>codesnippets.ini.origin</code> files,
so when you'll run <code>_start.cmd</code>, the current-path will get updated and the proper <code>default.conf</code> and <code>codesnippets.ini</code> files 
will be written under the <code>program/.</code> folder.

<hr/>

there is an issue where if you'll do any settings-change, you must take the <code>default.conf</code>, 
and rename it to <code>default.conf.origin</code>, replacing the current-folder use back to <code>##HOME##</code>..

clarifying again, for now, your setting will be overwriten each time with the one stored in the <code>default.conf.origin</code> file, 
if you wish to keep them, you need to copy <code>default.conf</code> from the program folder, and renaming it to <code>default.conf.origin</code>, 
then you should edit the line of the program-path that ends with <code>(...the.program.path....)/MingW</code> to <code>##HOME##/MingW</code>.

<hr/>

Version used:
http://www.codeblocks.org/downloads/26 (standard binary), 
then downloading codeblocks-17.12mingw-setup.exe
( http://sourceforge.net/projects/codeblocks/files/Binaries/17.12/Windows/codeblocks-17.12mingw-setup.exe )

installing, choosing built-in MingW as default and grabing the %APPDATA%\CodeBlocks\ files, dropping them into the exe-folder.

<hr/>

How to download and use:
use https://github.com/eladkarako/partial-download-github-repository
to download just the <code>https://github.com/eladkarako/mods/tree/master/CodeBlocks</code> folder.
uncompress the <code>program.7z</code> - 50MB compressed/ 250MB uncompressed,
you should have a <code>program</code> folder (make sure you don't have <code>program/program/</code> folder..),
run CodeBlocks by executing <code>_start.cmd</code>.
