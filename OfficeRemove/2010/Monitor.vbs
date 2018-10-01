Dim objShell  :  Set objShell     = CreateObject("Wscript.Shell")
Dim ErrorCode : ErrorCode         = 0
Dim ResultPage: ResultPage        = "msiexec /i ErrorPageMsi.msi ERROR="""
Dim OffScrubCmd: OffScrubCmd      = "cscript.exe OffScrub10.vbs ClientSuites"

Dim ResultPageCode : ResultPageCode = 0

ErrorCode = RunOffscrub
ResultPageCode = GetResultCodeFromErrorCode(ErrorCode)

ResultPage = ResultPage & ResultPageCode & """"

objShell.run ResultPage, 1, false

function GetResultCodeFromErrorCode(ErrorCode)

    ' This part is copied from offscrub10.vbs
    Const ERROR_SUCCESS                 = 0   'Bit #1.  0 indicates Success. Script completed successfully
    Const ERROR_REBOOT_REQUIRED         = 2   'Bit #2.  Reboot bit. If set a reboot is required
    Const ERROR_SUCCESS_CONFIG_COMPLETE = 1728
    Const ERROR_SUCCESS_REBOOT_REQUIRED = 3010

    if (ERROR_SUCCESS = ErrorCode Or ERROR_SUCCESS_CONFIG_COMPLETE = ErrorCode Or ERROR_SUCCESS_REBOOT_REQUIRED = ErrorCode Or ERROR_REBOOT_REQUIRED = ErrorCode) Then
        GetResultCodeFromErrorCode = 0
    else
        GetResultCodeFromErrorCode = 1
    End if

End Function

function RunOffscrub

    if Not CheckRegPermissions Then
        RunOffscrub = objShell.run(OffScrubCmd, 0, true)
    else
        RunOffscrub = objShell.run(OffScrubCmd, 1, true)
    End if

End function

Function CheckRegPermissions
    Const KEY_QUERY_VALUE       = &H0001
    Const KEY_SET_VALUE         = &H0002
    Const KEY_CREATE_SUB_KEY    = &H0004
    Const DELETE                = &H00010000
    Const HKLM                  = &H80000002

    Dim sSubKeyName
    Dim fReturn
    Dim oReg
    Set oReg        = GetObject("winmgmts:\\.\root\default:StdRegProv")

    CheckRegPermissions = True
    sSubKeyName = "Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\"
    oReg.CheckAccess HKLM, sSubKeyName, KEY_QUERY_VALUE, fReturn
    If Not fReturn Then CheckRegPermissions = False
    oReg.CheckAccess HKLM, sSubKeyName, KEY_SET_VALUE, fReturn
    If Not fReturn Then CheckRegPermissions = False
    oReg.CheckAccess HKLM, sSubKeyName, KEY_CREATE_SUB_KEY, fReturn
    If Not fReturn Then CheckRegPermissions = False
    oReg.CheckAccess HKLM, sSubKeyName, DELETE, fReturn
    If Not fReturn Then CheckRegPermissions = False

End Function 'CheckRegPermissions