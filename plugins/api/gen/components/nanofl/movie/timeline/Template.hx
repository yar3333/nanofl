package components.nanofl.movie.timeline;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var headers(get, never) : js.JQuery;
	var headerIcon(get, never) : js.JQuery;
	var headerTitle(get, never) : js.JQuery;
	var headerEdited(get, never) : js.JQuery;
	var visibleAll(get, never) : js.JQuery;
	var lockedAll(get, never) : js.JQuery;
	var framesHeader(get, never) : js.JQuery;
	var borders(get, never) : js.JQuery;
	var framesBorder(get, never) : js.JQuery;
	var content(get, never) : js.JQuery;
	var controls(get, never) : js.JQuery;
	var buttons(get, never) : js.JQuery;
	var addLayer(get, never) : js.JQuery;
	var addFolder(get, never) : js.JQuery;
	var removeLayer(get, never) : js.JQuery;
	var play(get, never) : js.JQuery;
	var stop(get, never) : js.JQuery;
	var hscrollContainer(get, never) : js.JQuery;
	var activeFrameIndex(get, never) : js.JQuery;
	var layerBottomPanel(get, never) : js.JQuery;
	var hScrollbar(get, never) : components.nanofl.common.horizontalscrollbar.Code;
	var frameContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	var layerContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	var timelineContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
}