<h1><img src="resources/icon.png"/> cURL</h1>

v7.60.0, updated at May 16<sup><em>th</em></sup>, 2018, <br/>
with modified manifest to work with Windows 10, a wrapper batch-file (and a readme updater).

I'm using the x86 (32 bit) version since it does not matter, <br/>
and this way it will have wider support on older systems.

<pre>
curl 7.60.0 (i386-pc-win32) libcurl/7.60.0 OpenSSL/1.1.0h (WinSSL) zlib/1.2.11 brotli/1.0.5 WinIDN libssh2/1.8.0 nghttp2/1.32.0
Release-Date: 2018-05-16
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS IDN IPv6 Largefile SSPI Kerberos SPNEGO NTLM SSL libz brotli TLS-SRP HTTP2 HTTPS-proxy MultiSSL 
</pre>

<hr/>

original: <br/>
https://curl.haxx.se/download.html#Win32 <br/>
https://bintray.com/artifact/download/vszakats/generic/curl-7.60.0-win32-mingw.zip <br/>

compiled by <a href="https://bintray.com/vszakats/generic/curl/">Viktor Szakats</a>. <br/>
(it seems to be the best of the Windows binaries).

<hr/>

<h2>Also..</h2>

<code>curl.cmd</code> helps you by providing commonly-used command-line arguments, <br/>
such as UserAgent and Referer HTTP-headers, very permissive secure-downloads, <br/>
continue of partially-downloaded files and IPv4 favoring over IPv6 which is buggy in Windows versions of cURL.
<br/>
Note: In Windows, <code>curl.cmd</code> will be favored when calling <code>curl</code> without extension, <br/>
which will make usage easier for future/past downloads, seamlessly integrating <code>curl.cmd</code> in your existing scripts.<br/>
<br/>
Tip: Add the cURL folder to the system-PATH for an easier usage from every folder.<br/>

<hr/>

the resources folder contains <code>curl-7.46.0-win32 compatible with Windows XP.7z</code>, <br/>
which should work on older operation-systems, <br/>
and another batch to update the curl 'manual' which is an extended version of the curl 'help.
