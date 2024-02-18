package nanofl.ide.libraryitems;

import js.lib.Promise;
import nanofl.engine.IPathElement;
import htmlparser.HtmlNodeElement;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import stdlib.Debug;

class SpriteItem extends nanofl.engine.libraryitems.SpriteItem
	implements IIdeInstancableItem
{
	override public function save(fileSystem:nanofl.ide.sys.FileSystem) : Void {}
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : SpriteItem
	{
		if (itemNode.name != "sprite") return null;
		
		//var version = itemNode.getAttribute("version");
		//if (version == null || version == "") version = "1.0.0";
		
		var r = new SpriteItem(namePath, []);
		r.loadProperties(itemNode);
		return r;
	}
	
	override public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
		
		return ensureSpriteSheet();
	}
	
	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
		Debug.assert(spriteSheet != null);
		Debug.assert(spriteSheet.complete);
		var sprite = new easeljs.display.Sprite(spriteSheet);
		sprite.gotoAndStop(initFrameIndex);
		return sprite;
	}
	
	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String) : IIdeLibraryItem
	{
		return null;
	}
	
	public function getUsedSymbolNamePaths() return Debug.methodNotSupported(this);
	
	public function getFilePathToRunWithEditor() : String return null;
	
	public function getLibraryFilePaths() : Array<String> return [];
}