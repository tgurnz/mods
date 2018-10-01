@echo off
::fill PYTHON execute path and normalise for fully qualified, "8.3" short path.
set PYTHON=
for /f "tokens=*" %%a in ('call where.exe python.exe 2^>nul') do (set PYTHON=%%a)
if ["%PYTHON%"] == [""] ( goto NOPYTHON )
for /f %%a in ("%PYTHON%")do (set "PYTHON=%%~fsa")

::normalise the arguments to this weird execution...
set QTFASTSTART=%~dp0bin\qtfaststart
for /f %%a in ("%QTFASTSTART%")do (set "QTFASTSTART=%%~fsa")



::----------------------------------------------------------------------------------------------------
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
echo processing file...

set FILE_INPUT=%~s1
set FILE_OUTPUT=%~d1%~p1%~n1_faststart%~x1%

for /f %%a in ("%FILE_INPUT%")do (set "FILE_INPUT=%%~fsa")

call %PYTHON% %QTFASTSTART% "%FILE_INPUT%" "%FILE_OUTPUT%"


::--------------------------------------------------------------------------------

:NEXT
  echo.
  shift
  goto LOOP

:NOPYTHON
  echo.
  echo ERROR: no python found.. sorry... 
  goto END

:END
  echo.
  pause
