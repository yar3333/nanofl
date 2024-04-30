package nanofl.ide.library;

import js.lib.Promise;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import easeljs.display.Shape;
import easeljs.display.Graphics;
import nanofl.engine.elements.Instance;
import nanofl.engine.movieclip.TweenedElement;
import nanofl.ide.library.IdeLibrary;

class SceneFramesIterator
{
    final totalFrames : Int;
    final sceneInstance : Instance;
    final framerate : Float;
    
    final stage : nanofl.Stage;
    final ctx : CanvasRenderingContext2D;

    var scene : MovieClip;
    var curFrame = 0;

    @:noapi
    public function new(documentProperties:DocumentProperties, library:IdeLibrary, applyBackgroundColor:Bool)
    {
        var canvas : CanvasElement = cast js.Browser.document.createElement("canvas");
        canvas.width = documentProperties.width;
        canvas.height = documentProperties.height;
        
        this.totalFrames = library.getSceneItem().getTotalFrames();
        this.sceneInstance = library.getSceneInstance();
        this.framerate = documentProperties.framerate;

        stage = new nanofl.Stage(canvas);
       
        if (applyBackgroundColor)
        {
            var g = new Graphics();
            g.beginFill(documentProperties.backgroundColor);
            g.drawRect(0, 0, canvas.width, canvas.height);
            g.endFill();
            stage.addChild(new Shape(g));
        }

        recreateScene();
 
        ctx = canvas.getContext2d({ willReadFrequently:true });
    }

    public function hasNext() : Bool return curFrame < totalFrames;

    public function next() : Promise<CanvasRenderingContext2D>
    {
        if (curFrame >= totalFrames) return Promise.resolve(ctx);
        
        return stage.waitLoading().then(_ -> 
        {
            stage.update();

            curFrame++;
            if (hasNext()) recreateScene();

            return ctx;
        });
    }

    function recreateScene()
    {
        if (scene != null) stage.removeChild(scene);

        scene = cast sceneInstance.createDisplayObject();
        stage.addChild(scene);
        scene.advanceTo(curFrame, new TweenedElement(sceneInstance, sceneInstance), framerate);
    }
}