package nanofl.ide.textureatlas;

extern class Rectangle {
	function new(x:Int, y:Int, width:Int, height:Int):Void;
	var x : Int;
	var y : Int;
	var width : Int;
	var height : Int;
	function intersects(b:nanofl.ide.textureatlas.Rectangle):Bool;
	function contains(b:nanofl.ide.textureatlas.Rectangle):Bool;
	function clone():nanofl.ide.textureatlas.Rectangle;
	function splits(b:nanofl.ide.textureatlas.Rectangle):Array<nanofl.ide.textureatlas.Rectangle>;
	function inflate(v:Int):Void;
	function deflate(v:Int):Void;
	function toString():String;
	var left(get, set) : Int;
	var top(get, set) : Int;
	var right(get, set) : Int;
	var bottom(get, set) : Int;
	var empty(get, never) : Bool;
}