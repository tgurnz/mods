////////////////////////////////////////////////////////////
//	Public functions
////////////////////////////////////////////////////////////

// Global variable
var g_objRegistry = null;
var g_nRegistryType = 0;

// Registry access
// root key values:
// 0: HKEY_CLASSES_ROOT = 0x80000000
// 1: HKEY_CURRENT_CONFIG = 0x80000005
// 2: HKEY_CURRENT_USER = 0x80000001
// 3: HKEY_LOCAL_MACHINE = 0x80000002
// 4: HKEY_USERS = 0x80000003
function createRegistryObject()
{
	if(g_objRegistry)
		return true;
	
	if ("@mozilla.org/windows-registry-key;1" in Components.classes)
	{
		g_objRegistry = Components.classes["@mozilla.org/windows-registry-key;1"].createInstance(Components.interfaces.nsIWindowsRegKey);
		g_nRegistryType = 2;
	}
	else if("@mozilla.org/winhooks;1" in Components.classes)
	{
		g_objRegistry = Components.classes["@mozilla.org/winhooks;1"].getService(Components.interfaces.nsIWindowsRegistry);
		g_nRegistryType = 1;
	}
	else if("@mozilla.org/browser/shell-service;1" in Components.classes)
	{
		g_objRegistry = Components.classes["@mozilla.org/browser/shell-service;1"].getService(Components.interfaces.nsIWindowsShellService);
		g_nRegistryType = 1;
	}
	else
	{
		g_objRegistry = null;
		g_nRegistryType = 0;
	}
	
	if(g_nRegistryType == 0)
		return false;
	return true;
}

function regReadLMString(strPath, strName)
{
	if(!createRegistryObject())
		return false;
	if(g_nRegistryType == 1)
	{
		return g_objRegistry.getRegistryEntry(3, strPath, strName);
	}
	else if(g_nRegistryType == 2)
	{
		g_objRegistry.open(Components.interfaces.nsIWindowsRegKey.ROOT_KEY_LOCAL_MACHINE,
						   strPath, Components.interfaces.nsIWindowsRegKey.ACCESS_READ);
		return g_objRegistry.readStringValue(strName);	
	}
}

function regReadCUString(strPath, strName)
{
	if(!createRegistryObject())
		return false;
	if(g_nRegistryType == 1)
	{
		return g_objRegistry.getRegistryEntry(3, strPath, strName);
	}
	else if(g_nRegistryType == 2)
	{
		g_objRegistry.open(Components.interfaces.nsIWindowsRegKey.ROOT_KEY_CURRENT_USER,
						   strPath, Components.interfaces.nsIWindowsRegKey.ACCESS_READ);
		return g_objRegistry.readStringValue(strName);	
	}
}


function regWriteString(strPath, strName, strString)
{
	if(!createRegistryObject())
		return false;

	if(g_nRegistryType == 1)
	{
		return g_objRegistry.setRegistryEntry(3, strPath, strName, strString, strString.length);
	}
	else if(g_nRegistryType == 2)
	{
		g_objRegistry.open(ROOT_KEY_LOCAL_MACHINE, strPath, Components.interfaces.nsIWindowsRegKey.ACCESS_WRITE);
		return g_objRegistry.writeStringValue(strName, strString);	
	}
}

// Unicode string convert
function fromUnicodeString(aCharset, strUnicode)
{
	var unicodeConverter = Components.classes["@mozilla.org/intl/scriptableunicodeconverter"].createInstance(Components.interfaces.nsIScriptableUnicodeConverter);
	unicodeConverter.charset = aCharset;
	strUnicode = unicodeConverter.ConvertFromUnicode(strUnicode);
	return strUnicode;
}

// File access
function isFileExists(strPath)
{
	var objFile = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
	objFile.initWithPath(strPath);
	try
	{
		objFile.isFile();
		return true;
	}
	catch(e)
	{
		return false;
	}
}

