package components.nanofl.popups.aboutapplicationpopup;

import nanofl.engine.Version;
import nanofl.ide.preferences.Preferences;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var preferences : Preferences;
	
	override function init()
	{
		super.init();
		
		template().version.html(Version.ide);
	}
	
	public function show()
	{
		showPopup();
	}
}