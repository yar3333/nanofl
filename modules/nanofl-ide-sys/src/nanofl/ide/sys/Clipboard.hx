package nanofl.ide.sys;

@:rtti
interface Clipboard
{
    function hasText() : Bool;
    function hasImage() : Bool;
    
    function readText() : String;
    function readImageAsPngBytes() : haxe.io.Bytes;
    
    function writeText(data:String) : Void;
}
