package components.nanofl.library.librarytoolbar;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var newMovieClip(get, never) : js.JQuery;
	inline function get_newMovieClip() return component.q('#newMovieClip');
	
	public var newFolder(get, never) : js.JQuery;
	inline function get_newFolder() return component.q('#newFolder');
	
	public var properties(get, never) : js.JQuery;
	inline function get_properties() return component.q('#properties');
	
	public var removeItems(get, never) : js.JQuery;
	inline function get_removeItems() return component.q('#removeItems');

	public function new(component:wquery.Component) this.component = component;
}