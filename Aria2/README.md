<h1><img src="resources/icon.png"/> Aria2</h1>

<del>You can't edit the binary since it was built with <a href="https://github.com/aria2/aria2/issues/963">a weird packet-protector/compiler</a>, so if you need to run it on Windows-10 you can use <a href="https://gist.github.com/eladkarako/d24d5ed3c917ef230b0fc990104f9fe6">this registry fix</a>,<br/>and the generic manifest (put in the same folder) instead of modifying the binary...</del>

I'm using a statically built-version from <a href="https://github.com/q3aql/aria2-static-builds/">https://github.com/q3aql/aria2-static-builds/</a>,<br/>
which will allow both manifest and versioninfo block to be written without corrupting the execute.

I'm using the x86 32bit version since it makes no difference and allows wider os-compatibility.

useful batch files:

<code>aria2c.cmd</code> provides a very permissive-ssl connections (not verifying certificate etc...), 
<code>aria2download.cmd</code> is the legacy name for <code>aria2c.cmd</code> and <code>aria2list.cmd</code> simply adds the "using of list" as the first argument.

<hr/>

see all switched in <code>readme_aria2c.nfo</code>.

<hr/>

current version 1.34.0.0 from
https://github.com/q3aql/aria2-static-builds/releases/tag/v1.34.0
based on <del>https://github.com/aria2/aria2/releases/tag/release-1.34.0</del>(don't use this one!)
