package components.nanofl.library.librarypreview;

import js.html.Audio;
import js.html.CanvasElement;
import js.html.VideoElement;
import nanofl.Stage;
import nanofl.TextField;
import nanofl.TextRun;
import nanofl.DisplayObjectTools;
import nanofl.engine.ILibraryItem;
import nanofl.engine.LibraryItemType;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Polygon;
import nanofl.engine.libraryitems.FontItem;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.engine.libraryitems.SoundItem;
import nanofl.ide.Application;
import nanofl.ide.Globals;
import nanofl.ide.libraryitems.VideoItem;
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
		stage = new Stage(canvas);
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

		template().video
			.width(maxWidth)
			.height(maxHeight);
		
		update();
	}
	
	function update()
	{
		stage.removeAllChildren();
		stage.clear();

        switch (item?.type)
        {
            case LibraryItemType.bitmap,
                 LibraryItemType.movieclip,
                 LibraryItemType.mesh:
                showInstancableItem((cast item : InstancableItem));
            
            case LibraryItemType.video:
                showVideoItem((cast item : VideoItem));
            
            case LibraryItemType.font:
                showFontItem((cast item : FontItem));

            case LibraryItemType.sound:
                showSoundItem((cast item : SoundItem));
            
            case LibraryItemType.folder, null:
                template().canvas.hide();
                template().video.hide();
                template().sound.hide();
                stopPlaying();
        }

        updateStage();
	}

    function showInstancableItem(item:InstancableItem)
    {
        template().canvas.show();
        template().video.hide();
        template().sound.hide();
        
        template().canvas.css("background-color", app.document?.properties.backgroundColor ?? "white");
        
        final instance = item.newInstance();
        if (instance != null)
        {
            final obj = instance.createDisplayObject();
            stage.addChild(obj);
            final bounds = DisplayObjectTools.getOuterBounds(obj);
            if (bounds != null)
            {
                final k = Math.min(canvas.width / bounds.width, canvas.height / bounds.height);
                obj.scaleX = obj.scaleY = k;
                obj.x = (canvas.width - bounds.width * k) / 2 - bounds.x * k;
                obj.y = (canvas.height - bounds.height * k) / 2 - bounds.y * k;
            }
        }

        stage.waitLoading().then(_ -> updateStage());
    }

    function showVideoItem(item:VideoItem)
    {
        template().canvas.hide();
        template().video.show();
        template().sound.hide();
        
        final elem : VideoElement = cast template().video[0];
        elem.src = item.getUrl();
    }    

    function showFontItem(item:FontItem)
    {
        template().canvas.show();
        template().video.hide();
        template().sound.hide();
        
        template().canvas.css("background-color", "white");
        
        final font = item.toFont();
        
        final text = new TextField(0, 0, false, false, false, font.variants.mapi((i, v) -> TextRun.create
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
        )).array());
        
        text.update();
        
        final bounds = DisplayObjectTools.getInnerBounds(text);
        if (bounds != null)
        {
            text.x = (canvas.width  - bounds.width ) / 2;
            text.y = (canvas.height - bounds.height) / 2;
            stage.addChild(text);
        }
    }

    function showSoundItem(item:SoundItem)
    {
        template().canvas.hide();
        template().video.hide();
        template().sound.show();
        
        template().sound.find(">i").attr("class", soundPlaying != item.namePath ? "icon-play" : "icon-pause");
    }
	
	function sound_click(_)
	{
		if (!Std.isOfType(item, SoundItem)) return;
		
        if (soundPlaying == item.namePath) { stopPlaying(); return; }
        
        soundPlaying = item.namePath;
        final sound : SoundItem = cast item;
        sound.preload().then(_ ->
        {
            if (soundPlaying == item.namePath)
            {
                audioPlaying = sound.play();
                audioPlaying.addEventListener("ended", () -> stopPlaying());     
            }
        });

        update();
	}

    function updateStage()
    {
 		Edges.showSelection = false;
		Polygon.showSelection = false;
		
		stage.update();
		
		Edges.showSelection = true;
		Polygon.showSelection = true;
   }

    function stopPlaying()
    {
        if (soundPlaying == null && (cast template().video[0] : VideoElement).paused) return;

        if (audioPlaying != null) { audioPlaying.pause(); audioPlaying = null; }
        soundPlaying = null;
        
        (cast template().video[0] : VideoElement).pause();
        
        update();
    }
}