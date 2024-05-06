package nanofl.engine;

import haxe.Json;
import js.Browser;
import js.lib.Error;
import haxe.Exception;
import stdlib.Debug;
import stdlib.ExceptionTools;
using StringTools;

class Log
{
    #if ide
    static var app : AppLike;
    static var fileSystem : nanofl.ide.sys.FileSystem;
    static var folders : nanofl.ide.sys.Folders;
	
	public static function init(app:AppLike, fileSystem:nanofl.ide.sys.FileSystem, folders:nanofl.ide.sys.Folders)
	{
        Log.app = app;
        Log.fileSystem = fileSystem;
        Log.folders = folders;

		Browser.window.onerror = cast function(msg:String, url:String, line:Int, col:Int, e:Dynamic)
		{
			if (Std.isOfType(e, Exception)) e = (cast e : Exception).details().replace(" line ", ":");
            console.error(e);
			//sendBugReport(e, msg);
            return true;
		};
		
		haxe.Log.trace = function(v:Dynamic, ?p:haxe.PosInfos) console.log(v);
	}
	
	//public static function sendBugReport(err:Dynamic, ?data:String) : Void
	//{
		//JQuery.postAjax("http://nanofl.com/report_error/", { exception:"NanoFL Editor " + Version.ide + "\n" + toString(err), data:data });
	//}

    public static function logShapeCombineError(shapeA:nanofl.ide.undo.states.ShapeState, shapeB:nanofl.ide.undo.states.ShapeState)
    {
        final fileName = folders.temp + "/shape_combine_errors/" + js.lib.Date.now() + ".json";
        fileSystem.saveContent(fileName, Json.stringify({ shapeA:shapeA, shapeB:shapeB }, "\t"));
        console.error("Detected shape combine error");
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
			var stack = haxe.CallStack.toString((cast v : Exception).stack);
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

    @:allow(nanofl.engine.Console)
    static function writeToFile(type:String, data:Dynamic) : Void
    {
        final dir = folders.temp + "/logs/";
        if (!fileSystem.exists(dir)) fileSystem.createDirectory(dir);

        final fileName = dir + "/" + (app.document?.id ?? "_general") + ".log";

        var stack = haxe.CallStack.callStack();
        if (isTopStackItemMatch(stack, null, "writeToFile"))
        {
            stack = stack.slice(1);

            if (isTopStackItemMatch(stack, null, "log"))
            {
                stack = stack.slice(1);
            }
        }

        fileSystem.saveContent
        (
            fileName,
            Json.stringify
            ({
                dateTime: DateTools.format(Date.now(), "%Y-%m-%d %H:%M:%S"),
                path: app.document?.path,
                type: type,
                data: data,
                stack: haxe.CallStack.toString(stack)
            }) + "\n",
            true
        );
    }

    static function isTopStackItemMatch(stack:Array<haxe.CallStack.StackItem>, classname:String, method:String) : Bool
    {
        if (stack.length > 0)
        {
            switch (stack[0])
            {
                case haxe.CallStack.StackItem.FilePos(s, file, line, column):
                    switch (s)
                    {
                        case haxe.CallStack.StackItem.Method(classname, method):
                            return classname == null && method == "writeToFile";
                        case _:
                    }
                case _:
            }
        }
        return false;
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

        #if ide Log.writeToFile("log", args.toArray()); #end
    }

    public function warn(...args:Dynamic) : Void
    {
        Browser.console.warn(...args);
        
        #if ide Log.writeToFile("warn", args.toArray()); #end
    }

    public function error(...args:Dynamic) : Void
    {
        Browser.console.error(...args);
        
        #if ide Log.writeToFile("error", args.toArray()); #end
    }

    public function namedLog(type:String, data:Dynamic)
    {
        data = Reflect.isFunction(data) ? data() : data;

        Browser.console.groupCollapsed("[" + type + "]", data);
        Browser.console.trace();
        Browser.console.groupEnd();

        #if ide Log.writeToFile("[" + type + "]", data); #end
    }
}

typedef AppLike =
{
    var document(get, never) :
    { 
        var id(default, null) : String;
        var path(default, null) : String;
    }
}
