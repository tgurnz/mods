@echo off

set "_DATE="
set "_TIME="
set "_ARG=%~1"

For /f "tokens=2-4 delims=/ " %%a in ("%DATE%") do ( set "_DATE=%%c/%%a/%%b" ) 
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do ( set "_TIME=%%a:%%b"     )

echo %_DATE% %_TIME%   %_ARG%   >>"%~sdp0history.txt"

exit /b 0