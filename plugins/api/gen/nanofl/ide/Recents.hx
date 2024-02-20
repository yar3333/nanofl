package nanofl.ide;

extern class Recents extends nanofl.ide.InjectContainer {
	function new():Void;
	function add(path:String, view:nanofl.ide.ui.View):Void;
	function getAsMenuItems(prefixID:String, ?options:{ @:optional
	public var lengthLimit(default, default) : Int; @:optional
	public var countLimit(default, default) : Int; @:optional
	public var addEmptyIfNoRecents(default, default) : Bool; }):htmlparser.XmlDocument;
}