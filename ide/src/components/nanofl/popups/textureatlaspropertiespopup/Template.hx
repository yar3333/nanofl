package components.nanofl.popups.textureatlaspropertiespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var name(get, never) : js.JQuery;
	inline function get_name() return component.q('#name');
	
	public var width(get, never) : js.JQuery;
	inline function get_width() return component.q('#width');
	
	public var height(get, never) : js.JQuery;
	inline function get_height() return component.q('#height');
	
	public var padding(get, never) : js.JQuery;
	inline function get_padding() return component.q('#padding');
}