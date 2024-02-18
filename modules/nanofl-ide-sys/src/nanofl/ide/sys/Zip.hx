package nanofl.ide.sys;

@:rtti
interface Zip
{
	function compress(srcDir:String, destZip:String, ?relFilePaths:Array<String>) : Bool;
	function decompress(srcZip:String, destDir:String, ?elevated:Bool) : Bool;
}