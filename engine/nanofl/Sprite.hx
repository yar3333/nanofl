package nanofl;

import nanofl.engine.libraryitems.ISpritableItem;

class Sprite extends easeljs.display.Sprite
    implements nanofl.engine.AdvancableDisplayObject
{
    public function new(symbol:ISpritableItem)
    {
        super(symbol.spriteSheet);    
    }
}