package nanofl;

extern class MovieClip extends easeljs.display.Container implements nanofl.engine.AdvancableDisplayObject implements nanofl.engine.InstanceDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.MovieClipItem, initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.MovieClipItem;
	var currentFrame(default, null) : Int;
	var paused : Bool;
	var loop : Bool;
	function addChildToLayer(child:easeljs.display.DisplayObject, layerIndex:Int):easeljs.display.DisplayObject;
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
	/**
		
			 * Return keeped children MovieClips. Return null if all children are keeped.
			 
	**/
	function gotoFrame(labelOrIndex:Dynamic):nanofl.engine.MovieClipGotoHelper;
	function advance(?time:Float):Void;
	override function clone(?recursive:Bool):nanofl.MovieClip;
	override function toString():String;
}