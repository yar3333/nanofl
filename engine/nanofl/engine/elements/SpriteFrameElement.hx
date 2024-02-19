package nanofl.engine.elements;

import nanofl.engine.elements.Element;
import nanofl.engine.geom.Point;
import nanofl.engine.IPathElement;
import nanofl.engine.libraryitems.SpriteItem;
import stdlib.Debug;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
#end

class SpriteFrameElement extends Element
{
	function get_type() return ElementType.spriteFrame;
	
    var sprite : SpriteItem;
	var index : Int;
	
	public function new(sprite:SpriteItem, index:Int)
	{
		super();
		
		this.sprite = sprite;
		this.index = index;
	}
	
	#if ide
	override function loadProperties(node:HtmlNodeElement, version:String) return Debug.methodNotSupported(this);
	#end
	
    override function loadPropertiesJson(obj:Dynamic, version:String) return Debug.methodNotSupported(this);
	
	#if ide
	override public function saveProperties(out:XmlBuilder) Debug.methodNotSupported(this);
    override public function savePropertiesJson(obj:Dynamic) Debug.methodNotSupported(this);
	#end
	
	public function clone() : SpriteFrameElement return Debug.methodNotSupported(this);
	
	#if ide
	override public function getState() : nanofl.ide.undo.states.ElementState return Debug.methodNotSupported(this);
	override public function setState(state:nanofl.ide.undo.states.ElementState) Debug.methodNotSupported(this);
	#end
	
	public function createDisplayObject(frameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
		var dispObj = sprite.createDisplayObject(index, null);
		updateDisplayObjectProperties(dispObj);
		return dispObj;
	}
	
	public function updateDisplayObject(dispObj:easeljs.display.DisplayObject, frameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
		updateDisplayObjectProperties(dispObj);
		sprite.updateDisplayObject(dispObj, frameIndexes);
		return dispObj;
	}
	
	override function getNearestPointsLocal(pos:Point) : Array<Point>
	{
		return [ sprite.getNearestPoint(pos) ];
	}
	
	override public function equ(element:Element) return Debug.methodNotSupported(this);
	
	override public function toString() return "SpriteFrameElement(" + sprite.namePath + ":" + index + ")";
}