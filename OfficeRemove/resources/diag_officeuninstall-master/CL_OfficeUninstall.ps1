# Copyright © 2016, Microsoft Corporation. All rights reserved.
#============================================================= 
<#
CL_OfficeUninstall.Ps1  includes common function used for Microsoft office uninstaller V4.0
Arguments:
None
Return values:
None
#>

#*=================================================================================
#Import Localized data for strings
#*=================================================================================
Import-LocalizedData -BindingVariable Strings_CL_OfficeUninstall -FileName CL_OfficeUninstall


Function Create-WMIRegObj($objswbem)
{
	 <#
	FUNCTION DESCRIPTION:Create-WMIRegObj
	To create WMI object...

	ARGUMENTS:
	$objswbem:object

	RETURN VALUE:
	$objReg:Object
	#>
    $objReg = $null
    $Computer = "."
    try {                
            # Create a WMI connection object if one is not passed to the function already         
            If ($WMIObject -eq $null) 
            {
               $ObjLocator = New-Object -ComObject "Wbemscripting.SWbemLocator"
               $objServices = $objLocator.ConnectServer($Computer,"root\Default",$null,$null,$null,$null,$null,$objswbem)
               $objReg = $objServices.Get("stdRegProv")
            }
        }
        catch
        {}
        return $objReg

 }

#Function to get the value of a registry key.  
Function Get-RegValue($WMIObject,$objNamedValueSet,$hkey,$regkey,$value)
{
	<#
	 Get-RegValue
	FUNCTION DESCRIPTION:
	Function to get the value of a registry key. 

	ARGUMENTS:
	$WMIObject:wmi object
	$objNamedValueSet:output of create-wmi object function...
	$hkey:rootkey of the registry...
	$regkey:Path of the registry...
	$value:Value of registry key


	RETURN VALUE:
	$result:Output 
	$null
	#>
    $objStdRegProv = $WMIObject
    # Obtain an InParameters object specific to the method.
    $Inparams = ($objStdRegProv.Methods_ | where {$_.name -eq "GetStringValue"}).InParameters.SpawnInstance_()   
    $regHkey = Get-HkeyValue($hkey)   
    # Add the input parameters
    ($Inparams.Properties_ | where {$_.name -eq "Hdefkey"}).Value = $regHkey
    ($Inparams.Properties_ | where {$_.name -eq "Ssubkeyname"}).Value = $regkey
    ($Inparams.Properties_ | where {$_.name -eq "Svaluename"}).Value = $value
 
    #Execute the method
    $Outparams = $objStdRegProv.ExecMethod_("GetStringValue", $Inparams, $null, $objNamedValueSet)
     
    if (($Outparams.Properties_ | where {$_.name -eq "ReturnValue"}).Value -eq 0)
	 {
        $result = ($Outparams.Properties_ | where {$_.name -eq "sValue"}).Value
        return $result

     }
	 else
	 {
        Return $null
     }	
}
 Function Get-HkeyValue([string]$Hkey)
 {
	  <#
	 Get-HkeyValue
	FUNCTION DESCRIPTION:
	To get the particular root key of the registry. 

	ARGUMENTS:
	$Hkey:rootkey of the registry...

	RETURN VALUE:
	$HkeyVal:unique code of rootkey...
	#>
    # Set the Hkey value
    switch ($Hkey) {
        “HKCR” {$HkeyVal = "&h80000000"} #HKEY_CLASSES_ROOT 
        “HKCU” {$HkeyVal = "&h80000001"} #HKEY_CURRENT_USER
        “HKLM” {$HkeyVal = "&h80000002"} #HKEY_LOCAL_MACHINE 
        "HKU" {$HkeyVal = "&h80000003"}  #HKEY_USERS                 
        "HKCC" {$HkeyVal = "&h80000005"} #HKEY_CURRENT_CONFIG
        "HKDD" {$HkeyVal = "&h80000006"} #HKEY_DYN_DATA                
    }
	 
      return $HkeyVal

 }

#Function to check the path of a registry key.  
Function Get-RegPath($WMIObject,$objNamedValueSet,$hkey,$regkey)
 { 
	<#
	Get-RegKey
	FUNCTION DESCRIPTION:
	Function to check the path of a registry key. 

	ARGUMENTS:
	$WMIObject:wmi object
	$objNamedValueSet:output of create-wmi object function...
	$hkey:rootkey of the registry...
	$regkey:Path of the registry...



	RETURN VALUE:
	$outputObj
	$null
	#>  
    $objStdRegProv = $WMIObject
    # Obtain an InParameters object specific to the method.
    $Inparams = $objStdRegProv.Methods_.Item("EnumKey").Inparameters   
    $regHkey = Get-HkeyValue($hkey)   
    # Add the input parameters
     $inparams.properties_.item("Hdefkey").Value = $regHkey
     $inparams.properties_.item("sSubKeyName").Value = $regkey
    #Execute the method
     $Outparams = $objStdRegProv.ExecMethod_.Invoke("EnumKey", $Inparams,$null,$objNamedValueSet)
    if (($Outparams.Properties_ | where {$_.name -eq "ReturnValue"}).Value -eq 0)
	 {
        $OutputObj = New-Object -Type PSObject
        $OutputObj | Add-Member -MemberType NoteProperty -Name "KeyPath" –Value "$HKey`:\$regkey"
        Return $OutputObj
     }
	 else
	 {
        Return $null
     }

}

Function Get-RegSubKeys($regkey)
{
	<#
	FUNCTION DESCRIPTION:Get-RegSubKeys
	Function to get the subkeys of a registry key. 

	ARGUMENTS:
	$regkey:Path of the registry...


	RETURN VALUE:
	$rootkeys
	#>
	if($regkey -ne $null)
	{
		$hklm=[UInt32] "0x80000002"
		$wmi = [wmiclass]"root\default:stdRegProv"
		$rootkeys = $wmi.EnumKey($hklm,$regkey).snames
		Return $rootkeys
	}
}
$objswbem = New-Object -ComObject "WbemScripting.SWbemNamedValueSet"

#Get the size of the OSArchitecure to check whether the office installed in 32bit or 64 bit OS.
$osArchitecture = [IntPtr]::Size;

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

