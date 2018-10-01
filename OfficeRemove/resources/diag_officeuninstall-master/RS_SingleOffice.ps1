# Copyright © 2016, Microsoft Corporation. All rights reserved.
#============================================================= 
<#
RS_Singleoffice.ps1 resolves the office issues and uninstall single installed office versions.

Arguments:
None

Return values:
None
#>

#Load parameters...
PARAM($officeID,$count)
#*=================================================================================
# Load Utilities
#*=================================================================================
. .\CL_OfficeUninstall.ps1
#*=================================================================================
#Import localization data
#*=================================================================================
Import-LocalizedData -BindingVariable Strings_RS_SingleOffice -FileName RS_SingleOffice

#Get the size of the OSArchitecure to check whether the office installed in 32bit or 64 bit OS.
$osArchitecture = [IntPtr]::Size;

#Create new object...
$objswbem = New-Object -ComObject "WbemScripting.SWbemNamedValueSet"
if($osArchitecture -eq 8)
{
	$objswbem.Add("__ProviderArchitecture", 64) | Out-null
}
elseif($osArchitecture -eq 4)
{
	$objswbem.Add("__ProviderArchitecture", 32) | Out-null
}
$objswbem.Add("__RequiredArchitecture", $True) | Out-null
$regObject = Create-WMIRegObj($objswbem)

#Create alias(object) for Classroot registry...
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

#Inintialize regpath to get the exact installed officepath to avoid bitness isssue in chrome...
$registryPath = "SOFTWARE\Microsoft\Windows\CurrentVersion"

#Pass the parameters to get the office common path and programfilespath
$value = "CommonFilesDir"
$commonFiles = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value 
$value = "CommonFilesDir (x86)"
$commonFilesx86 = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value
$value = "ProgramFilesDir (x86)"	
$programFilesx86Reg = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value 
$value = "ProgramFilesDir"
$programFilesReg = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value

