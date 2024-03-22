package nanofl.ide.library;

import js.lib.Promise;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import easeljs.display.Shape;
import easeljs.display.Graphics;
import nanofl.ide.library.IdeLibrary;

class SceneFramesIterator
{
    final stage : nanofl.Stage;
    final scene : nanofl.MovieClip;
    final ctx : CanvasRenderingContext2D;

    var curFrame = 0;

    @:noapi
    public function new(documentProperties:DocumentProperties, library:IdeLibrary, applyBackgroundColor:Bool)
    {
        var canvas : CanvasElement = cast js.Browser.document.createElement("canvas");
        canvas.width = documentProperties.width;
        canvas.height = documentProperties.height;
        
        stage = new nanofl.Stage(canvas, documentProperties.framerate);
        scene = cast library.getSceneInstance().createDisplayObject();
        
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

    public function hasNext() : Bool return curFrame < scene.getTotalFrames();

    public function next() : Promise<CanvasRenderingContext2D>
    {
        if (curFrame >= scene.getTotalFrames()) return Promise.resolve(ctx);
        
        return stage.waitLoading().then(_ -> 
        {
            stage.update();

            curFrame++;
            if (hasNext()) scene.advanceToNextFrame();

            return ctx;
        });
    }
}