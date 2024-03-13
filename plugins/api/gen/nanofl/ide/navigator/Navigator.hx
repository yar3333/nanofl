package nanofl.ide.navigator;

extern class Navigator extends nanofl.ide.InjectContainer {
	var editPath(get, never) : Array<nanofl.ide.navigator.PathItem>;
	private function get_editPath():Array<nanofl.ide.navigator.PathItem>;
	var pathItem(get, never) : nanofl.ide.navigator.PathItem;
	@:noCompletion
	private function get_pathItem():nanofl.ide.navigator.PathItem;
	function navigateDown(instance:nanofl.engine.elements.Instance):Void;
	function navigateTo(editPath:Array<nanofl.ide.navigator.PathItem>, ?isCenterView:Bool, ?commitBeforeChange:Bool):Void;
	function setLayerIndex(index:Int):Void;
	function setFrameIndex(index:Int, ?invalidater:nanofl.ide.Invalidater, ?commitBeforeChange:Bool):js.lib.Promise<{ }>;
	function getState():nanofl.ide.undo.states.NavigatorState;
	function setState(state:nanofl.ide.undo.states.NavigatorState):Void;
	function navigateUp(?newEditPathLength:Int):Void;
	function update(isCenterView:Bool):Void;
	function getNamePaths():Array<String>;
}