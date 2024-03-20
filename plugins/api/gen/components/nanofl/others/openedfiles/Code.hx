package components.nanofl.others.openedfiles;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var active(default, null) : nanofl.ide.Document;
	var length(get, never) : Int;
	private function get_length():Int;
	function add(doc:nanofl.ide.Document):Void;
	function close(doc:nanofl.ide.Document):Void;
	function activate(id:String):Void;
	function closeAll(?force:Bool):js.lib.Promise<{ }>;
	function iterator():haxe.iterators.ArrayIterator<nanofl.ide.Document>;
	function outerHeight():Int;
	function titleChanged(doc:nanofl.ide.Document):Void;
	function resize():Void;
}