package components.nanofl.movie.timeline;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var headers(get, never) : js.JQuery;
	inline function get_headers() return component.q('#headers');
	
	public var headerIcon(get, never) : js.JQuery;
	inline function get_headerIcon() return component.q('#headerIcon');
	
	public var headerTitle(get, never) : js.JQuery;
	inline function get_headerTitle() return component.q('#headerTitle');
	
	public var headerEdited(get, never) : js.JQuery;
	inline function get_headerEdited() return component.q('#headerEdited');
	
	public var visibleAll(get, never) : js.JQuery;
	inline function get_visibleAll() return component.q('#visibleAll');
	
	public var lockedAll(get, never) : js.JQuery;
	inline function get_lockedAll() return component.q('#lockedAll');
	
	public var framesHeader(get, never) : js.JQuery;
	inline function get_framesHeader() return component.q('#framesHeader');
	
	public var borders(get, never) : js.JQuery;
	inline function get_borders() return component.q('#borders');
	
	public var framesBorder(get, never) : js.JQuery;
	inline function get_framesBorder() return component.q('#framesBorder');
	
	public var content(get, never) : js.JQuery;
	inline function get_content() return component.q('#content');
	
	public var controls(get, never) : js.JQuery;
	inline function get_controls() return component.q('#controls');
	
	public var buttons(get, never) : js.JQuery;
	inline function get_buttons() return component.q('#buttons');
	
	public var addLayer(get, never) : js.JQuery;
	inline function get_addLayer() return component.q('#addLayer');
	
	public var addFolder(get, never) : js.JQuery;
	inline function get_addFolder() return component.q('#addFolder');
	
	public var removeLayer(get, never) : js.JQuery;
	inline function get_removeLayer() return component.q('#removeLayer');

	public var play(get, never) : js.JQuery;
	inline function get_play() return component.q('#play');

	public var stop(get, never) : js.JQuery;
	inline function get_stop() return component.q('#stop');
	
	public var hscrollContainer(get, never) : js.JQuery;
	inline function get_hscrollContainer() return component.q('#hscrollContainer');
	
    public var activeFrameIndex(get, never) : js.JQuery;
	inline function get_activeFrameIndex() return component.q('#activeFrameIndex');
	
	public var hScrollbar(get, never) : components.nanofl.common.horizontalscrollbar.Code;
	inline function get_hScrollbar() return cast component.children.hScrollbar;
	
	public var frameContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	inline function get_frameContextMenu() return cast component.children.frameContextMenu;
	
	public var layerContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	inline function get_layerContextMenu() return cast component.children.layerContextMenu;

	public var timelineContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	inline function get_timelineContextMenu() return cast component.children.timelineContextMenu;

	public function new(component:wquery.Component) this.component = component;
}