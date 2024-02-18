package nanofl.ide;

import js.Browser;
import js.JQuery;
import js.lib.Promise;
using StringTools;

class ExternalScriptLoader
{
	public static function loadAndExecute(jsFilePath:String) : Promise<{}>
	{
		return new Promise((resolve, reject) ->
		{
			var id = jsFilePath.replace(":", "_").replace("\\", "_").replace("/", "_").replace(" ", "_").replace(".", "_");
			
			new JQuery("#" + id).remove();
			
			var script = Browser.document.createScriptElement();
			script.id = id;
			script.onload = () -> resolve(null);
			script.onerror = e -> reject(e);
			script.src = jsFilePath;

			Browser.document.head.appendChild(script);
		});
	}
}