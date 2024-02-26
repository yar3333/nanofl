package nanofl;

import js.Browser;
import js.html.CanvasElement;
import js.html.DivElement;
import js.lib.Promise;
import js.lib.Error;
import createjs.utils.Ticker;
import easeljs.display.SpriteSheet;
import nanofl.engine.Library;
import nanofl.engine.TextureAtlasTools;
import nanofl.engine.ScaleMode;

@:expose
class Player
{
	public static var container : DivElement;
	public static var library : nanofl.engine.Library;
	
	public static var stage : easeljs.display.Stage;
	public static var scene : nanofl.MovieClip;
	
	public static var spriteSheets : Dynamic<easeljs.display.SpriteSheet> = {};
	
	static function __init__()
	{
		//js.Syntax.code("$hx_exports.$extend = $extend");
	}
	
	public static function init(args:PlayerArgs) : Promise<{}>
	{
        if (args.container == null) throw new Error("Player.init: argument `container` must be specified.");
        if (args.libraryData == null) throw new Error("Player.init: argument `libraryData` must be specified.");
        if (args.scaleMode == null) args.scaleMode = "custom";
        if (args.framerate == null) args.framerate = 24;

		Player.container = args.container;
		Player.library = Library.loadFromJson("library", args.libraryData);
		
		args.container.innerHTML = "";
		
		var canvas : CanvasElement = cast Browser.document.createCanvasElement();
		canvas.style.position = "absolute";
		args.container.appendChild(canvas);
		
        return TextureAtlasTools.resolveImages(args.textureAtlasesData)
        .then(_ ->
        {
            if (args.textureAtlasesData != null)
            {
                for (textureAtlasData in args.textureAtlasesData)
                {
                    for (namePath in Reflect.fields(textureAtlasData))
                    {
                        Reflect.setField(spriteSheets, namePath, new SpriteSheet(Reflect.field(textureAtlasData, namePath)));
                    }
                }
            }

            return library.preload().then(_ ->
            {
                stage = new nanofl.Stage(canvas);
                
                if (args.scaleMode != ScaleMode.custom)
                {
                    var originalWidth = args.container.offsetWidth;
                    var originalHeight = args.container.offsetHeight;
                    Browser.window.addEventListener("resize", () -> resize(args.scaleMode, originalWidth, originalHeight));
                    resize(args.scaleMode, originalWidth, originalHeight);
                }
                
                stage.addChild(scene = cast library.getSceneInstance().createDisplayObject(null));
                
                DisplayObjectTools.callMethod(scene, "init");
                DisplayObjectTools.callMethod(scene, "onEnterFrame");
                
                stage.update();
                
                Ticker.framerate = args.framerate;
                Ticker.addEventListener("tick", () ->
                {
                    scene.advance();
                    DisplayObjectTools.callMethod(scene, "onEnterFrame");
                    stage.update();
                });

                return null;
            });
        });
	}
	
	static function resize(scaleMode:String, originalWidth:Int, originalHeight:Int)
	{
		Browser.document.body.style.width  = Browser.window.innerWidth  + "px";
		Browser.document.body.style.height = Browser.window.innerHeight + "px";
		
		var kx : Float;
		var ky : Float;
		
		switch (scaleMode)
		{
			case ScaleMode.fit:
				kx = ky = Math.min
				(
					Browser.window.innerWidth  / originalWidth,
					Browser.window.innerHeight / originalHeight
				);
				
			case ScaleMode.fill:
				kx = ky = Math.max
				(
					Browser.window.innerWidth  / originalWidth,
					Browser.window.innerHeight / originalHeight
				);
				
			case ScaleMode.stretch:
				kx = Browser.window.innerWidth  / originalWidth;
				ky = Browser.window.innerHeight / originalHeight;
				
			case _:
				kx = ky = 1;
		};
		
		var w = Math.round(originalWidth  * kx);
		var h = Math.round(originalHeight * ky);
		
		container.style.width = w + "px";
		container.style.height = h + "px";
		
		for (node in container.children)
		{
			if (node.tagName.toUpperCase() == "CANVAS")
			{
				(cast node:CanvasElement).width = w;
				(cast node:CanvasElement).height = h;
			}
		}
		
		container.style.left = Math.round((Browser.window.innerWidth  - container.offsetWidth ) / 2) + "px";
		container.style.top  = Math.round((Browser.window.innerHeight - container.offsetHeight) / 2) + "px";
		
		stage.scaleX = kx;
		stage.scaleY = ky;
	}
}