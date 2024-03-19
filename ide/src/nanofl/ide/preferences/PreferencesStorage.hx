package nanofl.ide.preferences;

import nanofl.ide.keyboard.KeymapItem;
import haxe.Json;
import js.Browser;
import stdlib.Serializer;
import stdlib.Std;
import stdlib.Unserializer;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.ui.menu.MenuItem;
using stdlib.Lambda;

@:rtti
class PreferencesStorage extends InjectContainer
{
	var defaults : Map<String, Dynamic> =
	[
		"application.checkNewVersionPeriod" => "start",
		"application.defaultGeneratorName" =>  "CreateJS",
		"application.defaultGeneratorParams" => { mode:"HTML", urlOnClick:"" }
	];
	
	@inject var fileSystem : FileSystem;
	@inject var keyboard : Keyboard;
	@inject var folders : Folders;
	
	public function set(key:String, value:Dynamic) : Dynamic
	{
		if (Std.isOfType(value, String) || Std.isOfType(value, Float) || Std.isOfType(value, Bool))
		{
			setValue(key, Std.string(value));
		}
		else
		{
			setValue(key, Serializer.run(value, true));
		}
		return value;
	}
	
	public function getString(key:String, ?defValue:String) : String
	{
		var r = getValue(key);
		return r != null ? r : getDefaultValue(key, defValue);
	}
	
	public function getInt(key:String, ?defValue:Int) : Int
	{
		var r = getValue(key);
		return r != null ? Std.parseInt(r) : getDefaultValue(key, defValue);
	}
	
	public function getFloat(key:String, ?defValue:Float) : Float
	{
		var r = getValue(key);
		return r != null ? Std.parseFloat(r) : getDefaultValue(key, defValue);
	}
	
	public function getBool(key:String, ?defValue:Bool) : Bool
	{
		var r = getValue(key);
		return r != null ? Std.bool(r) : getDefaultValue(key, defValue);
	}
	
	public function getObject(key:String, ?defValue:Dynamic) : Dynamic
	{
		var r = getValue(key);
		return r != null ? Unserializer.run(r) : getDefaultValue(key, defValue);
	}
	
	function setValue(key:String, value:String) : Void
	{
		Browser.window.localStorage.setItem(key, value);
	}
	
	function getValue(key:String) : String
	{
		return Browser.window.localStorage.getItem(key);
	}
	
	function getDefaultValue(key:String, defValue:Dynamic) : Dynamic
	{
		return defValue != null ? defValue : defaults.get(key);
	}
	
	public function applyToIDE(?atStartup:Bool) 
	{
		if (atStartup)
		{
			keyboard.setKeymap(getKeymap("keymap"));
		}
	}
	
	function getKeymap(pathID:String) : Array<KeymapItem> return getFromFile(pathID);
	
	public function getMenu(pathID:String) : Array<MenuItem> return getFromFile(pathID);
	
	function getFromFile(pathID:String) : Dynamic
	{
		return Json.parse(fileSystem.getContent(folders.application + "/preferences/" + pathID + ".json"));
	}
}