#Inintialize regpath to get the exact installed officepath to avoid bitness isssue in chrome...
$registryPath = "SOFTWARE\Microsoft\Windows\CurrentVersion"

#To get the path of the common files and Program directory from registry to avoid chrome issue.
# result will be $commonFiles = "C:\Programfiles\CommonFiles"
$value = "CommonFilesDir"
$commonFiles = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value 
$value = "CommonFilesDir (x86)"
$commonFilesx86 = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value
$value = "ProgramFilesDir (x86)"	
$programFilesx86Reg = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value 
$value = "ProgramFilesDir"
$programFilesReg = Get-RegValue $regObject $objswbem "HKLM" $registryPath $value

# Initialize ,check whether office installed is c2r version and get the version from reg value.
$officeC2R15Path ="Software\Microsoft\Office\15.0\ClickToRun\Configuration"
$value = "VersionToReport"
$office15C2R = Get-RegValue $regObject $objswbem "HKLM" $officeC2R15Path $value
$officeC2R16Path ="Software\Microsoft\Office\ClickToRun\Configuration"
$value = "VersionToReport"
$office16C2R = Get-RegValue $regObject $objswbem "HKLM" $officeC2R16Path $value

#Creating array of VersionID that need to be passed...
$officeVersionIDs = @("Office11","Office12","Office14","Office15","Office16")

