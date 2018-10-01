@echo off
set "EXIT_CODE=0"
chcp 65001 2>nul >nul

set "PYTHON="
for /f "tokens=*" %%a in ('where python.exe 2^>nul') do ( set "PYTHON=%%a" )
if ["%ErrorLevel%"] NEQ ["0"]  ( goto ERROR_NOPYTHON  )
if ["%PYTHON%"]     EQU [""]   ( goto ERROR_NOPYTHON  )
for /f %%a in ("%PYTHON%") do  ( set "PYTHON=%%~fsa"  )

set "PROGRAM=%~sdp0pyglossary.pyw"
if not exist "%PROGRAM%"       ( goto ERROR_NOPROGRAM )
for /f %%a in ("%PROGRAM%") do ( set "PROGRAM=%%~fsa" )

call "%PYTHON%" "%PROGRAM%" "--no-progress-bar" "--no-color" "--verbosity" "4" %*
set "EXIT_CODE=%ErrorLevel%"


goto END


:ERROR_NOPYTHON
  echo ERROR: can not find 'python.exe' in system PATH.                 &1>2
  set "EXIT_CODE=1111"
  goto END

:ERROR_NOPROGRAM
  echo ERROR: can not find 'pyglossary.pyw' in current-folder %~dp0     &1>2
  set "EXIT_CODE=2222"
  goto END

:END
  pause                                                                 &1>2
  exit /b %EXIT_CODE%
