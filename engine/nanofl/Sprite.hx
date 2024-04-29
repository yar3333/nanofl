package nanofl;

import stdlib.Std;
import nanofl.engine.libraryitems.IPlayableItem;
import nanofl.engine.libraryitems.ISpritableItem;
import nanofl.engine.movieclip.TweenedElement;

typedef SpriteParams =
{
    @:optional var currentFrame : Int;
}

class Sprite extends easeljs.display.Sprite
    implements nanofl.engine.AdvancableDisplayObject
{
    final symbol : ISpritableItem;

    public function new(symbol:ISpritableItem, params:SpriteParams)
    {
        super(symbol.spriteSheet);
        this.symbol = symbol;
        this.paused = !Std.isOfType(symbol, IPlayableItem) || !(cast symbol:IPlayableItem).autoPlay;
        this.currentFrame = params?.currentFrame ?? 0;
    }

    public function advanceTo(lifetimeOnParent:Int, framerate:Float, tweenedElement:TweenedElement)
    {
        if (paused) return;
        
        currentFrame = Std.min(symbol.spriteSheet.getNumFrames(), lifetimeOnParent);
    }
}