package nanofl.engine.strokes;

import nanofl.engine.geom.Matrix;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

abstract class BaseStroke
{
	public var thickness : Float;
	
	/**
	 *  butt, round, or square. Easeljs's default is butt.
	 */
	public var caps : String;
	
	/**
	 * bevel, round, or miter. Easeljs's default is miter.
	 */
	public var joints : String;
	
	/**
	 * Miter limit ratio which controls at what point a mitered joint will be clipped. Easeljs's default is 10.
	 */
	public var miterLimit : Float;
	
	public var ignoreScale : Bool;
	
	function new(thickness=1.0, caps="round", joints="round", miterLimit=3.0, ignoreScale=false)
	{
		this.thickness = thickness;
		this.caps = caps;
		this.joints = joints;
		this.miterLimit = miterLimit;
		this.ignoreScale = ignoreScale;
	}
	
    #if ide
	public static function load(node:HtmlNodeElement, version:String) : IStroke
	{
		var r : BaseStroke;
		switch (node.getAttr("type"))
		{
			case "solid":	r = new SolidStroke();
			case "linear":	r = new LinearStroke([], [], 0, 0, 0, 0);
			case "radial":	r = new RadialStroke([], [], 0, 0, 0, 0, 0);
			case "bitmap":	r = new BitmapStroke();
			case _: throw "Unknow stroke type '" + node.getAttr("type") + "'.";
		}
		r.loadProperties(node);
		return cast r;
	}
    #end
	
	public static function loadJson(obj:{ type:String }, version:String) : IStroke
	{
		var r : BaseStroke;
		switch (obj.type)
		{
			case "solid":	r = new SolidStroke();
			case "linear":	r = new LinearStroke([], [], 0, 0, 0, 0);
			case "radial":	r = new RadialStroke([], [], 0, 0, 0, 0, 0);
			case "bitmap":	r = new BitmapStroke();
			case _: throw "Unknow stroke type '" + obj.type + "'.";
		}
		r.loadPropertiesJson(obj);
		return cast r;
	}

    @:noapi abstract function getTyped() : TypedStroke;

    #if ide
    public final function save(out:XmlBuilder)
    {
        out.begin("stroke").attr("type", getTyped().getName());
        saveProperties(out);
        out.end();
    }

    public final function saveJson() : { type:String }
    {
        var obj = { type:getTyped().getName() };
        savePropertiesJson(obj);
        return obj;
    }
	
	abstract function loadProperties(node:HtmlNodeElement) : Void;
	function loadBaseProperties(node:HtmlNodeElement) : Void
	{
		thickness = node.getAttr("thickness", 1.0);
		caps = node.getAttr("caps", "round");
		joints = node.getAttr("joints", "round");
		miterLimit = node.getAttr("miterLimit", 3.0);
		ignoreScale = node.getAttr("ignoreScale", false);
	}
    #end
	
	abstract function loadPropertiesJson(obj:Dynamic) : Void;
	function loadBasePropertiesJson(obj:Dynamic) : Void
	{
		thickness = obj.thickness ?? 1.0;
		caps = obj.caps ?? "round";
		joints = obj.joints ?? "round";
		miterLimit = obj.miterLimit ?? 3.0;
		ignoreScale = obj.ignoreScale ?? false;
	}
	
    #if ide
	abstract function saveProperties(out:XmlBuilder) : Void;
	function saveBaseProperties(out:XmlBuilder) : Void
	{
		out.attr("thickness", thickness, 1.0);
		out.attr("caps", caps, "round");
		out.attr("joints", joints, "round");
		out.attr("miterLimit", miterLimit, 3.0);
		out.attr("ignoreScale", ignoreScale, false);
	}

	abstract function savePropertiesJson(obj:Dynamic) : Void;
	function saveBasePropertiesJson(obj:Dynamic) : Void
	{
		obj.thickness = thickness ?? 1.0;
		obj.caps = caps ?? "round";
		obj.joints = joints ?? "round";
		obj.miterLimit = miterLimit ?? 3.0;
		obj.ignoreScale = ignoreScale ?? false;
	}
    #end
	
	function setStrokeStyle(g:ShapeRender) : Void
	{
		g.setStrokeStyle(thickness, caps, joints, miterLimit, ignoreScale);
	}
	
	public function clone() : IStroke
	{
		throw "Cloning of " + Type.getClassName(Type.getClass(this)) + " is not supported.";
		return null;
	}
	
	public function equ(e:IStroke) : Bool
	{
		var ee : BaseStroke = cast e;
		return ee.thickness == thickness
			&& ee.caps == caps
			&& ee.joints == joints
			&& ee.miterLimit == miterLimit
			&& ee.ignoreScale == ignoreScale;
	}
	
	public function setLibrary(library:Library) { }
	
	public function getTransformed(m:Matrix, applyToThickness:Bool) : IStroke
	{
		var r = clone();
		if (applyToThickness) r.thickness *= m.getAverageScale();
		return r;
	}
}