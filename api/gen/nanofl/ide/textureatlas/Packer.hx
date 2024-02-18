package nanofl.ide.textureatlas;

extern class Packer<T> {
	function new(width:Int, height:Int, padding:Int, method:nanofl.ide.textureatlas.PackingMethod, rotate:nanofl.ide.textureatlas.RotateMethod):Void;
	var width(default, null) : Int;
	var height(default, null) : Int;
	var padding(default, null) : Int;
	var method(default, null) : nanofl.ide.textureatlas.PackingMethod;
	var rotate(default, null) : nanofl.ide.textureatlas.RotateMethod;
	var length(get, never) : Int;
	function get(index:Int):nanofl.ide.textureatlas.Packed<T>;
	function add(width:Int, height:Int, ?data:T):Bool;
	function iterator():Iterator<nanofl.ide.textureatlas.Packed<T>>;
}