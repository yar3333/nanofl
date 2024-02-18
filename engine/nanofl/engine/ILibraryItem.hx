package nanofl.engine;

import js.lib.Promise;
import nanofl.engine.Library;

interface ILibraryItem
{
	@jsonIgnore
	var library(default, null) : Library;
	
	//@:allow(nanofl.engine.Library.renameItemInner)
	//@:allow(nanofl.engine.Library.setState)
	//var namePath(default, null) : String;
	var namePath : String;
	
	var type(get, never) : LibraryItemType;
	
	function getIcon() : String;
	
	function clone() : ILibraryItem;
	
	public function preload() : Promise<{}>;

    public function loadPropertiesJson(obj:Dynamic) : Void;
	
	//@:allow(nanofl.engine.Library)
	public function setLibrary(library:Library) : Void;
	
	public function duplicate(newNamePath:String) : ILibraryItem;
	
	public function remove() : Void;
	
	public function equ(item:ILibraryItem) : Bool;
	
	public function toString() : String;
}