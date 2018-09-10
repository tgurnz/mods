<h2>This folder includes an updater of the latest nightly-build of Firefox.</h2>

<code>get_most_updated_url.cmd</code> gets the latest HTML content from 
https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/ 
and extracts the latest URL of en-GB for Windows x64bit, 
it then writes URL to the STDOUT and some other information to the STDERR (it can be ignored this way).

<code>updater.cmd</code> uses the data from <code>get_most_updated_url.cmd</code> simply downloads the URL using <code>aria2c.cmd</code>.

<hr/>

You need <code>aria2c.exe</code> and its wrapper-script <code>aria2c.cmd</code> from: 
https://github.com/eladkarako/mods/tree/master/Aria2 
and either place them in the system-PATH or in the same folder as <code>updater.cmd</code>.

<hr/>

Example data: 

URL:
https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/firefox-63.0a1.en-GB.win64.zip


aria2c.cmd:
D:\DOS\PARALL~2\aria2c.exe  --split=5 --min-split-size=1M --dir=. --referer="https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/firefox-63.0a1.en-GB.win64.zip" --file-allocation=falloc --save-session-interval=10 --human-readable=true --enable-color=true --user-agent="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:55.0) Gecko/20100101 Firefox/55.0" --http-no-cache=true --header="DNT: 1" --auto-save-interval=10 --content-disposition-default-utf8=true --retry-wait=2 --max-tries=10 --timeout=120 --connect-timeout=300 --max-file-not-found=1 --continue=true --allow-overwrite=false --auto-file-renaming=false --console-log-level=notice --check-certificate=false --check-integrity=false --http-auth-challenge=true --rpc-allow-origin-all=true --rpc-secure=false --max-concurrent-downloads=16 --max-connection-per-server=16 --enable-http-keep-alive=true --enable-http-pipelining=true --connect-timeout=120 --disable-ipv6=true --async-dns=true --async-dns-server=8.8.8.8,8.8.4.4 "https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/firefox-63.0a1.en-GB.win64.zip"


