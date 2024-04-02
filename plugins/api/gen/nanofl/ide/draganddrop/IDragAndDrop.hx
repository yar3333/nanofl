package nanofl.ide.draganddrop;

interface IDragAndDrop {
	/**
		
			 * Specify selector if you want to delegate from parent element specified by `elem`. In other case, set `selector` to null.
			 * If you use selector, then you must manualy add `draggable="true"` attribute to the draggable elements.
			 
	**/
	function draggable(elem:js.JQuery, selector:String, getInfo:(e:js.JQuery.JqEvent) -> nanofl.ide.draganddrop.DragInfo, ?removeMoved:nanofl.ide.draganddrop.DragInfo -> Void):Void;
	function droppable(elem:js.JQuery, ?selector:String, getDragImageType:(type:nanofl.ide.draganddrop.DragDataType, params:nanofl.ide.draganddrop.DragInfoParams) -> nanofl.ide.draganddrop.DragImageType, processDropData:(type:nanofl.ide.draganddrop.DragDataType, params:nanofl.ide.draganddrop.DragInfoParams, data:String, e:js.JQuery.JqEvent) -> Bool, ?processDropFiles:(Array<js.html.File>, js.JQuery.JqEvent) -> Void):Void;
}