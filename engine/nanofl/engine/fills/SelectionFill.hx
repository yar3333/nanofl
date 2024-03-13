package nanofl.engine.fills;

import stdlib.Debug;
import easeljs.geom.Matrix2D;
import easeljs.display.Shape;
import nanofl.engine.geom.Matrix;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
using Lambda;

class SelectionFill extends BaseFill implements IFill
{
	static var pattern : Shape;
	
	var scale : Float;
	
	public function new(scale:Float)
	{
		if (pattern == null)
		{
			pattern = new Shape();
			pattern.graphics
				.beginFill("rgba(0,0,0,0.75)").rect(0, 0, 1, 1).rect(2, 2, 1, 1).endFill()
				.beginFill("rgba(255,255,255,0.75)").rect(2, 0, 1, 1).rect(0, 2, 1, 1).endFill();
			pattern.cache(0, 0, 4, 4);
		}
		
		this.scale = scale;
	}
	
	public function save(out:XmlBuilder) : Void Debug.methodNotSupported(this);
	public function saveJson() return Debug.methodNotSupported(this);
	
	public function clone() : SelectionFill return Debug.methodNotSupported(this);
	
	public function applyAlpha(alpha:Float) : Void {}
	
	public function setLibrary(library:Library) {}
	
    public function getTransformed(m:Matrix) : IFill return this;
	
	@:noapi
	public function getTyped() : TypedFill return Debug.methodNotSupported(this);
	
	public function begin(g:ShapeRender)
	{
		g.beginBitmapFill(pattern.cacheCanvas, "repeat", new Matrix2D(scale, 0, 0, scale));
	}
	
	public function equ(e:IFill) : Bool return Debug.methodNotSupported(this);
	
	public function swapInstance(oldNamePath:String, newNamePath:String) { }
	
	public function toString() return 'new SelectionFill()';
}
