<img alt="" src="resources/icon.gif"/>

<pre>
a flat-pack, modified (slightly) version of 7Zip-ZSTD,
with an added manifest resource for
a Windows 10 support, better text rendering and
scaling for high-DPI screens,
and reduced resources-usage due to not using 
Windows' sandbox-virtualization.
</pre>

<hr/>

current version is <code>17.01 ZS v1.3.1 R1 (Based On 17.1.0.0)</code>,<br/>
based on latest <a href="https://github.com/mcmilk/7-Zip-zstd/releases/">7zip-ZStandard</a>.

<hr/>

How to use:<br/>
<ol>
<li>
  Cleanup previous versions of 7-zip:</br>
  it is advised that you first uninstall any<br/>
  7-zip shell-extensions. Next uninstall and remove<br/>
  and existing versions of 7-zip you currently have.<br/>
  You can use <a href="https://www.piriform.com/ccleaner/download">CCleaner</a> for that.<br/>
  Finally, use the reg-scan/clean of <a href="https://www.piriform.com/ccleaner/download">CCleaner</a>.<br/>
</li>
<li>Download this repository as a zip: <a href="https://github.com/eladkarako/7z-mod/archive/master.zip">github.com/eladkarako/7z-mod/archive/master.zip</a></li>
<li>Extract to your desktop</li>
<li>
  From the <code>uninstall</code>folder, run <code>uninstall.reg</code> to finish the cleanup process,<br/>
  it will also remove any old-settings, associations, shell-extension handles and other registry-leftovers.<br/>
  <br/>
  restart your PC to complete the process.
</li>
<li>
  Copy just the version you want to use (32bit/64bit/64bit_ia)<br/>
  to your prefered location,<br/>
  you may delete the other folders.<br/>
  
  Rename the folder to whatever name you want (for example <code>7zip</code>).<br/>
</li>
<li>
  Start <code>7zFM.exe</code> from your location,<br/>
  optionally set the settings and associations,<br/>
  those will be stored in the registry,<br/>
  so it is best to avoid if you're running from a flash-drive.
  <br/>
  Your settings will be stored in the registry in <code>HKEY_CURRENT_USER\Software\7-Zip-ZStandard</code><br/>
</li>
</ol>

