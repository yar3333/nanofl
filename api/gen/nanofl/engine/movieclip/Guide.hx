package nanofl.engine.movieclip;

extern class Guide {
	function new(?guideLine:nanofl.engine.movieclip.GuideLine):Void;
	function get(startProps:{ var rotation : Float; var x : Float; var y : Float; }, finishProps:{ var rotation : Float; var x : Float; var y : Float; }, orientToPath:Bool, t:Float):{ var rotation : Float; var x : Float; var y : Float; };
}