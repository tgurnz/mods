<h1>Chromium</h1>
with this you can have some improved clarity on windows.
seems that when overriden as an internal resource, it won't work well...
but side-by-side works ok'ish...

have a look at the manifest file and update the second <code>dependentAssembly</code><br/>
it should be the current version, you can find out what it is from the <code>chrome.exe</code> file.

You can have an additional scroll accuracy if you'll add<br/>
the support of high-dpi scrolling,

see <code>generic_extended.manifest</code> on <a href="https://github.com/eladkarako/manifest/">https://github.com/eladkarako/manifest/</a>.

<hr/>

You can also disable the dpi awareness if it case problems but you'll need <a href="https://gist.github.com/eladkarako/d24d5ed3c917ef230b0fc990104f9fe6">a side-by-side registry override</a>.