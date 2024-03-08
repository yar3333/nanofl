package nanofl;

import stdlib.Debug;
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

    override function advance(?time:Float)
    {
        if (paused || Std.isOfType(symbol, IPlayableItem) && !(cast symbol:IPlayableItem).loop && currentFrame >= spriteSheet.getNumFrames() - 1) return;
        super.advance();
    }

    #if ide
    public function advanceTo(advanceFrames:Int)
    {
        Debug.methodNotSupported(this);
    }
    #end
}