#Assign common directory paths globally...
$officeProgramfiles = "$programFilesReg\Microsoft Office"
$officeProgramfilesx86 = "$programFilesx86Reg\Microsoft Office"
$officesourceEngine = "$commonFiles\microsoft shared\Source Engine"
$officeSourceEnginex86 = "$commonFilesx86\microsoft shared\Source Engine"
$officeProgramData = $env:ProgramData + "\Microsoft\Office"
#===========================================================================================
#Get-InstalledOffice
#===========================================================================================
Function Get-InstalledOffice($officeVerifier)
{
	<#
	Get-InstalledOffice
	Function description:
	Function to get the list of installed office and creation datetime

	Arguments:
	None

	Return values:
	$detectedOffice: Array of object contains list of installed officeID and creationdate
	#>
	#Pass each versionID and get the installed Office version and respective Date
	if($officeVerifier -ne $null)
	{
		$officeVersionIDs = $officeVerifier
	}
	$detectedOffices =@()
	Foreach($officeVersion in $officeVersionIDs)
	{
		$officeVersionPaths = "$commonFiles\microsoft Shared\$officeVersion\mso.dll"
		$officeVersionPathsx86 = "$commonFilesx86\microsoft Shared\$officeVersion\mso.dll"
		$officex86Path = $programFilesx86Reg + "\Microsoft Office\root\$officeVersion"
		$officex86Paths = $programFilesx86Reg + "\Microsoft Office\$officeVersion"
		#Check for MSI office versions
		if(Test-Path $officeVersionPathsx86)
		{
			$detectedOffice = '' | select OfficeID ,InstalledDate
			$detectedOffice.OfficeID = $officeVersion
			$detectedOffice.InstalledDate = Get-Item  (Split-Path $officeVersionPathsx86) | %{$_.CreationTime}	
			$detectedOffices += $detectedOffice
		}
		elseif(Test-Path $officeVersionPaths)
		{			
			$detectedOffice = '' | select OfficeID ,InstalledDate
			$detectedOffice.OfficeID = $officeVersion
			$detectedOffice.InstalledDate = Get-Item  (Split-Path $officeVersionPaths) | %{$_.CreationTime}	
			$detectedOffices += $detectedOffice
		}
	}

		# Initialize ,check whether office installed is c2r version and get the version from reg value.
		$officeC2R15Path ="Software\Microsoft\Office\15.0\ClickToRun\Configuration"
	    #Check whether c2r versions of office is installed
		$value = "VersionToReport"
		$office15C2R = Get-RegValue $regObject $objswbem "HKLM" $officeC2R15Path $value
		$officeC2R16Path ="Software\Microsoft\Office\ClickToRun\Configuration"
		$value = "VersionToReport"
		$office16C2R = Get-RegValue $regObject $objswbem "HKLM" $officeC2R16Path $value		
	    
		if($office15C2R)	
		{
			$officeVersionPaths = "$commonFiles\microsoft Shared\$officeVersion\mso.dll"
			$officeVersionPathsx86 = "$commonFilesx86\microsoft Shared\$officeVersion\mso.dll"	 
			#Check whether the installed office is 64bit or 32bit... 
			if((Test-Path ($programFilesx86Reg + "\Microsoft Office\root\Office15")) -or (Test-Path ($programFilesx86Reg + "\Microsoft Office\Office15")) -and $osArchitecture -eq 8)
			{				
				if(Test-Path ("$commonFilesx86\microsoft Shared\Office15"))
				{
					$detectedOffice = '' | select OfficeID ,InstalledDate
					$detectedOffice.OfficeID = "Office15C2R"
					$detectedOffice.InstalledDate =  Get-Item  "$commonFilesx86\microsoft Shared\Office15" | %{$_.CreationTime}
					$detectedOffices += $detectedOffice
				}				
			}
			else
			{
				if(Test-Path "$commonFiles\microsoft Shared\Office15")
				{
					$detectedOffice = '' | select OfficeID ,InstalledDate
					$detectedOffice.OfficeID = "Office15C2R"
					$detectedOffice.InstalledDate = Get-Item  "$commonFiles\microsoft Shared\Office15" | %{$_.CreationTime}
					$detectedOffices += $detectedOffice
				}				
			}
		}
        elseif($office16C2R)	
		{	 
			#Check whether the installed office is 64bit or 32bit... 
			if((Test-Path ($programFilesx86Reg + "\Microsoft Office\root\Office16")) -or (Test-Path ($programFilesx86Reg + "\Microsoft Office\Office16")) -and $osArchitecture -eq 8)
			{				
				if(Test-Path ("$commonFilesx86\microsoft Shared\Office16"))
				{
					$detectedOffice = '' | select OfficeID ,InstalledDate
					$detectedOffice.OfficeID = "Office16C2R"
					$detectedOffice.InstalledDate = Get-Item  ("$commonFilesx86\microsoft Shared\Office16") | %{$_.CreationTime}
					$detectedOffices += $detectedOffice
				}				
			}
			else
			{
				if(Test-Path "$commonFiles\microsoft Shared\Office16")
				{
					$detectedOffice = '' | select OfficeID ,InstalledDate
					$detectedOffice.OfficeID = "Office16C2R"
					$detectedOffice.InstalledDate = Get-Item  "$commonFiles\microsoft Shared\Office16" | %{$_.CreationTime}	
					$detectedOffices += $detectedOffice
				}				
			}
		}
	
	Return $detectedOffices
}
Function List-CommonOfficeRegistry($officeID,$count)
{
	<#
	List-CommonOfficeRegistry
	Function description:
	Function to List common office registry files for all versions

	Arguments:
	None
	Return values:
	$commonRegList:list of dir and registries
	#>
	# Get the user name and sid ...
	$userName = Get-WmiObject win32_useraccount -Filter "name = '$env:username'" 
	$SID = $a.sid
	#if the OS is 64bit then delete Wow6432Node registry paths
	if($osArchitecture -eq 8)
	{
		if($count -gt 1)
		{
			$officex86 = "SOFTWARE\Wow6432Node\Microsoft\Office\$officeID"
			$officeHKCUWow6432 = "HKCU:\SOFTWARE\Wow6432Node\Microsoft\Office\$officeID"
			$OfficeRegHKeyUsersx86 = "registry::\HKEY_USERS\$SID\Software\Wow6432Node\Microsoft\Office\$OfficeID"
		}
		else
		{
			$officex86 = "SOFTWARE\Wow6432Node\Microsoft\Office"
			$officeHKCUWow6432 = "HKCU:\SOFTWARE\Wow6432Node\Microsoft\Office"
			$OfficeRegHKeyUsersx86 = "registry::\HKEY_USERS\$SID\Software\Wow6432Node\Microsoft\Office"
		}
		$officeWizardx86 = "Software\Wow6432Node\Microsoft\OfficeCustomizeWizard"
		$officeWizardHKCUWow6432 = "HKCU:\Software\Wow6432Node\Microsoft\OfficeCustomizeWizard"	
		if($count -gt 1)
		{
			$registryHKLM +=@($officex86)
			$officeDirPaths +=@($officeHKCUWow6432,$OfficeRegHKeyUsersx86)
		}
		else
		{
			$registryHKLM += @("$officex86","$officeWizardx86")	
			$officeDirPaths += @("$officeWizardHKCUWow6432","$officeHKCUWow6432","$OfficeRegHKeyUsersx86")
		}
	}
	if($count -gt 1)
	{
		$officex64 = "SOFTWARE\Microsoft\Office\$officeID"
		$officeHKCU = "HKCU:\SOFTWARE\Microsoft\Office\$officeID"
		$OfficeRegHKeyUsers = "registry::\HKEY_USERS\$SID\Software\Microsoft\Office\$officeID"
	}
	else
	{
		$officex64 = "SOFTWARE\Microsoft\Office"
		$officeHKCU = "HKCU:\SOFTWARE\Microsoft\Office"
		$OfficeRegHKeyUsers = "registry::\HKEY_USERS\$SID\Software\Microsoft\Office"
	}
	$appVISV = "SOFTWARE\Microsoft\AppVISV"
	$officeWizardx64 = "Software\Microsoft\OfficeCustomizeWizard"
	$regosf = "SOFTWARE\Classes\PROTOCOLS\Handler\osf.16"
	$regosf1 = "SOFTWARE\Classes\PROTOCOLS\Handler\osf-roaming.16"
	$officeWizardHKCU = "HKCU:\Software\Microsoft\OfficeCustomizeWizard"
	$OfficeRegHKCUAppV = "HKCU:\SOFTWARE\Microsoft\AppVISV"
	$officeservies = "HKLM:\SYSTEM\CurrentControlSet\Services\ose"
	$officeservies64 = "HKLM:\SYSTEM\CurrentControlSet\Services\ose64"	

    #Assign the paths to remove shellnew(contextmenu shortcuts from desktop)
	$regOffWordShortcut = "HKCR:\.docx\Word.Document.12\shellNew";
	$regOfficedatabase = "HKCR:\.mdb\Access.MDBFile\shellNew";
	$regOfficedatabasemde = "HKCR:\.mde\Access.MDBFile\shellNew";
	$regOfficedatabasemdb = "HKCR:\.mdb\shellNew";
	$regOffpubdoc = "HKCR:\.pub\publisher.document.15\shellNew";
	$regOffpubdoc12 = "HKCR:\.pub\publisher.document.12\shellNew";
	$regOffpubdoc16 = "HKCR:\.pub\publisher.document.16\shellNew";
	$regOffpubdoc14 = "HKCR:\.pub\publisher.document.14\shellNew";
	$regOfficeXcelShortcut = "HKCR:\.xlsx\Excel.Sheet.12\shellNew";
	$regOffpowerpoint = "HKCR:\.pptx\Powerpoint.Show.12\shellNew";
	$regOffpowerpoint8 = "HKCR:\.pptx\Powerpoint.Show.8\shellNew";
	$regOffmsproject = "HKCR:\.mpp\MSProject.Project.9\shellNew";
	$regOffVisioShortcut = "HKCR:\.vsdx\Visio.Drawing.15\shellNew";
	$regOffrtf = "HKCR:\.rtf\shellNew";
	$regOffrtf8 = "HKCR:\.rtf\word.RTF.8";
	$regOffWordShortcut8 = "HKCR:\.doc\Word.Document.8\shellNew";
	$regOfficedatabase11= "HKCR:\.mdb\Access.Application.11\shellNew";
	$regOfficedatabase12= "HKCR:\.accdb\Access.Application.12\shellNew";
	$regOfficedatabase15= "HKCR:\.accdb\Access.Application.15\shellNew";
	$regOffpubdoc11 = "HKCR:\.pub\publisher.document.11\shellNew";	
	$regOfficeXcelShortcut8 = "HKCR:\.xls\Excel.Sheet.8\shellNew";
	$regOffpowerpointppt = "HKCR:\.ppt\Powerpoint.Show.8\shellNew";
	if($count -gt 1)
	{
		$registryHKLM += @($officex64)
		$officeDirPaths += @("$officeHKCU","$OfficeRegHKeyUsers","$regOffWordShortcut","$regOfficedatabase","$regOfficedatabasemde","$regOfficedatabasemdb","$regOffpubdoc",
		"$regOffpubdoc12","$regOffpubdoc16","$regOffpubdoc14","$regOfficeXcelShortcut","$regOffpowerpoint","$regOffpowerpoint8","$regOffmsproject","$regOffVisioShortcut",
		"$regOffrtf","$regOffrtf8","$regOffWordShortcut8","$regOfficedatabase11","$regOfficedatabase12","$regOfficedatabase15","$regOffpubdoc11","$regOfficeXcelShortcut8","$regOffpowerpointppt")
	}
	else
	{
		 $registryHKLM += @("$officex64","$officeWizardx64","$regosf","$regosf1","$appVISV")
		 $officeDirPaths += @("$officeWizardHKCU","$officeHKCU","$OfficeRegHKeyUsers","$OfficeRegHKCUAppV","$officeservies","$officeservies64","$regOffWordShortcut",
		"$regOfficedatabase","$regOfficedatabasemde","$regOfficedatabasemdb","$regOffpubdoc","$regOffpubdoc12","$regOffpubdoc16","$regOffpubdoc14","$regOfficedatabase15",
		"$regOfficeXcelShortcut","$regOffpowerpoint","$regOffmsproject","$regOffpowerpoint8","$regOffVisioShortcut","$regOffrtf","$regOffrtf8",
		"$regOffWordShortcut8","$regOfficedatabase11","$regOfficedatabase12","$regOffpubdoc11","$regOfficeXcelShortcut8","$regOffpowerpointppt")
	}
    $commonRegfiles = '' | select registryHKLM, officeDirPath
	$commonRegList = @()
	$commonRegfiles.registryHKLM = $registryHKLM
	$commonRegfiles.officeDirPath = $officeDirPaths
	$commonRegList = $commonRegfiles
	Return $commonRegList 
}
Function List-CommonOfficeDirectory($officeID,$count)
{
	<#
	List-CommonOfficeDirectory
	Function description:
	Function to list common office directory files...

	Arguments:
	None
	Return values:
	$officeDir:list of office dir
	#>
	#set the location to the user path...
	$setUserPath = $env:SystemDrive + "\Users"
	Set-Location $setUserPath
	#Get the Current username
	$currentUserName = $env:username
	$officeUserPath = "$setUserPath\$currentUserName\AppData\Local\Microsoft\Office"
	$roamingPath = "$setUserPath\$currentUserName\AppData\Roaming\Microsoft\Office"
	$office15 = $programFilesReg + "\Microsoft Office 15"
	$office15x86 = $programFilesx86Reg + "\Microsoft Office 15"
	#If the OS is 64bit then delete the list of files passed in array
	if($osArchitecture -eq 8)
	{
		if($count -gt 1)
		{
			$programfilesx86 = "$officeProgramfilesx86\$officeID"
			$chainedInstalls = "$officeProgramfilesx86\Chained_Installs"
			$templatesx86 = "$officeProgramfilesx86\Templates"
			$clipartx86 = "$officeProgramfilesx86\CLIPART"
			$mediax86 = "$officeProgramfilesx86\Media"
			$custom11x86 = "$officeProgramfilesx86\CUSTOM11.prf"
			$patchfilesx86 = "$officeProgramfilesx86\patchFiles"
			$stationeryx86 = "$officeProgramfilesx86\Stationery"
			$officeDir += @("$programfilesx86","$templatesx86","$clipartx86","$mediax86","$custom11x86","$chainedInstalls","$patchfilesx86","$stationeryx86")
		}
		else
		{
			$officeDir += @("$officeSourceEnginex86","$officeProgramfilesx86","$office15x86")
		}
	}
	if($count -gt 1)
	{
		$programfiles = "$officeProgramfiles\$officeID"
		$chainedInstallsx86 = "$officeProgramfiles\Chained_Installs"
		$templates = "$officeProgramfiles\Templates"
		$clipart = "$officeProgramfiles\CLIPART"
		$media = "$officeProgramfiles\Media"
		$custom11 = "$officeProgramfiles\CUSTOM11.prf"
		$patchfiles = "$officeProgramfiles\patchFiles"
		$stationery = "$officeProgramfiles\Stationery"
		$officeDir += @("$programfiles","$templates","$clipart","$media","$custom11","$chainedInstallsx86","$patchfiles","$stationery")
	}
	else
	{
		$officeDir += @("$officesourceEngine","$officeUserPath","$roamingPath","$officeProgramData","$officeProgramfiles","$office15")
	}
	if($count -eq 0)
	{
		$removefilesafterReboot = @($officeProgramfiles,$officeProgramfilesx86)
		foreach($removefileafterReboot in $removefilesafterReboot)
		{
			if(Test-Path $removefileafterReboot)
			{
				RemoveDir-AfterReboot $removefileafterReboot $null 
			}
		}
	}
	Return $officeDir
}
Function List-officeControlPanelRegistryKeys($officeGuid, $officeGuidKey, $officeVersionIDs, $officeControlPanelRegPath,$officec2r1516,$officeIDList,$count)
{
	<#
	List-officeControlPanelRegistry
	Function description:
	Function to List office from control panel using regpath..

	Arguments:
	$officeGuid:OfficeGUID
	$officeGuidKey:another OfficeGuid
	$officeVersionIDs:Displayname to compare
	$officeControlPanelRegPath:The regpath to delete
	Return values:
	$controlPanelRegistryList:list of regkeys to delete office from control panel
	#>
	$officeSubkeys=@()
	$controlPanelRegistryList = @()
	#Get the subkeys from the Main regpath...
	$officeSubkeys = Get-RegSubKeys $officeControlPanelRegPath
	if($officeSubkeys -ne $null)
	{
		foreach($subKey in $officeSubkeys)
		{
			#If not null then for each below reg key compare the display name and GUID with the installed version of office and remove from registry if matches...
			$officeRegKey = $officeControlPanelRegPath +"\" + $subKey
			$value = "DisplayName"
			$getDisplayName = Get-RegValue $regObject $objswbem "HKLM" $officeRegKey $value
			$value = "DisplayIcon"
			$getDisplayIcon = Get-RegValue $regObject $objswbem "HKLM" $officeRegKey $value
			$displayIcon = "$commonFiles\Microsoft Shared\ClickToRun\OfficeClickToRun.exe"
			$value = "InstallLocation"
			$getInstallLocation = Get-RegValue $regObject $objswbem "HKLM" $officeRegKey $value
			if($getDisplayName)
			{
				if($count -eq 0)
				{	
					if($getDisplayName.Contains("Office") -or ($getDisplayIcon -eq $displayIcon))
					{
						if(($subKey.Endswith("0000000FF1CE")) -or ($subKey.StartsWith("{90")) -or ($subKey.StartsWith("{91")) -or ($getDisplayIcon -eq $displayIcon) -or ($getInstallLocation -eq $officeProgramfiles) -or ($getInstallLocation -eq $officeProgramfilesx86))	
						{
							$controlPanelRegistryList += $officeRegKey
						}
					}						
				} 
				else
				{					
					if((($getDisplayName.Contains("Office")) -or (($subKey.Endswith("0000000FF1CE")) -or  ($subKey.StartsWith("$officeGuid")) -or ($subKey.StartsWith("$officeGuidKey"))) -or ($getDisplayIcon -eq $displayIcon)))
					{	
						#If the office version installed is C2r then delete C2R related Regkeys.
						if($officeIDList.Contains("C2R") -and (($getDisplayName.Contains("Office 365")) -or ($getDisplayName.Contains("$officec2r1516")) -or $getDisplayName.Contains("$officeVersionIDs")))
						{
							$controlPanelRegistryList += $officeRegKey
						}
						elseif($getDisplayName.Contains("$officeVersionIDs"))
						{
							$controlPanelRegistryList += $officeRegKey
						}
					}
				}					
			}
		}
		Return $controlPanelRegistryList		
	}
}
Function List-CustomInstallOfficeDirectory($OfficeRegID)
{
	<#
	List-CustomInstallOffice
	Function description:
	Function to List custom installed office directories.

	Arguments:
	$OfficeRegID:office reg value eg:11.0,12.0...
	Return values:
	$customDirectories:list of custom directories
	#>
	$officeCustomPath = @()
	#Assign the default path
	$officerootPath = $ProgramFilesReg + "\Microsoft Office\root"
	$office15Path = $ProgramFilesReg + "\Microsoft Office 15\root"

	$officerootPathx86 = $programFilesx86Reg + "\Microsoft Office\root"
	$office15Pathx86 = $programFilesx86Reg + "\Microsoft Office 15\root"
	$value = "Path"
	$officeExactPath = $null
	$officeDefaultPaths = @("$officerootPath","$office15Path","$officerootPathx86","$office15Pathx86","$officeProgramfiles","$officeProgramfilesx86")
	$customDirectories = @()
	foreach($officeDirPaths in $officeRegID)
	{		
		if($osArchitecture -eq 8)
		{
			$folderPath = "SOFTWARE\Wow6432Node\Microsoft\Office\$officeDirPaths\Common\InstallRoot"
			$officeExactPath = Get-RegValue $regObject $objswbem "HKLM" $folderPath $value	
		}
		if(!$officeExactPath)
		{
			$folderPath = "SOFTWARE\Microsoft\Office\$officeDirPaths\Common\InstallRoot"
			$officeExactPath = Get-RegValue $regObject $objswbem "HKLM" $folderPath $value
		}
		#Get the Custom path from the registry...
		if($officeExactPath)
		{
			#If the path exists then concatenate the required files need to be deleted in an array
			$exactPath = Split-Path $officeExactPath
			$docTheme14 = $exactPath +"\Document Themes 14"
			$clipart = $exactPath +"\CLIPART"
			$stationery = $exactPath +"\Stationery"
			$templates = $exactPath +"\Templates"
			$docthemes12 = $exactPath +"\Document Themes 12"
			$chainedinstals = $exactPath +"\Chained_Installs"
			$patchfiles = $exactPath +"\PatchFiles"
			$doctheme11 = $exactPath +"\Document Themes 11"
			$doctheme16 = $exactPath +"\Document Themes 16"
			$doctheme15 = $exactPath +"\Document Themes 15"
			$custom11 = $exactPath +"\Custom11.prf"
			$media = $exactPath +"\MEDIA"
			$officeCustomPath = @("$media","$custom11","$doctheme15","$doctheme16","$doctheme11","$patchfiles","$chainedinstals","$docthemes12","$templates","$stationery","$clipart","$docTheme14")
			$count = $null
			#Compare the defualt path with custom path get the count
			foreach($compareFolder in $officeDefaultPaths)
			{
				if($exactPath -ne $compareFolder)
				{
					$count++
				}
			}
	        #If the custom path and default path is not equal then get the custom path
			if($count -eq "6")
			{
				$customDirectories += $officeCustomPath
			}
			#Get the Main path from the directory...
			if(Test-Path $officeExactPath)
			{
				$officeExactPath = $officeExactPath.Substring(0,$officeExactPath.Length-1)
				$customDirectories += $officeExactPath
			}
		}		
	}
	Return $customDirectories
}
Function List-HKCROfficeInstallerRegFiles($officeProductIDs,$hkcrID)
{
	<#
	Remove-HKCROfficeInstallerRegFiles
	Function description:
	Function to remove HKCR products, featurs extensibility components...

	Arguments:
	$officeProductID:Office version related GUIDS eg:*904011*
	$hkcrID:Products,Featurs,Upgradecodes
	Return values:
	$hkcrkeys:HKCR reg keys list
	#>
	$hkcrkeys = @()
	foreach($officeProductID in $officeProductIDs)
	{	
		#Get the regkeys from the registry to delete
		$regkeyDelete = Get-ChildItem -Path HKCR:\Installer\$hkcrID\ -Recurse -Include $officeProductID -ErrorAction SilentlyContinue
		foreach($officedelete in $regkeyDelete)
		{
		   #Get the reg properties name 
		   $deletePath = $officedelete.Name
		   $hkcrkeys += "registry::\$deletePath"
		}
	}
	Return $hkcrkeys
}
Function Delete-RegistryKey($path, $hkey,$WMIObject, $objswbem)
{
	<#
	FUNCTION DESCRIPTION:Delete-RegistryKey
	Function to delete the path of a registry key. 

	ARGUMENTS:
	$hkey:hklm value of the registry...
	$path:Path of the registry...
	$WMIObject:wmi object
	$objswbem:output of create-wmi object function...

	RETURN VALUE:
	none
	#>
  $regHkey = Get-HkeyValue($hkey)
  $objStdRegProv = $WMIObject
  Delete-RegistrySubKey $path $regHkey $objStdRegProv $objswbem
}
Function Delete-RegistrySubKey($path ,$regHkey ,$objStdRegProv, $objswbem)
{
	<#
	FUNCTION DESCRIPTION:Delete-RegistrySubKey
	Function to delete the subtree of a registry key. 

	ARGUMENTS:
	$regHkey:rootkey value of the registry...
	$path:Path of the registry...
	$objStdRegProv:wmi object
	$objswbem:output of create-wmi object function...

	RETURN VALUE:
	None
	#>
    # Load the Deletekey method into the inparams
    $Inparams = ($objStdRegProv.Methods_ | where {$_.name -eq "DeleteKey"}).InParameters.SpawnInstance_()  
    # Add the input parameters
    ($Inparams.Properties_ | where {$_.name -eq "Hdefkey"}).Value = $regHkey
    ($Inparams.Properties_ | where {$_.name -eq "Ssubkeyname"}).Value = $Path       
	$output = Get-RegSubKeys $path
	if($output -ne $null)
	{
		foreach($skeyname in $output)
		{
			$path1 = $path + "\" + $skeyname
			Delete-RegistrySubKey $path1 $regHkey $objStdRegProv $objswbem
			$Outparams = $objStdRegProv.ExecMethod_.Invoke("DeleteKey", $Inparams,$null,$objswbem)
		}
	}
	else
	{
		$Outparams = $objStdRegProv.ExecMethod_.Invoke("DeleteKey", $Inparams,$null,$objswbem) 
	}	
}
Function Remove-OfficeRegistry([string[]] $registryHKLM, [string]$exception = '')
{
	<#
	Remove-OfficeRegistry
	Function description:
	Function to remove common office HKLM registry files for all versions to avoid chrom 32bit issue

	Arguments:
	$registryHKLM : list of regpath that need to be deleted.
	Return values:
	None
	#>
	if($registryHKLM -ne $null)
	{
		if([System.Environment]::Version.Major -ge 4)
		{
			foreach($regPath in $registryHKLM)
			{
				if($regPath)
				{
					Remove-HKLMRegistry $regPath $exception
				}
			}
		}
		else
		{
			foreach($regPath in $registryHKLM)
			{
				#Get the registry path need to be deleted
				$officeDirPaths = Get-RegPath $regObject $objswbem "HKLM" $regPath 
				if($officeDirPaths)
				{
					#Delete the particualr reg key if exists...
					Delete-RegistryKey $regPath "HKLM" $regObject $objswbem 
				}
			}
		}  
	}
}

