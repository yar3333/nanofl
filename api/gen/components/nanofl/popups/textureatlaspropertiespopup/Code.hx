package components.nanofl.popups.textureatlaspropertiespopup;

extern class Code extends components.nanofl.popups.basepopup.Code {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function show(name:String, params:nanofl.ide.textureatlas.TextureAtlasParams, success:({ public var params(default, default) : nanofl.ide.textureatlas.TextureAtlasParams; public var name(default, default) : String; }) -> Void):Void;
}