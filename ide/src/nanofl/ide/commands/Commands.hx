package nanofl.ide.commands;

import nanofl.engine.Log.console;

@:rtti
class Commands
{
	var _application : ApplicationGroup;
	public var application(get, never) : ApplicationGroup;
	function get_application() return _application ?? (_application = new ApplicationGroup());
	
	var _document : DocumentGroup;
	public var document(get, never) : DocumentGroup;
	function get_document() return _document ?? (_document = new DocumentGroup());
	
	var _editor : EditorGroup;
	public var editor(get, never) : EditorGroup;
	function get_editor() return _editor ?? (_editor = new EditorGroup());
	
	var _library : LibraryGroup;
	public var library(get, never) : LibraryGroup;
	function get_library() return _library ?? (_library = new LibraryGroup());
	
	var _timeline : TimelineGroup;
	public var timeline(get, never) : TimelineGroup;
	function get_timeline() return _timeline ?? (_timeline = new TimelineGroup());
	
	var _clipboard : ClipboardGroup;
	public var clipboard(get, never) : ClipboardGroup;
	function get_clipboard() return _clipboard ?? (_clipboard = new ClipboardGroup());
	
	public function new()
	{
	}
	
	public function validateCommand(command:String)
	{
        final groupAndMethod = command.split(".");
		
        if (groupAndMethod.length != 2)
		{
			console.warn("Bad command '" + command + "': expected format 'group.method'.");
            return;
		}

		if (!Reflect.isFunction(Reflect.field(this, "get_" + groupAndMethod[0])))
		{
			console.warn("Bad command '" + command + "': unknow group.");
            return;
		}

        final group = Reflect.callMethod(this, Reflect.field(this, "get_" + groupAndMethod[0]), []);
		
        if (!Reflect.isFunction(Reflect.field(group, groupAndMethod[1])))
		{
			console.warn("Bad command '" + command + "': command not found.");
            return;
		}
	}
	
	public function run(command:String, ?params:Array<Dynamic>) : Bool
	{
		validateCommand(command);

        log("run: " + command);
		
		final groupAndMethod = command.split(".");
		
		final group = Reflect.callMethod(this, Reflect.field(this, "get_" + groupAndMethod[0]), []);
		if (group == null) return false;
		
		var method = Reflect.field(group, groupAndMethod[1]);
		if (method == null) method = Reflect.field(group, groupAndMethod[1] + "_");
		if (method == null) return false;
		
		Reflect.callMethod(group, method, params);
		
		return true;
	}

	static function log(v:Dynamic)
	{
		nanofl.engine.Log.console.namedLog("Commands", v);
	}
}
