package wquery;

extern class Component {
	var page(default, null) : wquery.Component;
	var parent(default, null) : wquery.Component;
	var id(default, null) : String;
	var fullID(default, null) : String;
	var prefixID(default, null) : String;
	var children(default, null) : Dynamic<wquery.Component>;
	function remove():Void;
	static function create<T:(wquery.Component)>(klass:Class<T>, parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):T;
}