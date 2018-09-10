@echo off
chcp 65001 2>nul >nul


::pre-cleanup
set "EXIT_CODE="
set "SCRIPT="
set "NODE="
set "FILE_INPUT="
set "FILE_BCKUP="


set "EXIT_CODE=0"
set "SCRIPT=%~sdp0index.js"


::get 'node.exe' fully-qualified path.
echo [INFO] looking for node.exe ...                                         1>&2
for /f "tokens=*" %%a in ('where node.exe 2^>nul') do ( set "NODE=%%a"    )
if ["%NODE%"] EQU [""]              ( goto NONODE            )
for /f %%a in ("%NODE%")         do ( set "NODE=%%~fsa"      )
if not exist %NODE%                 ( goto NONODE            )
echo [INFO] using node.exe from: %NODE%                                      1>&2


::peerblock.conf .
set "FILE_INPUT=%~1"
set "FILE_BCKUP=%~1.backup"


::get 'peerblock.conf' (and peerblock.conf.backup) fully-qualified path.
if ["%FILE_INPUT%"]==[""]          ( goto NOARG              )
if not exist %~s1                  ( goto NOARG              )
if     exist %~s1\NUL              ( goto NOARG              )

for /f %%a in ("%FILE_INPUT%")  do ( set "FILE_INPUT=%%~fa" )
for /f %%a in ("%FILE_BCKUP%")  do ( set "FILE_BCKUP=%%~fa" )


echo [INFO] backing up:                                                      1>&2
echo          %FILE_INPUT%                                                   1>&2
echo      to  %FILE_BCKUP%                                                   1>&2

call copy /b /y "%FILE_INPUT%" "%FILE_BCKUP%"                                2>nul >nul
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"]       ( goto ERR_BACKUP         )


echo -------------------------------------------------[NODEJS - START]       1>&2
call node.exe "%SCRIPT%" "%FILE_INPUT%"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"]       ( goto ERR_NODEJS         )
echo -------------------------------------------------[NODEJS -  DONE]       1>&2


goto EXIT


:NONODE
  echo [ERROR] Could not find node.exe on the system                         1>&2
  set "EXIT_CODE=111"
  goto EXIT


:NOARG
  echo [ERROR] Missing argument: PeerBlock Config file.                      1>&2
  set "EXIT_CODE=222"
  goto EXIT


:ERR_BACKUP
  echo [ERROR] copy %FILE_INPUT% to %FILE_BCKUP% failed, try again later.    1>&2
  set "EXIT_CODE=333"
  goto EXIT


:ERR_NODEJS
  echo [ERROR] NodeJS finished with an error.                                1>&2
  ::keep NodeJS exit-code.
  goto EXIT


:EXIT
  pause
  exit /b %EXIT_CODE%


::--------------------------------------------
::  Exit codes
::    111      not found:          node.exe                                 - get it from https://nodejs.org/download/nightly/  (choose version, download node.exe from the 'win-x86/' folder).
::    222      missing argument:   peerblock.conf      
::    333      copy error:         peerblock.conf to peerblock.conf.backup  - maybe locked file?
::    other    (handled by NodeJS)                                          - maybe you're offline.. or other NodeJS unhandled exception.
::--------------------------------------------
