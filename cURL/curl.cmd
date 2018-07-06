@echo off
chcp 65001 2>nul >nul


set "EXIT_CODE=0"

set "CURL=%~sdp0curl.exe"
set  ALL=%*


set "LAST_ARG="
::---------------------------------------assuming last arg is always 'the URL'. writes 'LAST_ARG' variable.
call :GET_LAST_ARG %*
::---------------------------------------


set "ARGS="
::---------------------------------------developers only. when enabled- generates the libcurl (C/C++) equivalent of the cURL command-line. Useful for PHP too (similar syntax).
::set  ARGS=%ARGS% --libcurl "libcurl.c"
::---------------------------------------continue previously downloaded-file.
set  ARGS=%ARGS% --continue-at "-"
::---------------------------------------simplified DNS-resolving and increase performances by not using IPv6 which is not well-implemented in Windows-builds of curl.
set  ARGS=%ARGS% --ipv4
::---------------------------------------simplified HTTPS/SSL downloading regardless of certificate issues.
set  ARGS=%ARGS% --anyauth --insecure --location-trusted
::---------------------------------------show a lot of information.
set  ARGS=%ARGS% --verbose


::--------------------------------------------------::
:: MOCK HTTP Headers (UserAgent, Referer),          ::
:: but only if user hasn't already specified ones.  ::
::--------------------------------------------------::


::---------------------------------------use a generic useragent (instead of 'curl/7.60.0').
echo.%ALL% | findstr /C:"-A" /C:"--user-agent"  2>nul 1>nul
IF ["%ErrorLevel%"] EQU ["1"] ( 
  set  ARGS=%ARGS% --user-agent "Mozilla/5.0 Chrome"
) 

::---------------------------------------use a referer, which is same as the download URL (only when last-argument is really a URL, since it might be a local-file).
echo.%ALL% | findstr /C:"-e" /C:"--referer"  2>nul 1>nul
IF ["%ErrorLevel%"] EQU ["1"] ( 
  rem -----------------------------------this make sure last-argument is really a URL (since it might be a file..)
  echo.%LAST_ARG% | findstr /C:"//"          2>nul 1>nul
  IF ["%ErrorLevel%"] EQU ["0"] ( 
    set  ARGS=%ARGS% --referer "%LAST_ARG%"
  ) 
) 


echo "%CURL%" %ARGS% %ALL%    1>&2
echo.                         1>&2
pause
::call "%CURL%" %ARGS% %ALL%    1>&2
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto ERR_CURL )


goto END


:ERR_CURL
  echo [ERROR] cURL reported an error while downloading the file.            1>&2
  echo Exit-Code: %EXIT_CODE%                                                1>&2
  echo All exit-codes: https://curl.haxx.se/libcurl/c/libcurl-errors.html    1>&2
  goto END


::subroutine that loop the arg.s to last without destroying the list. (as all subroutines, it must go to ':EOF' to 'mark it done'..)
:GET_LAST_ARG
  set "LAST_ARG=%~1"
  shift
  if ["%~1"] NEQ [""] ( goto GET_LAST_ARG )
  goto :EOF


:END
  pause
  exit /b %EXIT_CODE%


::-------------------------------------------
:: this is a wrapper script around curl.exe
:: allowing to use it as usuall but will add
:: several switches by default all the time.
::-------------------------------------------
:: by adding the current folder to the system's PATH
:: curl.cmd will be launched (instead of curl.exe)
:: everytime someone runs 'curl ....' (non explicit extension).
:: since Windows prioritize files with the same-name, this way..
::-------------------------------------------

