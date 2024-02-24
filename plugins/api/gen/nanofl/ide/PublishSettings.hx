package nanofl.ide;

extern class PublishSettings {
	function new(?useTextureAtlases:Bool, ?textureAtlases:Map<String, nanofl.ide.textureatlas.TextureAtlasParams>, ?isConvertImagesIntoJpeg:Bool, ?jpegQuality:Int, ?audioQuality:Int, ?urlOnClick:String, ?useLocalScripts:Bool):Void;
	var useTextureAtlases : Bool;
	var textureAtlases : Map<String, nanofl.ide.textureatlas.TextureAtlasParams>;
	var isConvertImagesIntoJpeg : Bool;
	var jpegQuality : Int;
	var audioQuality : Int;
	var urlOnClick : String;
	var useLocalScripts : Bool;
	function equ(p:nanofl.ide.PublishSettings):Bool;
	function clone():nanofl.ide.PublishSettings;
	function save(out:htmlparser.XmlBuilder):Void;
	static function load(xml:htmlparser.HtmlNodeElement):nanofl.ide.PublishSettings;
}