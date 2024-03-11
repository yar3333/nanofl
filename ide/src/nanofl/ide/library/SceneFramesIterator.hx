package nanofl.ide.library;

import js.lib.Error;
import js.lib.Promise;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import easeljs.display.Shape;
import easeljs.display.Graphics;
import nanofl.ide.library.IdeLibrary;

class SceneFramesIterator
{
    final framerate : Float;
    
    final stage : nanofl.Stage;
    final scene : nanofl.MovieClip;
    final ctx : CanvasRenderingContext2D;

    var curFrame = 0;

    @:noapi
    public function new(documentProperties:DocumentProperties, library:IdeLibrary, applyBackgroundColor:Bool)
    {
        framerate = documentProperties.framerate;
        
        var canvas : CanvasElement = cast js.Browser.document.createElement("canvas");
        canvas.width = documentProperties.width;
        canvas.height = documentProperties.height;
        
        stage = new nanofl.Stage(canvas);
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
        stage.update();

        curFrame++;

        if (scene.currentFrame >= scene.getTotalFrames() - 1) return Promise.resolve(ctx);
        
        scene.advanceToNextFrame(framerate);
        
        final videoPromises = new Array<Promise<{}>>();
        DisplayObjectTools.iterateTreeFromBottomToTop(scene, obj ->
        {
            if (Std.isOfType(obj, nanofl.Video))
            {
                final videoObj : nanofl.Video = cast obj;
                if (videoObj.video.seeking)
                {
                    videoPromises.push(new Promise((resolve, reject) ->
                    {
                        videoObj.video.addEventListener("loadeddata", () -> resolve(null), { once:true });
                        videoObj.video.addEventListener("error", () -> reject(new Error("Unable to load video: " + videoObj.video.src)), { once:true });
                    }));
                }
            }
        });

        return Promise.all(videoPromises).then(_ -> ctx);
    }
}