::@echo off
chcp 65001 2>nul >nul

set "EXIT_CODE=0"

set "FILE_IN="
set "FILE_MIFF="
set "FILE_OUT1="
set "FILE_OUT2="

if ["%~1"] EQU [""] ( goto ERROR_NOARG )

set "FILE_IN=%~sdp1%~nx1"
set "FILE_MIFF=tmp.miff"
set "FILE_OUT1=%~sdp1%~n1_optimized1%~x1"
set "FILE_OUT2=%~sdp1%~n1_optimized2%~x1"

del /f /q "%FILE_MIFF%" 1>nul 2>nul
del /f /q "%FILE_OUT1%" 1>nul 2>nul
del /f /q "%FILE_OUT2%" 1>nul 2>nul

::------------------------------------------------------------to "ImageMagick Machine independent File Format bitmap". use '^' before '%'.
call "D:\Software\ImageMagic\convert.exe" -verbose "%FILE_IN%" -fuzz "8%%" -deconstruct "%FILE_MIFF%"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto END )
::------------------------------------------------------------optimize 1   Optimize or OptimizeFrame
call "D:\Software\ImageMagic\convert.exe" -verbose "%FILE_MIFF%" -coalesce "+dither" -layers OptimizeFrame -colors 32 "%FILE_OUT1%"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto END )
del /f /q "%FILE_MIFF%" 1>nul 2>nul
::------------------------------------------------------------optimize 2
call gifsicle.exe --verbose --optimize=2 "%FILE_OUT1%" --colors 256 --output "%FILE_OUT2%"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( goto END )



::call "D:\Software\ImageMagic\convert.exe" -verbose "%FILE_IN%" -coalesce -fuzz 2%% "+dither" -layers OptimizeFrame "+map" tmp.miff
::call magick.exe "convert" "%FILE_IN%" "-coalesce" "-layers" "OptimizeFrame" "%FILE_OUT%"
::set "EXIT_CODE=%ErrorLevel%"


goto END


:ERROR_NOARG
  echo ERROR: missing argument (gif path to optimize). 1>&2
  set "EXIT_CODE=1111"
  goto END


:END
  pause
  exit /b %EXIT_CODE%