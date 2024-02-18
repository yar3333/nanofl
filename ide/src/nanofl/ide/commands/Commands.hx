package nanofl.ide.commands;

@:rtti
class Commands
{
	var _application : ApplicationGroup;
	public var application(get, never) : ApplicationGroup;
	function get_application() return _application != null ? _application : (_application = new ApplicationGroup());
	
	var _document : DocumentGroup;
	public var document(get, never) : DocumentGroup;
	function get_document() return _document != null ? _document : (_document = new DocumentGroup());
	
	var _editor : EditorGroup;
	public var editor(get, never) : EditorGroup;
	function get_editor() return _editor != null ? _editor : (_editor = new EditorGroup());
	
	var _library : LibraryGroup;
	public var library(get, never) : LibraryGroup;
	function get_library() return _library != null ? _library : (_library = new LibraryGroup());
	
	var _timeline : TimelineGroup;
	public var timeline(get, never) : TimelineGroup;
	function get_timeline() return _timeline != null ? _timeline : (_timeline = new TimelineGroup());
	
	var _output : OutputGroup;
	public var output(get, never) : OutputGroup;
	function get_output() return _output != null ? _output : (_output = new OutputGroup());
	
	var _openedFile : OpenedFileGroup;
	public var openedFile(get, never) : OpenedFileGroup;
	function get_openedFile() return _openedFile != null ? _openedFile : (_openedFile = new OpenedFileGroup());
	
	var _code : CodeGroup;
	public var code(get, never) : CodeGroup;
	function get_code() return _code != null ? _code : (_code = new CodeGroup());
	
	public function new()
	{
	}
	
	public function validateCommand(command:String)
	{
		if (command.split(".").length != 2)
		{
			trace("Bad command '" + command + "': expected format 'group.method'.");
		}
		else
		if (!Reflect.isFunction(Reflect.field(this, "get_" + command.split(".")[0])))
		{
			trace("Bad command '" + command + "': unknow group.");
		}
		/*else
		if (
			!Reflect.isFunction(Reflect.field(Reflect.field(this, "get_" + command.split(".")[0])(), command.split(".")[1]))
		 && !Reflect.isFunction(Reflect.field(Reflect.field(this, "get_" + command.split(".")[0])(), command.split(".")[1] + "_"))
		)
		{
			trace("Bad command '" + command + "': unknow method.");
		}*/
	}
	
	public function run(command:String, ?params:Array<Dynamic>) : Bool
	{
		validateCommand(command);
		
		var groupAndMethod = command.split(".");
		
		var group = Reflect.callMethod(this, Reflect.field(this, "get_" + groupAndMethod[0]), []);
		if (group == null) return false;
		
		var method = Reflect.field(group, groupAndMethod[1]);
		if (method == null) method = Reflect.field(group, groupAndMethod[1] + "_");
		if (method == null) return false;
		
		Reflect.callMethod(group, method, params);
		
		return true;
	}
}
