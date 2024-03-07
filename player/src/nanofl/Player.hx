package nanofl;

import js.html.Image;
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
                stage = new nanofl.Stage(canvas, args.framerate);
                
                if (args.scaleMode != ScaleMode.custom)
                {
                    var originalWidth = args.container.offsetWidth;
                    var originalHeight = args.container.offsetHeight;
                    Browser.window.addEventListener("resize", () -> resize(args.scaleMode, originalWidth, originalHeight));
                    resize(args.scaleMode, originalWidth, originalHeight);
                }

                Ticker.paused = true;
                Ticker.timingMode = Ticker.RAF_SYNCHED;
                Ticker.framerate = args.framerate;
                Ticker.addTickEventListener(e ->
                {
                    if (e.paused) return;
                    scene.advance();
                    DisplayObjectTools.callMethod(scene, "onEnterFrame");
                    stage.update();
                });
                
                if (args.clickToStart)
                {
                    final startButton = new Image();
                    startButton.src = startButtonImageDataUri;
                    startButton.style.position = "absolute";
                    startButton.style.left = "calc(50% - 64px)";
                    startButton.style.top = "calc(50% - 64px)";
                    Browser.document.body.append(startButton);

                    Browser.window.addEventListener("click", () -> { startButton.remove(); start(); }, { once:true });
                }
                else
                {
                    start();
                }

                return null;
            });
        });
	}

    static function start()
    {
        stage.addChild(scene = cast library.getSceneInstance().createDisplayObject());
        
        DisplayObjectTools.callMethod(scene, "init");
        DisplayObjectTools.callMethod(scene, "onEnterFrame");
        
        stage.update();

        Ticker.paused = false;
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

    static final startButtonImageDataUri = "data:image/png;base64,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";
}