function readFile(strPath)
{
	var objFile = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
	objFile.initWithPath(strPath);
	
	var objInputStream = Components.classes["@mozilla.org/network/file-input-stream;1"].createInstance(Components.interfaces.nsIFileInputStream);
	var objSIStream = Components.classes["@mozilla.org/scriptableinputstream;1"].createInstance(Components.interfaces.nsIScriptableInputStream);
	
	objInputStream.init(objFile, 1, 0, false);
	objSIStream.init(objInputStream);
		
	var data = new String();
	data += objSIStream.read(-1);
	
	objSIStream.close();
	objInputStream.close();
	return data;
}

function writeTmpFile(strString)
{
    var uc = Components.classes["@mozilla.org/intl/scriptableunicodeconverter"].
         createInstance(Components.interfaces.nsIScriptableUnicodeConverter);
    uc.charset = "UTF-8";
    var data_stream = uc.ConvertFromUnicode( strString );

    var tmpFile = Components.classes["@mozilla.org/file/directory_service;1"].getService(Components.interfaces.nsIProperties).get("TmpD", Components.interfaces.nsIFile);
    var i = Math.round(10000*Math.random())
    tmpFile.append("orbit_" + i + ".lst");
    try
    {
        if (tmpFile.exists())
            tmpFile.remove(false);

        tmpFile.create(Components.interfaces.nsIFile.NORMAL_FILE_TYPE, 0664);
    }
    catch (e)
    {
        tmpFile.createUnique(Components.interfaces.nsIFile.NORMAL_FILE_TYPE, 0664);
    }

    var foStream = Components.classes["@mozilla.org/network/file-output-stream;1"].createInstance(Components.interfaces.nsIFileOutputStream);
    foStream.init(tmpFile, 0x02 | 0x08 | 0x20, 0664, 0);
    foStream.write(data_stream, data_stream.length);
    foStream.close();
    return tmpFile.path;
}


function writeFile(strPath, strString)
{
	var objFile = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
	objFile.initWithPath(strPath);
	
	var objOutStream = Components.classes["@mozilla.org/network/file-output-stream;1"].createInstance(Components.interfaces.nsIFileOutputStream);
	var nFlags = 0x02 | 0x08 | 0x20; // wronly | create | truncate
	objOutStream.init(objFile, nFlags, 0664, 0);
	objOutStream.write(strString, strString.length);
	objOutStream.close();
	return true;
}


// Execute file
function runExe(strFile, strArg)
{
	var objFile = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
	objFile.initWithPath(strFile);
	
	if(objFile.isFile() && objFile.isExecutable())
	{
		var objProcess = Components.classes["@mozilla.org/process/util;1"].createInstance(Components.interfaces.nsIProcess);
		objProcess.init(objFile);

		var args = new Array();
		args[args.length] = strArg;
		objProcess.run(false, args, args.length);
	}
}

// get orbit path
function getOrbitPath()
{
	var strOrbitPath = regReadLMString("Software\\orbit\\", "path");
	return strOrbitPath;
}

// Global functions
function execCommand(command, strArgs)
{
	// separate command arguments
	var args = new Array();
	var quoted = false;
	var double_quoted = false;
	var param = "";
	for (var i = 0; i < strArgs.length; i++) { 
		var charArgs = strArgs.substring(i,i + 1);
		if ( charArgs == "\""  && !quoted ) { double_quoted =! double_quoted; }
		else if ( charArgs == "\'" && !double_quoted ) { quoted =! quoted; } 
		else if ( /\s/.test(charArgs) && !quoted && !double_quoted ) {
			if (param != "") args.push( param );
			param = "";
		} else param += charArgs;	
	}
	if (param != "") args.push( param );
	// create a file object for the external program
	try {
		var applicFile = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
		var applic = Components.classes["@mozilla.org/process/util;1"].createInstance(Components.interfaces.nsIProcess);
		applicFile.initWithPath(command);
		if (!applicFile.exists()) {
			alert("Executable '" + command + "' does not exist.");
		} else {
			applic.init(applicFile);
			applic.run(false, args, args.length);
		}
	} catch (e) {
		alert("Cannot run executable: " + e);
		return false;
	}
}

