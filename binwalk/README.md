<h1><img src="resources/icon.png"/> binwalk</h1>

<strong>You need Python!</strong> <br/>
(I use WinPython, under <code>C</code> drive, and added <code> C:\Python\python-3.6.3 </code> (where <code>python.exe</code> is) to the system-<code>PATH</code>).

<br/>

version 2.1.2. <br/>

binwalk from https://github.com/ReFirmLabs/binwalk <br/>
pre-built, with a wrapper to help you use it under Windows.<br/>

will work just like in linux. <br/>

<hr/>

<h2>How to use?</h2>

download https://github.com/eladkarako/github-partial-get <br/>
and paste it <code>https://github.com/eladkarako/mods/tree/master/binwalk</code> . <br/>
keep <code>lib</code>, <code>program</code> and <code>binwalk.cmd</code>, place it anywhere, use it from anywhere, <br/>
no installation, no registry values. you still need python though!  <br/>

<hr/>

Here is the "help": <br/>

<pre>
Binwalk v2.1.2
Craig Heffner, ReFirmLabs
https://github.com/ReFirmLabs/binwalk

Usage: binwalk [OPTIONS] [FILE1] [FILE2] [FILE3] ...

Signature Scan Options:
    -B, --signature              Scan target file(s) for common file signatures
    -R, --raw=&lt;str&gt;              Scan target file(s) for the specified sequence of bytes
    -A, --opcodes                Scan target file(s) for common executable opcode signatures
    -m, --magic=&lt;file&gt;           Specify a custom magic file to use
    -b, --dumb                   Disable smart signature keywords
    -I, --invalid                Show results marked as invalid
    -x, --exclude=&lt;str&gt;          Exclude results that match &lt;str&gt;
    -y, --include=&lt;str&gt;          Only show results that match &lt;str&gt;

Extraction Options:
    -e, --extract                Automatically extract known file types
    -D, --dd=&lt;type:ext:cmd&gt;      Extract &lt;type&gt; signatures, give the files an extension of &lt;ext&gt;, and execute &lt;cmd&gt;
    -M, --matryoshka             Recursively scan extracted files
    -d, --depth=&lt;int&gt;            Limit matryoshka recursion depth (default: 8 levels deep)
    -C, --directory=&lt;str&gt;        Extract files/folders to a custom directory (default: current working directory)
    -j, --size=&lt;int&gt;             Limit the size of each extracted file
    -n, --count=&lt;int&gt;            Limit the number of extracted files
    -r, --rm                     Delete carved files after extraction
    -z, --carve                  Carve data from files, but don't execute extraction utilities
    -V, --subdirs                Extract into sub-directories named by the offset

Entropy Options:
    -E, --entropy                Calculate file entropy
    -F, --fast                   Use faster, but less detailed, entropy analysis
    -J, --save                   Save plot as a PNG
    -Q, --nlegend                Omit the legend from the entropy plot graph
    -N, --nplot                  Do not generate an entropy plot graph
    -H, --high=&lt;float&gt;           Set the rising edge entropy trigger threshold (default: 0.95)
    -L, --low=&lt;float&gt;            Set the falling edge entropy trigger threshold (default: 0.85)

Binary Diffing Options:
    -W, --hexdump                Perform a hexdump / diff of a file or files
    -G, --green                  Only show lines containing bytes that are the same among all files
    -i, --red                    Only show lines containing bytes that are different among all files
    -U, --blue                   Only show lines containing bytes that are different among some files
    -w, --terse                  Diff all files, but only display a hex dump of the first file

Raw Compression Options:
    -X, --deflate                Scan for raw deflate compression streams
    -Z, --lzma                   Scan for raw LZMA compression streams
    -P, --partial                Perform a superficial, but faster, scan
    -S, --stop                   Stop after the first result

General Options:
    -l, --length=&lt;int&gt;           Number of bytes to scan
    -o, --offset=&lt;int&gt;           Start scan at this file offset
    -O, --base=&lt;int&gt;             Add a base address to all printed offsets
    -K, --block=&lt;int&gt;            Set file block size
    -g, --swap=&lt;int&gt;             Reverse every n bytes before scanning
    -f, --log=&lt;file&gt;             Log results to file
    -c, --csv                    Log results to file in CSV format
    -t, --term                   Format output to fit the terminal window
    -q, --quiet                  Suppress output to stdout
    -v, --verbose                Enable verbose output
    -h, --help                   Show help output
    -a, --finclude=&lt;str&gt;         Only scan files whose names match this regex
    -p, --fexclude=&lt;str&gt;         Do not scan files whose names match this regex
    -s, --status=&lt;int&gt;           Enable the status server on the specified port
</pre>
