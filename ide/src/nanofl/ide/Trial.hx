package nanofl.ide;

#if !no_trial

import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.Popups;

@:rtti
class Trial extends InjectContainer
{
	public static var PERIOD(default, never) = 30;
	
	@inject var app : Application;
	@inject var preferences : Preferences;
	@inject var popups : Popups;
	
	public function onStart(finishInitialization:Void->Void)
	{
		if (preferences.application.firstStartTime == 0)
		{
			preferences.application.firstStartTime = Date.now().getTime();
		}
		
		if (!preferences.application.registered && preferences.application.firstStartTime < DateTools.delta(Date.now(), DateTools.days(-Trial.PERIOD)).getTime())
		{
			haxe.Timer.delay(function()
			{
				popups.register.show(true).then(function(registered:Bool)
				{
					if (registered)
					{
						finishInitialization();
					}
					else
					{
						app.quit();
					}
				});
			}, 1000);
		}
		else
		{
			finishInitialization();
		}
	}
}

#end
