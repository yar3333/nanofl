package nanofl.engine;

class SerializationAsJsTools
{
    #if ide
    public static function save(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String, namePath:String, data:Dynamic)
    {
        fileSystem.saveContent
        (
            destLibraryDir + "/" + namePath + ".js",
            'nanofl.libraryFiles ||= {}; nanofl.libraryFiles["' + namePath + '"] = ' + haxe.Json.stringify(data)
        );        
    }
    #end

    public static function load(library:Library, namePath:String, removeAfterLoad:Bool) : js.lib.Promise<Dynamic>
    {
        return Loader.javaScript(library.realUrl(namePath + ".js")).then(_ ->
        {
            if (!(cast js.Browser.window).nanofl) throw new js.lib.Error("Global `nanofl` is not found.");
            if (!(cast js.Browser.window).nanofl.libraryFiles) throw new js.lib.Error("Global `nanofl.libraryFiles` is not found.");
            var libraryFiles = (cast js.Browser.window).nanofl.libraryFiles;
            var r = js.Syntax.field(libraryFiles, namePath);
            if (js.Syntax.typeof(r) == "undefined") throw new js.lib.Error('Global `nanofl.libraryFiles["' + namePath + '"]` is not found.');
            if (removeAfterLoad) Reflect.deleteField(libraryFiles, namePath);
            return r;
        });
    }
}
