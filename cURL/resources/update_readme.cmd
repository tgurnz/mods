@echo off
chcp 65001 2>nul >nul

call "%~sdp0..\curl.exe" "--version"   1>&2    >..\readme_curl.nfo
echo. >>..\readme_curl.nfo
echo ------------------------------------------------------------------------------ >>..\readme_curl.nfo
call "%~sdp0..\curl.exe" "--manual"    1>&2   >>..\readme_curl.nfo