Function Remove-HKLMRegistry($regPath,$version,[string]$exception = '')
{
	<#
	Function description:
	function to delete HKLM\Software hive regkeys using .net inbuilt functions.

	Arguments:
	$regPath: Registry path to be deleted.

	Return values:
	None
	#>
	try
	{
		if($regPath -ne $null)
		{
			$openBaseKey = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64)
			$openSubKey = $openBaseKey.OpenSubKey($regPath, $true)
			$subKeysCount = $openSubKey.GetSubKeyNames()
			if($subKeysCount.Count -eq 0)
			{
				$openBaseKey.DeleteSubKey($regPath)
			}
			else
			{
				$subKeysCount | Where { $_ -notlike "$exception" } | ForEach {
				$openSubKey.DeleteSubKeyTree($_)}
			}
		}
	}
	catch
	{
		$_.error | Convertto-xml | Update-Diagreport  -id "CL_OfficeUninstall" -name "Error: $_.error" -Verbosity Informational
	}
}
Function Remove-OfficeDirectory([string[]] $officeDirPaths)
{
	<#
	Remove-OfficeDirectory
	Function description:
	Function to remove common office registry files for all versions

	Arguments:
	$officeDirPaths:List of regpaths need to be deleted...
	Return values:
	None
	#>
	if($officeDirPaths -ne $null)
	{
		$officeDirPaths = $officeDirPaths | ? {$_}
		foreach($regPath in $officeDirPaths)
		{
			if($regPath -ne $null)
			{
				if(Test-Path $regPath)
				{
					#If the directory exists remove it...
					Remove-Item -Path $regPath -force -recurse -ErrorAction SilentlyContinue
				}
			}		
		}
	}
}
Function Remove-RegistryInstallerFolderKey()
{
	<#
	Remove-RegistryInstallerFolderKey
	Function description:
	Function to remove folderslist registrypath..

	Arguments:
	None
	Return values:
	None
	#>
	#Set the location to the users path
	$setUserPath = $env:SystemDrive + "\Users"
	Set-Location $setUserPath
	#Get the username
	$currentUserName = $env:username
	$officeUserPath = "$setUserPath\$currentUserName\AppData\Local\Microsoft\Office"
	$officeDir = @("$officeProgramfilesx86","$officeSourceEnginex86","$officeProgramfiles","$officesourceEngine","$officeUserPath","$officeProgramData")
	#Remove the reg keys from the below path...
	$officeFolderListPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders"
	$officeRegistryContents = Get-Item -LiteralPath $officeFolderListPath
	$folderList = $officeRegistryContents.Property
	foreach($folders in $folderList)
	{
		foreach($path in $officeDir)
		{
			if($path -eq $folders)
			{
				#If the directory path and reg path same then remove that particualr regkey from the registry
				Remove-ItemProperty -Path $officeFolderListPath -Name $folders 
			}
		}
	}
}
Function Close-RunningOfficeApps()
{
	<#
	Close-RunningOfficeApps
	Function description:
	Function to kill the running office apps while uninstalling...

	Arguments:
	None
	Return values:
	None
	#>
	#Assign the list of office apps exe to array...
	$apps = @("WINWORD","MSACCESS","MSTORE","EXCEL","INFOPATH","SETLANG","MSOUC","OIS","ONENOTE","OUTLOOK","POWERPNT","MSPUB","GROOVE","VISIO","WINPROJ","GRAPH","lync")  
	try
	{
		$runningApps = ""
		foreach($app in $apps)
		{
			$process = (Get-Process |?{$_.ProcessName  -ieq $app })
			if($process)
			{ 
				$runningApps += $app + ","
			}
		}
		if($runningApps -ne "")
		{
			#Interaction for the user to know Office apps will be closed.
			Get-Diaginput -Id "INT_CloseOfficeApps"
			foreach($recheckApps in $runningApps.Split(','))
			{
				#check if process is running and close it
				$recheckProcess = (Get-Process |?{$_.ProcessName -ieq $recheckApps })
				if($recheckProcess)
				{ 
					Stop-Process -Name $recheckApps -Force
				}
			}
		}
	}
	catch
	{
		$_.error | Convertto-xml | Update-Diagreport  -id "CL_OfficeUninstall" -name "Error: $_.error" -Verbosity Informational
	}
}   
Function Unpin-TaskBar($officeID,$officeDirPaths)
{
	<#
	Function description:
	function to unpin from taskbar

	Arguments:
	$exePath:List of exePaths need to be unpinned

	Return values:
	None 
	#>
	if($officeID -eq "Office16C2R")
	{
		$officeVersion = $officeID.Replace('C2R','')
	}
	elseif($officeID -eq "Office15C2R")
	{
		$officeVersion = $officeID.Replace('C2R','')
	}
	else
	{
		$officeVersion = $officeID
	}
	
	if($officeID -eq "Office16C2R")
	{
		$unpinfilesPath = "$programFilesx86Reg\Microsoft Office\root\$officeVersion"
	}
	elseif($officeID -eq "Office15C2R")
	{
		$unpinfilesPath = "$programFilesx86Reg\Microsoft Office 15\root\$officeVersion"
	}
	else
	{
		$unpinfilesPath = "$programFilesx86Reg\Microsoft Office\$officeVersion"
	}
	if(!(Test-Path $unpinfilesPath))
	{
		if($officeID -eq "Office16C2R")
		{
			$unpinfilesPath = "$programFilesReg\Microsoft Office\root\$officeVersion"
		}
		elseif($officeID -eq "Office15C2R")
		{
			$unpinfilesPath = "$programFilesReg\Microsoft Office 15\root\$officeVersion"
		}
		else
		{
			$unpinfilesPath = "$programFilesReg\Microsoft Office\$officeVersion"
		}
	}
	if(Test-Path $unpinfilesPath)
	{
		$exeList = Get-ChildItem $unpinfilesPath -Filter *.exe
	}
	if($exeList -eq $null)
	{
		if($osArchitecture -eq 8)
		{
			$folderPath = "SOFTWARE\Wow6432Node\Microsoft\Office\$officeDirPaths\Common\InstallRoot"
		}
		else
		{
			$folderPath = "SOFTWARE\Microsoft\Office\$officeDirPaths\Common\InstallRoot"
		}
		#Get the Custom path from the registry...
		$value = "Path"
		$unpinfilesPath = Get-RegValue $regObject $objswbem "HKLM" $folderPath $value	
	}
	if($unpinfilesPath)
	{
		$exeList = Get-ChildItem $unpinfilesPath -Filter *.exe
	}
	if($exeList -ne $null)
	{
		foreach($officeApps in $exeList)
		{
			$programs = $officeApps.Name 
			[string]$item = "$unpinfilesPath\$programs"		
			#If the path is present then unpin from taskba
			if(Test-Path $item)
			{
				#create new object for shell application
				$shell = New-Object -ComObject "Shell.Application"
				#split the path to get the main path
				$itemParent = Split-Path -Path $item -Parent
				#get the subpath
				$itemLeaf = Split-Path -Path $item -Leaf
				$folder = $Shell.NameSpace($itemParent)
				$itemObject = $folder.ParseName($itemLeaf)
				#get the verbs for the Object
				$verbs = $itemObject.Verbs()
				try
				{
					#If the verbs contains Unpin from taskbar then unpin that exe from taskbar...
					$verb = $verbs | Where-Object {$_.Name -EQ "Unpin from Tas&kbar"} -ErrorAction Stop
					$verb.DoIt()
				}
				catch
				{
					$_.error | Convertto-xml | Update-Diagreport  -id "CL_OfficeUninstall" -name "Error: $_.error" -Verbosity Informational
				}
			}
		}
	}
}

