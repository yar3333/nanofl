package components.nanofl.popups.documentpropertiespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var width(get, never) : js.JQuery;
	inline function get_width() return component.q('#width');
	
	public var height(get, never) : js.JQuery;
	inline function get_height() return component.q('#height');
	
	public var backgroundColor(get, never) : components.nanofl.common.color.Code;
	inline function get_backgroundColor() return cast component.children.backgroundColor;
	
	public var framerate(get, never) : js.JQuery;
	inline function get_framerate() return component.q('#framerate');
	
	public var scaleMode(get, never) : js.JQuery;
	inline function get_scaleMode() return component.q('#scaleMode');
	
	public var autoPlay(get, never) : js.JQuery;
	inline function get_autoPlay() return component.q('#autoPlay');
	
	public var loop(get, never) : js.JQuery;
	inline function get_loop() return component.q('#loop');
	
	public var clickToStart(get, never) : js.JQuery;
	inline function get_clickToStart() return component.q('#clickToStart');
	
	public var sceneLinkedClass(get, never) : js.JQuery;
	inline function get_sceneLinkedClass() return component.q('#sceneLinkedClass');

	public var relatedSound(get, never) : js.JQuery;
	inline function get_relatedSound() return component.q('#relatedSound');
}