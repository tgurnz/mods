@echo off
::              set code-page for UTF-8 charset.
chcp 65001

::              normalise to fully qualified path. short path (8.3) is used for testing the path.
set FOLDER=%~s1
for /f %%a in ("%FOLDER%") do ( set "FOLDER=%%~fsa" )

::              verify existing folder.
if ["%FOLDER%"]==[""]         ( goto RUN_STANDARD   )
if not exist %FOLDER%         ( goto RUN_STANDARD   )
if not exist %FOLDER%\NUL     ( goto RUN_STANDARD   )

goto RUN_FOLDER


::--------------------------------------------------------


:RUN_FOLDER
::             prefer long-path.
  set FOLDER=%~1
  echo.
  echo Starting Cygwin From ^[%FOLDER%^] ...
::             convert to cygwin-compatible path (forward-slash, removing drive's ":" and /cygdrive/ as root)
  set FOLDER=%FOLDER:\=/%
  set FOLDER=%FOLDER::/=/%
  set FOLDER=/cygdrive/%FOLDER%
  call "%~dp0bin\mintty.exe" "-i" "/Cygwin-Terminal.ico" %~dp0bin\bash.exe -l -c "cd \"%FOLDER%\"; exec bash" - 2>nul >nul
  goto EXIT


:RUN_STANDARD
  echo.
  echo Starting Cygwin From Home...
  call "%~dp0bin\mintty.exe" "-i" "/Cygwin-Terminal.ico" "-"   2>nul >nul
  goto EXIT


:EXIT

