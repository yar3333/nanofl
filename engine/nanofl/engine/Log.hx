package nanofl.engine;

import js.Browser;
import js.lib.Error;
import haxe.Exception;
import haxe.CallStack;
import stdlib.Debug;
import stdlib.Event;
import stdlib.ExceptionTools;
using StringTools;

class Log
{
    #if ide
	public static var fileSystem : nanofl.ide.sys.FileSystem;
	public static var onMessage = new Event<{ type:String, message:String }>(null);
	public static var logFile : String;
	
	public static function init(fileSystem:nanofl.ide.sys.FileSystem, alerter:components.nanofl.others.alerter.Code)
	{
		Browser.window.onerror = cast function(msg:String, url:String, line:Int, col:Int, e:Dynamic)
		{
			if (Std.isOfType(e, Exception)) e = (cast e : Exception).details().replace(" line ", ":");
            console.error(e);
			sendBugReport(e, msg);
            return true;
		};
		
		haxe.Log.trace = function(v:Dynamic, ?p:haxe.PosInfos) console.log(v);
	}
	
	public static function sendBugReport(err:Dynamic, ?data:String) : Void
	{
		//JQuery.postAjax("http://nanofl.com/report_error/", { exception:"NanoFL Editor " + Version.ide + "\n" + toString(err), data:data });
	}
	
	static function toString(v:Dynamic) : String
	{
		var err = toError(v);
		var text = err.message != null ? err.message : "";
		if (err.stack != null && err.stack != "")
		{
			text += "\n\nException stack:\n" + err.stack;
		}
		return text.trim();
	}
	
	public static function toError(v:Dynamic) : Error
	{
		if (Std.isOfType(v, Exception))
		{
			var stack = CallStack.toString((cast v : Exception).stack);
			v = new Error(v.message);
			v.stack = stack;
		}
		
		if (Std.isOfType(v.message, String) && v.stack != null)
		{
			v.stack = ~/^(?:\s*Called from module )?([^@]*)@(?:(.*?)\s*->\s*)?(.+):(\d+):\d+$/gm.map(v.stack, re ->
			{
				try
				{
					if (re.matched(0).indexOf(" | ") >= 0) return re.matched(0);
					
					var method = (try re.matched(1) catch (e:Dynamic) "").replace("prototype<.", "").replace("prototype.", "");
					//var baseFile = re.matched(2);
					var file = re.matched(3);
					var line = re.matched(4);
					
					if (file.startsWith("file:///")) file = file.substring("file:///".length);
					
					return method + " | " + file + " : " + line;
				}
				catch (e:Dynamic)
				{
					console.log(ExceptionTools.string(e));
					return re.matched(0);
				}
			});
			
			return v;
		}
		
		if (Std.isOfType(v, Error)) return v;
		
		if (!Std.isOfType(v, Error) && Reflect.fields(v).length == 0) v = Std.string(v);
		
		var r = new Error(Std.isOfType(v, String) ? v : Debug.getDump(v));
		(cast r).stack = null;
		return r;
	}
    #end

    public static final console = new Console();
}

private class Console
{
    public function new() {}

    public function log(...args:Dynamic) : Void
    {
        Browser.console.groupCollapsed(...args);
        Browser.console.trace();
        Browser.console.groupEnd();
    }

    public function warn(...args:Dynamic) : Void
    {
        Browser.console.warn(...args);
    }

    public function error(...args:Dynamic) : Void
    {
        Browser.console.error(...args);
    }
}
