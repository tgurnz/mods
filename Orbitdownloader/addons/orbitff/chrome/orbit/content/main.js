/* 
   Credit: 

   Copy & Paste source code from 
        downloadwith By Gustavo Bittencourt
        adblockplusa By Wladimir Palant
        mediaplayerconnectivity By Sethnakht
   Thanks a lot!

*/

function OnOrbitContextMenu(event)
{
	var strOrbitPath = getOrbitPath();
    strOrbitPath = strOrbitPath.concat("\\orbitdm.exe");
	if(isFileExists(strOrbitPath))
	{
		if(gContextMenu.onLink)
			document.getElementById("OrbitDownload").setAttribute("hidden", false);
		else
			document.getElementById("OrbitDownload").setAttribute("hidden", true);
		
		document.getElementById("OrbitDownloadAll").setAttribute("hidden", false);
		document.getElementById("OrbitDownloadGrab").setAttribute("hidden", false);
		document.getElementById("OrbitDownloadUp").setAttribute("hidden", false);
	}
	else
	{
		document.getElementById("OrbitDownload").setAttribute("hidden", true);
		document.getElementById("OrbitDownloadAll").setAttribute("hidden", true);
		document.getElementById("OrbitDownloadUp").setAttribute("hidden", true);
		document.getElementById("OrbitDownloadGrab").setAttribute("hidden", true);	
	}	
}

function OnOrbitDownload(event)
{
	// Get current page URL
	var doc = document.commandDispatcher.focusedWindow.document;
    var strUrl = gContextMenu.link.toString();
    var islclick = "0"; 
    orbitExecDownload(strUrl, "", doc.URL, doc.cookie, islclick);
}


function OnOrbitDownloadGrabVideo(event)
{
        var vhosts = ["youtube.com","www.youtube.com","video.google.com","myspace.com","www.myspace.com","www.metacafe.com","www.dailymotion.com"];
	var doc = document.commandDispatcher.focusedWindow.document;
	var strUrl = gContextMenu.link.toString();
    	if(strUrl=="false")
    		strUrl = doc.URL;
        var isvhost = 0;
        for (var k = 0; k < vhosts.length; k++) {
            if(doc.location.hostname.indexOf(vhosts[k], 0) != -1) {
                isvhost = 1; 
            }
        }
        if(isvhost == 1) 
        {
           	orbitExecVDownload(strUrl, "", doc.URL, doc.cookie);
        }
        else
        {
  		GrabVideoUrl(strUrl, "", doc.URL, doc.cookie);
  	}
}

function OnOrbitDownloadAll(event)
{
	// Get current page URL
	var doc = document.commandDispatcher.focusedWindow.document;
 
	// Get all links and all image count
	var links = document.commandDispatcher.focusedWindow.document.links;
	var images = document.commandDispatcher.focusedWindow.document.images;
	var link_count = links.length;
	var image_count = images.length;
    var strUrllist = "";
    var strTitle = "";	
    var strRefer = doc.URL.replace(/(\n|\r|\|)/g,"");
    var strCookie = doc.cookie.replace(/(\n|\r|\|)/g,"");;
	
	for(var i=0; i<link_count; i++)
	{
		strUrllist = strUrllist.concat(links[i].href, "|");
        strTitle = links[i].innerHTML.replace(/(\n|\r|\|)/g,"");
		strUrllist = strUrllist.concat(strTitle, "|");
		strUrllist = strUrllist.concat(strRefer, "|");
		strUrllist = strUrllist.concat(strCookie, "\n");
	}
	for(var i=0; i<image_count; i++)
	{
		strUrllist = strUrllist.concat(images[i].src, "|");
        strTitle = images[i].textContent.replace(/(\n|\r|\|)/g,"");
		strUrllist = strUrllist.concat(strTitle, "|");
		strUrllist = strUrllist.concat(strRefer, "|");
		strUrllist = strUrllist.concat(strCookie, "\n");
	}
	
    var urllist = writeTmpFile(strUrllist);
    // Call Orbit
    orbitExecMultiDownload(urllist);
}


