@echo off
chcp 65001 2>nul >nul


set "EXIT_CODE=0"


::make-sure peerblock is closed (0-closed. 128-process wasn't running).
call "%windir%\System32\taskkill.exe" /T /F /IM "peerblock.exe"  2>nul >nul
set "EXIT_CODE=%ErrorLevel%"


if ["%EXIT_CODE%"] EQU ["0"] ( 
  echo [INFO] peerblock.exe process closed.               1>&2
) 

if ["%EXIT_CODE%"] EQU ["128"] ( 
  echo [INFO] peerblock.exe process wasn't running.       1>&2
) 


if ["%EXIT_CODE%"] NEQ ["0"] ( 
  if ["%EXIT_CODE%"] NEQ ["128"] ( 
    goto PROCESS_STILL_RUNNING
  ) 
) 


::update URLs of lists directly in peerblock.conf
call index.cmd peerblock.conf
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto NOUPDATE )


::clear old/cache
echo [INFO] deleting old-lists and cache...               1>&2
del /q /f     lists\*.list      2>nul >nul
del /q /f     lists\*.list.tmp  2>nul >nul
del /q /f     cache.p2b         2>nul >nul
del /q /f     history.db        2>nul >nul


echo [INFO] click any key to start PeerBlock program...   1>&2
pause                           2>nul >nul
start /abovenormal /max "cmd /c "call C:\PeerBlock\peerblock.lnk""


goto EXIT


:PROCESS_STILL_RUNNING
  echo [ERROR] peerblock.exe process is still running.    1>&2
  goto EXIT


:NOUPDATE
  echo [ERROR] update filed.    1>&2
  echo Exit-Code: %EXIT_CODE%   1>&2
  goto EXIT


:EXIT


::-------------------------------------------::
:: you need to click "update" in peerblock.  ::
::-------------------------------------------::

