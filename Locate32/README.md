<h1><img src="resources/icon.png"/> Locate32-Portable</h1>

A modified version of Locate32 v3.1.11.7100 - 32bit<br/>
The modification nature is a Windows10 embedded (and external) manifest.

This <code>Locate32</code> version is also semi-portable, 
with the configurations kept in <code>portable.reg</code>, 
and the database files written, with a relative-path to the local <code>db</code>-folder.

To downloaded just this folder (instead of all of the <code>mods</code> repository), 
first download: https://github.com/eladkarako/github-partial-get 
then paste it the string: <code>https://github.com/eladkarako/mods/tree/master/Locate32</code> .

Copy all of the files and anywhere you'll like. 
Before running anything, I advice you'll uninstall any existing Locate32 from your PC, 
and clear up any residues using <code>resources/_clean_all.cmd</code> (run as admin).

<h3>First-time usage.</h3>
Start <code>locate32.exe</code>, and modify the existing settings to your needs, 
modifying DB drives/names/update. Another example exist in <code>resources/portable_db_has_c_d_only.reg</code>.
Once you've modified the settings, and before updating the databases, fully close-down Locate32, 
use <code>File - Exit</code>, and use the Windows task-manager to make sure <code>locate32.exe</code> isn't running, 
Edit (using Notepad++/Notepad2) the <code>portable.reg</code> file, 
modifying lines like <code>"ArchiveName"="D:\\Software\\Locate32\\db\\c.dbs"</code>, 
leaving just: <code>"ArchiveName"="db\\c.dbs"</code> (look for other lines looking like this and edit them too),
this change will make Locate32 "more portable", since the access to the database files will not be "hard-coded". 
This tweak is not native to the program, so everytime you'll edit the settings, you better close down the program, 
and make sure <code>portable.reg</code> still has the "relative" format.

<h3>Keep a copy of <code>portable.reg</code>!!!</h3>
<code>portable.reg</code> and Locate32 registry-entries too for that matter, 
got/still get corrupted very easily due to the program not writing properly and often unloads before it writes down the configurations as it should.
The settings: <code>Leave Locate32 running on background when the main dialog is closed.</code> is ON by default, which makes those issues slightly better (and Locate32 launch slightly faster too).
But if for some reason you'll open up Locate32 and see that it looks "raw"/"default", close it down, run <code>_clean_all.cmd</code> and rename your backup to <code>portable.reg</code> placing it in the main folder. STILL KEEP A BACKUP FOR THE NEXT TIME!!!

Try not to run more then one process of <code>locate32.exe</code> at a time, 
the program should have set keyboard shortcuts for <code>Win+F</code> and <code>F3</code> (when cursor is placed in a Windows-explorer URL addresbar).

<hr/>

<h3>Run as admin - useful!</h3>
Since this program is kind-of a "mini-explorer", and you can rename/copy/move/delete file, 
it is better to make sure it always runs "As an Administrator". 
Right click <code>locate32.exe</code>, properties, compatibility tab, check ON <code>Run this program as an administrator</code>, 
click <code>change settings for all users</code> button, again check ON <code>Run this program as an administrator</code>, click OK and OK again.
do this for all of the EXE-files in the folder.

<hr/>

<h3>Blocking online access</h3>
This program is quite safe but here are some of the URLs that you might want to block through your HOSTS file:
<pre>
#-------------------------------------locate32
0.0.0.0 locate32.net
0.0.0.0 www.locate32.net
0.0.0.0 locate32.cogit.net
</pre>