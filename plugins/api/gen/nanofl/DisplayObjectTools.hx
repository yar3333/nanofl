package nanofl;

extern class DisplayObjectTools {
	static var autoHitArea : Bool;
	static function getOuterBounds(obj:easeljs.display.DisplayObject, ?ignoreSelf:Bool):easeljs.geom.Rectangle;
	static function getInnerBounds(obj:easeljs.display.DisplayObject):easeljs.geom.Rectangle;
	static function iterateTreeFromBottomToTop(parent:easeljs.display.DisplayObject, visibleOnly:Bool, callb:easeljs.display.DisplayObject -> Void):Void;
	static function callMethod(parent:easeljs.display.DisplayObject, name:String):Void;
	static function dispatchMouseEvent(parent:easeljs.display.DisplayObject, name:String, e:nanofl.MouseEvent):Void;
	static function smartHitTest(obj:easeljs.display.DisplayObject, x:Float, y:Float, ?minAlpha:Int):Bool;
	static function dump(obj:easeljs.display.DisplayObject, ?level:Int):Void;
	static function recache(dispObj:easeljs.display.DisplayObject, ?force:Bool):Bool;
	static function cache(dispObj:easeljs.display.DisplayObject, ?bounds:easeljs.geom.Rectangle):Void;
}