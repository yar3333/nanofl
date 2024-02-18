package components.nanofl.movie.zoomer;

import nanofl.ide.Application;
import nanofl.ide.Globals;

@:rtti
class Code extends wquery.Component
{
	@inject var app : Application;
	
	var zoomLevel : Float = null;
	
	function init()
	{
		Globals.injector.injectInto(this);
	}
	
	public function update()
    {
		if (app.document.editor.zoomLevel == zoomLevel) return;
		zoomLevel = app.document.editor.zoomLevel;
		
		var levels : Array<Float> = [ 25, 50, 75, 100, 150, 200, 400 ];
		if (levels.indexOf(zoomLevel) < 0) levels.push(zoomLevel);
		levels.sort(Reflect.compare);
		
		var options = levels.map(function(z) 
		{
			var r = Math.round(z);
			var selected = z == zoomLevel ? " selected='selected'" : "";
			return "<option value='" + z + "'" + selected + ">" + r + (z == r || levels.indexOf(r) < 0 ? "" : "*") + "%</options>";
		});
		
		template().select.html(options.join(""));
    }
	
	function select_change(_)
	{
		app.document.editor.zoomLevel = Std.parseFloat(template().select.val());
		template().select.blur();
	}
}