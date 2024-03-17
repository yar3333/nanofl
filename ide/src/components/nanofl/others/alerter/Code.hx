package components.nanofl.others.alerter;

import js.JQuery;
import nanofl.engine.Log.console;

class Code extends wquery.Component
{
	var span : JQuery;
	
	function init()
	{
		span = template().container.find(">span");
	}
	
	function show(cssClass:String, text:String, duration:Int)
	{
		if (text == null || text == "") return;

        console.log(text);
		
		template().container
			.queue(function(next)
			{
				span.html(text).attr("class", cssClass);
				next();
			})
			.fadeIn("fast")
			.delay(duration)
			.fadeOut("fast");
	}
	
	public function info(text:String, duration=3000)
	{
		show("alerter-info", text, duration);
	}
	
	public function warning(text:String, duration=3000)
	{
		show("alerter-warning", text, duration);
	}
	
	public function error(text:String, duration=3000)
	{
		show("alerter-error", text, duration);
	}
	
	public function reset() template().container.finish();
}