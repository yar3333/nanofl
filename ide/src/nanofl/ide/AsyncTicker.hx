package nanofl.ide;

import stdlib.Timer;
import js.Browser;
import js.lib.Promise;

class AsyncTicker
{
    final framerate : Float;
    final tickFunc : Void->Promise<{}>;

    var paused = false;
    var nextTickAt : Float;

    public function new(framerate:Float, tickFunc:Void->Promise<{}>)
    {
        this.framerate = framerate;
        this.tickFunc = tickFunc;

        doNext();
    }

    function doNext()
    {
        if (paused) return;

        nextTickAt = Browser.window.performance.now() + 1000 / framerate;
        
        tickFunc().then(_ ->
        {
            final now = Browser.window.performance.now();
            Timer.delayAsync(Math.round(nextTickAt - now)).then(_ -> doNext());
        });
    }

    public function stop()
    {
        paused = true;
    }
}