; Metopi Installer Script

!include "MUI2.nsh"
!include "FileFunc.nsh"

; General
Name "Metopi"
OutFile "..\dist\MetopiSetup.exe"
InstallDir "$PROGRAMFILES\Metopi"
InstallDirRegKey HKCU "Software\Metopi" ""

; Interface Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Languages
!insertmacro MUI_LANGUAGE "English"

; Installer
Section "Install"
  SetOutPath "$INSTDIR"
  
  ; Files
  File "..\dist\metopi.exe"
  
  ; Start Menu
  CreateDirectory "$SMPROGRAMS\Metopi"
  CreateShortcut "$SMPROGRAMS\Metopi\Metopi.lnk" "$INSTDIR\metopi.exe"
  CreateShortcut "$SMPROGRAMS\Metopi\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  
  ; Registry
  WriteRegStr HKCU "Software\Metopi" "" $INSTDIR
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Metopi" \
                   "DisplayName" "Metopi"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Metopi" \
                   "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
  
  ; Create uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"
SectionEnd

; Uninstaller
Section "Uninstall"
  Delete "$INSTDIR\metopi.exe"
  Delete "$INSTDIR\uninstall.exe"
  RMDir "$INSTDIR"
  
  Delete "$SMPROGRAMS\Metopi\Metopi.lnk"
  Delete "$SMPROGRAMS\Metopi\Uninstall.lnk"
  RMDir "$SMPROGRAMS\Metopi"
  
  DeleteRegKey HKCU "Software\Metopi"
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Metopi"
SectionEnd
