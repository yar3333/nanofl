package nanofl.ide.sys;

@:rtti
interface Clipboard
{
    function writeText(data:String) : Void;
    function has(format:String) : Bool;
    function readText() : String;
    function readImageAsPngBytes() : haxe.io.Bytes;
}
