
# Copyright © 2012, Microsoft Corporation. All rights reserved.
#============================================================= 
<#
RS_RemoveO15ClickToRun resolves the problem related the Microsoft office 2013 and 2016, completely uninstalls the Office.

Arguments:

None

Return values:

None
 
#>
#Load paramters...
PARAM($officeStringMessage)
#*=================================================================================
# Load Utilities
#*=================================================================================
. .\utils_SetupEnv.ps1
. .\CL_Office.ps1
#*=================================================================================
#Import localization data
#*=================================================================================
Import-LocalizedData -BindingVariable Strings_RS_RemoveO15ClickToRun -FileName RS_RemoveO15ClickToRun
Function Get-Off15RemovalResultFromLog($O15RemovalLogPath, $key)
{   
	if(!(Test-Path ($O15RemovalLogPath)))
	{
		return $null
    }
	$logs= get-content $O15RemovalLogPath 
    if($logs -eq $null) 
	{ 
		return $null 
	}
    $result = $logs | where { ($_ -match $key)}
    return $result
}
<#
Function description:
function to remove office license in admin mode..


Arguments:
$Key:Product key of Office version.
$OffClass:"OfficeSoftwareProtectionProduct"

Return values:

None 
#>

#===========================================================================================
# Remove-L
#===========================================================================================
     
Function Remove-L
{ 
	Param ([string]$Key, [string]$OffClass)
	$Computer = "."
	$Class = $OffClass 
	$Method = "UninstallProductKey"
	$ID = $Key
	$filter="PartialProductKey = '$ID'"
	$MC = get-WMIObject -Class $class -computer $Computer -Namespace "ROOT\CIMV2" -filter $filter
	if($MC -ne $null)
	{
	$InParams = $mc.psbase.GetMethodParameters($Method) 
	$mc.PSBase.InvokeMethod($Method ,$Null)
	}
}
<#
Function description:
function to expand the diag cab

Arguments:
$diagcab:Diagcab file Path.
$destinationFolder: Path of Destination folder.

Return values:

None 
#>
#===========================================================================================
# expand-diagcab
#===========================================================================================
Function expand-diagcab($diagcab,$destinationFolder)
{

     $i = 0
     $oldFolder = $destinationFolder
     while(Test-Path $destinationFolder)
	 {
           $destinationFolder   = $oldFolder + "" + $i
           $i = $i + 1
		
     }
     
     md $destinationFolder -force
     & "expand" $diagcab "-f:*.*" $destinationFolder
}
<#
Function description:
function to check OfficeBitness 64bit or 32 bit only for C2R.


Arguments:

none

Return values:

$Platform:64bit or 32bit.
#>
#===========================================================================================
 #OfficeBitness
#===========================================================================================
Function OfficeBitness()
{
    $officearchitecture = "HKLM:\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Configuration" #For O15 SP1
    $officearchitecture1 = "HKLM:\SOFTWARE\Microsoft\Office\15.0\ClickToRun\propertyBag" #For O15
    $officearchitecture16 = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" #For O15 SP1
    $officearchitecture16o = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\propertyBag" #For O15


    if(Test-Path $officearchitecture)
    {
        $Key = Get-Item -Path $officearchitecture
	
	    if(($Key.GetValue("platform")) -ne $null)
	    {
            $platform = Get-ItemProperty -Path $officearchitecture -Name Platform |%{$_.Platform}
	
        }
	}
	elseif(Test-Path $officearchitecture1) 
	{
	    $Key1 = Get-Item -Path $officearchitecture1
	
	    if(($Key1.GetValue("platform")) -ne $null)
	    {
	        $platform = Get-ItemProperty -Path $officearchitecture1 -Name Platform |%{$_.Platform}
		
	    }
	}

	elseif(Test-Path $officearchitecture16)
    {
        $Key = Get-Item -Path $officearchitecture16
	
	    if(($Key.GetValue("platform")) -ne $null)
	    {
            $platform = Get-ItemProperty -Path $officearchitecture16 -Name Platform |%{$_.Platform}
	
        }
	}
	elseif(Test-Path $officearchitecture16o) 
	{
	    $Key1 = Get-Item -Path $officearchitecture16o
	
	    if(($Key1.GetValue("platform")) -ne $null)
	    {
	        $platform = Get-ItemProperty -Path $officearchitecture16o -Name Platform |%{$_.Platform}
		
	    }
	}
	if(($platform -eq "x86") -or ($platform -eq $null))
    {
        $platform = "32bit"
    }
    elseif($platform -eq "x64")
    {
        $platform = "64bit"
    }
  
	return $platform 
}

