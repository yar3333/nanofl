package nanofl.ide.sys;

@:rtti interface WebServerUtils {
	/**
		
		        Start a web server process.
		        Several web servers can be started simultaneously.
		        Returns `uid`.
		    
	**/
	function start(directoryToServe:String):Int;
	/**
		
		        Returns: URL like "http://127.0.0.1:9990".
		    
	**/
	function getAddress(uid:Int):String;
	/**
		
		        Kill specified web server process.
		    
	**/
	function kill(uid:Int):Void;
}