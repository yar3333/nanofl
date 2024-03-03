package nanofl;

import js.html.DivElement;
import easeljs.display.SpriteSheetData;

typedef PlayerArgs = 
{
    var container : DivElement;
    var libraryData : Dynamic;
    @:optional var framerate : Float;
    @:optional var scaleMode : String;
    @:optional var textureAtlasesData : Array<Dynamic<SpriteSheetData>>;
    @:optional var clickToStart : Bool;
}