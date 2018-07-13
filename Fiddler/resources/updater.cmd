@echo off

del /f /q "FiddlerSetup.exe.old"                2>nul >nul
ren "FiddlerSetup.exe" "FiddlerSetup.exe.old"   2>nul >nul

call curl.exe --verbose --ipv4 --anyauth --insecure --location-trusted --url "https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe" --output "FiddlerSetup.exe" --resolve "telerik-fiddler.s3.amazonaws.com:443:52.216.160.107" --resolve "telerik-fiddler.s3.amazonaws.com:80:52.216.160.107"

pause