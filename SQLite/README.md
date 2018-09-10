<h1><img src="resources/icon.png" />SQLite</h1>


<h3>About.</h3>
Full program, portable too (by design). <br/>


version <code>3.24.0.0</code> from <code>2018-06-04 19:24:41</code> <br/>
those are the Windows-x86 (32 bit) pre-compiled binaries of SQLite3, <br/>
from https://www.sqlite.org/2018/sqlite-tools-win32-x86-3240000.zip <br/>
<strong>slightly modified</strong>.


<h3>Modification?</h3>
modified with an accurate (was missing) VERSIONINFO block for both <code>sqldiff.exe</code> and <code>sqlite3_analyzer.exe</code>, <br/>
an icon (from https://commons.wikimedia.org/wiki/File:Sqlite-square-icon.svg which was then converted to several PNG-files using inkscape, for creating a Windows-compatible-icon for the icon-block in the exe) <br/>
and a <a href="https://github.com/eladkarako/manifest/blob/master/generic.manifest">proper Windows10 manifest</a> (using <a href="https://github.com/eladkarako/manifest">my Manifest tool</a>).


<h3>Download:</h3>
download just the <code>SQLite3</code> folder, <br/>
using <a href="https://github.com/eladkarako/github-partial-get/">github.com/eladkarako/github-partial-get</a> <br/>
with <code>https://github.com/eladkarako/mods/tree/master/SQLite3</code>. <br/>
place the downloaded folder anywhere and configure your editor/IDE/build-script to the location of the folder.


<h3>Resources:</h3>
in the <code>resource</code> folder you'll find two useful scripts, <br/>
that will VACUUM ( https://www.sqlite.org/lang_vacuum.html ) the common-files for Chromium and Firefox, <br/>
making the browsers faster. <br/>
adjust it to your browser/profile paths, will work on Chrome too, <br/>
(make sure close the browsers first..).