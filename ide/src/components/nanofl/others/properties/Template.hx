package components.nanofl.others.properties;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var nothing(get, never) : components.nanofl.properties.nothing.Code;
	inline function get_nothing() return cast component.children.nothing;
	
	public var instance(get, never) : components.nanofl.properties.instance.Code;
	inline function get_instance() return cast component.children.instance;
	
	public var positionAndSize(get, never) : components.nanofl.properties.positionandsize.Code;
	inline function get_positionAndSize() return cast component.children.positionAndSize;
	
	public var colorEffect(get, never) : components.nanofl.properties.coloreffect.Code;
	inline function get_colorEffect() return cast component.children.colorEffect;
	
	public var display(get, never) : components.nanofl.properties.display.Code;
	inline function get_display() return cast component.children.display;
	
	public var filters(get, never) : components.nanofl.properties.filters.Code;
	inline function get_filters() return cast component.children.filters;
	
	public var character(get, never) : components.nanofl.properties.character.Code;
	inline function get_character() return cast component.children.character;
	
	public var paragraph(get, never) : components.nanofl.properties.paragraph.Code;
	inline function get_paragraph() return cast component.children.paragraph;
	
	public var stroke(get, never) : components.nanofl.properties.stroke.Code;
	inline function get_stroke() return cast component.children.stroke;
	
	public var fill(get, never) : components.nanofl.properties.fill.Code;
	inline function get_fill() return cast component.children.fill;
	
	public var shape(get, never) : components.nanofl.properties.shape.Code;
	inline function get_shape() return cast component.children.shape;
	
	public var frameLabel(get, never) : components.nanofl.properties.framelabel.Code;
	inline function get_frameLabel() return cast component.children.frameLabel;
	
	public var motionTween(get, never) : components.nanofl.properties.motiontween.Code;
	inline function get_motionTween() return cast component.children.motionTween;
	
	public var meshParams(get, never) : components.nanofl.properties.meshparams.Code;
	inline function get_meshParams() return cast component.children.meshParams;
	
	public var video(get, never) : components.nanofl.properties.video.Code;
	inline function get_video() return cast component.children.video;

	public function new(component:wquery.Component) this.component = component;
}