package nanofl.ide.textureatlas;

extern class TextureAtlasGenerator {
	function new(?width:Int, ?height:Int, ?padding:Int, ?packingMethod:nanofl.ide.textureatlas.PackingMethod, ?sortingMethods:Array<nanofl.ide.textureatlas.SortingMethod>, ?rotateMethod:nanofl.ide.textureatlas.RotateMethod):Void;
	var width(default, null) : Int;
	var height(default, null) : Int;
	var method(default, null) : nanofl.ide.textureatlas.PackingMethod;
	var sorter(default, null) : Array<(nanofl.ide.textureatlas.ImageData, nanofl.ide.textureatlas.ImageData) -> Int>;
	var rotate(default, null) : nanofl.ide.textureatlas.RotateMethod;
	var padding(default, null) : Int;
	function generate(items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>):nanofl.ide.textureatlas.TextureAtlas;
	function toString():String;
}