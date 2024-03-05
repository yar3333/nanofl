package nanofl.engine;

interface AdvancableDisplayObject {
	/**
		
		        `time` is ignored.
		    
	**/
	function advance(?time:Float):Void;
}