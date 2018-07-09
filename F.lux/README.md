<h1><img src="resources/icon.png"/> F.lux</h1>

An old version of F.lux,<br/>
with Win10 manifest fixes and VERSIONINFO block added to the exe,<br/>
since the version-information was not added in the older versions,<br/>
it can be anything from 1.x.x to 2.x.x, it was originated at August 2009.<br/>
I've also set it to require admin rights both in the manifest and in the registry installation.<br/>

<hr/>

Flat installation,<br/>
just place anywhere <em>(by default <code>D:\Software\F.lux</code>)</em><br/>
and run <code>_install.reg</code>. To uninstall run <code>_uninstall.reg</code> (and optionally delete the folder).

For another location edit <code>_install.reg</code> and <code>_uninstall.reg</code>.<br/>

<hr/>

The <code>_install.reg</code> includes by default my home-location (Netanya, Israel),<br/>
"Netanya, Israel" accurate Latitude, Longitude are 32.3332,34.8546,<br/>
but don't use 323332 and 348546 since f.lux cut the two right digit (mod% 100)<br/>
to "calculate" two digits floating-point -so it will get 3485.46 (the moon??)<br/>
so use the hex of 3233 (32.33) and 3485 (34.85) instead.<br/>
you may change it before installation (in the reg file) or by using the program UI.

<hr/>

The <code>_install.reg</code> also apply a registry-fix (<code>GdiIcmGammaRange</code>) to enable colors lower than <code>3400k</code>,<br/>
the <code>_uninstall.reg</code> will restore the Windows-default,
If you want to apply the fix yourself (no need if you've run <code>_install.reg</code> already), run:

```ini
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ICM]
"GdiIcmGammaRange"=dword:00000100

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\ICM]
"GdiIcmGammaRange"=dword:00000100
```

and you can uninstall it (restoring Windows' default) using:
```ini
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ICM]
"GdiIcmGammaRange"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\ICM]
"GdiIcmGammaRange"=-
```

You can set Indoor (default d48===3400)/Outdoor (default 1964===6500) to something else,<br/>
for example:

Ember: 1200K<br/>
Candle: 1900K<br/>
Warm Incandescent: 2300K<br/>
Incandescent: 2700K<br/>
Halogen: 3400K<br/>
Fluorescent: 4200K<br/>
Sunlight: 5500K<br/>
<br/>

here are some of the most common for easier conversion:<br/>
<code>dword:000006a4</code>  1700k<br/>
<code>dword:0000073a</code>  1850k<br/>
<code>dword:00000960</code>  2400k<br/>
<code>dword:000009f6</code>  2550k<br/>
<code>dword:00000a8c</code>  2700k<br/>
<code>dword:00000bb8</code>  3000k<br/>
<code>dword:00000c80</code>  3200k<br/>
<code>dword:00000d16</code>  3350k<br/>
<code>dword:00001388</code>  5000k<br/>
<code>dword:0000157c</code>  5500k<br/>
<code>dword:00001770</code>  6000k<br/>
<code>dword:00001838</code>  6200k<br/>
<code>dword:00001964</code>  6500k<br/>
<code>dword:0000251c</code>  9500k<br/>
<code>dword:00003a98</code> 15000k<br/>

<img src="resources/color_table.png" alt=""/><br/>

<img src="resources/color_temperature_chart.jpg" alt=""/><br/>

<img src="resources/black_body_visible_spectrum.gif" alt=""/><br/>

<hr/>

There should not be updates for the program because of the <code>"DisableUpdate"=dword:00000001</code> part in <code>_install.reg</code>,<br/>
but you can also make sure of it by blocking those hosts in your <code>C:\Windows\System32\drivers\etc\hosts</code> file:

<pre>
#----------------------------------F.lux
0.0.0.0 forum.stereopsis.com
0.0.0.0 www.stereopsis.com
0.0.0.0 stereopsis.com
0.0.0.0 update.stereopsis.com
0.0.0.0 fluxupdate.stereopsis.com
0.0.0.0 justgetflux.com
0.0.0.0 forum.justgetflux.com
0.0.0.0 update.justgetflux.com
0.0.0.0 www.justgetflux.com
</pre>

