package nanofl.ide.displayobjects;

import js.lib.Promise;
import stdlib.Std;
import nanofl.Video.VideoParams;
import nanofl.ide.libraryitems.VideoItem;
import nanofl.engine.AdvancableDisplayObject;

class IdeVideo extends nanofl.Video
    implements AdvancableDisplayObject
{
    var currentFrame : Int;
   
    var _currentTime : Float;
    public var currentTime(get,set) : Float;
    function get_currentTime() return _currentTime;
    function set_currentTime(v:Float) { currentFrame = -1; return _currentTime = v; }

    inline function getFramerate() return (cast stage : nanofl.Stage).framerate;
    
    public function new(symbol:VideoItem, params:VideoParams)
    {
        super(symbol, null);
        
        this.currentTime = params?.currentTime ?? 0;
    }

    public function waitLoading() : Promise<{}>
    {
        return VideoCache.getImageAsync((cast symbol:VideoItem).getUrl(), _currentTime).then(canvas ->
        {
            removeAllChildren();
            addChild(new easeljs.display.Bitmap(canvas));
            return null;
        });
    }

	public function advanceToNextFrame() : Void
    {
        if (currentFrame == -1)
        {
            currentFrame = Math.floor(_currentTime * getFramerate());
        }

        final totalFrames = Std.int(duration * getFramerate());
        
        if (!symbol.loop && currentFrame >= totalFrames - 1) return;

        currentFrame++;
        if (currentFrame >= totalFrames) currentFrame -= totalFrames;

        _currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / getFramerate() + 0.0001);
    }

    public function advanceTo(advanceFrames:Int, framerate:Float)
    {
        if (!symbol.autoPlay) return;

        advanceFrames += Math.round(_currentTime * framerate);

        final totalFrames = Std.int(duration * framerate);

        currentFrame = symbol.loop ? advanceFrames % totalFrames : Std.min(totalFrames - 1, advanceFrames);

        _currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / framerate + 0.0001);
    }

    override function clone(?recursive:Bool) : Video
    {
		final r : IdeVideo = (cast this)._cloneProps(new IdeVideo(cast symbol, null));

        r.currentFrame = currentFrame;
        r._currentTime = _currentTime;
        
        return r;
    }
}