package nanofl.ide.filesystem;

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
	@inject var documentTools : DocumentTools;
	
	var timer : Timer;

    function new() super();

    public static function start()
    {
        final detector = new ExternalChangesDetector();
        detector.startInner();
    }
	
	function startInner()
	{
		timer = new Timer(CHECKING_PERIOD);
		timer.run = detectChanges;
	}
	
	function detectChanges()
	{
		if (app.document == null || !app.document.allowAutoReloading) return;
		
		documentTools.reload(app.document).then((e:{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }) ->
		{
			if (e.added.length > 0 || e.removed.length > 0)
			{
				view.alerter.warning("Document was externally changed.");
				if (e.added.length > 0) view.alerter.info("Added item" + (e.added.length > 1 ? "s" : "") + ": " + e.added.map(x -> x.namePath).join(", ") + ".");
				if (e.removed.length > 0) view.alerter.info("Removed item" + (e.removed.length > 1 ? "s" : "") + ": " + e.removed.map(x -> x.namePath).join(", ") + ".");
				view.alerter.info("Document was successfully reloaded.");
			}
		});
	}
}
