package nanofl.engine.strokes;

import htmlparser.HtmlNodeElement;
import stdlib.Debug;
import htmlparser.XmlBuilder;

class SelectionStroke extends BaseStroke implements IStroke
{
	static var pattern : easeljs.display.Shape;
	
	public function new(base:IStroke, scale:Float)
	{
		if (pattern == null)
		{
			pattern = new easeljs.display.Shape();
			pattern.graphics
				.beginFill("rgba(0,0,0,0.75)").rect(0, 0, 2, 2).rect(2, 2, 2, 2).endFill()
				.beginFill("rgba(255,255,255,0.75)").rect(2, 0, 2, 2).rect(0, 2, 2, 2).endFill();
			pattern.cache(0, 0, 4, 4);
		}
		
		super(Math.max(4, base.ignoreScale ? base.thickness : base.thickness / scale), base.caps, base.joints, base.miterLimit, true);
	}
	
	public function begin(g:ShapeRender) : Void
	{
		g.beginBitmapStroke(pattern.cacheCanvas, "repeat");
		setStrokeStyle(g);
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String) { }
	
	public function applyAlpha(alpha:Float) : Void { }
	
	@:noapi public function getTyped() return null;
	
	public function toString() return 'new SelectionStroke()';

    function loadProperties(node:HtmlNodeElement) Debug.methodNotSupported(this);

    function loadPropertiesJson(obj:Dynamic) Debug.methodNotSupported(this);

    function saveProperties(out:XmlBuilder) Debug.methodNotSupported(this);

    function savePropertiesJson(obj:Dynamic) Debug.methodNotSupported(this);
}
