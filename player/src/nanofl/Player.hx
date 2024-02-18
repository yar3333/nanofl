package nanofl;

import nanofl.engine.Library;
import soundjs.Sound;
import easeljs.display.SpriteSheet;
import createjs.utils.Ticker;
import js.Browser;
import js.html.CanvasElement;
import js.html.DivElement;
import nanofl.engine.ScaleMode;
import nanofl.engine.TextureAtlasData;

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
	
	public static function init(container:DivElement, libraryData:Dynamic, framerate=24.0, scaleMode="custom", ?textureAtlasesData:Array<Dynamic<TextureAtlasData>>) : Void
	{
		Player.container = container;
		Player.library = Library.loadFromJson("library", libraryData);
		
		container.innerHTML = "";
		
		var canvas : CanvasElement = cast Browser.document.createCanvasElement();
		canvas.style.position = "absolute";
		container.appendChild(canvas);
		
		if (textureAtlasesData != null)
		{
			for (textureAtlasData in textureAtlasesData)
			{
				for (namePath in Reflect.fields(textureAtlasData))
				{
					Reflect.setField(spriteSheets, namePath, new SpriteSheet(Reflect.field(textureAtlasData, namePath)));
				}
			}
		}
		
		Sound.alternateExtensions = [ "ogg", "mp3", "wav" ];
		Sound.registerSounds(library.getSounds().map(item -> { src:item.getUrl(), id:item.linkage }), null);
		
		library.preload().then(_ ->
		{
			stage = new nanofl.Stage(canvas);
			
			if (scaleMode != ScaleMode.custom)
			{
				var originalWidth = container.offsetWidth;
				var originalHeight = container.offsetHeight;
				Browser.window.addEventListener("resize", () -> resize(scaleMode, originalWidth, originalHeight));
				resize(scaleMode, originalWidth, originalHeight);
			}
			
			stage.addChild(scene = cast library.getSceneInstance().createDisplayObject(null));
			
			DisplayObjectTools.callMethod(scene, "init");
			DisplayObjectTools.callMethod(scene, "onEnterFrame");
			
			stage.update();
			
			Ticker.framerate = framerate;
			Ticker.addEventListener("tick", function()
			{
				scene.advance();
				DisplayObjectTools.callMethod(scene, "onEnterFrame");
				stage.update();
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