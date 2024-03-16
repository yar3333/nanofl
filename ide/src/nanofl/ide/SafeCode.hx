package nanofl.ide;

import js.lib.Error;
import nanofl.engine.Log;
import nanofl.engine.Log.console;

class SafeCode
{
	public static function run(getErrorMessage:haxe.extern.EitherType<String, Void->String>, f:Void->Void, ?onError:{ message:String, stack:String }->Void, ?p:haxe.PosInfos) : Bool
	{
		try
		{
			f();
		}
		catch (e:Dynamic)
		{
			var err : { message:String, stack:String } = cast Log.toError(e);
			
			var errorMessage : String = Reflect.isFunction(getErrorMessage) ? (cast getErrorMessage)() : getErrorMessage;
			
			var stackPrefix = "";
			if (errorMessage != null && errorMessage != "")
			{
				if (err.message != null && err.message != "")
				{
					err = setMessage(err, errorMessage + "\n\t" + StringTools.replace(err.message, "\n", "\n\t"));
					stackPrefix += "\t";
				}
				else
				{
					err = setMessage(err, errorMessage);
				}
			}
			
			if (err.stack != null && err.stack != "" && stackPrefix != "")
			{
				err.stack = stackPrefix + StringTools.replace(err.stack, "\n", "\n" + stackPrefix);
			}
			
			console.error(err);
			
			if (onError != null) onError(err);
			
			return false;
		}
		
		return true;
	}
	
	static function setMessage(err:{ message:String, stack:String }, message:String) : { message:String, stack:String }
	{
		try
		{
			err.message = message;
		}
		catch (_:Dynamic)
		{
			var r = new Error(message);
			(cast r).stack = err.stack;
			return cast r;
		}
		
		return err;
	}
}