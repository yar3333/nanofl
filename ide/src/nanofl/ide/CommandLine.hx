package nanofl.ide;

import js.Lib;
import nanofl.ide.SafeCode;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.MainProcess;
import nanofl.ide.ui.View;
using stdlib.Lambda;
using StringTools;
import stdlib.Timer;

@:rtti
class CommandLine extends InjectContainer
{
	@inject var view : View;
	@inject var app : Application;
	@inject var fileSystem : FileSystem;
	@inject var folders : Folders;
	@inject var mainProcess : MainProcess;
	
	public function process(callb:Int->Void): Void
	{
        var options = mainProcess.getCommandLineArgs();
        //Browser.console.log(options);
        processNextArg(options, callb);
	}
	
	function processNextArg(args:Array<String>, callb:Int->Void)
	{
		if (args.length == 0) { callb(0); return; }
		
		var arg = args.shift();
		
		if (arg.endsWith(".js") || arg.endsWith(".jsnf"))
		{
			var code = fileSystem.getContent(arg);
			
			var errorMessage = "Error loading script \"" + arg + "\".";
			var r = SafeCode.run(errorMessage, () ->
			{
				Lib.eval("(" + code + ")");
			});
			
			Timer.delayAsync(50).then(_ ->
			{
				view.movie.timeline.update();
				if (!r)
				{
					view.alerter.error(errorMessage);
					callb(1);
				}
				else
				{
					processNextArg(args, callb);
				}
			});
		}
		else
		if (arg == "-pid")
		{
			if (args.length > 0 && !args[0].startsWith("-"))
			{
				app.pid = args.shift();
				Log.logFile = folders.temp + "/logs/" + app.pid + ".log";
				Log.onMessage.bind(function(_, e) if (e.type == "error") app.quit(true, 1));
				processNextArg(args, app.quit.bind(true, _));
			}
			else
			{
				error("File path expected after '-pid' option.", callb);
			}
		}
		else
		if (arg == "-fps")
		{
			view.fpsMeter.enable();
			processNextArg(args, callb);
		}
		else
		if (arg == "-export")
		{
			if (args.length > 0 && !args[0].startsWith("-"))
			{
				var destFileName = args.shift();
				app.document.export(destFileName).then((success:Bool) ->
				{
					if (success) processNextArg(args, callb);
					else         callb(1);
				});
			}
			else
			{
				error("Output file path expected after '-export' option.", callb);
			}
		}
		else
		if (arg == "-resize-fit")
		{
			var reWH = ~/^(\d*)[xX](\d*)$/;
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
				
				processNextArg(args, callb);
			}
			else
			{
				error("Size (like '200x100') expected after '-resize-fit' option.", callb);
			}
		}
		else
		if (arg == "-publish")
		{
			app.document.publish().then(_ -> processNextArg(args, callb));
		}
		else
		if (arg == "-quit")
		{
			app.quit(true);
		}
		else
		if (arg == "-scaleMode")
		{
			if (args.length > 0)
			{
				if ([ "noScale", "fit", "fill", "stretch", "custom" ].indexOf(args[0]) >= 0)
				{
					var scaleMode = args.shift();
					app.document.properties.scaleMode = scaleMode;
					processNextArg(args, callb);
				}
				else
				{
					error("Unknow scale mode ('" + args[0] + "').", callb);
				}
			}
			else
			{
				error("Scale mode name expected after '-scaleMode' option.", callb);
			}
		}
		else
		if (arg == "-script")
		{
			if (args.length > 0)
			{
				var script = args.shift();
				js.Lib.eval("'use strict';" + script);
				processNextArg(args, callb);
			}
			else
			{
				error("JS code expected after '-script' option.", callb);
			}
		}
		else
		if (!arg.startsWith("-"))
		{
			app.openDocument(arg).then((doc:Document) ->
			{
				if (doc != null) processNextArg(args, callb);
				else             error("Error loading '" + arg + "'.", callb);
			});
		}
		else
		{
			error("Unknow command line argument: " + arg, callb);
		}
	}
	
	function error(message:String, callb:Int->Void) : Void
	{
		js.Browser.window.console.error("ERROR: " + message);
		view.alerter.error(message);
		callb(1);
	}
}