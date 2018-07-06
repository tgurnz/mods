<h1><img src="resources/icon.png"/> Cygwin</h1>

<code>Cygwin.bat</code> - a modified batch file to place in the cygwin folder, 
it allows passing a folder as an argument, to start the cygwin terminal directly-there, 
without the need to <code>cd</code>, <code>cd</code>, <code>cd</code>, ...
it uses the folder "short path" (8.3 DOS format) to avoid Unicode/spaces/etc.. issues.

<code>open_in_cygwin.reg</code> - adds an item ("open in cygwin") for each folder.
<code>open_in_cygwin_uninstall.reg</code> - removes it.

you need to edit the <code>reg</code> files to the current path of cygwin, installed on your system, 
my is at <code>c:\cygwin</code> (in <code>reg</code> files you need to escape <code>\</code> into <code>\\</code>).

<hr/>

the resources folder includes some tweaks you can drop in your <code>/home/USERNAME</code>, 
<code>.bash_history</code> includes just my past commands (backup for me really..) .
<code>.bashrc</code> (and <code>.bashrc_original</code> to help you see the changes) adds JAVA to the cygwin path.
<code>.inputrc</code> adds some keyboard hooks for arrow-keys with ctrl / del / backspace.

<code>.minttyrc</code> is the configuration for the font for the terminal.
<code>.mkshrc</code> adds some thing (?) .
<code>.profile</code> makes sure <code>.bashrc</code> is loaded.
<code>.parallel</code> folder hides the message in the parallel script (may duplicate for other 'cite' scripts).