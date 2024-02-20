package nanofl.ide;

extern class DocumentProperties extends nanofl.ide.InjectContainer {
	function new(?title:String, ?width:Int, ?height:Int, ?backgroundColor:String, ?framerate:Float, ?scaleMode:String, ?publishSettings:nanofl.ide.PublishSettings):Void;
	var title : String;
	var width : Int;
	var height : Int;
	var backgroundColor : String;
	var framerate : Float;
	var scaleMode : String;
	var publishSettings : nanofl.ide.PublishSettings;
	function save(filePath:String):Void;
	function equ(p:nanofl.ide.DocumentProperties):Bool;
	function clone():nanofl.ide.DocumentProperties;
	static function load(filePath:String, fileSystem:nanofl.ide.sys.FileSystem):nanofl.ide.DocumentProperties;
}