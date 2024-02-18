package components.nanofl.others.fpsmeter;

import haxe.Timer;
import nanofl.ide.Application;
import nanofl.ide.Globals;

@:rtti
class Code extends wquery.Component
{
	@inject var app : Application;
	
	public var editorUpdateCounter = 0;
	public var editorUpdateTime = 0.0;
	
	function init()
	{
		Globals.injector.injectInto(this);
	}
	
	public function enable()
	{
		var startTime = Date.now().getTime();
		new Timer(0).run = function()
		{
			app.document.editor.update();
			
			var nowTime = Date.now().getTime();
			if (nowTime - startTime > 5000)
			{
				var s = "fps = " + Math.round(editorUpdateCounter / (nowTime - startTime) * 1000) + "<br/>";
				s += "avgUpdateDuration = " + Math.round(editorUpdateTime / editorUpdateCounter);
				template().container.html(s);
				
				editorUpdateCounter = 0;
				editorUpdateTime = 0;
				startTime = Date.now().getTime();
			}
		};
	}
}