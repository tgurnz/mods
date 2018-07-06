<h1><img src="resources/icon.png"/> CCleaner</h1>

<ul>
<li>
Portable variation (uses <code>INI</code> in same-folder for storing the settings instead of the PC's-registry).
</li>
<li>
Version <code>5.41.129.6446</code> (<code>Compile_2018_0306_224357</code>).
</li>
<li>
Run auto-clean (using last settings) with: <code>ccleaner.exe /auto</code>.
</li>
<li>
<strong>You should block online-access from this program!!!</strong> - use your HOSTS file:
<pre>
0.0.0.0 app.piriform.com
0.0.0.0 badownload.piriform.com
0.0.0.0 bounce.mail.piriform.com
0.0.0.0 ccleaner.com
0.0.0.0 cdn.piriform.com
0.0.0.0 crash-reports.piriform.com
0.0.0.0 crash-stats.piriform.com
0.0.0.0 docs.piriform.com
0.0.0.0 download.ccleaner.com
0.0.0.0 download.piriform.com
0.0.0.0 forum.ccleaner.com
0.0.0.0 forum.piriform.com
0.0.0.0 license.piriform.com
0.0.0.0 mail.piriform.com
0.0.0.0 mta-7.mail.piriform.com
0.0.0.0 multimedia.mail.piriform.com
0.0.0.0 piriform.com
0.0.0.0 s1.ccleaner.com
0.0.0.0 secure.ccleaner.com
0.0.0.0 secure.piriform.com
0.0.0.0 service.piriform.com
0.0.0.0 speccy.piriform.com
0.0.0.0 static.piriform.com
0.0.0.0 sugar.piriform.com
0.0.0.0 support.ccleaner.com
0.0.0.0 support.piriform.com
0.0.0.0 translate.piriform.com
0.0.0.0 web1.license.piriform.com
0.0.0.0 web1.web-staging.piriform.com
0.0.0.0 web1.web.piriform.com
0.0.0.0 web2.web.piriform.com
0.0.0.0 web-staging.piriform.com
0.0.0.0 web.piriform.com
0.0.0.0 www.ccleaner.com
0.0.0.0 www.mail.piriform.com
0.0.0.0 www.piriform.com
</pre>
</li>
<li>
<code>updater.cmd</code> will download the latest version, overriding the current one (ini, branding.dll, CCleaner.dat will not be overrided).

Requires <code>cURL.exe</code> and <code>unzip.exe</code> somewhere in the PATH (or in this folder).

It will work even if you'll block the domains in your HOSTS file.
</li>
<li>
For obvious reasons it is the free-version (my license file isn't being shared...) nor the personal-ini settings, you'll get your own generated on first start (or copy your old ones..).
</li>
</ul>

<hr/>

Modifications:
<ul>
<li>
manifest with high DPI support and OS compatibility,
both embedded and external-file.
</li>
<li>
Dialogs #<code>129,203,206,207,208,209,212,222</code> were modified to have a slightly larger font-size of <code>12</code> instead of <code>8</code> (unmodified font-family of <code>Tahoma</code>).
</li>
<li>
You can find in the exe an embedded INI settings for various cleaning tasks,
those are used by the program itself (same format as <code>ccleaner.ini</code>),
I've exported the INI files and you can view them in the resources folder.
</li>
</ul>
