@echo off
chcp 65001 2>nul >nul

:LOOP
::has argument ?
if ["%~1"]==[""] (
  echo done.
  goto END;
)
::argument exist ?
if not exist %~s1 (
  echo not exist
  goto NEXT;
)
::file exist ?
echo exist
if exist %~s1\NUL (
  echo is a directory
  goto NEXT;
)
::OK
echo is a file


set "FILE_INPUT=%~1"

start /ABOVENORMAL "cmd /c "call remove_metadata.cmd "%FILE_INPUT%"""


goto END

:NEXT
shift
goto LOOP

:END
::pause