function getElementOuterHTML(element)
{
	if(element.nodeType != 1)
		return null;
		
	var strOuterHTML = "<" + element.nodeName;
	for(var i=0; i<element.attributes.length; i++)
	{
		if(element.attributes[i].value != null)
		{
			strOuterHTML += " ";
			strOuterHTML += element.attributes[i].name;
			strOuterHTML += "=\"";
			strOuterHTML += element.attributes[i].value;
			strOuterHTML += "\"";
		}
	}
	strOuterHTML += ">"
	strOuterHTML += element.innerHTML;
	strOuterHTML += "</" + element.nodeName + ">";
	return strOuterHTML;
}

function OnElementMouseOver(event)
{
	if(event == null)
		return false;
	if(event.target == null)
		return false;
	
	if(event.target.tagName == "A" ||
	   event.target.tagName == "B" ||
	   event.target.tagName == "FONT")
	{
		var theElement = event.target;
		do
		{
			if(theElement.tagName == "A")
			{
				var strDocumentUrl = document.commandDispatcher.focusedWindow.document.URL;
				var strOuterHTML = getElementOuterHTML(theElement);
				g_orbitComponent.ShowFloatBar(strDocumentUrl, strOuterHTML);
				break;
			}
			theElement = theElement.parentNode;
		}
		while(theElement != null);
	}
	else if(event.target.tagName == "EMBED" ||
			event.target.tagName == "OBJECT")
	{
		var strDocumentUrl = document.commandDispatcher.focusedWindow.document.URL;
		var strOuterHTML = getElementOuterHTML(event.target);
		g_orbitComponent.ShowFloatBar(strDocumentUrl, strOuterHTML);
	}
	else
	{
		g_orbitComponent.HideFloatBar();
	}
    return true;
}


function SetEventHandler(parentWindow)
{
	var elements = parentWindow.document.getElementsByTagName("*");
	for(var i=0; i<elements.length; i++)
	{
		if(elements[i].tagName != "IFRAME" &&
		   elements[i].tagName != "FRAME")
		{
			elements[i].onmouseover = OnElementMouseOver;
		}
	}
	
	var theFrames = parentWindow.frames;
	for(i=0; i<theFrames.length; i++)
	{
		SetEventHandler(theFrames[i]);
	}
}


function SetEventHandlerWrapper(parentWindow)
{
	var elements = parentWindow.document.getElementsByTagName("*");
	for(var i=0; i<elements.length; i++)
	{
		if(elements[i].tagName != "IFRAME" &&
		   elements[i].tagName != "FRAME")
		{
			//alert(elements[i].setAttributeNS);
		}
	}
	
	var theFrames = parentWindow.frames;
	for(i=0; i<theFrames.length; i++)
	{
		SetEventHandlerWrapper(theFrames[i]);
	}
}


function OnWindowLoad(event)
{
	// attach events
	if(event.originalTarget == "[object HTMLDocument]")
	{
		var theDocument = event.originalTarget;
		SetEventHandler(theDocument.defaultView);
	}
	if(event.originalTarget == "[object XPCNativeWrapper [object HTMLDocument]]")
	{
		var theDocument = event.originalTarget;
		SetEventHandlerWrapper(theDocument.defaultView);	
	}
}


const STATE_START = Components.interfaces.nsIWebProgressListener.STATE_START;
const STATE_STOP = Components.interfaces.nsIWebProgressListener.STATE_STOP;

var strErrorUrl = "http://www.orbitdownloader.com/pageerror.php?type=ErrorCode&url=CurUrl&ref=CurRef&browser=Firefox";

function registerorbit_urlChangeListener()
{
 // orbitDebug("registerorbit_urlChangeListener");
  window.getBrowser().addProgressListener(orbit_urlChangeListener, STATE_START);
  window.getBrowser().addProgressListener(orbit_urlChangeListener, STATE_STOP);
}

function unregisterorbit_urlChangeListener()
{
  //orbitDebug("unregisterorbit_urlChangeListener");
  window.getBrowser().removeProgressListener(orbit_urlChangeListener);
}

