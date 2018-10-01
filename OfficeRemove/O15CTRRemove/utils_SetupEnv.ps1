#*=================================================================================
# Copyright © 2013, Microsoft Corporation. All rights reserved.

#*=================================================================================
#function find-typeassembly($classname) # return assembly
#function import-cs([string] $classname, [string] $sourcefile, [string] $sourcetext, [switch] $force)
#[bool] function log-cwosscriptexception()
#function Save($xmldoc, $path)
#function Set-PSVersionTable 
#*=================================================================================

	#$null = [reflection.assembly]::loadwithpartialname("system.windows.forms")
##line 14

#*=================================================================================
#Function:	find-typeassembly
#Purpose:	Search all loaded assemblies for the named type
#Return:	assembly
#*=================================================================================
function find-typeassembly($typename) # return assembly
{
	foreach ($assembly in [appdomain]::currentdomain.getassemblies())
	{
		foreach ($type in $assembly.gettypes())
		{
			if ($type.fullname -eq $typename)
			{
				return $assembly
			}
		} # $type
	} # $assembly
	return $null
} # find-classassembly

#*=================================================================================
#Function:	cwos-stack
#Purpose:	Wrap current stack trace as a multi line string.
#Param:		optional $format -- default $null is 'long'
#Param:		optional $maxparamlength -- -1 is full, default 0 is interpreted as 50
#Return:	[string]
#*=================================================================================
function cwos-stack([string] $stackformat, [int] $maxparamlength)
{
	if ([string]::isnullorempty($stackformat)) 
	{ $stackformat = 'long' }
	if ($maxparamlength -eq 0) 
	{ $maxparamlength = 50 }
	if (@(get-command *get-pscallstack).length -eq 0)
	{ return '(Stack trace is unavailable)' }	
	$callstack = @( &{
		get-pscallstack
		trap [management.automation.commandnotfoundexception] 
		{ throw 'Failed obtain call stack' }
	} )
	$trimargs = {
		# debug: [console]::error.writeline("trimargs $($_.command) $($_.arguments)")
		$args = $_.arguments
		if ($maxparamlength -gt 1 -and $_.arguments.length -gt $maxparamlength)
		{ 
			$x = $_ | select *
			$x.arguments = '[' + $_.arguments.substring(1, $maxparamlength - 2) + '...]'
			return $x
		}
		else
		{
			return $_
		}
	} # $trimargs
	switch ($stackformat)
	{
		'long' {
			$f = { "$($_.location): $($_.command)$($_.arguments)" }
		} # long
	} # switch
	$l = @( $callstack |% $trimargs |% $f )
	return [string]::join("`n", $l)
} # cwos-stack

