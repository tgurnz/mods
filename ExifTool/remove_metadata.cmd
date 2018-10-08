@echo off
chcp 65001 2>nul >nul

set "FILE_INPUT=%~s1"
set "FILE_BCKUP=%~1.backup"

::                                                         backup
call copy /b /y "%FILE_INPUT%" "%FILE_BCKUP%" 2>nul >nul

call exiftool -overwrite_original_in_place -progress -verbose -preserve -ignoreMinorErrors -XMPToolkit="" -all="" -trailer:all="" "%FILE_INPUT%"

pause

exit
