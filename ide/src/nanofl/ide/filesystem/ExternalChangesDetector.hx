package nanofl.ide.filesystem;

import js.lib.Promise;
import haxe.Timer;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.Application;
import nanofl.ide.ui.View;
using stdlib.Lambda;

@:rtti
class ExternalChangesDetector extends InjectContainer
{
	static var CHECKING_PERIOD(default, never) = 2000;
	
	@inject var app : Application;
	@inject var view : View;
	
	var timer : Timer;

    var reloading : Promise<{}> = Promise.resolve(null);

    function new() super();

    public function start()
    {
		timer = new Timer(CHECKING_PERIOD);
		timer.run = detectChanges;
    }
	
	function stop() : Promise<{}>
	{
		timer.stop();
        timer = null;
        return reloading;
	}
	
	function detectChanges()
	{
		if (app.document == null) return;
		
		reloading = app.document.reload().then((e:{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }) ->
		{
			if (e.added.length == 0 && e.removed.length == 0) return null;
			
            view.alerter.warning("Document was externally changed.");
            if (e.added.length > 0) view.alerter.info("Added item" + (e.added.length > 1 ? "s" : "") + ": " + e.added.map(x -> x.namePath).join(", ") + ".");
            if (e.removed.length > 0) view.alerter.info("Removed item" + (e.removed.length > 1 ? "s" : "") + ": " + e.removed.map(x -> x.namePath).join(", ") + ".");
            view.alerter.info("Document was successfully reloaded.");

            return null;
		});
	}

    public function runPreventingAutoReloadAsync<T>(f:Void->Promise<T>) : Promise<T>
    {
        return stop().then(_ ->
        {
            try
            {
                return f().finally(() -> start());
            }
            catch (e)
            {
                start();
                throw e;
            }
        });
    }

    public function runPreventingAutoReloadSync(f:Void->Void) : Promise<{}>
    {
        return stop().then(_ ->
        {
            try
            {
                f();
                start();
                return null;
            }
            catch (e)
            {
                start();
                throw e;
            }
        });
    }    
}
