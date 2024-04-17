package nanofl.engine.fills;

import nanofl.engine.geom.Matrix;
import nanofl.engine.Library;
import nanofl.engine.libraryitems.BitmapItem;
using Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class BitmapFill extends BaseFill implements IFill
{
	var library : Library;
	
	public var bitmapPath : String;
	public var repeat : String;
	public var matrix : Matrix;

	public function new(bitmapPath:String, repeat:String, matrix:Matrix)
	{
		this.bitmapPath = bitmapPath;
		this.repeat = repeat;
		this.matrix = matrix;
	}
	
	#if ide
    public static function load(node:HtmlNodeElement, version:String)
	{
		return new BitmapFill
		(
			node.getAttr("bitmapPath"),
			node.getAttr("repeat", "repeat"),
			Matrix.load(node)
		);
	}
    #end
	
	public static function loadJson(obj:Dynamic, version:String) : BitmapFill
	{
		return new BitmapFill
		(
			obj.bitmapPath,
			obj.repeat ?? "repeat",
			Matrix.loadJson(obj)
		);
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
		out.begin("fill").attr("type", "bitmap");
		out.attr("bitmapPath", bitmapPath);
		out.attr("repeat", repeat, "repeat");
		matrix.save(out);
		out.end();
	}
	
	public function saveJson()
	{
        var r =
        {
            type: "bitmap",
            bitmapPath: bitmapPath,
            repeat: repeat,
        };
        matrix.saveJson(r);
        return r;
	}
    #end
	
	public function clone() : BitmapFill
	{
		var r = new BitmapFill(bitmapPath, repeat, matrix.clone());
		r.library = library;
		return r;
	}
	
	public function applyAlpha(alpha:Float) : Void
	{
		// TODO: unsupported by EaselJS
	}
	
	@:noapi
	public function getTyped() return TypedFill.bitmap(this);
	
	public function begin(g:ShapeRender)
	{
		if (library.hasItem(bitmapPath))
		{
			var image = cast(library.getItem(bitmapPath), BitmapItem).image;
			g.beginBitmapFill(image, repeat, matrix.toNative());
		}
		else
		{
			g.beginFill("rgba(0,0,0,0)");
		}
	}
	
	public function getBitmapWidth()
	{
        if (bitmapPath == null || !library.hasItem(bitmapPath)) return 1.0;
		var item : BitmapItem = cast library.getItem(bitmapPath);
		if (item == null || !Std.isOfType(item, BitmapItem)) return 1.0;
		return item.image.width;
	}
	
	public function equ(e:IFill) : Bool
	{
		if (e == this) return true;
		if (Std.isOfType(e, BitmapFill))
		{
			var ee : BitmapFill = cast e;
			return ee.bitmapPath == bitmapPath && ee.matrix.equ(matrix) && ee.repeat == repeat;
		}
		return false;
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String)
	{
		if (bitmapPath == oldNamePath) bitmapPath = newNamePath;
	}
	
	public function setLibrary(library:Library) this.library = library;
	
	public function getTransformed(m:Matrix) : IFill
	{
		var r = clone();
		r.matrix.prependMatrix(m);
		return r;
	}
	
	public function toString() : String
	{
		return 'new BitmapFill("' + bitmapPath + '")';
	}
}