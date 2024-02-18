package components.nanofl.movie.movie;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var timeline(get, never) : components.nanofl.movie.timeline.Code;
	inline function get_timeline() return cast component.children.timeline;
	
	public var frameContainer(get, never) : js.JQuery;
	inline function get_frameContainer() return component.q('#frameContainer');
	
	public var toolbar(get, never) : components.nanofl.movie.toolbar.Code;
	inline function get_toolbar() return cast component.children.toolbar;
	
	public var navigatorLine(get, never) : js.JQuery;
	inline function get_navigatorLine() return component.q('#navigatorLine');
	
	public var navigator(get, never) : components.nanofl.movie.navigator.Code;
	inline function get_navigator() return cast component.children.navigator;
	
	public var zoomer(get, never) : components.nanofl.movie.zoomer.Code;
	inline function get_zoomer() return cast component.children.zoomer;
	
	public var editor(get, never) : components.nanofl.movie.editor.Code;
	inline function get_editor() return cast component.children.editor;
	
	public var statusBar(get, never) : components.nanofl.others.statusbar.Code;
	inline function get_statusBar() return cast component.children.statusBar;

	public function new(component:wquery.Component) this.component = component;
}