Function Get-OSVersion()
{	
	<#
	Function description:
	function to get the OS version

	Arguments:
	None:

	Return values:
	$OsVersion: OS version Value
	#>
	$osVersionWmi = (Get-WmiObject -Class Win32_OperatingSystem).Version.Split(".")
	$osVersion = ($osVersionWmi[0] + "." + $osVersionWmi[1])
	return $osVersion
}

function Pop-Msg {
	 param([string]$msg ="message",
	 [string]$ttl = "Title",
	 [int]$type = 64) 
	 $popwin = new-object -comobject wscript.shell
	 $null = $popwin.popup($msg,0,$ttl,$type)
	 remove-variable popwin
}
Function RemoveDir-AfterReboot 
{ 
	<#
	RemoveDir-AfterReboot 
	Function description:
	function to delete the folders after reboot..


	Arguments:
	Path:The Path of the office folder to be moved and delete after reboot.
	Destination:Destination Path where office folders are saved.

	Return values:

	None 
#>
    param($path, $destination)
    $path = (Resolve-Path $path).Path 
    $destination = $executionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($destination)
    $MOVEFILE_DELAY_UNTIL_REBOOT = 0x00000004

    $memberDefinition = @’ 
    [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Auto)] 
    public static extern bool MoveFileEx(string lpExistingFileName, string lpNewFileName, 
      int dwFlags); 
