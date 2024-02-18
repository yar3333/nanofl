package components.nanofl.common.color;

import js.JQuery;
import wquery.Event;
import nanofl.engine.ColorTools;
using js.jquery.Spectrum;
using StringTools;

class Code extends wquery.Component 
{
	var inited = false;
	
	public var cssClass = "";
	public var display = true;
	
	public var showAlpha = true;
	
    var event_change = new Event<{ color:String }>();
	
	var freezed = false;
	
	@:isVar public var value(get, set) : String;
	
	function get_value() : String
	{
		var r = template().color.spectrum().get();
		return r != null ? ColorTools.normalize(r.toRgbString()) : null;
	}
	
	function set_value(v:String) : String
	{
		v = ColorTools.normalize(v);
		if (v == value) return v;
		
		value = v;
		
		freezed = true;
		template().color.spectrum().set(v);
		freezed = false;
		
		return v;
	}
	
	var _allowEmpty : Bool;
	public var allowEmpty(get, set) : Bool;
	function get_allowEmpty() : Bool return inited ? template().color.spectrum().getOption("allowEmpty") : _allowEmpty;
	function set_allowEmpty(v:Bool) : Bool { if (inited) { template().color.spectrum().setOption("allowEmpty", v); return v; } else return _allowEmpty; }
	
	public var visibility(get, set) : Bool;
	function get_visibility() : Bool return template().container.css("visibility") != "hidden";
	function set_visibility(v:Bool) : Bool
	{
		var s = v ? "visible" : "hidden";
		if (template().container.css("visibility") != s)
		{
			template().container.css("visibility", s);
		}
		return v;
	}
	
	public var panel(get, never) : JQuery;
	function get_panel() return template().color.spectrum().container();
	
	public function showPanel() template().color.spectrum().show();
	public function hidePanel() template().color.spectrum().hide();
	
	public function show() template().container.css("display", "");
	public function hide() template().container.css("display", "none");
	
	function init()
    {
		if (!display) template().container.css("display", "none");
		if (!visibility) template().container.css("visibility", "hidden");
		
		template().color.spectrum(new SpectrumOptionsBuilder()
			.chooseText("OK")
			.cancelText("Cancel")
			.showAlpha(showAlpha)
			.allowEmpty(allowEmpty)
			.showInput(true)
			.preferredFormat("hex")
			.move(changeColor)
			.change(changeColor)
			.hide(changeColor)
			.clickoutFiresChange(true)
			.options
		);
		
		inited = true;
    }
	
	function changeColor(e:TinyColor)
	{
		if (freezed) return;
		event_change.emit({ color:value });
	}
}