<h1><img src="resources/icon.png"/> DOSBox - &nbsp; &nbsp; <a href="https://paypal.me/e1adkarak0" ok><img src="https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png" alt="PayPal Donation" ok></a></h1>

Couple of DOSBOX versions, with a slightly modified manifest to work in Windows 10,
plus removed registry/app virtualisation for better performances, GDI+ rendering, scaling and a stable pipe to the printer-driver.

Read more about those builds: <a href="http://www.dosbox.com/wiki/SVN_Builds">dosbox.com/wiki/SVN_Builds</a>

<h3>Tip: Portable Mode!</h3>
To run in portable mode, use <code>-conf </code> specifying a <a href="https://www.dosbox.com/wiki/Dosbox.conf">conf file</a> other than the default one in the user-profile and the enhanced version, with no console that quits when the application ends: <code>dosbox.exe "...path_to\application.exe" -noconsole -exit -conf "...path_to\your_dosbox.conf"</code>. Alternatively, specify your application commands in a custom-conf file, for example this is for running Mortal-Kombat 2 ;)

<pre>
[autoexec]
mount c c:\
cd MK2
ultramid.exe -q -c -m100
mk2.exe
</pre>

