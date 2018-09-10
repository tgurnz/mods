::@echo off
chcp 65001 2>nul >nul
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Affiliation Database" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Cookies" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Cookies-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\databases\Databases.db" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\databases\Databases.db-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Extension Cookies" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Favicons" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Favicons-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\History" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Login Data" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Login Data-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Network Action Predictor" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Network Action Predictor-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Origin Bound Certs" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Origin Bound Certs-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\previews_opt_out.db" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\QuotaManager" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\QuotaManager-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Shortcuts" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Shortcuts-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Sync Data\SyncData.sqlite3" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Sync Data\SyncData.sqlite3-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Top Sites" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Top Sites-journal" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Web Data" VACUUM
call "%~sdp0sqlite3.exe" "%LocalAppData%\Chromium\User Data\Default\Web Data-journal" VACUUM
