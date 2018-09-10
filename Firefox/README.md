<h1><img src="resources/icon.png"/> Firefox</h1>

a portable firefox, but without any complex-wrappers such as the onces used for other portable-apps, 
this one just uses firefox and an explicit profile relative to the folders location. all is managed by the <code>firefox.cmd</code>. 

Note #1:
this is just a standard firefox, version <code>62.0a1</code>, from:
https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/firefox-62.0a1.en-GB.win64.zip

and it was made to run as portable without any complex wrapping or other programs, 
I've simply added a batch file to use a local-folder as the profile one.

Note #2:
another 'tweak' is a pre-set preference-files,
<code>channel-prefs.js</code> and <code>mozilla.cfg</code> contains <a href="https://support.mozilla.org/en-US/questions/1160596">a way to pre-set few preferences</a>, 
even before there is an actual profile created. it helps to avoid analytics-collection.
The settings are set using <code>prefLock</code> to prevent firefox from changing them (for example some UUID settings are set as an empty string, so this way firefox won't generate new ones, which help security, others are disabling metrics and statistics and sending them to Mozilla).

Note #3:
to complete the #2-part, <code>crashreporter.exe</code>, <code>maintenanceservice.exe</code>, <code>maintenanceserviceinstaller.exe</code>, <code>minidump-analyzer.exe</code>, <code>pingsender.exe</code>, <code>updater.exe</code> were renamed to avoid updating, ping-ing, or sending reports in the background.

Note #4:
Updates.
download the installer from https://www.mozilla.org/en-US/firefox/nightly/all/ or the zip from https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/ , extract the files with <a href="https://github.com/eladkarako/mods/tree/master/7z">7zip</a>, delete the old <code>firefox</code> folder and place the newer version.
All of tweaks above will be applied automatically just run <code>firefox.cmd</code>.

Note #5:
You can clear your profile by delete and recreate <code>profile</code> folder.

Note #6:
don't share the <code>pref.js</code> or the <code>profile</code> folder, it may contain private information.

Note #7:
you may change the profile-initial settings by editing <code>_mozilla.cfg_</code>, 
for example changing <code>lockPref("browser.search.countryCode", "IL");</code> to <code>lockPref("browser.search.countryCode", "US");</code>, 
or <code>lockPref("browser.search.defaulturl", "https://www.google.co.il/search?num=50&gbv=1&q=");</code> to <code>lockPref("browser.search.defaulturl", "https://www.google.com/search?num=100&gbv=1&q=");</code>.

Note #8:
The manifest is fine, no need to patch it.

<hr/>

Note #9:
a nice little trick to ignore everything inside the <code>profile</code> folder, 
but still keep the folder, is using the following <code>.gitignore</code> file at the project root:
<pre>
/profile/*
!/profile/.placeholder
</pre>

<hr/>

Note #10:
if only thing you want is to provide an override for the default preferences, 
you might just want to copy the <code>user.js</code> to the profile folder, 
at the same place as <code>prefs.js</code>. 
Firefox will load the "normal settings" from <code>prefs.js</code> and then add/override any preferences 
with the content of <code>user.js</code>.

Note #11:
You can use <code>Note #10</code> as an easy way to put the preferences you want, 
in <strong>Firefox for Android</strong>. All you have to do is to browse 
<code>/data/data/org.mozilla.firefox/files/mozilla/<strong>______</strong>.default</code> or 
<code>/data/data/org.mozilla.firefox_beta/files/mozilla/<strong>______</strong>.default</code>
you need to browse manually the last folder (you profile) since its name is randomly generated, 
so look for a folder with a <code>.default</code> suffix, and open it, it is your profile. Copy the <code>user.js</code> there.
Quit firefox (hard stop the application) and start it again to see the changes.

<hr/>

Note #12:
if you'll download <strong>Firefox for Android</strong> APK, 
for example, from: 
https://www.apkmirror.com/apk/mozilla/firefox/ 
https://www.apkmirror.com/apk/mozilla/firefox-beta/ 
https://www.apkmirror.com/apk/mozilla/firefox-nightly-for-developers/ 
and open it (it's a zip) with <a href="https://github.com/eladkarako/mods/tree/master/7z">7zip</a>, 
under the <code>/assets/</code> folder you'll find <code>omni.ja</code> (used to be <code>omni.jar</code> but renamed for security reasons... is a zip too), 
in <code>omni.ja</code> you'll find <code>/greprefs.js</code> and <code>/defaults/pref/mobile.js</code> and <code>/defaults/pref/mobile-l10n.js</code>, 
which carries the preferences of the Firefox mobile addition (Android). It might be compatible with <code>mozilla.cfg</code> tweaking, or editing, 
but the simplest way is to copy the <code>user.js</code> after you've normally installed (an unmodified) Firefox on your Android.

to repack the APK, first extract <code>/defaults/pref/mobile.js</code> to your desktop, 
edit it, save it as UTF-8 (no BOM!) and Windows EOL (just to make sure comments won't mix lines...), 
copy <code>omni.ja</code> to your desktop and put-in the updated file. 
Optimize the zip by aligning it using <code>zipalign.exe -v 4 omni.ja</code>. 
Update the APK with the updated <code>omni.ja</code>. 
Delete the folder <code>META-INF</code>.

You may sign it yourself if you wish, by creating <code>generate_keystore.cmd</code>:

```cmd
@echo off

del /f /q "foo.keystore" 2>nul >nul

call keytool.exe  -genkeypair                                     ^
                  -alias       "alias_name"                       ^
                  -keyalg      "RSA"                              ^
                  -keysize     "2048"                             ^
                  -sigalg      "SHA1withRSA"                      ^
                  -validity    "10000"                            ^
                  -keypass     "111111"                           ^
                  -keystore    "foo.keystore"                     ^
                  -storepass   "111111"                           ^
                  -dname       "CN=*, OU=*, O=*, L=*, S=*, C=*"   ^
                  -v

::keytool -importkeystore -srckeystore foo.keystore -destkeystore foo.keystore -deststoretype pkcs12

pause
```

and <code>sign.cmd</code>:

```cmd
@echo off
if not exist "foo.keystore"   call "generate_keystore.cmd"

set FILE_SOURCE="%~1"
set FILE_TARGET="%~d1%~p1%~n1_signed%~x1"
copy /y %FILE_SOURCE% %FILE_TARGET% >nul

::call jarsigner.exe  -keystore     "foo.keystore"     ^
call D:\Software\Java\8\x64\JDK18~1.0_1\bin\JARSIG~1.EXE  -keystore     "foo.keystore"     ^
                    -storepass    "111111"           ^
                    -keypass      "111111"           ^
                    -digestalg    "SHA1"             ^
                    -sigalg       "SHA1withRSA"      ^
                    -verbose:all                     ^
                    -tsa          "http://sha1timestamp.ws.symantec.com/sha1/timestamp" ^
                    -strict                          ^
                    %FILE_TARGET%                    ^
                    alias_name

echo.
echo %FILE_SOURCE%
echo -^> %FILE_TARGET%
echo.
echo ------------------------------------
echo.
```

then drag and drop the apk over the <code>sign.cmd</code>, 
which will create (for example) <code>Firefox_Beta_45.0_2015401201_signed.apk</code> 

Optimize the APK too, for example, using <code>zipalign.exe -v 4 Firefox_Beta_45.0_2015401201_signed.apk</code> - if you've signed it, 
or <code>zipalign.exe -v 4 Firefox_Beta_45.0_2015401201.apk</code> - if you've skiped it.

again, on Android, prefer the <code>user.js</code> way, 
it is easier! 

