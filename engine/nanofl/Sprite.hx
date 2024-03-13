package nanofl;

import nanofl.engine.libraryitems.IPlayableItem;
import nanofl.engine.libraryitems.ISpritableItem;

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

	public function advanceToNextFrame() : Void
    {
        if (paused || Std.isOfType(symbol, IPlayableItem) && !(cast symbol:IPlayableItem).loop && currentFrame >= spriteSheet.getNumFrames() - 1) return;
        super.advance();
    }

    #if ide
    public function advanceTo(advanceFrames:Int, framerate:Float)
    {
        stdlib.Debug.methodNotSupported(this);
    }
    #end
}