package nanofl.engine.strokes;

import js.lib.Error;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class SolidStroke extends BaseStroke implements IStroke
{
	public var color : String;
	
	public function new(color="black", thickness=1.0, caps="round", joints="round", miterLimit=3.0, ignoreScale=false)
	{
		super(thickness, caps, joints, miterLimit, ignoreScale);
		this.color = color;
	}
	
    #if ide
	function loadProperties(node:HtmlNodeElement) : Void
	{
		loadBaseProperties(node);
		color = node.getAttr("color", "#000000");
	}
    #end

	function loadPropertiesJson(obj:Dynamic) : Void
	{
		loadBasePropertiesJson(obj);
		color = obj.color ?? "#000000";
	}
    
    #if ide
	function saveProperties(out:XmlBuilder) 
	{
		out.attr("color", color);
		saveBaseProperties(out);
	}
        
	function savePropertiesJson(obj:Dynamic) 
	{
		obj.color = color;
		saveBasePropertiesJson(obj);
	}
    #end
	
	public function begin(g:ShapeRender) : Void
	{
		g.beginStroke(color);
		setStrokeStyle(g);
	}
	
	override public function clone() : SolidStroke
	{
		return new SolidStroke(color, thickness, caps, joints, miterLimit, ignoreScale);
	}
	
	override public function equ(e:IStroke) : Bool
	{
		if (e == this) return true;
		if (!Std.isOfType(e, SolidStroke) || !super.equ(e)) return false;
		var ee : SolidStroke = cast e;
		return ee.color == color;
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String) { }
	
	public function applyAlpha(alpha:Float) : Void
	{
		var rgba = ColorTools.parse(color);
		if (rgba == null) throw new Error("Can't parse color '" + color + "'.");
		rgba.a *= alpha;
		color = ColorTools.rgbaToString(rgba);
	}
	
	@:noapi public function getTyped() return TypedStroke.solid(this);
	
	public function toString()
	{
		return 'new SolidStroke("$color")';
	}
}