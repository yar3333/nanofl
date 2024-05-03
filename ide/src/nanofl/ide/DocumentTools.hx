package nanofl.ide;

import js.lib.Promise;
import haxe.io.Path;
import stdlib.Uuid;
import nanofl.ide.DocumentProperties;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.plugins.Importer;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.ui.View;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using stdlib.StringTools;

@:rtti
class DocumentTools extends InjectContainer
{
	@inject var preferences : Preferences;
	@inject var fileSystem : FileSystem;
	@inject var view : View;
	@inject var folders : Folders;
	@inject var openedFiles : OpenedFiles;

    @:allow(nanofl.ide.Application.createNewEmptyDocument)
    function createTemporary(?properties:DocumentProperties) : Document
    {
        if (properties == null) properties = new DocumentProperties();
        var path = generateTempFilePath();
        var library = new IdeLibrary(Path.directory(path) + "/library");
        var document = new Document(path, properties, library);
        openedFiles.add(document);
        return document;
    }

    @:allow(nanofl.ide.Application.openDocument)
    function load(path:String) : Promise<Document>
    {
        path = Path.normalize(path);
        
        if (Path.extension(path) != "nfl") return import_(path);
        
        log("Loading " + path);
        
        view.waiter.show();
        return loadLibraryAndProperties(path, null).then((e:{ library:IdeLibrary, properties:DocumentProperties, lastModified:Date }) ->
        {
            if (e == null) { view.waiter.hide(); view.alerter.error("Can't load document '" + path + "'."); return null; }
            
            var document = new Document(path, e.properties, e.library, e.lastModified);
            document.library.fixErrors();
            return e.library.preload().then(_ ->
            {
                openedFiles.add(document);
                view.waiter.hide();
                return document;
            });
        });
    }
    
    public function loadLibraryAndProperties(path:String, lastModified:Date) : Promise<{ library:IdeLibrary, properties:DocumentProperties, lastModified:Date }>
    {
        if (fileSystem.exists(path) && !fileSystem.isDirectory(path))
        {
            final realLastModified = fileSystem.getDocumentLastModified(path);
            if (lastModified == null || lastModified.getTime() < realLastModified.getTime())
            {
                log("loadLibraryAndProperties " + path);
                
                final properties = DocumentProperties.load(path, fileSystem);
                final library = new IdeLibrary(Path.join([ Path.directory(path), "library" ]));
                return library.loadItems().then(_ ->
                ({
                    properties: properties,
                    library: library,
                    lastModified: realLastModified
                }));
            }
        }
        return Promise.resolve(null);
    }

    public function import_(path:String, ?importer:Importer) : Promise<Document>
    {
        log("Importing " + path);

        final document = createTemporary();
        return document.import_(path, importer).then(success -> success ? document : null);
    }

    function generateTempFilePath() : String
    {
        final name = Uuid.newUuid();
        return folders.unsavedDocuments + "/" + name + "/" + name + ".nfl";
    }
	
	static function log(v:Dynamic)
	{
		nanofl.engine.Log.console.trace("DocumentTools", Reflect.isFunction(v) ? v() : v);
	}
}