function orbit_extractStreamOnDoc(doc, doc1, doc2, trusted)
{
   //orbitDebug("orbit_extractStreamOnDoc ("+doc.location.href+")");
   var elem = null;
   var parent = null;
   var tabOfElement;
   var nbObj;
   var sourceMedia = null;
   var objTab = null;
   var wnd = null;
   var topWnd = null;
   var wndhost = null;
   var wndpath = null;
   var finalloc = null;


   tabOfElement = doc.getElementsByTagName("embed");
   nbObj = tabOfElement.length;

   for (var i = 0; i < nbObj; ++i)
   { 
       elem = tabOfElement[i];
       parent = elem.parentNode;
       sourceMedia = elem.href || elem.qtsrc || elem.filename || elem.movie || elem.url ||  elem.location || elem.code || elem.object || elem.data || elem.src;
//      alert("elem.href=" + elem.href + "\nelem.movie=" + elem.movie + "\nelem.url=" + elem.url + "\nelem.location= " + elem.location + "\nelem.src=" + elem.src + "\nelem.data=" + elem.data );
        //alert("sourceMedia = " + sourceMedia);
        if(!sourceMedia) {
       //     alert("no sourcemedia");
            continue;
        }
        wnd = null;
        topWnd = null;
        finalloc = null;
        wnd = doc.defaultView;
        if(!wnd) {
        //    alert("no wnd");
            continue;
        }
        topWnd = wnd.top;
        if (!topWnd || !topWnd.location || !topWnd.location.href) {
        //    alert("no topwnd");
            continue;
        }
        var iloc = topWnd.location.pathname.lastIndexOf("/");
        var realpath = topWnd.location.pathname.substring(0,iloc+1);
        
        if(sourceMedia.indexOf("://") == -1) {
            if(sourceMedia.charAt(0) == '/') {
               finalloc = "http://" + topWnd.location.hostname + sourceMedia;
            }else{
               finalloc = "http://" + topWnd.location.hostname + realpath + sourceMedia;
            }
        }else {
            finalloc = sourceMedia;
        }
//        alert("finalloc: "+finalloc+"\nsourceMedia: "+sourceMedia);

       objTab = elem.ownerDocument.createElementNS("http://www.w3.org/1999/xhtml", "div");
       wnd.setTimeout(addOrbitTab, 0, elem, finalloc, objTab);
   }
}

window.addEventListener("load", OnWindowLoad, true);

if(isHookFlash()) {
window.addEventListener("pageshow", function(event) {orbit_extractStreamOnDoc(event.originalTarget); }, true);
}

if(isSeguestPageError()) {
	window.addEventListener("load",registerorbit_urlChangeListener,false);
window.addEventListener("unload",unregisterorbit_urlChangeListener,false);
}

var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

function base64encode(locUrl) 
{
	
    var out, i, len;
    var c1, c2, c3;
	var str = unescape(locUrl);
    len = str.length;
    i = 0;
    out = "";
	
    while(i < len) 
	{
		c1 = str.charCodeAt(i++) & 0xff;
		if(i == len)
		{
			 out += base64EncodeChars.charAt(c1 >> 2);
			 out += base64EncodeChars.charAt((c1 & 0x3) << 4);
			 out += "==";
			 break;
		 }
		 c2 = str.charCodeAt(i++);
		if(i == len)
		{
			 out += base64EncodeChars.charAt(c1 >> 2);
			 out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
			 out += base64EncodeChars.charAt((c2 & 0xF) << 2);
			 out += "=";
			 break;
		}
		c3 = str.charCodeAt(i++);
		out += base64EncodeChars.charAt(c1 >> 2);
		out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
		out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >>6));
		out += base64EncodeChars.charAt(c3 & 0x3F);
    }
	
    return out;
}

function ProcessErrorPage(errorCode, href, referrer)
{
	if (href.indexOf("orbitdownloader.com") != -1)
	{
		return;
	}
		
	var strUrl = strErrorUrl;
	strUrl = strUrl.replace("ErrorCode", errorCode);
	var strCurUrl = base64encode(href);
	strCurUrl = encodeURIComponent(strCurUrl);
	strUrl = strUrl.replace("CurUrl", strCurUrl);
	if(referrer.length > 0)
	{
		var strRef = base64encode(referrer);
		strRef = encodeURIComponent(strRef);
		strUrl = strUrl.replace("CurRef", strRef);
	}
	else
	{
		strUrl = strUrl.replace("CurRef", "");
	}
	
	window._content.document.location = strUrl;
	window.content.focus();
}

