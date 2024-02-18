package nanofl.ide;

import stdlib.ExceptionTools;

class AsyncQueue
{
	var operations : Array<{ label:String, f:(Void->Void)->Void }> = [];
	
	public var running(default, null) = false;
	
	public function new() {}
	
	public function add(label:String, f:(Void->Void)->Void)
	{
		log("AsyncQueue.add " + label);
		operations.push({ label:label, f:f });
		if (!running) run();
	}
	
	function run()
	{
		log("AsyncQueue.run operations.length = " + operations.length);
		if (operations.length > 0)
		{
			running = true;
			var op = operations.shift();
			try
			{
				log("AsyncQueue.run =====> " + op.label);
				op.f(run);
				log("AsyncQueue.run ^^^^^^ " + op.label);
			}
			catch (e:Dynamic)
			{
				trace("EXCEPTION: " + ExceptionTools.string(e));
				run();
			}
		}
		else
		{
			running = false;
		}
	}
	
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}