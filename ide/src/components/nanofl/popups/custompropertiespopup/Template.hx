package components.nanofl.popups.custompropertiespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var customProperties(get, never) : components.nanofl.others.custompropertiespane.Code;
	inline function get_customProperties() return cast component.children.customProperties;
}