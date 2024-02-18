package components.nanofl.popups.fontpropertiespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var family(get, never) : js.JQuery;
	inline function get_family() return component.q('#family');
	
	public var variantsPlaceholder(get, never) : js.JQuery;
	inline function get_variantsPlaceholder() return component.q('#variantsPlaceholder');
	
	public var addVariant(get, never) : js.JQuery;
	inline function get_addVariant() return component.q('#addVariant');
}