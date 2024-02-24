package nanofl;

import js.html.DivElement;
import nanofl.engine.TextureAtlasData;

typedef PlayerArgs = 
{
    var container : DivElement;
    var libraryData : Dynamic;
    @:optional var framerate : Float;
    @:optional var scaleMode: String;
    @:optional var textureAtlasesData:Array<Dynamic<TextureAtlasData>>;
}