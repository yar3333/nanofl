package nanofl.ide.undo.states;

extern class NavigatorState {
	function new(first:{ var frameIndex : Int; var layerIndex : Int; var namePath : String; }, nexts:Array<{ public var layerIndex(default, default) : Int; public var frameIndex(default, default) : Int; public var elementIndex(default, default) : Int; }>):Void;
	var first(default, null) : { var frameIndex : Int; var layerIndex : Int; var namePath : String; };
	var nexts(default, null) : Array<{ public var layerIndex(default, default) : Int; public var frameIndex(default, default) : Int; public var elementIndex(default, default) : Int; }>;
}