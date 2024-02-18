package nanofl.engine;

extern class GroupKeyFrame extends nanofl.engine.movieclip.KeyFrame {
	function new(group:nanofl.engine.elements.GroupElement):Void;
	override function addElement(element:nanofl.engine.elements.Element, ?index:Int):Void;
	override function duplicate(?label:String, ?duration:Int, ?elements:Array<nanofl.engine.elements.Element>):nanofl.engine.movieclip.KeyFrame;
}