@echo off
chcp 65001 2>nul >nul


::---------------
::Steps to update to latest-nightly-build, of the latest firefox:
:: 1. get the URL for the latest nightly version in a zip-format, from 'https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/' HTML (using NodeJS)
:: 2. download using 'aria2c.cmd'
:: 3. extract zip.
:: 4. replace content of 'D:\Software\Mozilla\firefox\' folder with the content from step [3.] .
:: 5. done
::---------------


::pre-cleanup (solves repeating-override problem).
set "EXIT_CODE=0"
set "GET_MOST_UPDATED_URL="
set "URL="
set "ARIA2C_CMD="


set "GET_MOST_UPDATED_URL=%~sdp0get_most_updated_url.cmd"
for /f %%a in ("%GET_MOST_UPDATED_URL%")                        do ( set "GET_MOST_UPDATED_URL=%%~fsa"   )
if not exist %GET_MOST_UPDATED_URL%                                ( goto ERROR_NO_GET_MOST_UPDATED_URL  )


echo [INFO] Using get_most_updated_url.cmd from:   %GET_MOST_UPDATED_URL%     1>&2


for /f "tokens=*" %%a in ('call %GET_MOST_UPDATED_URL%') do ( set "URL=%%a"                             )
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"]                                       ( goto ERROR_FAILED_TO_GET_MOST_UPDATED_URL )
if ["%URL%"] EQU [""]                                              ( goto ERROR_FAILED_TO_GET_MOST_UPDATED_URL )


echo going to download:     1>&2
echo %URL%                  1>&2
echo using 'aria2c.cmd'     1>&2


call aria2c.cmd "%URL%"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"]                                       ( goto ERROR_FAILED_DOWNLOAD                )


::---------------------------------------------------
::---------------------------------------------------
:: PUT HERE EXTRACTION/REPLACEMENT METHODS...
::---------------------------------------------------
::---------------------------------------------------


goto END


:ERROR_NO_GET_MOST_UPDATED_URL
  echo [ERROR] can't find 'get_most_updated_url.cmd'.  1>&2
  goto END


:ERROR_FAILED_TO_GET_MOST_UPDATED_URL
  echo [ERROR] 'get_most_updated_url.cmd' failed.      1>&2
  goto END


:END
  echo exit code: [%EXIT_CODE%]. 1>&2
  echo.                          1>&2
  pause                          1>&2
  exit /b %EXIT_CODE%

