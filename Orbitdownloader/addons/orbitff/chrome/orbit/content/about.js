function init()
{
	var extensionsStrings = document.getElementById("myextensionsStrings");
	var titlevar = extensionsStrings.getFormattedString("aboutWindowTitle",["Orbit Downloader"]);
	document.title = titlevar;
	
  	var extensionVersion = document.getElementById("extensionVersion");
  	extensionVersion.setAttribute("value", extensionsStrings.getFormattedString("aboutWindowVersionString", ["2.02"]));
	

  	var acceptButton = document.documentElement.getButton("accept");
  	acceptButton.label = extensionsStrings.getString("aboutWindowCloseButton");
}

function loadHomepage(aEvent) {
  window.close();
  window.opener.openURL("http://www.orbitdownloader.com");
}

