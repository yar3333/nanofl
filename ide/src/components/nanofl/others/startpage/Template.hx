package components.nanofl.others.startpage;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var recents(get, never) : js.JQuery;
	inline function get_recents() return component.q('#recents');
	
	public var creates(get, never) : js.JQuery;
	inline function get_creates() return component.q('#creates');
	
	public var docs(get, never) : js.JQuery;
	inline function get_docs() return component.q('#docs');

	public function new(component:wquery.Component) this.component = component;
}