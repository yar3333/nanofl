package nanofl;

import js.lib.Promise;

class Sprite extends easeljs.display.Sprite
    implements nanofl.engine.AdvancableDisplayObject
{
    public function advance() : Promise<{}>
    {
        super.advanceNative();
        return Promise.resolve(null);
    }
}