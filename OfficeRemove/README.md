<h1>office_remove</h1>

<h2>Official From Microsoft : Remove Microsoft Office Installation - Files And Registry + My Additions To Remove Extra Registry Keys</h2>

<h3>How to run (example)</h3>
<ol>
<li><h2>If you can - use classic uninstall or CCleaner's uninstall to remove the program.</h2></li>
<li><h3>Open up <code>CMD</code> (as <strong>administrator</strong>!).</h3></li>
<li><h3><code>C:\Windows\System32\cscript.exe  //NOLOGO "C:\Users\Elad\Desktop\office_remove\2013\OffScrub03.vbs"</code></h3></li>
<li><h3>Repeat the same for each vbs..</h3></li>
<li><h3>Run <code>uninstall_office_reg_keys.reg</code> to remove extra leftover registry-keys.</h3></li>
<li><h3>Optionally go ahead to <a href="https://github.com/eladkarako/WinInstaller-Cleanup-3">https://github.com/eladkarako/WinInstaller-Cleanup-3</a> and look for a missing entries related to <code>Microsoft Office</code></h3></li>

<li><h3>download and execute CCleaner, preform cleanup, then switch to registry fix section and execute scan and fix.</h3></li>
<li><h3>done.</h3></li>
</ol>


<pre>
/
|   run_command_cmd.txt
|   uninstall_office_reg_keys.reg
|   
+---2007
|       OffScrub07.vbs
|       
+---2010
|       ErrorPageMsi.msi
|       Monitor.vbs
|       OffScrub10.vbs
|       
+---2013
|       CompVerbose.txt
|       FileList.txt
|       OffScrub03.vbs
|       RegList.txt
|       SkuLog.txt
|       {9017040D-6000-11D3-8CFE-0150048383C9}.msi
|       {90F8040D-6000-11D3-8CFE-0150048383C9}.msi
|       
\---O15CTRRemove
    |   cleanospp.cab
    |   CL_Office.ps1
    |   DiagPackage.cat
    |   DiagPackage.diagpkg
    |   DiagPackage.dll
    |   OffScrubc2r.vbs
    |   OffScrub_O15msi.vbs
    |   OffScrub_O16msi.vbs
    |   RC_RemoveO15ClickToRun.ps1
    |   rc_removeo15clicktorun.psd1
    |   RS_RemoveO15ClickToRun.ps1
    |   rs_removeo15clicktorun.psd1
    |   TS_Main.ps1
    |   utils_SetupEnv.ps1
    |   VF_RemoveO15ClickToRun.ps1
    |   vf_removeo15clicktorun.psd1
    |   
    +---cleanospp
    |       cleanospp.exe
    |       msvcr100.dll
    |       
    +---en-us
    |       en-us.cat
    |       rc_removeo15clicktorun.psd1
    |       rs_removeo15clicktorun.psd1
    |       vf_removeo15clicktorun.psd1
    |       
    \---fr-fr
            fr-FR.cat
            rc_removeo15clicktorun.psd1
            rs_removeo15clicktorun.psd1
            vf_removeo15clicktorun.psd1
            
</pre>