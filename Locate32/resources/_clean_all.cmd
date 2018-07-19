@echo off

call "%windir%\System32\reg.exe" import "%~sdp0_clean_from_registry.reg"  2>nul >nul

call rmdir /q /s "%UserProfile%\AppData\Roaming\Locate32"                 2>nul >nul

pause