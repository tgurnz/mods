@echo off

call "%~sdp0aria2c.cmd" --input-file="%~1" %2 %3 %4 %5

exit /b %ErrorLevel%
