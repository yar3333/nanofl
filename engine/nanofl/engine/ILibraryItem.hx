package nanofl.engine;

import js.lib.Promise;
import nanofl.engine.Library;

interface ILibraryItem
{
	var library(default, null) : Library;
	
	var namePath : String;
	
	var type(get, never) : LibraryItemType;
	
	function getIcon() : String;
	
	function clone() : ILibraryItem;
	
	public function preload() : Promise<{}>;

    public function loadPropertiesJson(obj:Dynamic) : Void;
	
	public function setLibrary(library:Library) : Void;
	
	public function duplicate(newNamePath:String) : ILibraryItem;
	
	public function remove() : Void;
	
	public function equ(item:ILibraryItem) : Bool;
	
	public function toString() : String;
}