#===========================================================================================
#Remove License
#===========================================================================================
$OfficeAppId = "0ff1ce15-a989-479d-af46-f275c6370663" #Office 2013
$OS = (Get-WmiObject Win32_OperatingSystem).Name
$Win =$OS.Substring(0,19)
if ($Win -eq "Microsoft Windows 7")
{
   $query = "Select Name, PartialProductKey from OfficeSoftwareProtectionProduct Where ApplicationId = ""$OfficeAppId"" and PartialProductKey <> "" NULL "" "
   $Class = "OfficeSoftwareProtectionProduct"
}
else
{
   $query = "Select Name, PartialProductKey from SoftwareLicensingProduct Where ApplicationId = ""$OfficeAppId"" and PartialProductKey <> "" NULL "" " 
   $Class = "SoftwareLicensingProduct"
}
   $ProductInstances = gwmi -Query $query -ErrorAction SilentlyContinue
 
foreach ($instance in $ProductInstances)
{
    if ($instance.PartialProductKey -ne $null)
     {
         $O15 = $instance.Name.substring(0,9)
		 if($O15 -eq "Office 15")
         {
            Remove-L $instance.PartialProductKey -OffClass $Class                        
         }
      }
}

#===========================================================================================
                                  ######## MAIN ###########
#===========================================================================================
Write-DiagProgress -activity $Strings_RS_RemoveO15ClickToRun.ID_NAME_progAc_Off15C2R -status $Strings_RS_RemoveO15ClickToRun.ID_NAME_progSt_Off15C2R
#check all folders Path ,registry Path of office pack...
$Installed = $Strings_RS_RemoveO15ClickToRun.id_name_progst_installed
$StringMessageMSI13 = "Microsoft Office 2013 MSI " + $Installed
$StringMessageMSI16 = "Microsoft Office 2016 MSI " + $Installed
$StringMessageC2R13 = "Microsoft Office 2013 Click-to-Run " + $Installed
$StringMessageC2R16 = "Microsoft Office 2016 Click-to-Run " + $Installed
$default = "CLIENTALL"
#if installed office is office MSI 16 then call offscrub_o16msi.vbs 
if(($officeStringMessage.contains($StringMessageMSI16)))
{
	CScript.exe ".\OffScrub_O16msi.vbs" $default 
	#offscrubc2r folder created
	$ScrubLogDir = join-Path $env:temp "OffScrub_O16msi"
}
#if c2r installed is true call OffScrubc2R.vbs files to unistall Office C2R files.
elseif(($officeStringMessage.contains($StringMessageC2R13)) -or ($officeStringMessage.contains($StringMessageC2R16)))
{
    #calling VBscript
	CScript.exe ".\OffScrubc2r.vbs"
	$ScrubLogDir = join-Path $env:temp "OffScrubC2R"
}
#if installed office is  MSI 15 then call offscrub_o15msi.vbs 
elseif(($officeStringMessage.contains($StringMessageMSI13)))
{	
	CScript.exe ".\OffScrub_O15msi.vbs" $default 
	#offscrubc2r folder created
	$ScrubLogDir = join-Path $env:temp "OffScrub_O15msi"
}

#creating new directory for HKCR
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

#get the registry Path for context menu(NEW) shortcut...
$regOffWordShortcut = "HKCR:\.docx\Word.Document.12\shellNew";
$regOfficedatabase = "HKCR:\.mdb\Access.MDBFile\shellNew";
$regOfficedatabase1 = "HKCR:\.mdb\shellNew";
$regOffpubdoc = "HKCR:\.pub\publisher.document.15\shellNew";
$regOffpubdoc1 = "HKCR:\.pub\publisher.document.16\shellNew";	
$regOfficeXcelShortcut = "HKCR:\.xlsx\Excel.Sheet.12\shellNew";
$regOffpowerpoint = "HKCR:\.pptx\Powerpoint.Show.12\shellNew";
$regOffmsproject = "HKCR:\.mpp\MSProject.Project.9\shellNew";
$regOffVisioShortcut = "HKCR:\.vsdx\Visio.Drawing.15\shellNew";
$regOffrtf = "HKCR:\.rtf\shellNew";

