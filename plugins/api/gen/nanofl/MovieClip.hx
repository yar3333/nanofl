package nanofl;

extern class MovieClip extends easeljs.display.Container implements nanofl.engine.AdvancableDisplayObject implements nanofl.engine.InstanceDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.MovieClipItem, params:nanofl.MovieClip.MovieClipParams):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.MovieClipItem;
	var currentFrame(default, null) : Int;
	var paused : Bool;
	var loop : Bool;
	function addChildToLayer(child:easeljs.display.DisplayObject, layerIndex:Int, ?beforeChild:easeljs.display.DisplayObject):easeljs.display.DisplayObject;
	override function removeAllChildren():Void;
	override function removeChild(child:easeljs.display.DisplayObject):Bool;
	override function removeChildAt(index:Int):Bool;
	function replaceChild(oldChild:easeljs.display.DisplayObject, newChild:easeljs.display.DisplayObject):Void;
	function play():Void;
	function stop():Void;
	function gotoAndStop(labelOrIndex:Dynamic):Void;
	function gotoAndPlay(labelOrIndex:Dynamic):Void;
	function getTotalFrames():Int;
	function getChildrenByLayerIndex(layerIndex:Int):Array<easeljs.display.DisplayObject>;
	function gotoFrame(labelOrIndex:Dynamic):nanofl.engine.MovieClipGotoHelper;
	function advanceToNextFrame():Void;
	function advanceTo(lifetimeOnParent:Int, framerate:Float):Void;
	function getChildByElement(elem:nanofl.engine.elements.Element):easeljs.display.DisplayObject;
	override function clone(?recursive:Bool):nanofl.MovieClip;
	override function toString():String;
}

typedef MovieClipParams = {
	@:optional
	var currentFrame : Int;
};