package nanofl.ide.textureatlas;

extern class Packed<T> {
	function new(rect:nanofl.ide.textureatlas.TRect, data:T, ?rotated:Bool):Void;
	var rect(default, null) : nanofl.ide.textureatlas.TRect;
	var data(default, null) : T;
	var rotated(default, null) : Bool;
}