package nanofl.engine.strokes;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import nanofl.engine.Library;
import nanofl.engine.libraryitems.BitmapItem;
using htmlparser.HtmlParserTools;
using Lambda;

class BitmapStroke extends BaseStroke implements IStroke
{
	var library : Library;
	
	public var bitmapPath : String;
	public var repeat : String;

	public function new(?bitmapPath:String, repeat="repeat", thickness=1.0, caps="round", joints="round", miterLimit=3.0, ignoreScale=false)
	{
		super(thickness, caps, joints, miterLimit, ignoreScale);
		this.bitmapPath = bitmapPath;
		this.repeat = repeat;
	}
	
	function loadProperties(node:HtmlNodeElement) : Void
	{
		loadBaseProperties(node);
		bitmapPath = node.getAttr("bitmapPath");
		repeat = node.getAttr("repeat");
	}

	function loadPropertiesJson(obj:Dynamic) : Void
	{
		loadBasePropertiesJson(obj);
		bitmapPath = obj.bitmapPath;
		repeat = obj.repeat;
	}
	
	function saveProperties(out:XmlBuilder) 
	{
		out.attr("bitmapPath", bitmapPath);
		out.attr("repeat", repeat, "repeat");
		saveBaseProperties(out);
	}
	
	function savePropertiesJson(obj:Dynamic) 
	{
		obj.bitmapPath = bitmapPath;
		obj.repeat = repeat ?? "repeat";
		saveBasePropertiesJson(obj);
	}
	
	public function begin(g:ShapeRender) : Void
	{
		if (library.hasItem(bitmapPath))
		{
			var image = cast(library.getItem(bitmapPath), BitmapItem).image;
			g.beginBitmapStroke(image, repeat);
			setStrokeStyle(g);
		}
		else
		{
			g.beginStroke("rgba(0,0,0,0)");
		}
	}
	
	override public function clone() : BitmapStroke
	{
		var obj = new BitmapStroke(bitmapPath, repeat, thickness, caps, joints, miterLimit, ignoreScale);
		obj.library = library;
		return obj;
	}
	
	override public function equ(e:IStroke) : Bool
	{
		if (e == this) return true;
		if (!Std.isOfType(e, BitmapStroke) || !super.equ(e)) return false;
		var ee : BitmapStroke = cast e;
		return ee.bitmapPath == bitmapPath && ee.repeat == repeat;
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String)
	{
		if (bitmapPath == oldNamePath) bitmapPath = newNamePath;
	}
	
	override public function setLibrary(library:Library) this.library = library;
	
	public function applyAlpha(alpha:Float) : Void
	{
		// TODO: unsupported by EaselJS
	}
	
	@:noapi public function getTyped() return TypedStroke.bitmap(this);
	
	public function toString()
	{
		return 'new BitmapStroke("$bitmapPath")';
	}
}