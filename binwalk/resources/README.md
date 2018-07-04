for debug-purposes the first line you'll see in the console is something like this: <br/>
<code>C:\Python\PYTHON~1.3\python.exe C:/Users/Elad/Desktop/build/program/binwalk.py sample_7z__LZMA2.unknown</code> <br/>
which is the python.exe path, the binwalk <code>__main__</code> script and the list of arguments, <br/>
you can safely ignore it, is it written to the STDERR stream and you can redirect the batch script to a file, <br/>
without it will be shown.


<hr/>

Here is the output you'll get by drag&amp;drop each of those archives over <code>binwalk.cmd</code>.

the compressed file is <code>sample.txt</code>.
the format are included for your information (with the fake extension <code>.unknown</code>).

to get the output you probably want to direct the STDOUT to a file, <br/>
or uncomment the <code>::pause</code> the the last few lines of <code>binwalk.cmd</code>.

<ul>
<li><code>binwalk.cmd sample_7z__LZMA2.unknown</code>
<pre>
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             7-zip archive data, version 0.4
</pre>
</li>

<li><code>binwalk.cmd sample_zip__legacy.unknown</code>
<pre>
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             Zip archive data, at least v1.0 to extract, compressed size: 6, uncompressed size: 6, name: sample.txt
138           0x8A            End of Zip archive, footer length: 22
</pre>
</li>
</ul>