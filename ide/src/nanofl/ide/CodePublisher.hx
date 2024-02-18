package nanofl.ide;

import haxe.io.Path;
import nanofl.engine.Version;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.DocumentProperties;
using stdlib.Lambda;
using stdlib.StringTools;

@:rtti
class CodePublisher extends InjectContainer
{
	@inject var fileSystem : FileSystem;
	@inject var folders : Folders;

	var destDir : String;
	var properties : DocumentProperties;
	
	final supportDir: String;
	
    function new(destDir:String, properties:DocumentProperties)
	{
        super();

		this.destDir = destDir;
		this.properties = properties;

        supportDir = folders.application + "/" + "templates";
	}

	public static function publishHtmlAndJsFiles(destDir:String, properties:DocumentProperties, addLinkToThreeJs:Bool, addLinkToApplicationJs:Bool) : Void
	{
        new CodePublisher(destDir, properties).publishHtmlAndJsFilesInner(addLinkToThreeJs, addLinkToApplicationJs);
    }

	function publishHtmlAndJsFilesInner(addLinkToThreeJs:Bool, addLinkToApplicationJs:Bool)
	{
		var template = fileSystem.getContent(supportDir + "/project" + (addLinkToThreeJs ? "-threejs":"") + ".html");

        final hasTextureAtlases = properties.publishSettings.useTextureAtlases && properties.publishSettings.textureAtlases.iterator().hasNext();
		
        template = template.replace("{title}", properties.title != "" ? properties.title : Path.withoutDirectory(Path.withoutExtension(destDir)));
		template = template.replace("{width}", properties.width + "px");
		template = template.replace("{height}", properties.height + "px");
		template = template.replace("{backgroundColor}", properties.backgroundColor);
		template = template.replace("{framerate}", Std.string(properties.framerate));
		template = template.replace("{scaleMode}", properties.scaleMode);
		template = template.replace("{textureAtlasesData}", hasTextureAtlases ? "textureAtlasesData" : "null");
		template = template.replace("{preContainer}", properties.publishSettings.urlOnClick != "" ? "<a href='" + properties.publishSettings.urlOnClick + "' target='_blank'>\n\t\t\t" : "");
		template = template.replace("{postContainer}", properties.publishSettings.urlOnClick != "" ? "\n\t\t</a>" : "");
		template = template.replace("{playerVersion}", Version.player);

        if (!hasTextureAtlases)
        {
            template = template.replace('\t\t<script src="texture-atlases.js"></script>\r\n', '');
        }
        
        if (addLinkToApplicationJs)
        {
            template = ~/[ \t]*[<][!]-- BEGIN NOT APP --[>].*?[<][!]-- END --[>]\r\n/s.replace(template, "");
            template = ~/[ \t]*[<][!]-- BEGIN APP --[>]\r\n/s.replace(template, "");
            template = ~/[ \t]*[<][!]-- END --[>]\r\n/s.replace(template, "");
        }
        else
        {
            template = template.replace('\t\t<script src="application.js"></script>\r\n', '');
            template = ~/[ \t]*[<][!]-- BEGIN APP --[>].*?[<][!]-- END --[>]\r\n/s.replace(template, "");
            template = ~/[ \t]*[<][!]-- BEGIN NOT APP --[>]\r\n/s.replace(template, "");
            template = ~/[ \t]*[<][!]-- END --[>]\r\n/s.replace(template, "");
        }

        if (properties.publishSettings.useLocalScripts)
        {
            template = template.replace("https://code.createjs.com/createjs-2014.12.12.combined.js",  "scripts/createjs-1.0.0.js");
            template = template.replace("http://player.nanofl.com/nanofl-" + Version.player + ".js", "scripts/nanofl-" + Version.player + ".js");
            template = template.replace("https://unpkg.com/three@0.161.0/build/three.module.js", "scripts/three-r161.js");
            template = template.replace("https://unpkg.com/three@0.161.0/examples/jsm/", "scripts/three-addons/");
        }
		
		fileSystem.saveContent(destDir + "/index.html", template);
		
		prepareLocalScriptFiles(addLinkToThreeJs);
	}
	
	function prepareLocalScriptFiles(addLinkToThreeJs:Bool)
	{
        if (properties.publishSettings.useLocalScripts)
        {
            exportScriptFile("createjs-1.0.0.js");
            if (addLinkToThreeJs)
            {
                exportScriptFile("three-r161.js");
                exportScriptFile("three-addons/loaders/GLTFLoader.js");
                exportScriptFile("three-addons/utils/BufferGeometryUtils.js");
            }
            exportScriptFile("nanofl-" + Version.player + ".js");
        }
        else
        {
            fileSystem.deleteDirectoryRecursively(destDir + "/scripts");
        }
	}

    function exportScriptFile(fileName:String)
    {
        var srcDir = supportDir + "/scripts";
        if (!fileSystem.exists(destDir + "/scripts/" + fileName))
        {
            fileSystem.copyFile(srcDir + "/" + fileName, destDir + "/scripts/" + fileName);
        }
    }
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}