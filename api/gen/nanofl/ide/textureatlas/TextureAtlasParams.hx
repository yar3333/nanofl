package nanofl.ide.textureatlas;

extern class TextureAtlasParams {
	function new(?width:Int, ?height:Int, ?padding:Int):Void;
	var width : Int;
	var height : Int;
	var padding : Int;
	function equ(p:nanofl.ide.textureatlas.TextureAtlasParams):Bool;
	function clone():nanofl.ide.textureatlas.TextureAtlasParams;
}