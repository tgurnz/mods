@echo off
chcp 65001 2>nul >nul


::this directory (8.3 name).
set "HOME=%~sdp0"
::remove '\' suffix.  
set "HOME=%HOME%##"
set "HOME=%HOME:\##=%"
set "HOME=%HOME:##=%"
::escape '\' to '\\' for using SED to modify 'default.conf'
set "ESCAPED=%HOME%"
set "ESCAPED=%ESCAPED:\=\\%"
::double-escape '\\' to '\\\\' for using SED to modify 'codesnippets.ini'
set "DOUBLE_ESCAPED=%HOME%"
set "DOUBLE_ESCAPED=%DOUBLE_ESCAPED:\=\\\\%"


::-----------------------------------------------------------------------------------------

echo ----------------------------------------------------------------
echo Continue?
echo -----------
echo overwrite: .\program\default.conf
echo with:      .\default.conf.origin
echo ----------------------------------------------------------------
echo if NOT - press CTRL+C now.
echo ----------------------------------------------------------------
echo keep your settings?
echo press CTRL+C now, and copy program\default.conf
echo to default.conf.origin replacing %HOME% with '##HOME##'.
echo ----------------------------------------------------------------
pause
pause

::-----------------------------------------------------------------------------------------


::check files exist
if not exist "%HOME%\default.conf.origin"       ( goto ERROR_DEFAULTCONFORIGIN     )
if not exist "%HOME%\codesnippets.ini.origin"   ( goto ERROR_CODESNIPPETSINIORIGIN )
if not exist "%HOME%\program\CbLauncher.exe"    ( goto ERROR_CBLAUNCHER            )


::info
echo [INFO] Running From:  %HOME%


::updating
echo [INFO] Updating 'default.conf' and 'codesnippets.ini'...

call "%HOME%\resources\sed.exe"  -e "s,\#\#HOME\#\#,%ESCAPED%\\program,g"           "%HOME%\default.conf.origin"      2>nul 1>%HOME%\program\default.conf
if not exist "%HOME%\program\default.conf"       ( goto ERROR_DEFAULTCONF     )

call "%HOME%\resources\sed.exe"  -e "s,\#\#HOME\#\#,%DOUBLE_ESCAPED%\\\\program,g"  "%HOME%\codesnippets.ini.origin"  2>nul 1>%HOME%\program\codesnippets.ini
if not exist "%HOME%\program\codesnippets.ini"   ( goto ERROR_CODESNIPPETSINI )


::done
echo [INFO] Launching 'CbLauncher.exe'...
start /abovenormal /max "cmd /c "call %HOME%\program\CbLauncher.exe""


echo [INFO] Done.


goto END


::--------------------------------------------------------error handling
:ERROR_DEFAULTCONFORIGIN
  echo [ERROR] missing:  %~dp0default.conf.origin                     1>&2
  goto END

:ERROR_CODESNIPPETSINIORIGIN
  echo [ERROR] missing:  %~dp0codesnippets.ini.origin                 1>&2
  goto END

:ERROR_CBLAUNCHER
  echo [ERROR] missing:  %~dp0program\CbLauncher.exe                  1>&2
  echo         make sure you have extract 'program.7z'                1>&2
  goto END

:ERROR_DEFAULTCONF
  echo [ERROR] write error, missing:  %~dp0program\default.conf       1>&2
  goto END

:ERROR_CODESNIPPETSINI
  echo [ERROR] write error, missing:  %~dp0program\codesnippets.ini   1>&2
  goto END

:END
  call "%HOME%\resources\SleepEx.exe" 5000
  exit /b 0
