package nanofl.ide.preferences;

extern class PreferencesStorage extends nanofl.ide.InjectContainer {
	function new():Void;
	function set(key:String, value:Dynamic):Dynamic;
	function getString(key:String, ?defValue:String):String;
	function getInt(key:String, ?defValue:Int):Int;
	function getFloat(key:String, ?defValue:Float):Float;
	function getBool(key:String, ?defValue:Bool):Bool;
	function getObject(key:String, ?defValue:Dynamic):Dynamic;
	function applyToIDE(?atStartup:Bool):Void;
	function getMenu(pathID:String):Array<nanofl.ide.ui.menu.MenuItem>;
}