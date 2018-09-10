@echo off
chcp 65001 2>nul >nul


::pre-cleanup (solves repeating-override problem).
set "EXIT_CODE=0"
set "NODE="
set "SCRIPT="


::--------------------------------------------------------------------------------------


::system-PATH 'node.exe'.
echo [INFO] looking for node.exe ...                                         1>&2
set "NODE=%~sdp0node.exe"
if exist %NODE%                                       ( goto LOCAL_NODE     )
for /f "tokens=*" %%a in ('where node.exe 2^>nul') do ( set "NODE=%%a"      )
if ["%ErrorLevel%"] NEQ ["0"]                         ( goto ERROR_NONODE   )
if ["%NODE%"] EQU [""]                                ( goto ERROR_NONODE   )
for /f %%a in ("%NODE%")                           do ( set "NODE=%%~fsa"   )
if not exist %NODE%                                   ( goto ERROR_NONODE   )
:LOCAL_NODE
echo [INFO] %NODE%                                                           1>&2
echo [INFO] Done.                                                            1>&2
echo.                                                                        1>&2


::--------------------------------------------------------------------------------------


::local 'index.js'.
echo [INFO] looking for 'index.js' ...                                       1>&2
set "SCRIPT=%~sdp0index.js"
for /f %%a in ("%SCRIPT%")                         do ( set "SCRIPT=%%~fsa" )
if not exist %SCRIPT%                                 ( goto ERROR_NOSCRIPT )
echo [INFO] %SCRIPT%                                                         1>&2
echo [INFO] Done.                                                            1>&2
echo.                                                                        1>&2


::--------------------------------------------------------------------------------------

echo.                              1>&2
echo [INFO] calling:               1>&2
echo  "%NODE%" "%SCRIPT%"          1>&2
echo.                              1>&2
echo [INFO] program output:        1>&2
echo ----------------------------- 1>&2
call  "%NODE%" "%SCRIPT%" 
set "EXIT_CODE=%ErrorLevel%"
echo ----------------------------- 1>&2
echo [INFO] Done.                  1>&2

echo.                              1>&2

if ["%EXIT_CODE%"] NEQ ["0"]                          ( goto ERROR_NODEJS   )


echo. 1>&2
echo [INFO] program finished successfully. 1>&2


goto END


::--------------------------------------------------------------------------------------


:ERROR_NONODE
  set "EXIT_CODE=111"
  echo [ERROR] node.exe - can not find it. 1>&2


:ERROR_NOSCRIPT
  set "EXIT_CODE=222"
  echo [ERROR] index.js - not exist in this folder. 1>&2
  goto END


:ERROR_NODEJS
  echo [ERROR] program finished with errors. 1>&2
  goto END


:END
  echo exit code: [%EXIT_CODE%]. 1>&2
  echo.                          1>&2
::pause                          1>&2
  exit /b %EXIT_CODE%


::--------------------------------------------------------------------------------------
::  Exit codes
::    0        success.                                         node.exe found in system-PATH, index.js found locally, index.js and node.exe finished with an exit-code "0" (success).
::
::    Errors:
::    ----------
::    From 'index.cmd':
::    ---------------------------
::    111      node.exe - not found in system-PATH.             get it from https://nodejs.org/download/nightly/  (choose version, download node.exe from the 'win-x86/' folder).
::    222      index.js - not found locally.                    check you have it.
::
::    From 'index.js' (NodeJS):
::    ---------------------------
::    1/other  JavaScript syntax-error or unexpected thrown-exception by NodeJS itself.
::--------------------------------------------------------------------------------------

