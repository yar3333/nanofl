package components.nanofl.properties.base;

import js.JQuery;
import nanofl.ide.Globals;
import wquery.Event;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.Application;
import nanofl.ide.PropertiesObject;
import nanofl.ide.editor.Editor;
import nanofl.ide.undo.document.UndoQueue;

@:rtti
abstract class Code extends wquery.Component
{
	@inject var app : Application;
	
	var event_change = new Event<{ obj:PropertiesObject }>();
	
	var visible = false;
	
	var obj : PropertiesObject;
	
	var editor : Editor;
	var library : IdeLibrary;
	var undoQueue : UndoQueue;
	
	var freeze = false;
	
	var scrollBarWidth(get, null) : Int;
	function get_scrollBarWidth()
	{
		if (scrollBarWidth == null)
		{
			var outer = new JQuery("<div style='visibility:hidden; width:100px; overflow:scroll'>").appendTo('body');
			scrollBarWidth = 100 - (new JQuery("<div style='width:100%'>").appendTo(outer).outerWidth());
			outer.remove();
		}
		return scrollBarWidth;
	}
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		bind(PropertiesObject.NONE);
		
		template().container.on("click", ">fieldset>legend", e ->
		{
			var legend = q(e.currentTarget);
			var fieldset = legend.parent();
			if (!fieldset.hasClass("collapsed"))
			{
				fieldset.animate({ height:legend.height() + 2 }, fieldset.height() * 2, "linear", () ->
				{
					fieldset.addClass("collapsed");
				});
			}
			else
			{
				fieldset.removeClass("collapsed");
				var saveHeight = fieldset.height();
				fieldset.height(cast "auto");
				var destHeight = fieldset.height();
				fieldset.height(saveHeight);
				fieldset.animate({ height:destHeight }, 500, () -> fieldset.height(cast "auto"));
			}
		});
	}
	
	public function bind(obj:PropertiesObject)
	{
		if (freeze) return;
		
		this.obj = obj;
		if (app.document != null)
		{
			editor = app.document.editor;
			library = app.document.library.getRawLibrary();
			undoQueue = app.document.undoQueue;
		}
		
		update();
	}
	
	function update()
	{
		freeze = true;
		updateInner();
		freeze = false;
	}
	
	function fireChangeEvent()
	{
		if (!freeze) event_change.emit({ obj:obj });
	}
	
	function show()
	{
		if (!visible)
		{
			template().container.show();
			visible = true;
		}
	}
	
	function hide()
	{
		if (visible)
		{
			template().container.hide();
			visible = false;
		}
	}
	
	abstract function updateInner() : Void;
	
	function parseFloatEx(s:String, ?f:Float->Void) : Float
	{
		var r = Std.parseFloat(s);
		if (r != null && !Math.isNaN(r))
		{
			if (f != null) f(r);
			return r;
		}
		return null;
	}
	
	function roundFloat100(f:Float) : Float
	{
		return Math.round(f * 100) / 100;
	}
}