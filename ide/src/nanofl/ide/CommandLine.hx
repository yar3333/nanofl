package nanofl.ide;

import js.Lib;
import js.lib.Error;
import js.lib.Promise;
import stdlib.ExceptionTools;
import stdlib.Std;
import stdlib.Timer;
import nanofl.engine.Log;
import nanofl.engine.Log.console;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.MainProcess;
import nanofl.ide.ui.View;
using StringTools;
using stdlib.Lambda;

@:rtti
class CommandLine extends InjectContainer
{
	@inject var view : View;
	@inject var app : Application;
	@inject var fileSystem : FileSystem;
	@inject var folders : Folders;
	@inject var mainProcess : MainProcess;
	
    function new() super();

    public static function process() : Promise<{}>
    {
        final commandLine = new CommandLine();
        return commandLine.processInner();
    }

	function processInner() : Promise<{}>
	{
        final args = mainProcess.getCommandLineArgs();
        //console.log(args);
        return processNextArg(args);
	}
	
	function processNextArg(args:Array<String>) : Promise<{}>
	{
        if (args.length == 0) return Promise.resolve(null);

		final arg = args.shift();

		if (arg.endsWith(".js") || arg.endsWith(".jsnf"))
		{
			try
			{
                final code = fileSystem.getContent(arg);
				Lib.eval("(" + code + ")");
			}
            catch (e)
            {
                return error("Error loading script \"" + arg + "\".\n" + ExceptionTools.wrap(e).message);
            }
			
			return Timer.delayAsync(50).then(_ ->
			{
				view.movie.timeline.update();
                return processNextArg(args);
			});
		}
		
		if (arg == "-pid")
		{
			if (args.length > 0 && !args[0].startsWith("-"))
			{
				app.pid = args.shift();
				Log.logFile = folders.temp + "/logs/" + app.pid + ".log";
				Log.onMessage.bind(function(_, e) if (e.type == "error") app.quit(true, 1));
                return processNextArg(args);
			}
			return error("File path expected after '-pid' option.");
		}
		
		if (arg == "-fps")
		{
			view.fpsMeter.enable();
			return processNextArg(args);
		}
		
		if (arg == "-save")
		{
            return app.document.save(true).then(_ -> processNextArg(args));
		}
		
		if (arg == "-export")
		{
			if (args.length > 0 && !args[0].startsWith("-"))
			{
				var destFileName = args.shift();
				return app.document.export(destFileName).then(_ -> processNextArg(args));
			}
            return error("Output file path expected after '-export' option.");
		}
		
		if (arg == "-resize-fit")
		{
			final reWH = ~/^(\d*)[xX](\d*)$/;
			if (args.length > 0 && args[0] != "x" && args[0] != "X" && reWH.match(args[0]))
			{
				args.shift();
				
				var k : Float;
				
				if (reWH.matched(1) != "" && reWH.matched(2) != "")
				{
					k = Math.min
					(
						Std.parseInt(reWH.matched(1)) / app.document.properties.width,
						Std.parseInt(reWH.matched(2)) / app.document.properties.height
					);
				}
				else
				if (reWH.matched(1) != "")
				{
					k = Std.parseInt(reWH.matched(1)) / app.document.properties.width;
				}
				else
				{
					k = Std.parseInt(reWH.matched(2)) / app.document.properties.height;
				}
				
				app.document.resize
				(
					Math.round(app.document.properties.width  * k),
					Math.round(app.document.properties.height * k)
				);
				
				return processNextArg(args);
			}

			return error("Size (like '200x100') expected after '-resize-fit' option.");
		}
		
		if (arg == "-publish")
		{
			return app.document.publish().then(_ -> processNextArg(args));
		}
		
		if (arg == "-quit")
		{
			app.quit(true);
            return Promise.resolve(null);
		}
		
		if (arg == "-scaleMode")
		{
			if (args.length > 0)
			{
				if ([ "noScale", "fit", "fill", "stretch", "custom" ].indexOf(args[0]) >= 0)
				{
					var scaleMode = args.shift();
					app.document.properties.scaleMode = scaleMode;
					return processNextArg(args);
				}
				return error("Unknow scale mode ('" + args[0] + "').");
			}
    		return error("Scale mode name expected after '-scaleMode' option.");
		}
		
		if (arg == "-script")
		{
			if (args.length > 0)
			{
				var script = args.shift();
				js.Lib.eval("'use strict';" + script);
				return processNextArg(args);
			}
            return error("JS code expected after '-script' option.");
		}
		
        if (arg == "-devTools")
		{
			return processNextArg(args);
		}
		
		if (!arg.startsWith("-"))
		{
			return app.openDocument(arg).then(doc ->
			{
				return doc != null ? processNextArg(args) : error("Error loading '" + arg + "'.");
			});
		}
		
		return error("Unknow command line argument: " + arg);
	}
	
	function error(message:String) : Promise<{}>
	{
		console.error("ERROR: " + message);
		view.alerter.error(message);
        return Promise.reject(new Error(message));
    }
}