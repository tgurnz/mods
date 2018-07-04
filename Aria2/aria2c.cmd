@echo off
  chcp 65001 2>nul >nul

  ::clear
  set "ARIA2C="
  set "ARGS="
  set "EXIT_CODE="
  set "LAST_ARG="

  ::---------------------------------------assuming last arg is always 'the URL'. writes 'LAST_ARG' variable.
  call :GET_LAST_ARG %*
  ::---------------------------------------keeping history.
  call "%~sdp0history.cmd" "%LAST_ARG%"
  ::---------------------------------------
  set "ARIA2C=%~sdp0aria2c.exe"

  set "ARGS="
  set ARGS=%ARGS% --dir=.
  set ARGS=%ARGS% --split=5
  set ARGS=%ARGS% --min-split-size=1M

  set ARGS=%ARGS% --file-allocation=falloc
  set ARGS=%ARGS% --save-session-interval=10
  set ARGS=%ARGS% --human-readable=true
  set ARGS=%ARGS% --enable-color=true
  set ARGS=%ARGS% --user-agent="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:55.0) Gecko/20100101 Firefox/55.0"
  set ARGS=%ARGS% --referer="%LAST_ARG%"
  set ARGS=%ARGS% --http-no-cache=true
  set ARGS=%ARGS% --header="DNT: 1"
  set ARGS=%ARGS% --auto-save-interval=10
  set ARGS=%ARGS% --content-disposition-default-utf8=true
  ::                               error handling
  set ARGS=%ARGS% --retry-wait=2
  set ARGS=%ARGS% --max-tries=10
  set ARGS=%ARGS% --timeout=120
  set ARGS=%ARGS% --connect-timeout=300
  set ARGS=%ARGS% --max-file-not-found=1
  ::                               do-not overwrite, always continue. if a file is completed it won't re-downloaded it, and overwrite it. You have to maintain renaming/deleting the older file yourself outside of this batch file. it is safer this way since you can download a huge file and then run this batch again and start the whole thing again...
  set ARGS=%ARGS% --continue=true
  set ARGS=%ARGS% --allow-overwrite=false
  set ARGS=%ARGS% --auto-file-renaming=false
  ::                               log
  set ARGS=%ARGS% --console-log-level=notice
  ::                               permissive certificate/ssl
  set ARGS=%ARGS% --check-certificate=false
  set ARGS=%ARGS% --check-integrity=false
  set ARGS=%ARGS% --http-auth-challenge=true
  set ARGS=%ARGS% --rpc-allow-origin-all=true
  set ARGS=%ARGS% --rpc-secure=false
  ::                               ip/connection
  set ARGS=%ARGS% --max-concurrent-downloads=16
  set ARGS=%ARGS% --max-connection-per-server=16
  set ARGS=%ARGS% --enable-http-keep-alive=true
  set ARGS=%ARGS% --enable-http-pipelining=true
  set ARGS=%ARGS% --connect-timeout=120
  set ARGS=%ARGS% --disable-ipv6=true
  set ARGS=%ARGS% --async-dns=true
  set ARGS=%ARGS% --async-dns-server=8.8.8.8,8.8.4.4

  echo.
  echo %ARIA2C% %ARGS% %*
  echo.
  echo.
  call %ARIA2C% %ARGS% %*
  set "EXIT_CODE=%ErrorLevel%"
  echo.

  goto END


::subroutine that loop the arg.s to last without destroying the list. (as all subroutines, it must go to ':EOF' to 'mark it done'..)
:GET_LAST_ARG
  set "LAST_ARG=%~1"
  shift
  if ["%~1"] NEQ [""] goto GET_LAST_ARG
  goto :EOF


:END
  pause
  ::reset color
  color
  exit /b %EXIT_CODE%
