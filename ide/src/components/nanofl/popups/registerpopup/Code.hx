package components.nanofl.popups.registerpopup;

#if !no_trial

import js.lib.Promise;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.HttpUtils;
import nanofl.ide.filesystem.RequestResult;
import nanofl.ide.Trial;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var httpUtils : HttpUtils;
	@inject var preferences : Preferences;
	
	var callb : Bool->Void;
	
	public function show(showTrialOut=false) : Promise<Bool>
	{
		return new Promise<Bool>(function(resolve, reject)
		{
			this.callb = resolve;
			template().trialMessage.toggle(showTrialOut);
			showPopup();
		});
	}
	
	function register_click(_)
	{
		var key = StringTools.trim(template().key.val()).toUpperCase();
		if (key != "")
		{
			httpUtils.requestUrl("http://nanofl.com/validate_key/?key=" + key).then(function(result:RequestResult)
			{
				if (result.text == "true")
				{
					preferences.application.registered = true;
					preferences.application.key = key;
					js.Browser.alert("Thank you! The product was successfully registered.");
					hide();
					if (callb != null) callb(true);
				}
				else
				if (result.text == "false")
				{
					js.Browser.alert("Entered key is not valid.");
				}
				else
				{
					js.Browser.alert("Sorry, looks like a error occurred. Check your internet connection or try later.");
				}
			});
		}
		else
		{
			js.Browser.alert("Enter the key!");
		}
	}
	
	override function onCancel()
	{
		if (callb != null) callb(false);
	}
}

#else

class Code extends components.nanofl.popups.basepopup.Code {}

#end