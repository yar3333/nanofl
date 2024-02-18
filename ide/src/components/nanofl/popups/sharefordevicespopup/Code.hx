package components.nanofl.popups.sharefordevicespopup;

import nanofl.ide.ShareForDevices;
import nanofl.ide.preferences.Preferences;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var preferences : Preferences;
	
	var shareForDevices = new ShareForDevices();
	
	public function show() 
	{
		bind();
		
		showPopup();
	}
	
	function bind()
	{
		template().linkID.val(preferences.application.linkID);
		var url = "http://share.nanofl.com/packages/" + preferences.application.linkID + "/";
		template().url.attr("href", url);
		template().url.html(url);
	}
	
	function generateNewLinkID_click(_)
	{
		shareForDevices.generateNewLinkID();
		bind();
	}
}