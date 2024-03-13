package components.nanofl.library.librarypreview;

import js.html.CanvasElement;
import js.html.Audio;
import nanofl.DisplayObjectTools;
import nanofl.Stage;
import nanofl.TextField;
import nanofl.TextRun;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Polygon;
import nanofl.engine.libraryitems.FontItem;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.engine.ILibraryItem;
import nanofl.engine.libraryitems.SoundItem;
import nanofl.ide.Application;
import nanofl.ide.Globals;
using Lambda;

@:rtti
class Code extends wquery.Component
{
	@inject var app : Application;
	
	var canvas : CanvasElement;
    var stage : Stage;
	
	var soundPlaying : String = null;
	var audioPlaying : Audio = null;
	
	public var item(default, set) : ILibraryItem;
	function set_item(item:ILibraryItem) { this.item = item; update(); return item; }
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		canvas = cast template().canvas[0];
		stage = new Stage(canvas, app.document?.properties.framerate ?? 0);
	}
	
	public function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container
			.width(maxWidth)
			.height(maxHeight);
		
		template().canvas
			.width(maxWidth)
			.height(maxHeight);
		
		canvas.width = maxWidth;
		canvas.height = maxHeight;
		
		template().sound
			.width(maxWidth)
			.height(maxHeight);
		
		update();
	}
	
	function update()
	{
        stage.framerate = app.document?.properties.framerate ?? 0;
		stage.removeAllChildren();
		stage.clear();
		
		if (item != null)
		{
			if (Std.isOfType(item, InstancableItem))
			{
				template().canvas.css("background-color", app.document != null ? app.document.properties.backgroundColor : "white");
				template().canvas.show();
				template().sound.hide();
				
                var instance = (cast item:InstancableItem).newInstance();
                if (instance != null)
                {
                    var obj = instance.createDisplayObject();
                    stage.addChild(obj);
                    var bounds = DisplayObjectTools.getOuterBounds(obj);
                    if (bounds != null)
                    {
                        var k = Math.min(canvas.width / bounds.width, canvas.height / bounds.height);
                        obj.scaleX = obj.scaleY = k;
                        obj.x = (canvas.width - bounds.width * k) / 2 - bounds.x * k;
                        obj.y = (canvas.height - bounds.height * k) / 2 - bounds.y * k;
                    }
                }
			}
			else
			if (Std.isOfType(item, FontItem))
			{
				template().canvas.css("background-color", "white");
				template().canvas.show();
				template().sound.hide();
				
				var font = (cast item:FontItem).toFont();
				
				var text = new TextField(0, 0, false, false, false, font.variants.mapi(function(i, v)
				{
					return TextRun.create
					(
						"Abc Эюя" + (i + 1 < font.variants.length ? "\n":""),
						"#000000",
						font.family,
						v.style,
						30,
						"left",
						0,
						"#000000",
						true,
						0,
						0
					);
				}
				).array());
				
				text.update();
				
				var bounds = DisplayObjectTools.getInnerBounds(text);
				if (bounds != null)
				{
					text.x = (canvas.width  - bounds.width ) / 2;
					text.y = (canvas.height - bounds.height) / 2;
					stage.addChild(text);
				}
			}
			else
			if (Std.isOfType(item, SoundItem))
			{
				template().canvas.hide();
				template().sound.show();
				template().sound.find(">i").attr("class", soundPlaying != item.namePath ? "icon-play" : "icon-pause");
			}
			else
			{
				template().canvas.hide();
				template().sound.hide();
			}
		}
		else
		{
			template().canvas.hide();
			template().sound.hide();
		}
		
		Edges.showSelection = false;
		Polygon.showSelection = false;
		
		stage.update();
		
		Edges.showSelection = true;
		Polygon.showSelection = true;
	}
	
	function sound_click(_)
	{
		if (Std.isOfType(item, SoundItem))
		{
			if (soundPlaying != item.namePath)
			{
                soundPlaying = item.namePath;
                final sound : SoundItem = cast item;
                sound.preload().then(_ ->
                {
                    if (soundPlaying == item.namePath)
                    {
                        audioPlaying = sound.play();
                        audioPlaying.addEventListener("ended", () -> 
                        {
                            if (audioPlaying != null) { audioPlaying.pause(); audioPlaying = null; }
                            soundPlaying = null;
                            update();
                        });     
                    }
                });

                update();
			}
			else
			{
				if (audioPlaying != null) { audioPlaying.pause(); audioPlaying = null; }
                soundPlaying = null;
				update();
			}
		}
	}
}