if(Test-Path $regOffWordShortcut)
{
 	Remove-Item -Path HKCR:\.docx\Word.Document.12\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOffVisioShortcut)
{
 	Remove-Item -Path HKCR:\.vsdx\Visio.Drawing.15\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOffrtf)
{
 	Remove-Item -Path HKCR:\.rtf\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOfficedatabase)
{
 	Remove-Item -Path HKCR:\.mdb\Access.MDBFile\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOfficedatabase1)
{
 	Remove-Item -Path HKCR:\.mdb\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOffpubdoc)
{
 	Remove-Item -Path HKCR:\.pub\publisher.document.15\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOffpubdoc1)
{
 	Remove-Item -Path HKCR:\.pub\publisher.document.16\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOfficeXcelShortcut)
{
 	Remove-Item -Path HKCR:\.xlsx\Excel.Sheet.12\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOffmsproject)
{
 	Remove-Item -Path HKCR:\.mpp\MSProject.Project.9\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}
if(Test-Path $regOffpowerpoint)
{
 Remove-Item -Path HKCR:\.pptx\Powerpoint.Show.12\shellNew\ -force -recurse -ErrorAction SilentlyContinue 
}

if(Test-Path $ScrubLogDir) 
{   
	$scrubLogFile = (dir $ScrubLogDir | where {$_ -match "_scrubLog.txt"} | sort -prop lastWriteTime | select -last 1).Name
	if($scrubLogFile -ne $null)
	{
		$scrubLogFilePath = join-Path $ScrubLogDir $scrubLogFile
		if (Test-Path $scrubLogFilePath)
		{
 			$RemovalResult = Get-Off15RemovalResultFromLog $scrubLogFilePath "Removal result"	
	    }  	
    }
}
if(($officeStringMessage.contains($StringMessageMSI16)))
{
	$MSI16 = isOfficeMSI_Installed "OFFICE16"
	if(!$MSI16)
	{
    $RemovalResult = "SUCCESS"
	}
	else
	{
	$RemovalResult = "FAILED"
	}
}
elseif(($officeStringMessage.contains($StringMessageMSI13)))
{
	$MSI15 = isOfficeMSI_Installed "OFFICE15"
	if(!$MSI15)
	{
    $RemovalResult = "SUCCESS"
	}
	else
	{
	$RemovalResult = "FAILED"
	}
}
New-Item -path "$env:temp" -name "RemovalResult.txt" -itemtype file -force 
$RemovalResultVerfier = Join-Path "$env:temp" "RemovalResult.txt"
$RemovalResult >> $RemovalResultVerfier

if(($RemovalResult.substring($RemovalResult.Length - 7,7) -ieq "SUCCESS") -or ($RemovalResult.substring($RemovalResult.Length - 47,47) -ieq "Uninstall requires a system reboot to complete."))  
{
	 get-DiagInput -id "INT_O15C2R_Reboot"          
     $RemovalResult| convertto-xml | update-diagreport  -id "RS_RemoveO15ClickToRun" -name "Removal result:" -Verbosity Informational
}
else
{
     get-DiagInput -id "INT_O15C2R_UninstallFailed" -Parameter @{'failureMsg' =  $RemovalResult}            
     $RemovalResult | convertto-xml | update-diagreport  -id "RS_RemoveO15ClickToRun" -name "Removal result:" -Verbosity Informational
}




 
 




