package nanofl;

import nanofl.engine.libraryitems.IPlayableItem;
import nanofl.engine.libraryitems.ISpritableItem;

class Sprite extends easeljs.display.Sprite
    implements nanofl.engine.AdvancableDisplayObject
{
    final symbol : ISpritableItem;

    public function new(symbol:ISpritableItem)
    {
        super(symbol.spriteSheet);
        this.symbol = symbol;
        this.paused = !Std.isOfType(symbol, IPlayableItem) || !(cast symbol:IPlayableItem).autoPlay;
    }

	public function advanceToNextFrame(#if ide framerate:Float #end) : Void
    {
        if (paused || Std.isOfType(symbol, IPlayableItem) && !(cast symbol:IPlayableItem).loop && currentFrame >= spriteSheet.getNumFrames() - 1) return;
        super.advance();
    }

    #if ide
    public function advanceTo(advanceFrames:Int)
    {
        stdlib.Debug.methodNotSupported(this);
    }
    #end
}