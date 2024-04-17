package nanofl.ide.editor;

import easeljs.display.Shape;
import nanofl.engine.geom.Point;
using nanofl.engine.geom.PointTools;

class MagnetMark
{
	public var pos : Point;
	
	public function new() {}
	
	public function show(pos:Point)
	{
		if (this.pos == null || !pos.equ(this.pos))
		{
			this.pos = pos;
			log("MagnetMark.show OK");
		}
	}
	
	public function hide()
	{
		if (pos != null)
		{
			pos = null;
			log("MagnetMark.hide");
		}
	}
	
	public function draw(shape:Shape)
	{
		if (pos == null) return;
		
		var scale = shape.localToGlobal(1, 0).x - shape.localToGlobal(0, 0).x;
		
		var g = shape.graphics;
		g.beginStroke("#000000");
		g.setStrokeStyle(1, null, null, null, true);
		g.drawCircle(pos.x, pos.y, 5 / scale);
		g.endStroke();
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}