#*=================================================================================
#Function:	Import-CS
#Purpose:	Encapsulate loading of C# code.
#			The sourcefiles are ignored when the sourcetext is specified.
#			The classname should be declared by the c# source to indicate that the source was successfully loaded.
#Throw:		If $sourcefile is missing and $sourcetext is blank.
#Throw:		If $classname is not declared by the c# source.
#Throw:		If the class already exists, and -force is requested.  Re-loading a class is not supported.
#Return:	type
#Notice:	The source may declare many types, and NOT necessary to use the returned type reference.
#Notice:	The source files should have any import statements INSIDE the namespace.
#			At runtime, the c# code will fail to compile if import statements are outside 
#			namespace in the second and following files.
#*=================================================================================
function import-cs([string] $classname, [string[]] $sourcefile, [string] $sourcetext, [switch] $force, [string[]] $referencedassemblies,[string]$Language = "CSharp",[string]$CodeDomProvider)
{
	$type = $classname -as [type]
	if ($type -ne $null)
	{
		if ($force)
		{
			# Remove the old instance of this class
			throw "Unloading assemblies is not supported in this version"
		}
		else
		{
			# The class has already been loaded
			return $type
		}
	}
	if ($sourcetext -lt ' ')
	{
		foreach ($file in $sourcefile)
		{
			if (test-path $file)
			{
				$sourcetext += "`n" + [string]::join("`n", (get-content $file))
			}
			else
			{
				$title = "Missing c# source $file"
				[string] $message = $myinvocation.positionmessage
				$xml = $myinvocation | convertto-xml
				update-diagreport `
					-xml $xml `
					-id 'embeddedcodemissing' `
					-name $title `
					-description $message `
					-verbosity 'error' 
				throw "Source file $file does not exist"
			}
		} # for $file
	}
	&{
		$compilefile = 'compilefile.txt'
		$count = $error.count
		if(![string]::IsNullOrEmpty($CodeDomProvider))
		{
				$out = add-type `
			-typedefinition $sourcetext `
			-referencedassemblies $referencedassemblies -CodeDomProvider $CodeDomProvider `
			-ignorewarnings 2> $compilefile
		}
		else
		{		
				$out = add-type `
			-typedefinition $sourcetext `
			-referencedassemblies $referencedassemblies -Language $language `
			-ignorewarnings  2> $compilefile
		}

		$compileresult = cat $compilefile
		if ($error.count -ne $count)
		{
			$e = $error[0]
			$title = "Error " + $e.FullyQualifiedErrorId
			[string] $position = $e.invocationinfo.positionmessage
			[string] $message = $e.exception
			$message += $position
			$xml = @(cwos-stack) + $e + $sourcefile + $stdout + $stderr + $out | convertto-xml
			update-diagreport `
				-xml $xml `
				-id 'embeddedcodeerror' `
				-name 'Embedded Code Error' `
				-description $position `
				-verbosity 'error' 
			throw "Error compiling $sourcefile"
		}
		trap 
		{
			#$stdout = cat $outfile
			#$stderr = cat $errfile
			$e = $error[0]
			$title = "Error " + $e.FullyQualifiedErrorId
			[string] $position = $e.invocationinfo.positionmessage
			[string] $message = $e.exception
			$message += $position
			$xml = @(cwos-stack) + $sourcefile + $compileresult + $out + $e | convertto-xml
			update-diagreport `
				-xml $xml `
				-id 'embeddedcodeerror' `
				-name 'Embedded Code Error' `
				-description $position `
				-verbosity 'error' 
			throw "Error compiling $sourcefile"
		}
	} # compile
	$type = $classname -as [type]
	if ($type -eq $null)
	{
		$xml = @(cwos-stack) + $sourcefile + $compileresult + $out + $e | convertto-xml
		update-diagreport `
			-xml $xml `
			-id 'embeddedcodeerror' `
			-name 'Embedded Code Error' `
			-description $position `
			-verbosity 'error' 
		throw "The type [$classname] was not defined after compiling files [$sourcefile]"
	}
	return $type
} # Import-CS

#*=================================================================================
#Function : log-cwosscriptexception
#Purpose :  Writes the latest script exception to the diagnostic report
#Return  : [bool] $continue -- the script should terminate if $continue is false.
#*=================================================================================
function log-cwosscriptexception()
{
	$e = $error[0]
	$title = "Error " + $e.FullyQualifiedErrorId
	[string] $position = $e.invocationinfo.positionmessage
	[string] $message = $e.exception
	$message += $position
	[bool] $continue = $false
		$flags = [windows.forms.messageboxbuttons]::okcancel
		$result = [windows.forms.messagebox]::show($message, $title, $flags)
		$continue = $result -eq [windows.forms.dialogresult]::ok
##line 219
	$xml = $e | convertto-xml
	update-diagreport `
		-xml $xml `
		-id 'scripterror' `
		-name 'Script Error' `
		-description $position `
		-verbosity 'error' 
	return $continue
	
	trap
	{
		$null = [reflection.assembly]::loadwithpartialname("system.windows.forms")
		$message = "Error while writing error report"
		$message += $error[0].invocationinfo.positionmessage
		$message += $error[0].exception
		[windows.forms.messagebox]::show($message)
	}
} # log-cwosscriptexception

#*=================================================================================
#Function : Set-PSVersionTable
#Purpose :  Check system for current PowerShell Version
#Return  : void
#*=================================================================================
function Set-PSVersionTable 

{ 
     if (!(test-path variable:PSVersionTable))
	 {
	 	$myPSVersionTable = @{}		
		[Version]$CLRVersion = $([System.Reflection.Assembly]::GetExecutingAssembly().ImageRuntimeVersion).TrimStart("v")
		[Version]$BuildVersion = $(Get-WmiObject Win32_OperatingSystem).Version
		[Version]$PSVersion = "1.0"
		[Version]$WSManStackVersion = "0.0"
		[Array]$PSCompatibleVersions = @($PSVersion)
		[Version]$SerializationVersion = "0.0.0.0"
		[Version]$PSRemotingProtocolVersion = "0.0.0.0"

		$myPSVersionTable.Add('CLRVersion', $CLRVersion)		
		$myPSVersionTable.Add('BuildVers$PSion', $BuildVersion)
		$myPSVersionTable.Add('PSVersion', $PSVersion)
		$myPSVersionTable.Add('WSManStackVersion', $WSManStackVersion)
		$myPSVersionTable.Add('PSCompatibleVersions', $PSCompatibleVersions)
		$myPSVersionTable.Add('SerializationVersion', $SerializationVersion)
		$myPSVersionTable.Add('PSRemotingProtocolVersion', $PSRemotingProtocolVersion)
		
		Set-Variable -Name PSVersionTable -Scope Global -Value $myPSVersionTable -Option Constant
	 } 
}
Set-PSVersionTable

# If Powershell Version is less than 2.0 load compatibility scripts
#if ($PSVersionTable.PSVersion -lt '2.0')
#{ 
#	. .\utils_PowerShell_1_0.ps1
#}

#*=================================================================================
#Function : Save
#Purpose :  will check the version and accordingly save input xml to a file
#Return  : 
#*=================================================================================
function Save()
{
    param($xmldoc,$path)
    trap [Exception] {continue;}
    if($PSVersionTable.PSVersion -lt '2.0')
    { 
        if($xmldoc -ne $null)
        {
            $xmldoc | out-file $path -Force
        }
    }
    else 
    {
        if($xmldoc -ne $null)
        {
            $xmldoc.save($path)
        }
    } 
}
# Place ProductID in Debug Report
function Set-DiagPID([string]$ProductName, [string]$ProductID)
{
	$PIDObject = "" | Select-Object ProductName						# Return object
	$PIDObject.ProductName = $ProductName
	
	add-member -inputobject $PIDObject -membertype noteproperty -name ProductID -value $ProductID
	
	(convertto-xml -InputObject $PIDObject) | update-diagreport -id OAS_DATAPOINT_ID -name "OAS_DATAPOINT" -description "OAS Data Point for OAS submission" -verbosity debug
}
#*=================================================================================
#End
#*=================================================================================
# ///////////////////////////////////////////////////////////////////
# adding pop messagebox for compatibility with ps1 and ps2
###########
# Pop up window
############
function Pop-Msg {
	 param([string]$msg ="message",
	 [string]$ttl = "Title",
	 [int]$type = 64) 
	 $popwin = new-object -comobject wscript.shell
	 $null = $popwin.popup($msg,0,$ttl,$type)
	 remove-variable popwin
}

# SIG # Begin signature block
# MIIa6gYJKoZIhvcNAQcCoIIa2zCCGtcCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUTqqKImGpKHFwX8kcNlDreJ9U
# 66qgghWCMIIEwzCCA6ugAwIBAgITMwAAAI1AOzwvrcZ7uAAAAAAAjTANBgkqhkiG
# 9w0BAQUFADB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwHhcNMTUxMDA3MTgxNDA0
# WhcNMTcwMTA2MTgxNDA0WjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjENMAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNO
# OjE0OEMtQzRCOS0yMDY2MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmlIcRUD3lFDw
# EK27FJ0L7nJcRvoCDIV9j+iH+phgZsI1T1UGjG7uVQs4h9Mb2JBiK5aScts3g08g
# LnHe5pCo2MWegFpCGe1iEOirtCDXABUGrJ9ZiiCGKfsEXsNPVsY++5zSMY/12JF6
# l7bpGQJelF6hlPrL2XDrOQZtg2MCfZB0FJXRsFR/IxkLriSCe6GrmTNlgTubfcrW
# YFtYRXYJ+SNfM4YCFuygR4Tajdl8gKdJPgtbSls1CS6q+XUgCxusXijAemjvDnd9
# HoFms2vuNAhkbfL1h8TF5Sgt3ZkOqgtrvw3c3d7hTiE2XhnokXxz3g7KwVRzwapf
# YhWha1xNPwIDAQABo4IBCTCCAQUwHQYDVR0OBBYEFO+w/NAncAPOnsWMxNE+EIfv
# sAbaMB8GA1UdIwQYMBaAFCM0+NlSRnAK7UD7dvuzK7DDNbMPMFQGA1UdHwRNMEsw
# SaBHoEWGQ2h0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3Rz
# L01pY3Jvc29mdFRpbWVTdGFtcFBDQS5jcmwwWAYIKwYBBQUHAQEETDBKMEgGCCsG
# AQUFBzAChjxodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY3Jv
# c29mdFRpbWVTdGFtcFBDQS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwgwDQYJKoZI
# hvcNAQEFBQADggEBACJRuAWCXkNgGnPI5wLB03Kk2xYLTFzuC0uL6Pa4kQ6OlZ5O
# lJ8D1ISf29/eec92Gw/0oSi4XmgLE6yICiYYJUI+0esJjKj79iMyb3+Qo3lwgLBD
# ZPqg4rUXT32fZFHURjPJ0DmCV8JLhIllwTHp1tjrnpQwTq0oqeO8rbwrU0hvsgSv
# esdvxnu54IzsJnSWOsmpE3RCC0fTrnHIsU382SoqUnB5AlPK64q3ImJcQz0Ns5O5
# yUsWy0ef50ExRbA9tvBlvCZtVfCwLH/6U7MLoJcSkwpB7+VPlklyOxDBM8TXvRcE
# rgdbRaiScYxbKZGkb8JwJxLKt3KO4D8JT5MxVxYwggTsMIID1KADAgECAhMzAAAB
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
# 9wFlb4kLfchpyOZu6qeXzjEp/w7FW1zYTRuh2Povnj8uVRZryROj/TGCBNIwggTO
# AgEBMIGQMHkxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYD
# VQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xIzAh
# BgNVBAMTGk1pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBAhMzAAABCix5rtd5e6as
# AAEAAAEKMAkGBSsOAwIaBQCggeswGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFM0B
# QMXZ/YcDtdX8Oh+QztTBDDdgMIGKBgorBgEEAYI3AgEMMXwweqBggF4ATQBpAGMA
# cgBvAHMAbwBmAHQATwBmAGYAaQBjAGUAVQBuAGkAbgBzAHQAYQBsAGwAZQByAFYA
# MgBfAHUAdABpAGwAcwBfAFMAZQB0AHUAcABFAG4AdgAuAHAAcwAxoRaAFGh0dHA6
# Ly9taWNyb3NvZnQuY29tMA0GCSqGSIb3DQEBAQUABIIBAINDvbmmj0CVB9CVZqF+
# uKM04UGNjaqPICMHTGTFVN8JbvO1W7jWMc3y8V2888nY7nD/9ZB/T0u7tyJvOVn1
# /UEuBv67XoblxYoi5wzSGYKMQkIC94u83bnzncsXfy75DgqiTyTnBi79yZu52d0Q
# LRPq6OhHwxOjJYCWVGdQRm95vE6IaVr8KqTw4rneK+OpTsI/0L015NJ4sJunZm3B
# akloGaKhB0VezNjaMJ/KkoXzmeFkC+RkxilUZroIBKmKULCMcjzLIHW2tajHqrdj
# 9gYk6xhU3hTgEbcffEoKR59vzQ0DOrPVnr2R7QSsF7fsDayqvbs3+pK9diYQunxh
# O1mhggIoMIICJAYJKoZIhvcNAQkGMYICFTCCAhECAQEwgY4wdzELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEhMB8GA1UEAxMYTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgUENBAhMzAAAAjUA7PC+txnu4AAAAAACNMAkGBSsOAwIaBQCgXTAY
# BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTEyMDEx
# OTMwMDFaMCMGCSqGSIb3DQEJBDEWBBRAkDldp4sKKiqTu0/l6pwtzUeEuTANBgkq
# hkiG9w0BAQUFAASCAQATmir/X2LFfT9yRwtir3TzZs6ux7gdzbD08bBOVdLjKxAG
# s/iQ91ogMYf+yYPkqZMoCXWvUs4+W79u1hnN88V0ej89icFz8KqYBxn5HWSoTSf7
# foZ8l9CX5wVYVgBq2sPWEKlwTohdpkFeckqDsisDSFg0v7EV7Zv0UDy7RYxjZ52S
# hRuM2V+2D/QZ3Luzld+9qd9hRtIAzk5+/pDqsvzRdiovX6BR7Ph6Bg1Z0lKbwcbM
# B9yXISRn9ZUxK8Y5wVfMLb1Y/8hxg076gL0I0KfNCp5RGaDK3JhU7xxVFH6fcEz+
# 1rlOtK5jU0chrM4I1LIaG92rVll7Tj4802F3KSmC
# SIG # End signature block
