@echo off
  set "EXIT_CODE=0"


::-------------------------------------------------------------------------------------------Download
::set "URL=https://www.piriform.com/ccleaner/download/portable/downloadfile"
  set "URL=https://www.ccleaner.com/ccleaner/download/portable/downloadfile"


  set "ARGS=curl.exe"
  set  ARGS=%ARGS% --ipv4
  set  ARGS=%ARGS% --anyauth --insecure --location-trusted
  set  ARGS=%ARGS% --verbose
  set  ARGS=%ARGS% --url "%URL%"
  set  ARGS=%ARGS% --output "downloadfile.zip"

::Override DNS-resolving/HOSTS-blocking (keep blocking those with '0.0.0.0 www.piriform.com'!!!). IP from: https://dns.google.com/query?name=www.ccleaner.com
  set  ARGS=%ARGS% --resolve "www.piriform.com:443:151.101.0.64"
  set  ARGS=%ARGS% --resolve "www.ccleaner.com:443:151.101.2.202"
  
  echo %ARGS%
  call %ARGS%
  set "EXIT_CODE=%ErrorLevel%"

  if ["%EXIT_CODE%"] NEQ ["0"] ( goto ERR_CURL )
::-------------------------------------------------------------------------------------------


::-------------------------------------------------------------------------------------------Extract
  rmdir /s /q   "tmp"                                2>nul >nul
  md            "tmp"                                2>nul >nul
  unzip -j -qq  "downloadfile.zip"   -d "tmp"        2>nul >nul
  move  /y      "tmp\lang-1037.dll"  "."             2>nul >nul
  move  /y      "tmp\portable.dat"   "."             2>nul >nul
  move  /y      "tmp\CCleaner.exe"   "."             2>nul >nul
  rmdir /s /q   "tmp"                                2>nul >nul
  del   /f /q   "downloadfile.zip"                   2>nul >nul
  ren           "CCleaner.exe"       "ccleaner.exe"  2>nul >nul
::-------------------------------------------------------------------------------------------


::-------------------------------------------------------------------------------------------Auto Font-Size-Increase
::   echo Download done, going to modify the UI to be using bigger font-size.
::   ::modify the FONT from 8pt to 12pt - useful for larger screens.
::   set PATH_TO_EXE=".\ccleaner.exe"
::   for /f %%a in ("%PATH_TO_EXE%")do (set "PATH_TO_EXE=%%~fsa"  )
::   call "C:\www\dialog_fontsize_mod\fontsize_increase.cmd" "%PATH_TO_EXE%"
::   
::   ::cleanup
::   del   /f /q   "ccleaner_DIALOGs.rc"                2>nul >nul
::   del   /f /q   "ccleaner_DIALOGs.res"               2>nul >nul
::   
::   ::keep original file, but convert modified file to be named ccleaner.exe to be compatible with existing scripts...
::   del   /f /q   "ccleaner_original.exe"              2>nul >nul
::   ren   "ccleaner.exe" "ccleaner_original.exe"       2>nul >nul
::   ren   "ccleaner_MOD.exe" "ccleaner.exe"            2>nul >nul
::   
::   echo.
::   echo everything done.
::   echo modified file is ccleaner.exe ^(the original is kept as ccleaner_original.exe^).
::   echo.
::-------------------------------------------------------------------------------------------


goto EXIT


:ERR_CURL
  echo [ERROR] cURL reported an error while downloading the file.            1>&2
  echo Exit-Code: %EXIT_CODE%                                                1>&2
  echo All exit-codes: https://curl.haxx.se/libcurl/c/libcurl-errors.html    1>&2
  goto EXIT


:EXIT
  pause
  exit /b %EXIT_CODE%




::generate a C/libcurl equivalent.
::set  ARGS=%ARGS% --libcurl "libcurl.c"
