@echo off
chcp 65001 2>nul >nul


set "EXIT_CODE=0"


::this directory (8.3 name).
set "HOME=%~sdp0"
::remove '\' suffix.  
set "HOME=%HOME%##"
set "HOME=%HOME:\##=%"
set "HOME=%HOME:##=%"


::get path-to 'python.exe', and make short-path.
for /f "tokens=*" %%a in ('where python.exe 2^>nul') do ( set "PYTHON=%%a" )
if ["%ErrorLevel%"] NEQ ["0"]   ( goto ERROR_NOPYTHON  )
if ["%PYTHON%"] EQU [""]        ( goto ERROR_NOPYTHON  ) 
if not exist "%PYTHON%"         ( goto ERROR_NOPYTHON  ) 
for /f %%a in ("%PYTHON%")   do ( set "PYTHON=%%~fsa"  ) 


::get path-to 'binwalk.py', and make short-path (its modules, and the 'lib' folder is defined internally so do not think about it).
set "BINWALK=%HOME%\program\binwalk.py"
for /f %%a in ("%BINWALK%")  do ( set "BINWALK=%%~fsa"  ) 
if not exist "%BINWALK%"        ( goto ERROR_NOBINWALK  ) 


::make the path-to-binwalk.py a rtl-slash (unix-like) which works better in python.
set "BINWALK=%BINWALK:\=/%"


set "ARGS=%*"
:::::(ALSO..) convert entire argument-list from Windows-slash to Unix-slash (commented-out since it might break something). Uncomment if you wish to pass Windows-paths and it breaks for you (you can also "escape" slashes with '\\').
:::if ["%ARGS%"] NEQ [""] ( 
:::  set "ARGS=%ARGS:\=/%" 
:::) 


title %ARGS%
echo  %PYTHON% %BINWALK% %ARGS%  1>&2
echo.
call  %PYTHON% %BINWALK% %ARGS%
set "EXIT_CODE=%ErrorLevel"


goto END


:ERROR_NOPYTHON
  echo [ERROR] no python.exe   1>&2
  goto END

:ERROR_NOBINWALK
  echo [ERROR] no binwalk.py   1>&2

:END
::pause
  exit /b %EXIT_CODE%
