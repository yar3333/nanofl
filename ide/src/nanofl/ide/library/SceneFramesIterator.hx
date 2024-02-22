package nanofl.ide.library;

import easeljs.display.Shape;
import easeljs.display.Graphics;
import js.html.CanvasRenderingContext2D;
import nanofl.ide.library.IdeLibrary;
import js.html.CanvasElement;

class SceneFramesIterator
{
    var frameNum = 0;
    var totalFrames : Int;
    var stage : nanofl.Stage;
    var scene : nanofl.MovieClip;
    var ctx : CanvasRenderingContext2D;

    @:noapi
    public function new(documentProperties:DocumentProperties, library:IdeLibrary, applyBackgroundColor:Bool)
    {
        var canvas : CanvasElement = cast js.Browser.document.createElement("canvas");
        canvas.width = documentProperties.width;
        canvas.height = documentProperties.height;
        
        totalFrames = library.getSceneItem().getTotalFrames();

        stage = new nanofl.Stage(canvas);
        scene = cast library.getSceneInstance().createDisplayObject(null);
        
        if (applyBackgroundColor)
        {
            var g = new Graphics();
            g.beginFill(documentProperties.backgroundColor);
            g.drawRect(0, 0, canvas.width, canvas.height);
            g.endFill();
            stage.addChild(new Shape(g));
        }
        
        stage.addChild(scene);

        ctx = canvas.getContext2d({ willReadFrequently:true });
    }

    public function hasNext() : Bool return frameNum < totalFrames;

    public function next() : CanvasRenderingContext2D
    {
        if (frameNum >= totalFrames) return null;
        stage.update();
        frameNum++;
        if (frameNum < totalFrames) scene.advance();
        return ctx;
    }
}