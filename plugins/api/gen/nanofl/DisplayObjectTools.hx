package nanofl;

extern class DisplayObjectTools {
	static var autoHitArea : Bool;
	static function smartCache(obj:easeljs.display.DisplayObject):Void;
	static function smartUncache(obj:easeljs.display.DisplayObject):Void;
	static function getOuterBounds(obj:easeljs.display.DisplayObject, ?ignoreSelf:Bool):easeljs.geom.Rectangle;
	static function getInnerBounds(obj:easeljs.display.DisplayObject):easeljs.geom.Rectangle;
	static function callMethod(parent:easeljs.display.DisplayObject, name:String):Void;
	static function dispatchMouseEvent(parent:easeljs.display.DisplayObject, name:String, e:nanofl.MouseEvent):Void;
	static function smartHitTest(obj:easeljs.display.DisplayObject, x:Float, y:Float, ?minAlpha:Int):Bool;
	static function dump(obj:easeljs.display.DisplayObject, ?level:Int):Void;
}