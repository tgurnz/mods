@echo off
chcp 65001 2>nul >nul


call "%windir%\System32\taskkill.exe" /F /T /IM "firefox.exe"
if ["%ErrorLevel%"] EQU ["0"] ( 
  echo firefox.exe closed.
) 

if ["%ErrorLevel%"] EQU ["128"] ( 
  echo firefox.exe not running.
) 

if ["%ErrorLevel%"] NEQ ["0"] ( 
  if ["%ErrorLevel%"] NEQ ["128"] ( 
    echo firefox.exe still running.
    goto END
  ) 
) 


::----------------------------------------


::this directory (8.3 name).
set "HOME=%~sdp0"
::remove '\' suffix.  
set "HOME=%HOME%##"
set "HOME=%HOME:\##=%"
set "HOME=%HOME:##=%"

set "PROFILE=%HOME%\profile"

del   /s /q /s "%PROFILE%\*"    1>nul 2>nul
rmdir /s /q    "%PROFILE%\*"    1>nul 2>nul
rmdir /s /q    "%PROFILE%\"     1>nul 2>nul
rmdir /s /q    "%PROFILE%"      1>nul 2>nul
mkdir "%PROFILE%\"              1>nul 2>nul

::sometimes rmdir/del I/O are slow and the mkdir won't work. so if there isn't a folder yet, try recreate it again...
if not exist %PROFILE%\NUL  ( 
  mkdir "%PROFILE%\"              1>nul 2>nul
) 


echo. >"%PROFILE%\.placeholder"


:END
  exit /b %ErrorLevel%