#Call function to get the OSversion
$oSVersion = Get-OSVersion
#Fetch strings from the string table for the interaction...
$interactionID = $Strings_RS_Singleoffice.ID_NAME_DIAG_Off15C2R
$interactionDesc = $Strings_RS_Singleoffice.ID_DESC_DIAG_Off15C2R
#Display confirm interaction to the user...
$singleOffice = Get-DiagInput -id "INT_Office" -Parameter @{'Interaction' = $interactionID; 'InteractionName' = $interactionDesc;}
if($singleOffice -eq "Y")
{
	#If user confirms to uninstall the office call the functions...
	#Stop the required services
	$processes = @("ose","groove","sppsvc")
	foreach($process in $processes)
	{
		Stop-Service -Name $process -ErrorAction SilentlyContinue
	}
	#Function to close the office related running apps
	Close-RunningOfficeApps
	Write-DiagProgress -activity $Strings_RS_Singleoffice.ID_NAME_progAc_Off15C2R -status $Strings_RS_Singleoffice.ID_NAME_progSt_Off15C2R
	try
	{
		$ScheduledTaskList = @("OfficeTelemetryAgentFallBack","OfficeTelemetryAgentLogOn","OfficeTelemetryAgentFallBack2016","OfficeTelemetryAgentLogOn2016","Office Automatic Updates","Office 15 Subscription Heartbeat","Office Subscription Maintenance","Office ClickToRun Service Monitor")
		foreach($scheduler in $ScheduledTaskList)
		{
			SCHTASKS /Delete /TN  "Microsoft\Office\$scheduler" -f >nul
		}
	}
	catch
	{
		$_.error | Convertto-xml | Update-Diagreport  -id "RS_SingleOffice" -name "Error: $_.error" -Verbosity Informational
	}
	#Call the below function to delete Common office related registry keys...
	#If office 2003 is installed call CL_RemoveOffice2003.ps1 script that contains Remove-Office2003 function
   Switch ($officeID)
   {
	 "Office11"
	  {
		  . ./CL_RemoveOffice2003.ps1 $commonFilesx86 $commonFiles $officeID $oSVersion $count
	  }
	  "Office12"
	  {
		  . ./CL_RemoveOffice2007.ps1 $commonFilesx86 $commonFiles $officeID $oSVersion $count
	  }
	  "Office14"
	  {
		  . ./CL_RemoveOffice2010.ps1 $commonFilesx86 $commonFiles $officeID $oSVersion $count
	  }
	  {($_ -eq "Office15") -or ($_ -eq "Office15c2r")}
	  {
		  . ./CL_RemoveOffice2013.ps1 $commonFilesx86 $commonFiles $officeID $programFilesReg $programFilesx86Reg $oSVersion $count
	  }
	  {($_ -eq "Office16") -or ($_ -eq "Office16c2r")}
	  {
		
	      . ./CL_RemoveOffice2016.ps1 $commonFilesx86 $commonFiles $officeID $programFilesReg $programFilesx86Reg $oSVersion $count
	  }
	}
	$microsoftOffice = $programFilesReg + "\Microsoft Office"
	$microsoftOfficex86 = $programFilesx86Reg + "\Microsoft Office"
	$vfsx86 = $programFilesx86Reg + "\Microsoft Office\root"
	$vfs = $programFilesReg + "\Microsoft Office\root"
	$clickToRunShared = $commonFiles + "\Microsoft Shared\ClickToRun"
	$officeFiles = @("$clickToRunShared","$microsoftOffice","$microsoftOfficex86","$vfs","$vfsx86")

	#Call the below function to get the list of Common regkeys for all office versions..
	$commonregistryList = List-CommonOfficeRegistry
	$hKLMofficeReg = $commonregistryList.registryHKLM
	$otherRegkeys = $commonregistryList.officeDirPath
	$dirLists = @()

	#Function to get the list of common directories for all office versions
	$commondirectoryList = List-CommonOfficeDirectory
	$dirLists += $otherRegkeys 
	$dirLists += $commondirectoryList
	$dirLists += $officeFiles
	Remove-OfficeRegistry $hKLMofficeReg "Common"
	Remove-RegistryInstallerFolderKey
	Remove-OfficeDirectory $dirLists
	$removefilesafterReboot = @("$microsoftOffice","$microsoftOfficex86","$vfs","$vfsx86")
	foreach($removefileafterReboot in $removefilesafterReboot)
	{
		if(Test-Path $removefileafterReboot)
		{
			RemoveDir-AfterReboot $removefileafterReboot $null 
		}
	}
	if($officeID -eq "Office15c2r")
	{
		$officeID = "Office15"
	}
	elseif($officeID -eq "Office16c2r")
	{
		$officeID = "Office16"
	}
	#Verify whether office uninstalled successfully
	#Call the function to get the installed office list
	$officeList = Get-InstalledOffice $officeID 
	$officeID = $officeList.OfficeID
	#If the OfficeID is $null then assign Success to the variable or else failed.
	if($officeID -eq $null)
	{
		$resultString = "SUCCESS"
	}
	else
	{
		$resultString = "FAILED"
	}
	#Create a temp file in temp path to store the Result of office pack.
	New-Item -path "$env:temp" -name "OfficeVerifier.txt" -itemtype file -force 
	$officeVerifier = Join-Path "$env:temp" "OfficeVerifier.txt"
	$resultString >> $officeVerifier	 
	$count >> $officeVerifier  
	#Get the values from the temp path...
	if(Test-Path $officeVerifier)
	{
		$officeResultString = Get-Content -Path $officeVerifier 
	}
	#If the value is Failed then show interaction Failed to the user or else success interaction.
	if($officeResultString -match "FAILED")
	{
		Get-DiagInput -id "INT_O15C2R_UninstallFailed"          
		$officeResultString | Convertto-xml | Update-Diagreport  -id "RS_SingleOffice" -name "Removal result: $officeResultString" -Verbosity Informational
	}
	else
	{
		$success = $Strings_RS_Singleoffice.ID_NAME_INT_Reboot	
		Get-DiagInput -id "INT_O15C2R_Reboot"  -Parameter @{'Success' = $success; }        
		$officeResultString| Convertto-xml | Update-Diagreport  -id "RS_SingleOffice" -name "Removal result: $officeResultString" -Verbosity Informational
	}
}
else
{
	exit;
}