function orbitExecVDownload(url, info, referer, cookie)
{
	var strArgs = "";
    var strOrbitPath = getOrbitPath();
    strOrbitPath = strOrbitPath.concat("\\orbitdm.exe");

	if(info != undefined)
		strArgs += "\"/i" + info + "\" ";
	if(referer != undefined)
		strArgs += "\"/e" + referer + "\" ";
	if(cookie != undefined)
		strArgs += "\"/c" + cookie + "\" ";

	strArgs += "\"/V" + url + "\" ";

    if(isFileExists(strOrbitPath))
	    execCommand(strOrbitPath, strArgs);
}

function orbitExecDownload(url, info, referer, cookie, isLClick)
{
	var strArgs = "";
    var strOrbitPath = getOrbitPath();
    strOrbitPath = strOrbitPath.concat("\\orbitdm.exe");

	if( -1 != url.search("sourceforge.net"))
	{
		if( "sourceforge.net" != referer )
		{
			referer = "http://sourceforge.net/";
		}  
	}
	        
	        
	if(isLClick == "1")
		strArgs += "/k0 ";
	if(info != undefined)
		strArgs += "\"/i" + info + "\" ";
	if(referer != undefined)
		strArgs += "\"/e" + referer + "\" ";
	if(cookie != undefined)
		strArgs += "\"/c" + cookie + "\" ";

	strArgs += url;

    if(isFileExists(strOrbitPath))
	    execCommand(strOrbitPath, strArgs);
}

function GrabVideoUrl(url, info, referer, cookie)
{
	var strArgs = "";
    var strOrbitPath = getOrbitPath();
    strOrbitPath = strOrbitPath.concat("\\Grab.exe");
	        
	//strArgs = url;

    if(isFileExists(strOrbitPath))
	    execCommand(strOrbitPath, strArgs);
}


function orbitExecMultiDownload(urllist)
{
	var strArgs = "";
    var strOrbitPath = getOrbitPath();
    strOrbitPath = strOrbitPath.concat("\\orbitdm.exe");

	if(urllist != undefined)
	    strArgs +=  "\"/U" + urllist +  "\" ";

    if(isFileExists(strOrbitPath))
	    execCommand(strOrbitPath, strArgs);
}

function orbitDebug(message)
{ alert("#  "+message+"\n"); }

// check is hook download manager
function isHookDownload()
{
    var strAppPath =  regReadCUString("Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders","AppData");
	var strConfigPath =  strAppPath.concat("\\Orbit\\conf.dat");
	var strData = readFile(strConfigPath);
	var nIndex = strData.indexOf("bScoutExplorer=");
	if(nIndex == -1)
		return true;
	var strData2 = strData.substring(nIndex, nIndex+16);
	nIndex = strData2.indexOf("0");
	if(nIndex > 0)
		return false;
	return true;	
}
// check is hook flash
function isHookFlash()
{
    var strAppPath =  regReadCUString("Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders","AppData");
	var strConfigPath =  strAppPath.concat("\\Orbit\\conf.dat");
	var strData = readFile(strConfigPath);
	var nIndex = strData.indexOf("bScoutFlash=");
	if(nIndex == -1)
		return true;
	var strData2 = strData.substring(nIndex, nIndex+13);
	nIndex = strData2.indexOf("0");
	if(nIndex > 0)
		return false;
	return true;	
}

function isSeguestPageError()
{
	 var strAppPath =  regReadCUString("Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders","AppData");
	var strConfigPath =  strAppPath.concat("\\Orbit\\conf.dat");
	var strData = readFile(strConfigPath);
	var nIndex = strData.indexOf("SuggestError=");
	if(nIndex == -1)
		return true;
	var strData2 = strData.substring(nIndex, nIndex+14);
	nIndex = strData2.indexOf("0");
	if(nIndex > 0)
		return false;
	return true;	
}