‘@
    $type = Add-Type -Name MoveFileUtils -MemberDefinition $memberDefinition -PassThru 
    $type::MoveFileEx($path, $destination, $MOVEFILE_DELAY_UNTIL_REBOOT) 
}






  




# SIG # Begin signature block
# MIIdpgYJKoZIhvcNAQcCoIIdlzCCHZMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUIz7P8ZlUg3rGFf4s/0QyrhhC
# M0mgghhkMIIEwzCCA6ugAwIBAgITMwAAAMhHIp2jDcrAWAAAAAAAyDANBgkqhkiG
# 9w0BAQUFADB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwHhcNMTYwOTA3MTc1ODU0
# WhcNMTgwOTA3MTc1ODU0WjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjENMAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNO
# Ojk4RkQtQzYxRS1FNjQxMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoUNNyknhIcQy
# V4oQO4+cu9wdeLc624e9W0bwCDnHpdxJqtEGkv7f+0kYpyYk8rpfCe+H2aCuA5F0
# XoFWLSkOsajE1n/MRVAH24slLYPyZ/XO7WgMGvbSROL97ewSRZIEkFm2dCB1DRDO
# ef7ZVw6DMhrl5h8s299eDxEyhxrY4i0vQZKKwDD38xlMXdhc2UJGA0GZ16ByJMGQ
# zBqsuRyvxAGrLNS5mjCpogEtJK5CCm7C6O84ZWSVN8Oe+w6/igKbq9vEJ8i8Q4Vo
# hAcQP0VpW+Yg3qmoGMCvb4DVRSQMeJsrezoY7bNJjpicVeo962vQyf09b3STF+cq
# pj6AXzGVVwIDAQABo4IBCTCCAQUwHQYDVR0OBBYEFA/hZf3YjcOWpijw0t+ejT2q
# fV7MMB8GA1UdIwQYMBaAFCM0+NlSRnAK7UD7dvuzK7DDNbMPMFQGA1UdHwRNMEsw
# SaBHoEWGQ2h0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3Rz
# L01pY3Jvc29mdFRpbWVTdGFtcFBDQS5jcmwwWAYIKwYBBQUHAQEETDBKMEgGCCsG
# AQUFBzAChjxodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY3Jv
# c29mdFRpbWVTdGFtcFBDQS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwgwDQYJKoZI
# hvcNAQEFBQADggEBAJqUDyiyB97jA9U9vp7HOq8LzCIfYVtQfJi5PUzJrpwzv6B7
# aoTC+iCr8QdiMG7Gayd8eWrC0BxmKylTO/lSrPZ0/3EZf4bzVEaUfAtChk4Ojv7i
# KCPrI0RBgZ0+tQPYGTjiqduQo2u4xm0GbN9RKRiNNb1ICadJ1hkf2uzBPj7IVLth
# V5Fqfq9KmtjWDeqey2QBCAG9MxAqMo6Epe0IDbwVUbSG2PzM+rLSJ7s8p+/rxCbP
# GLixWlAtuY2qFn01/2fXtSaxhS4vNzpFhO/z/+m5fHm/j/88yzRvQfWptlQlSRdv
# wO72Vc+Nbvr29nNNw662GxDbHDuGN3S65rjPsAkwggYHMIID76ADAgECAgphFmg0
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
# bWrJUnMTDXpQzTGCBKwwggSoAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25pbmcg
# UENBIDIwMTECEzMAAABkR4SUhttBGTgAAAAAAGQwCQYFKw4DAhoFAKCBwDAZBgkq
# hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGC
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUKeUmpJrp4Vym2PZsNMyDZdQ0IPgwYAYKKwYB
# BAGCNwIBDDFSMFCgNoA0AE8AVQA0AF8AQwBMAF8ATwBmAGYAaQBjAGUAVQBuAGkA
# bgBzAHQAYQBsAGwALgBwAHMAMaEWgBRodHRwOi8vbWljcm9zb2Z0LmNvbTANBgkq
# hkiG9w0BAQEFAASCAQBCzErEHtnsKe8X/OK6n+3RiKgiUhlc42y7OtfYAV+QE34j
# a8YhiVuYxq6Q1eEmPMZw/JuTDmo82QV1FXO2WFdQzQLhqPL03zn7itNTrwghhZiF
# XubtpB4wGNmy+7kRUj8HeZI7wIB393XHUdH+cmOC1hT+PY+54qq6je+vYAi0wUY7
# CvHn0rzRdlK5zBLH7LSoOUM9bSqzO87VwKhs0LSKMxXs6c3Efn5V3X9cH/QG3XCy
# EqHMMd92EX3BheoozZ9wDRP+XFB9WgEYbm6Yk3uQ//3JVTcs12yLdjrGKcR39SRz
# Ov5ERjHwUTO/EyrZ/rSwq5WigEUPFCkvKDk5Ud7zoYICKDCCAiQGCSqGSIb3DQEJ
# BjGCAhUwggIRAgEBMIGOMHcxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xITAfBgNVBAMTGE1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQQITMwAAAMhH
# Ip2jDcrAWAAAAAAAyDAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3
# DQEHATAcBgkqhkiG9w0BCQUxDxcNMTYxMTMwMjA1ODI4WjAjBgkqhkiG9w0BCQQx
# FgQUV2oDhCAoaQ/P2Ywv/ggji4twxLgwDQYJKoZIhvcNAQEFBQAEggEALcd4GAFH
# trDdejd3+CPMhun7T6VV7u5iUZgRxHb7LVYhzmJ7uLJz41Ox6MbXgk5uindCN/8v
# L7DEad38HhXOiDUFPXMAl0OeUclCU/rF+84pmN2yrbAp36ZgfJPpyuYYNYrPOSXc
# j3CNtH3RP3icOMO2cvpMUGJi61a1Ud4GyGQcdDnrl8b3KVqRDrGNa0rT74xlpNVU
# 3q09/ipJbncGBnKlgBlSPgBMr30nBVoN1KzQ/Wy2SlDsSjQW53GXvV/otUf04Psc
# dFqvHJrFKJSY2TVOkErKfZmc4zU5OGswAzpn9ExlOrEyDwwT1LqBabPE9EgPrYrr
# nWnYfIBdcJHRMA==
# SIG # End signature block
