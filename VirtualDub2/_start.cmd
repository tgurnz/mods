@echo off

::starts program in portable mode.

chcp 65001 2>nul >nul

set "COMMAND=%~dp0VirtualDub.exe"

for /f %%a in ("%COMMAND%") do ( set "COMMAND=%%~fsa" )

call cmd.exe "/Q /C "start "/MAX /HIGH" %~dp0VirtualDub.exe /max /portable /priority high"