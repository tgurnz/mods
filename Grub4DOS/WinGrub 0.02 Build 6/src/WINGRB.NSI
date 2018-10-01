; WinGrub NSIS script

Name "WinGrub 0.02 Build 6"
OutFile "WINGRB0206.EXE"
InstallDir $PROGRAMFILES\WinGrub
InstallDirRegKey HKLM SOFTWARE\WinGrub "InstPath"
ShowInstDetails nevershow
ShowUninstDetails nevershow

;LicenseText "Please read the license carefully."
;LicenseData "COPYING.TXT"
ComponentText "Please choose the tools you need."
DirText "Choose the installation directory."

InstType "Full"
InstType "Normal"
InstType "Minimum"

Section "-Pre Install"
 Rmdir /r "$SMPROGRAMS\WinGrub"
 Rmdir /r "$INSTDIR"
 CreateDirectory "$INSTDIR"
 SetOutPath "$INSTDIR"
; DeleteRegKey HKLM "Software\WinGrub"
 WriteRegStr HKLM "Software\WinGrub" "InstPath" "$INSTDIR"
 ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
SectionEnd

Section "WinGrub GUI"
 SectionIn 1
 SectionIn 2
 SectionIn 3
 StrCmp $0 "" +1 +3
 SetOutPath "$SYSDIR"
 FILE "..\..\LIB\DMK\HDIO32.VXD"
 SetOutPath "$INSTDIR"
 FILE "WINGRB.EXE"
 FILE /oname="WINGRB.INI" "WINGRB.ORG"
 CreateDirectory "$INSTDIR\GRUB"
 SetOutPath "$INSTDIR\GRUB"
 FILE "GRUB\gr*"
 SetOutPath "$INSTDIR"
 FILE /r "HELP"
 FILE /r "LOGO"
 FILE /r "PROF"
 FILE "FONTS"
 FILE "MEMDISK.GZ"
 FILE "..\..\APP\DMK\PTED.EXE"
 FILE "..\..\APP\DMK\PTED16.EXE"
SectionEnd

Section "Stage Files"
 SectionIn 1
 SetOutPath "$INSTDIR\GRUB"
 FILE "GRUB\*stage*"
 SetOutPath "$INSTDIR"
SectionEnd

Section "-Uninstall"
 WriteUninstaller "UNINST.EXE"
 WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinGrub" \
  "DisplayName" "WinGrub"
 WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinGrub" \
  "UninstallString" '"$INSTDIR\UNINST.EXE"'
SectionEnd

Section "Create Shortcut"
 SectionIn 1
 SectionIn 2
 CreateDirectory "$SMPROGRAMS\WinGrub"
 CreateShortCut "$SMPROGRAMS\WinGrub\WinGrub GUI.lnk" "$INSTDIR\WINGRB.EXE"
 CreateShortCut "$SMPROGRAMS\WinGrub\Uninstall.lnk" "$INSTDIR\UNINST.EXE"
SectionEnd

Section "Create Desktop Icon"
 CreateShortCut "$DESKTOP\WinGrub.lnk" "$INSTDIR\WINGRB.EXE"
SectionEnd

UninstallText "This will uninstall WinGrub. Hit next to continue."

Section "Uninstall"
; StrCmp $0 "" +1 +2
; Delete "$SYSDIR\HDIO32.VXD"
; DeleteRegkey HKLM "Software\WinGrub"
 DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\WinGrub"
 Delete "$DESKTOP\WinGrub.lnk"
 Rmdir /r "$SMPROGRAMS\WinGrub"
 Rmdir /r "$INSTDIR"
SectionEnd