# SIG # Begin signature block
# MIIa/AYJKoZIhvcNAQcCoIIa7TCCGukCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUQZ8lWsTiVuXwV0ho+rTJma5f
# 3+qgghWCMIIEwzCCA6ugAwIBAgITMwAAAIpX6omjSeuL6AAAAAAAijANBgkqhkiG
# 9w0BAQUFADB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwHhcNMTUxMDA3MTgxNDAy
# WhcNMTcwMTA3MTgxNDAyWjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjENMAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNO
# OkIxQjctRjY3Ri1GRUMyMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAy8XCCCFsLcM0
# BUnA5TXkIRx+hkXEljDvD+u/MlomeT/pmRbc+4l1oz3FZZoq2aEbKmvJJ56sZZe5
# TbIOgsQAg9iR4ienNO29HtQSlDRE6NoL6QUBS+pVz4pKt5g3Kr7n5w2NPfmn1syY
# AeqQpJmXvwSLX0RFW8hZy6dxQxFqYt/mJehuNbrSiCwDifFnRmEzm4M+s2WJt6dg
# Xo7R3ORQCTw/C+cchNZlzJfRyzG1Igx/7gcKDc1A5Uw5N2oGtlnd4i6QaRvXd5+b
# 3K4vKEBkoABk/a6gbrtJ+18OCdEEHMO+yJPvasooaDOco+3zv6ougZoD7lgM1DdG
# XyRu8bHQ7wIDAQABo4IBCTCCAQUwHQYDVR0OBBYEFD0WsZSu/4ozJ/VxseuzhKon
# OOhLMB8GA1UdIwQYMBaAFCM0+NlSRnAK7UD7dvuzK7DDNbMPMFQGA1UdHwRNMEsw
# SaBHoEWGQ2h0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3Rz
# L01pY3Jvc29mdFRpbWVTdGFtcFBDQS5jcmwwWAYIKwYBBQUHAQEETDBKMEgGCCsG
# AQUFBzAChjxodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY3Jv
# c29mdFRpbWVTdGFtcFBDQS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwgwDQYJKoZI
# hvcNAQEFBQADggEBAAHUesgSM5gcsDCw++6r3TlkG7E27ohjvqBPXqCHrZlfcXQ/
# NSXMHonyC6N7MeYOK45oOPiCDtm6IgH+9BK5gxpi0yP54KdSvJLdLaihEOfrR84W
# vQuTOmJKdVTUTq8w5xhXKraWjjI0cB3tYVa47N1Tw2ysXKgCQ3GYYWzmuE5wfIBU
# jKfmOOp6zcDvVkMPAw6JyDpwHZrHVB1jezHy5hahIts6CKsESpPMYeL8SjGmHfQG
# rW9jS8BNnBJE4KmGxgvr9/grRMt2m8XwFvAc8yh3rcDNI+eElMI1lyB96BXxq+Eh
# dBZHe2Kw2ssXaxCoqeBmPh9a1B/sH7UdLdxshJEwggTsMIID1KADAgECAhMzAAAB
# Cix5rtd5e6asAAEAAAEKMA0GCSqGSIb3DQEBBQUAMHkxCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xIzAhBgNVBAMTGk1pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBMB4XDTE1MDYwNDE3NDI0NVoXDTE2MDkwNDE3NDI0NVowgYMxCzAJ
# BgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25k
# MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xDTALBgNVBAsTBE1PUFIx
# HjAcBgNVBAMTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjCCASIwDQYJKoZIhvcNAQEB
# BQADggEPADCCAQoCggEBAJL8bza74QO5KNZG0aJhuqVG+2MWPi75R9LH7O3HmbEm
# UXW92swPBhQRpGwZnsBfTVSJ5E1Q2I3NoWGldxOaHKftDXT3p1Z56Cj3U9KxemPg
# 9ZSXt+zZR/hsPfMliLO8CsUEp458hUh2HGFGqhnEemKLwcI1qvtYb8VjC5NJMIEb
# e99/fE+0R21feByvtveWE1LvudFNOeVz3khOPBSqlw05zItR4VzRO/COZ+owYKlN
# Wp1DvdsjusAP10sQnZxN8FGihKrknKc91qPvChhIqPqxTqWYDku/8BTzAMiwSNZb
# /jjXiREtBbpDAk8iAJYlrX01boRoqyAYOCj+HKIQsaUCAwEAAaOCAWAwggFcMBMG
# A1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBSJ/gox6ibN5m3HkZG5lIyiGGE3
# NDBRBgNVHREESjBIpEYwRDENMAsGA1UECxMETU9QUjEzMDEGA1UEBRMqMzE1OTUr
# MDQwNzkzNTAtMTZmYS00YzYwLWI2YmYtOWQyYjFjZDA1OTg0MB8GA1UdIwQYMBaA
# FMsR6MrStBZYAck3LjMWFrlMmgofMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9j
# cmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY0NvZFNpZ1BDQV8w
# OC0zMS0yMDEwLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6
# Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljQ29kU2lnUENBXzA4LTMx
# LTIwMTAuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQCmqFOR3zsB/mFdBlrrZvAM2PfZ
# hNMAUQ4Q0aTRFyjnjDM4K9hDxgOLdeszkvSp4mf9AtulHU5DRV0bSePgTxbwfo/w
# iBHKgq2k+6apX/WXYMh7xL98m2ntH4LB8c2OeEti9dcNHNdTEtaWUu81vRmOoECT
# oQqlLRacwkZ0COvb9NilSTZUEhFVA7N7FvtH/vto/MBFXOI/Enkzou+Cxd5AGQfu
# FcUKm1kFQanQl56BngNb/ErjGi4FrFBHL4z6edgeIPgF+ylrGBT6cgS3C6eaZOwR
# XU9FSY0pGi370LYJU180lOAWxLnqczXoV+/h6xbDGMcGszvPYYTitkSJlKOGMIIF
# vDCCA6SgAwIBAgIKYTMmGgAAAAAAMTANBgkqhkiG9w0BAQUFADBfMRMwEQYKCZIm
# iZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJbWljcm9zb2Z0MS0wKwYDVQQD
# EyRNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMTAwODMx
# MjIxOTMyWhcNMjAwODMxMjIyOTMyWjB5MQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMSMwIQYDVQQDExpNaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBD
# QTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJyWVwZMGS/HZpgICBC
# mXZTbD4b1m/My/Hqa/6XFhDg3zp0gxq3L6Ay7P/ewkJOI9VyANs1VwqJyq4gSfTw
# aKxNS42lvXlLcZtHB9r9Jd+ddYjPqnNEf9eB2/O98jakyVxF3K+tPeAoaJcap6Vy
# c1bxF5Tk/TWUcqDWdl8ed0WDhTgW0HNbBbpnUo2lsmkv2hkL/pJ0KeJ2L1TdFDBZ
# +NKNYv3LyV9GMVC5JxPkQDDPcikQKCLHN049oDI9kM2hOAaFXE5WgigqBTK3S9dP
# Y+fSLWLxRT3nrAgA9kahntFbjCZT6HqqSvJGzzc8OJ60d1ylF56NyxGPVjzBrAlf
# A9MCAwEAAaOCAV4wggFaMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFMsR6MrS
# tBZYAck3LjMWFrlMmgofMAsGA1UdDwQEAwIBhjASBgkrBgEEAYI3FQEEBQIDAQAB
# MCMGCSsGAQQBgjcVAgQWBBT90TFO0yaKleGYYDuoMW+mPLzYLTAZBgkrBgEEAYI3
# FAIEDB4KAFMAdQBiAEMAQTAfBgNVHSMEGDAWgBQOrIJgQFYnl+UlE/wq4QpTlVnk
# pDBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtp
# L2NybC9wcm9kdWN0cy9taWNyb3NvZnRyb290Y2VydC5jcmwwVAYIKwYBBQUHAQEE
# SDBGMEQGCCsGAQUFBzAChjhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2Nl
# cnRzL01pY3Jvc29mdFJvb3RDZXJ0LmNydDANBgkqhkiG9w0BAQUFAAOCAgEAWTk+
# fyZGr+tvQLEytWrrDi9uqEn361917Uw7LddDrQv+y+ktMaMjzHxQmIAhXaw9L0y6
# oqhWnONwu7i0+Hm1SXL3PupBf8rhDBdpy6WcIC36C1DEVs0t40rSvHDnqA2iA6VW
# 4LiKS1fylUKc8fPv7uOGHzQ8uFaa8FMjhSqkghyT4pQHHfLiTviMocroE6WRTsgb
# 0o9ylSpxbZsa+BzwU9ZnzCL/XB3Nooy9J7J5Y1ZEolHN+emjWFbdmwJFRC9f9Nqu
# 1IIybvyklRPk62nnqaIsvsgrEA5ljpnb9aL6EiYJZTiU8XofSrvR4Vbo0HiWGFzJ
# NRZf3ZMdSY4tvq00RBzuEBUaAF3dNVshzpjHCe6FDoxPbQ4TTj18KUicctHzbMrB
# 7HCjV5JXfZSNoBtIA1r3z6NnCnSlNu0tLxfI5nI3EvRvsTxngvlSso0zFmUeDord
# EN5k9G/ORtTTF+l5xAS00/ss3x+KnqwK+xMnQK3k+eGpf0a7B2BHZWBATrBC7E7t
# s3Z52Ao0CW0cgDEf4g5U3eWh++VHEK1kmP9QFi58vwUheuKVQSdpw5OPlcmN2Jsh
# rg1cnPCiroZogwxqLbt2awAdlq3yFnv2FoMkuYjPaqhHMS+a3ONxPdcAfmJH0c6I
# ybgY+g5yjcGjPa8CQGr/aZuW4hCoELQ3UAjWwz0wggYHMIID76ADAgECAgphFmg0
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
# 9wFlb4kLfchpyOZu6qeXzjEp/w7FW1zYTRuh2Povnj8uVRZryROj/TGCBOQwggTg
# AgEBMIGQMHkxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYD
# VQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xIzAh
# BgNVBAMTGk1pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBAhMzAAABCix5rtd5e6as
# AAEAAAEKMAkGBSsOAwIaBQCggf0wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFMMF
# NyXqXpJnEIBKT9OKL+ZiKDmYMIGcBgorBgEEAYI3AgEMMYGNMIGKoHCAbgBNAGkA
# YwByAG8AcwBvAGYAdABPAGYAZgBpAGMAZQBVAG4AaQBuAHMAdABhAGwAbABlAHIA
# VgAyAF8AUgBTAF8AUgBlAG0AbwB2AGUATwAxADUAQwBsAGkAYwBrAFQAbwBSAHUA
# bgAuAHAAcwAxoRaAFGh0dHA6Ly9taWNyb3NvZnQuY29tMA0GCSqGSIb3DQEBAQUA
# BIIBAIzb15j66Kw4iq8ZPf99A6pCNTLPWfxbutmW0flhgUK4FN/WlQYxuv/RDkz3
# gGT3NfzgzVPFpL/iOc+Arpsw7Uepm0dRkMPYYoNk+Uz+DGUAz9HXDVlsBuAp8iYv
# J/bg6l1WBH3s8ECipXbhKIoVgZ5o2g2TQhmaOWLJ+tQjBNw/5H9UpZz7vZcVIt8E
# IrF9geLmAhfpEEEXnzIVWdBUTmL+iVimUNAc2XDZrAucVm0KNFO7Gmq8DRHHd1bd
# CWHc1afjQayYprYfSBcrnVwKQmOJtd9qBd3K2qBuDLl2oDkYTlaxgV9dfTrQ++Vd
# z+yrmX3tcbDcYXogKnSef1XUYmOhggIoMIICJAYJKoZIhvcNAQkGMYICFTCCAhEC
# AQEwgY4wdzELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEhMB8G
# A1UEAxMYTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBAhMzAAAAilfqiaNJ64voAAAA
# AACKMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
# SIb3DQEJBTEPFw0xNTEyMDExOTMwMDFaMCMGCSqGSIb3DQEJBDEWBBT92Y0GsMu0
# T5Yaa8T6ggJdp4EucDANBgkqhkiG9w0BAQUFAASCAQC0w95Bi5ci4ORr8ntYLlif
# TjT6r1cuYASLu7YwR72X6pLZAFzPEbpht/qZXEQJ73m7Zr9vpkANa5vP5KXUIcSG
# x2O0/vG54by5kTbkbN/zXjgPjGVRUrWyKlyVKius5s6mjNWe9d91KfhFzd5z6fey
# 7s32EcA0U7hu3J6SoP/4mgV50FwlOGQv1iSUMR4VgDbD17Qe+2r2JdOWyjVKiR8+
# JnjdOw0w9Gx68zNZqug587Lw3OnMfx7cQbX3R3Y91s1z6IQdfPngcqpRS4yB5NIh
# tdQyb2OamuGCJot9SR1Gc3SeSC32rC7dHj6hf2UZKubr+ePRThHPP7LJUUo/FOxt
# SIG # End signature block