var strPreUrl = "";
var orbit_urlChangeListener =
{
  onStateChange:function(aProgress,aRequest,aFlag,aStatus)
  {
	if(aFlag & STATE_START)
   {
   } 
   if(aFlag & STATE_STOP)
   {
        var httpChannel = aRequest.QueryInterface(Components.interfaces.nsIHttpChannel);
		switch(httpChannel.responseStatus)
		{
			case 403:
			case 400:
			case 410:
			case 414:
			case 500:
			case 502:
			case 404:
			{
				 nPreFlag = false;
				 ProcessErrorPage(httpChannel.responseStatus, window._content.document.location.href, strPreUrl);
				 return;
			}
			break;
			default:
			break;
		}
		strPreUrl = window._content.document.location.href;
   }

  },
  onLocationChange:function (aWebProgress, aRequest, aLocation){},
  onProgressChange:function(aWebProgress, aRequest, aCurSelfProgress, aMaxSelfProgress, aCurTotalProgress, aMaxTotalProgress){},
  onStatusChange:function (aWebProgress, aRequest, aStatus, aMessage) {}, 
  onSecurityChange:function (aWebProgress, aRequest, aState) {},
  onLinkIconAvailable:function(a){},

  QueryInterface : function(aIID)
  {
    if (aIID.equals(Components.interfaces.nsIWebProgressListener) ||
        aIID.equals(Components.interfaces.nsISupportsWeakReference) ||
        aIID.equals(Components.interfaces.nsISupports))
      return this;
    throw Components.results.NS_NOINTERFACE;
  }
} 

// Generates a click handler for object tabs
function generateClickHandler(wnd, location) {
	return function() {
        var vhosts = ["youtube.com","www.youtube.com","video.google.com","myspace.com","www.myspace.com","www.metacafe.com","www.dailymotion.com"];
        var cdoc = document.commandDispatcher.focusedWindow.document;
        var strUrl = location.toString();
        var isvhost = 0;
        for (var k = 0; k < vhosts.length; k++) {
        	//alert(cdoc.location.hostname);
            if(cdoc.location.hostname.indexOf(vhosts[k], 0) != -1) {
                isvhost = 1; 
            }
        }
        //alert("download: " + strUrl); 
        //alert("ref: " + cdoc.URL); 
        //alert("cookie: " + cdoc.cookie);
        
        if(isvhost == 1) {
        	//alert("is five website!");
            //GrabVideoUrl(cdoc.URL, "", cdoc.URL, cdoc.cookie);
            orbitExecVDownload(cdoc.URL, "", cdoc.URL, cdoc.cookie);
        }else{         
            var islclick = "0"; 
            GrabVideoUrl(strUrl, "", cdoc.URL, cdoc.cookie, islclick);
        }
	}
}

// Creates a tab above/below the new object node
function addOrbitTab(node, location, tab, wnd,ref,cookie) {
    //alert("enter addOrbitTab");
	var offsetNode = node;

	if (node.parentNode && node.parentNode.tagName.toLowerCase() == "object") {
		// Don't insert object tabs inside an outer object, causes ActiveX Plugin to do bad things
		node = node.parentNode;
	}

	if (!node.parentNode)
		return;

	// Decide whether to display the tab on top or the bottom of the object
	var offsetTop = 0;
	for (; offsetNode; offsetNode = offsetNode.offsetParent)
		offsetTop += offsetNode.offsetTop;

	var onTop = (offsetTop > 40);
	if (onTop)
		tab.setAttribute("ontop", "true");
	tab.style.paddingLeft = node.offsetWidth + "px";

	// Click event handler
	tab.addEventListener("click", generateClickHandler(wnd, location), false);

	// Insert tab into the document
	tab.style.display = "none";
	if (onTop)
		node.parentNode.insertBefore(tab, node);
	else {
		var nextSibling = node.nextSibling;
		if (nextSibling)
			node.parentNode.insertBefore(tab, node.nextSibling);
		else
			node.parentNode.appendChild(tab);
	}

	// Attach binding
	var doc = node.ownerDocument;
	doc.loadBindingDocument("chrome://orbit/content/orbittab.xml");
	doc.addBinding(tab, "chrome://orbit/content/orbittab.xml#orbitTab");
//  createTimer(function() {tab.style.display = "block"}, 0);
}

