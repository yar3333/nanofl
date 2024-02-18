package components.nanofl.popups.preferencespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.tabbablepopup.Template
{
	public var generalPropertiesPane(get, never) : js.JQuery;
	inline function get_generalPropertiesPane() return component.q('#generalPropertiesPane');
	
	public var checkNewVersionPeriod(get, never) : js.JQuery;
	inline function get_checkNewVersionPeriod() return component.q('#checkNewVersionPeriod');

    ////////////////////////////////

	public var customPropertiesPane(get, never) : js.JQuery;
	inline function get_customPropertiesPane() return component.q('#customPropertiesPane');
	
	public var customPropertiesPaneTitle(get, never) : js.JQuery;
	inline function get_customPropertiesPaneTitle() return component.q('#customPropertiesPaneTitle');
	
	public var scrollable(get, never) : js.JQuery;
	inline function get_scrollable() return component.q('#scrollable');
	
	public var customPropertiesPaneNoProperties(get, never) : js.JQuery;
	inline function get_customPropertiesPaneNoProperties() return component.q('#customPropertiesPaneNoProperties');
	
	public var customProperties(get, never) : components.nanofl.others.custompropertiespane.Code;
	inline function get_customProperties() return cast component.children.customProperties;
}