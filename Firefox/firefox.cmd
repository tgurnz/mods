@echo off
chcp 65001 2>nul >nul

::this directory (8.3 name).
set "HOME=%~sdp0"
::remove '\' suffix.  
set "HOME=%HOME%##"
set "HOME=%HOME:\##=%"
set "HOME=%HOME:##=%"

set "FIREFOX=%HOME%\firefox\firefox.exe"
set "PROFILE=%HOME%\profile"

if not exist %FIREFOX% ( 
  echo [ERROR]
  echo you need to download and extract firefox to the firefox folder, 
  echo see the README.md in that folder.
  pause
  goto END
) 

::empty folder for profile.
if not exist %PROFILE% ( 
  mkdir "%PROFILE%\"               1>nul 2>nul
  echo. >"%PROFILE%\.placeholder"
) 


::block analytics/update services
ren "%HOME%\firefox\crashreporter.exe"                "_crashreporter.exe_"                             1>nul 2>nul
ren "%HOME%\firefox\maintenanceservice.exe"           "_maintenanceservice.exe_"                        1>nul 2>nul
ren "%HOME%\firefox\maintenanceservice_installer.exe" "_maintenanceservice_installer.exe_"              1>nul 2>nul
ren "%HOME%\firefox\minidump-analyzer.exe"            "_minidump-analyzer.exe_"                         1>nul 2>nul
ren "%HOME%\firefox\pingsender.exe"                   "_pingsender.exe_"                                1>nul 2>nul
ren "%HOME%\firefox\updater.exe"                      "_updater.exe_"                                   1>nul 2>nul
::block experiments
ren "%HOME%\firefox\browser\features"                 "_features_"                                      1>nul 2>nul
::no need for uninstaller....
ren "%HOME%\firefox\uninstall"                        "_uninstall_"                                     1>nul 2>nul
::copy defaults (channel-prefs.js contain instruction on where to find mozilla.cfg --- in the programs-folder. mozilla.cfg contains all the "stuff" - preferences needed, instead of 'user_pref', they are 'pref' which is stronger).
copy /b /y "%HOME%\_channel-prefs.js_"                "%HOME%\firefox\defaults\pref\channel-prefs.js"   1>nul 2>nul
copy /b /y "%HOME%\_mozilla.cfg_"                     "%HOME%\firefox\mozilla.cfg"                      1>nul 2>nul

start /low "cmd /c "call %FIREFOX% -profile %PROFILE% -foreground -nosplash""

goto END


:END
  exit /b %ErrorLevel%
