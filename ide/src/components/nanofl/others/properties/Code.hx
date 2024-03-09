package components.nanofl.others.properties;

import haxe.Timer;
import js.JQuery;
import nanofl.ide.Globals;
import nanofl.ide.ui.View;
import nanofl.ide.ActiveView;
import nanofl.ide.Application;
import nanofl.ide.PropertiesObject;
import nanofl.engine.movieclip.KeyFrame in KeyFrame;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Code extends wquery.Component
{
	static var imports =
	{
		"nothing-pane": components.nanofl.properties.nothing.Code,
		"instance-pane": components.nanofl.properties.instance.Code,
		"position-and-size-pane": components.nanofl.properties.positionandsize.Code,
		"color-effect-pane": components.nanofl.properties.coloreffect.Code,
		"display-pane": components.nanofl.properties.display.Code,
		"filters-pane": components.nanofl.properties.filters.Code,
		"character-pane": components.nanofl.properties.character.Code,
		"paragraph-pane": components.nanofl.properties.paragraph.Code,
		"stroke-pane": components.nanofl.properties.stroke.Code,
		"fill-pane": components.nanofl.properties.fill.Code,
		"shape-pane": components.nanofl.properties.shape.Code,
		"frame-label-pane": components.nanofl.properties.framelabel.Code,
		"motion-tween-pane": components.nanofl.properties.motiontween.Code,
		"mesh-params-pane": components.nanofl.properties.meshparams.Code
	};

	@inject var app : Application;
	@inject var view : View;
	
	var freeze = false;
	
	var timer : Timer;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		hide();
	}
	
	@:profile
	public function update(?rightNow:Bool)
	{
		if (freeze) return;
		
		if (timer != null) timer.stop();
		
		if (rightNow)
		{
			updateInner();
		}
		else
		{
			timer = Timer.delay(updateInner, 50);
		}
	}
	
	function updateInner()
	{
		var obj = getPropertiesObject();
		
		timer = null;
		template().nothing.bind(obj);
		template().instance.bind(obj);
		template().positionAndSize.bind(obj);
		template().character.bind(obj);
		template().paragraph.bind(obj);
		template().colorEffect.bind(obj);
		template().display.bind(obj);
		template().filters.bind(obj);
		template().stroke.bind(obj);
		template().fill.bind(obj);
		template().shape.bind(obj);
		template().frameLabel.bind(obj);
		template().motionTween.bind(obj);
		template().meshParams.bind(obj);
	}
	
	function nothing_change(e) fireChangeEvent();
	function instance_change(e) fireChangeEvent();
	function positionAndSize_change(e) fireChangeEvent();
	function character_change(e) fireChangeEvent();
	function paragraph_change(e) fireChangeEvent();
	function colorEffect_change(e) fireChangeEvent();
	function display_change(e) fireChangeEvent();
	function filters_change(e) fireChangeEvent();
	function stroke_change(e) fireChangeEvent();
	function fill_change(e) fireChangeEvent();
	function shape_change(e) fireChangeEvent();
	function frameLabel_change(e) fireChangeEvent();
	function motionTween_change(e) fireChangeEvent();
	function meshParams_change(e) fireChangeEvent();
	
	function fireChangeEvent()
	{
		freeze = true;
		
		switch (getPropertiesObject())
		{
			case PropertiesObject.INSTANCE(item):   app.document.editor.updateElement(item.element);
			case PropertiesObject.TEXT(item, _):	app.document.editor.updateElement(item.element);
			case PropertiesObject.GROUP(items):		// TODO: app.document.editor.updateElement(item.element);
			case PropertiesObject.SHAPE(_, _, _):	app.document.editor.updateShapes();
			case PropertiesObject.KEY_FRAME(_):	    view.movie.timeline.updateActiveLayerFrames();
			case PropertiesObject.NONE:				// nothing to do
		}
		
		freeze = false;
	}
	
	public function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container.css("height", maxHeight);
	}
	
	public function show()
	{
		template().container.show();
		update();
	}
	
	public function hide() template().container.hide();
	
	public function on(event:String, callb:JqEvent->Void)
	{
		template().container.on(event, callb);
	}
	
	function getPropertiesObject() : PropertiesObject
	{
		if (app.document != null)
		{
			switch (app.activeView)
			{
				case ActiveView.TIMELINE:
					var keyFrame = view.movie.timeline.getActiveKeyFrame();
                    return PropertiesObject.KEY_FRAME((cast keyFrame:KeyFrame));
					
				case _:
                    return app.document.editor.getPropertiesObject();
			}
		}
		
		return PropertiesObject.NONE;
	}
	
	public function activate()
	{
		(cast page : components.nanofl.page.Code).showPropertiesPanel();
	}
}