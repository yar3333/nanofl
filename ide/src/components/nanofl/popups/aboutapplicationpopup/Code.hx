package components.nanofl.popups.aboutapplicationpopup;

import nanofl.engine.Version;
import nanofl.ide.Trial;
import nanofl.ide.preferences.Preferences;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var preferences : Preferences;
	
	override function init()
	{
		super.init();
		
		template().version.html(Version.ide);
		
		#if no_trial
		
		template().trialMessage.remove();
		
		#end
	}
	
	public function show()
	{
		#if !no_trial
		
		if (!preferences.application.registered)
		{
			template().trialMessage.html("Trial period: " + (Trial.PERIOD - Std.int((Date.now().getTime() - preferences.application.firstStartTime) / DateTools.days(1))) + " day(s).");
		}
		else
		{
			template().trialMessage.html("Registered with a key <input readonly='readonly' style='width:250px; text-align:center' value='" + preferences.application.key + "' />.");
		}
		
		#end
		
		showPopup();
	}
}