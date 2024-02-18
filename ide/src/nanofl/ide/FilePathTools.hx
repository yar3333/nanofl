package nanofl.ide;

class FilePathTools
{
	public static function normalize(path:String) : String
    {
        path = StringTools.replace(path, "\\", "/");
        while (path.length > 1 && path.charAt(path.length - 1) == "/") path = path.substr(0, -1);
        return path;
    }    
}