::http://rufus.akeo.ie/downloads/rufus-2.18p.exe
@echo off
::pre-cleanup
del /f /q *.bin *.rc *.res            1>nul 2>nul

set "FILE__IN=%~s1"
set "FILE__RC=%~s1.rc"
set "FILE_RES=%~s1.res"
set "FILE_MOD=%~s1_unupx%~x1"

echo.
echo unUPX input file.
call upx.exe -d "%FILE__IN%"

echo.
echo extracting embedded UPX-compressed data from RCDATA section to RC file and external binary-files.
call reshacker.exe -extract "%FILE__IN%,%FILE__RC%,RCDATA,,"

echo.
echo uncompressing all binary-files, if possible.
call upx.exe -d *.bin

echo.
echo compiling all binary-files and RC file back to RES file.
call rc.exe /nologo /v "%FILE__RC%"

::cleanup
del /f /q *.bin *.rc            1>nul 2>nul

echo.
echo re-embedding resources into main file.
call reshacker.exe -addoverwrite "%FILE__IN%,%FILE_MOD%,%FILE_RES%,RCDATA,,"

::cleanup
del /f /q *.res      1>nul 2>nul

echo.
echo Original file: %FILE__IN%
echo Modified file: %FILE_MOD%

echo.
echo Done.

explorer.exe /select, %FILE_MOD%

pause