# SIG # Begin signature block
# MIIdoAYJKoZIhvcNAQcCoIIdkTCCHY0CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUOIQWu9oCHJEEWytCpfVc9WHi
# b3SgghhkMIIEwzCCA6ugAwIBAgITMwAAAMvZUgZTvz4qWQAAAAAAyzANBgkqhkiG
# 9w0BAQUFADB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwHhcNMTYwOTA3MTc1ODU1
# WhcNMTgwOTA3MTc1ODU1WjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjENMAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNO
# OjU4NDctRjc2MS00RjcwMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAum1PI6z8Uk7O
# jh+jHA7qkPtqGl+g9Ol0qKYBPtGxZ7SgIuZrXcfSVifUjgXwk+0q9TQFSiD+/b5L
# akoaE7Onwvh5GKjFrZH4Ymu8lwmIQBFCa5liePRTnVQybA/c18S/8AhhXn7t3/QL
# gh27vP7FnFy3lDYiVoEhxM40kv6vM0OuiBlFTxwWfBWzwHDem0cAw99IgtE4Ufac
# ftfmmIVMazRTlX1M1SLYTHo0u5yaOiU1ac1i2q/K30PewG+997QJHkpC6umA9XwH
# r4emFX3hqAChAO/fHrd3bRM0OMNH2sAFYTz41jH0D7ojyeRiRgMi+wAUtL1u+WTa
# 3RQ3NOF7VQIDAQABo4IBCTCCAQUwHQYDVR0OBBYEFJjHnFnzwMDY0qoqcv3dfXL2
# PD/mMB8GA1UdIwQYMBaAFCM0+NlSRnAK7UD7dvuzK7DDNbMPMFQGA1UdHwRNMEsw
# SaBHoEWGQ2h0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3Rz
# L01pY3Jvc29mdFRpbWVTdGFtcFBDQS5jcmwwWAYIKwYBBQUHAQEETDBKMEgGCCsG
# AQUFBzAChjxodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY3Jv
# c29mdFRpbWVTdGFtcFBDQS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwgwDQYJKoZI
# hvcNAQEFBQADggEBAEsgBVRD0msYysh0uEFNws3dDP5riqpVsamGJpWCMlJGNl4+
# LX4JIv283MTsCU37LaNIbGjhTuSi4ifVyvs73xsicr4tPiGK7IYBRthKL/3tEjeM
# /mGWSfY2rZRgSwUKbPIGVz1IgHaOm089sb6Q6yC4EkEOAxTrhBS/4SZeTM2RuT0o
# 8rFtffWR4sW8SrpgvRQuz28WAu2wDZ3XTTvAmiF+cjumrx6fA8UaLhYG6LWvJZT6
# zrlsZ8DcTZMwZLnw6tKSiqvb6gvIcyDTcVj25GRul3yzLfgsmLWGTRN7woCSGzfd
# gykqBndYo4OS6E0ssxjPR8zJw0DbhJjvUMtJ/egwggYHMIID76ADAgECAgphFmg0
# AAAAAAAcMA0GCSqGSIb3DQEBBQUAMF8xEzARBgoJkiaJk/IsZAEZFgNjb20xGTAX
# BgoJkiaJk/IsZAEZFgltaWNyb3NvZnQxLTArBgNVBAMTJE1pY3Jvc29mdCBSb290
# IENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw0wNzA0MDMxMjUzMDlaFw0yMTA0MDMx
# MzAzMDlaMHcxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYD
# VQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xITAf
# BgNVBAMTGE1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQTCCASIwDQYJKoZIhvcNAQEB
# BQADggEPADCCAQoCggEBAJ+hbLHf20iSKnxrLhnhveLjxZlRI1Ctzt0YTiQP7tGn
# 0UytdDAgEesH1VSVFUmUG0KSrphcMCbaAGvoe73siQcP9w4EmPCJzB/LMySHnfL0
# Zxws/HvniB3q506jocEjU8qN+kXPCdBer9CwQgSi+aZsk2fXKNxGU7CG0OUoRi4n
# rIZPVVIM5AMs+2qQkDBuh/NZMJ36ftaXs+ghl3740hPzCLdTbVK0RZCfSABKR2YR
# JylmqJfk0waBSqL5hKcRRxQJgp+E7VV4/gGaHVAIhQAQMEbtt94jRrvELVSfrx54
# QTF3zJvfO4OToWECtR0Nsfz3m7IBziJLVP/5BcPCIAsCAwEAAaOCAaswggGnMA8G
# A1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFCM0+NlSRnAK7UD7dvuzK7DDNbMPMAsG
# A1UdDwQEAwIBhjAQBgkrBgEEAYI3FQEEAwIBADCBmAYDVR0jBIGQMIGNgBQOrIJg
# QFYnl+UlE/wq4QpTlVnkpKFjpGEwXzETMBEGCgmSJomT8ixkARkWA2NvbTEZMBcG
# CgmSJomT8ixkARkWCW1pY3Jvc29mdDEtMCsGA1UEAxMkTWljcm9zb2Z0IFJvb3Qg
# Q2VydGlmaWNhdGUgQXV0aG9yaXR5ghB5rRahSqClrUxzWPQHEy5lMFAGA1UdHwRJ
# MEcwRaBDoEGGP2h0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1
# Y3RzL21pY3Jvc29mdHJvb3RjZXJ0LmNybDBUBggrBgEFBQcBAQRIMEYwRAYIKwYB
# BQUHMAKGOGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljcm9z
# b2Z0Um9vdENlcnQuY3J0MBMGA1UdJQQMMAoGCCsGAQUFBwMIMA0GCSqGSIb3DQEB
# BQUAA4ICAQAQl4rDXANENt3ptK132855UU0BsS50cVttDBOrzr57j7gu1BKijG1i
# uFcCy04gE1CZ3XpA4le7r1iaHOEdAYasu3jyi9DsOwHu4r6PCgXIjUji8FMV3U+r
# kuTnjWrVgMHmlPIGL4UD6ZEqJCJw+/b85HiZLg33B+JwvBhOnY5rCnKVuKE5nGct
# xVEO6mJcPxaYiyA/4gcaMvnMMUp2MT0rcgvI6nA9/4UKE9/CCmGO8Ne4F+tOi3/F
# NSteo7/rvH0LQnvUU3Ih7jDKu3hlXFsBFwoUDtLaFJj1PLlmWLMtL+f5hYbMUVbo
# nXCUbKw5TNT2eb+qGHpiKe+imyk0BncaYsk9Hm0fgvALxyy7z0Oz5fnsfbXjpKh0
# NbhOxXEjEiZ2CzxSjHFaRkMUvLOzsE1nyJ9C/4B5IYCeFTBm6EISXhrIniIh0EPp
# K+m79EjMLNTYMoBMJipIJF9a6lbvpt6Znco6b72BJ3QGEe52Ib+bgsEnVLaxaj2J
# oXZhtG6hE6a/qkfwEm/9ijJssv7fUciMI8lmvZ0dhxJkAj0tr1mPuOQh5bWwymO0
# eFQF1EEuUKyUsKV4q7OglnUa2ZKHE3UiLzKoCG6gW4wlv6DvhMoh1useT8ma7kng
# 9wFlb4kLfchpyOZu6qeXzjEp/w7FW1zYTRuh2Povnj8uVRZryROj/TCCBhAwggP4
# oAMCAQICEzMAAABkR4SUhttBGTgAAAAAAGQwDQYJKoZIhvcNAQELBQAwfjELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEoMCYGA1UEAxMfTWljcm9z
# b2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMTAeFw0xNTEwMjgyMDMxNDZaFw0xNzAx
# MjgyMDMxNDZaMIGDMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
# MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
# MQ0wCwYDVQQLEwRNT1BSMR4wHAYDVQQDExVNaWNyb3NvZnQgQ29ycG9yYXRpb24w
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTLtrY5j6Y2RsPZF9NqFhN
# FDv3eoT8PBExOu+JwkotQaVIXd0Snu+rZig01X0qVXtMTYrywPGy01IVi7azCLiL
# UAvdf/tqCaDcZwTE8d+8dRggQL54LJlW3e71Lt0+QvlaHzCuARSKsIK1UaDibWX+
# 9xgKjTBtTTqnxfM2Le5fLKCSALEcTOLL9/8kJX/Xj8Ddl27Oshe2xxxEpyTKfoHm
# 5jG5FtldPtFo7r7NSNCGLK7cDiHBwIrD7huTWRP2xjuAchiIU/urvzA+oHe9Uoi/
# etjosJOtoRuM1H6mEFAQvuHIHGT6hy77xEdmFsCEezavX7qFRGwCDy3gsA4boj4l
# AgMBAAGjggF/MIIBezAfBgNVHSUEGDAWBggrBgEFBQcDAwYKKwYBBAGCN0wIATAd
# BgNVHQ4EFgQUWFZxBPC9uzP1g2jM54BG91ev0iIwUQYDVR0RBEowSKRGMEQxDTAL
# BgNVBAsTBE1PUFIxMzAxBgNVBAUTKjMxNjQyKzQ5ZThjM2YzLTIzNTktNDdmNi1h
# M2JlLTZjOGM0NzUxYzRiNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzcitW2oynUC
# lTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtp
# b3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEGCCsGAQUF
# BwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Br
# aW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0MAwGA1Ud
# EwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAIjiDGRDHd1crow7hSS1nUDWvWas
# W1c12fToOsBFmRBN27SQ5Mt2UYEJ8LOTTfT1EuS9SCcUqm8t12uD1ManefzTJRtG
# ynYCiDKuUFT6A/mCAcWLs2MYSmPlsf4UOwzD0/KAuDwl6WCy8FW53DVKBS3rbmdj
# vDW+vCT5wN3nxO8DIlAUBbXMn7TJKAH2W7a/CDQ0p607Ivt3F7cqhEtrO1Rypehh
# bkKQj4y/ebwc56qWHJ8VNjE8HlhfJAk8pAliHzML1v3QlctPutozuZD3jKAO4WaV
# qJn5BJRHddW6l0SeCuZmBQHmNfXcz4+XZW/s88VTfGWjdSGPXC26k0LzV6mjEaEn
# S1G4t0RqMP90JnTEieJ6xFcIpILgcIvcEydLBVe0iiP9AXKYVjAPn6wBm69FKCQr
# IPWsMDsw9wQjaL8GHk4wCj0CmnixHQanTj2hKRc2G9GL9q7tAbo0kFNIFs0EYkbx
# Cn7lBOEqhBSTyaPS6CvjJZGwD0lNuapXDu72y4Hk4pgExQ3iEv/Ij5oVWwT8okie
# +fFLNcnVgeRrjkANgwoAyX58t0iqbefHqsg3RGSgMBu9MABcZ6FQKwih3Tj0DVPc
# gnJQle3c6xN3dZpuEgFcgJh/EyDXSdppZzJR4+Bbf5XA/Rcsq7g7X7xl4bJoNKLf
# cafOabJhpxfcFOowMIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkqhkiG9w0B
# AQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAG
# A1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTEw
# HhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQgQ29kZSBT
# aWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
# q/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03a8YS2Avw
# OMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akrrnoJr9eW
# WcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0RrrgOGSsbmQ1
# eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy4BI6t0le
# 2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9sbKvkjh+
# 0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAhdCVfGCi2
# zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8kA/DRelsv
# 1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTBw3J64HLn
# JN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmnEyimp31n
# gOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90lfdu+Hgg
# WCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0wggHpMBAG
# CSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2oynUClTAZ
# BgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/
# BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBaBgNVHR8E
# UzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9k
# dWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsGAQUFBwEB
# BFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraS9j
# ZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNVHSAEgZcw
# gZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNy
# b3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsGAQUFBwIC
# MDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABlAG0AZQBu
# AHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKbC5YR4WOS
# mUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11lhJB9i0ZQ
# VdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6I/MTfaaQ
# dION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0wI/zRive
# /DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560STkKxgrC
# xq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQamASooPoI/
# E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGaJ+HNpZfQ
# 7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ahXJbYANah
# Rr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA9Z74v2u3
# S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33VtY5E90Z1W
# Tk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr/Xmfwb1t
# bWrJUnMTDXpQzTGCBKYwggSiAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25pbmcg
# UENBIDIwMTECEzMAAABkR4SUhttBGTgAAAAAAGQwCQYFKw4DAhoFAKCBujAZBgkq
# hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGC
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUSHKv0Ye4UGXk1GV1/EoVUJfSD68wWgYKKwYB
# BAGCNwIBDDFMMEqgMIAuAE8AVQA0AF8AUgBTAF8AUwBpAG4AZwBsAGUATwBmAGYA
# aQBjAGUALgBwAHMAMaEWgBRodHRwOi8vbWljcm9zb2Z0LmNvbTANBgkqhkiG9w0B
# AQEFAASCAQAb9Jg87SqLqOG4v+eRnfVXQ4QZNFT9qOM1ozAwoJUMXA6DhcABLpLE
# oZvy7M3P0qCu7hoh1zm2PcqZhOSi/ecrfmH0AjMPPsRBmwheC4T8Y3ST1mXoEuB9
# zvKb/96m3dljCkIAffB7jDVFDmv8i2UH9+af7gbjfSzhb0ZYOIVxa8Oji6uQlQaW
# K9ju1BuBfNW8MMqyV+quQn5qMMBJzgZ2woQKywu7CLFFjN5UeElUYOvSOAkkNCh6
# +EznAFLY3YQBPDuVZ3Q7j2n6Ih1fi8sbMkYdfaw8uSF9la06VJFOPgpBDpc7NwYZ
# e7fMgNPt9GZqphzKCrJc20faMOnAzv4ToYICKDCCAiQGCSqGSIb3DQEJBjGCAhUw
# ggIRAgEBMIGOMHcxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# ITAfBgNVBAMTGE1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQQITMwAAAMvZUgZTvz4q
# WQAAAAAAyzAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
# BgkqhkiG9w0BCQUxDxcNMTYxMTMwMjA1ODMyWjAjBgkqhkiG9w0BCQQxFgQUneLt
# EYjFQxE4u0iUUPlDjWePigMwDQYJKoZIhvcNAQEFBQAEggEAqDYGJd5Ccxyg+lJE
# ntEGp5GupfxYIOH/8E1vreFi+0IUK4Ry849n8NSQzrq/HSmJ6LB8PmfvfbDiQTyC
# 7LqPdjUIaBzzcnKi6+AKmjor3Jc7RFCNoEwLTfFa5/8kgs3c1g9q4Oe8IqSfn3tl
# xiiijggwKe5pWZj+ibp5aRS72JJAdiARbx32PAdX+k69mtCl0LFRyIh258vGk/BM
# MupN02GrpvjviSeagJZMNngZpai76J3bm8RjcR3xbHeA6t/JOubc3/qEP/UOEOTV
# BE9xb8yBwPIrpR6W5QzNcHccco0hFfOXBo5NmJqr0OyjkkPZvWfwHv/eBnvl0T9k
# MULjfg==
# SIG # End signature block
