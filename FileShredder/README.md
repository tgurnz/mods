<h1><img src="resources/icon.png"/> FileShredder</h1>

<em>Pow-Tools</em> <strong>File-Shredder</strong> <code>v2.5.5.60</code> (2007), <br/>
from http://www.fileshredder.org .
with a patched manifest that required administrator-rights, and will fix registring the shell-extension.

This is the complete program, flat (no installation) but not portable (it uses registry to store its settings).

<hr/>

place the program anywhere, and modify the paths in the reg-files for the current folder-path the program is, <br/>
run <code>_uninstall.reg</code> then <code>_install.reg</code>, <br/>
<strong>if you are using a x32 bit system (a.k.a. x86, a.k.a. "not a x64 one") delete <code>fsshell.dll</code>, <br/>
and copy <code>fsshell_x32.dll</code> from the <code>resources/</code> folder to the program-folder, <br/>
renaming it to <code>fsshell.dll</code>.</strong>
optionally open up <code>Shredder.exe</code> and manually select the 'enable shell integration' checkbox for adding <br/>
a right-click context-menu-item.

<hr/>

The <code>resource/</code> folder also contains the older v1.0.0 (x86/x32 bit only) that might work better on Windows-XP.