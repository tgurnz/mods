/*
	Credit:

	Original source code from
   		DownThemAll! by Nils Maier <MaierMan@web.de>
	Re-written by
		Nelson <nelson@csie.us>
   
	Thanks a lot!
*/

var OrbitDialog = {
	init: function od_init()
    {
		var basicBox = document.getElementById('basicBox');
		var normalBox = document.getElementById('normalBox');
		const doRevert = basicBox && (!basicBox.collapsed || (normalBox && normalBox.collapsed));
		if (doRevert)
        {
            this.revertUI();
		}

		document.getElementById("OrbitDownloaderContainer").collapsed = false;

		this.dialog = dialog;
		this.url = dialog.mLauncher.source.spec;
		try
		{
			this.referrer =	dialog.mContext.QueryInterface
				(Components.interfaces.nsIWebNavigation).currentURI.spec;
  		}
		catch (ex)
		{
			this.referrer = this.url;
		}
		try
		{
			this.cookie = dialog.mContext.QueryInterface
				(Components.interfaces.nsIWebNavigation).document.cookie;
		}
		catch (ex)
		{
		}

		document.documentElement.setAttribute(
            'ondialogaccept',
            'if(OrbitDialog.dialogAccepted()) { '
            + document.documentElement.getAttribute('ondialogaccept')
            + '}'
        );
	},

	revertUI: function od_revertUI()
	{
		['open'].forEach(
			function(e) {
				e = document.getElementById(e);
				e.parentNode.collapsed = true;
				e.disabled = true;
			}
		);
		document.getElementById('basicBox').collapsed = true;
		document.getElementById('normalBox').collapsed = false;

		var nodes = document.getElementById('normalBox').getElementsByTagName('separator');
		for (var i = 0; i < nodes.length; ++i)
        {
			nodes[i].collapsed = true;
		}

		// take care of FlashGot... for now.
		// need to negotiate with the author (and possible other extension authors)
		try
        {
			gFlashGotDMDialog.init();
			document.getElementById("flashgot-basic").collapsed = true;
		}
		catch (ex)
        {}
		this.sizeToContent();
	},

	// Workaround for bug 371508
	sizeToContent: function()
    {
		try
        {
			window.sizeToContent();
		}
		catch (ex)
        {
			try
            {
				var btn = document.documentElement.getButton('accept');
				window.innerHeight = btn.boxObject.y + 10;
			}
			catch (ex)
            {}
		}
	},

	dialogAccepted: function od_accept()
	{
	    var mode = document.getElementById("mode").selectedItem;
	    var orbit = document.getElementById("OrbitDownloader");
	    
		if (mode == orbit)
		{
			// Call orbit
			var islclick = "1";
			orbitExecDownload(this.url, "", this.referrer, this.cookie, islclick);
			document.documentElement.removeAttribute('ondialogaccept');
			document.documentElement.cancelDialog();
			return false;
		}
		return true;
	},
}
window.addEventListener(
	"load",
	function() { OrbitDialog.init(); },
	false
);
