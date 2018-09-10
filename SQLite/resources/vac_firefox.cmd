::@echo off
chcp 65001 2>nul >nul
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\AlternateServices.txt" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\cert9.db" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\content-prefs.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\cookies.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\favicons.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\formhistory.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\key4.db" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\OfflineCache\index.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\parent.lock" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\permissions.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\places.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\SecurityPreloadState.txt" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\storage.sqlite" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\TRRBlacklist.txt" VACUUM
call "%~sdp0sqlite3.exe" "D:\Software\Mozilla\profile\webappsstore.sqlite" VACUUM
