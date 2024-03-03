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

        supportDir = folders.application + "/templates";
	}

	public static function publishHtmlAndJsFiles(destDir:String, properties:DocumentProperties, addLinkToThreeJs:Bool, addLinkToApplicationJs:Bool) : Void
	{
        new CodePublisher(destDir, properties).publishHtmlAndJsFilesInner(addLinkToThreeJs, addLinkToApplicationJs);
    }

	function publishHtmlAndJsFilesInner(addLinkToThreeJs:Bool, addLinkToApplicationJs:Bool)
	{
		var template = fileSystem.getContent(supportDir + "/index.html");

        final hasTextureAtlases = properties.publishSettings.useTextureAtlases && properties.publishSettings.textureAtlases.iterator().hasNext();
		
        template = template.replace("{title}", properties.title != "" ? properties.title : Path.withoutDirectory(Path.withoutExtension(destDir)));
		template = template.replace("{width}", properties.width + "px");
		template = template.replace("{height}", properties.height + "px");
		template = template.replace("{backgroundColor}", properties.backgroundColor);
		template = template.replace("{framerate}", Std.string(properties.framerate));
		template = template.replace("{scaleMode}", properties.scaleMode);
		template = template.replace("{textureAtlasesData}", hasTextureAtlases ? "textureAtlasesData" : "null");
		template = template.replace("{clickToStart}", properties.clickToStart ? "true" : "false");
		template = template.replace("{preContainer}", properties.publishSettings.urlOnClick != "" ? "<a href='" + properties.publishSettings.urlOnClick + "' target='_blank'>\n\t\t\t" : "");
		template = template.replace("{postContainer}", properties.publishSettings.urlOnClick != "" ? "\n\t\t</a>" : "");
		template = template.replace("{playerVersion}", Version.player);

        if (!addLinkToThreeJs)
        {
            template = ~/[ \t]*[<][!]-- NANOFL_BEGIN_THREE --[>].*?[<][!]-- NANOFL_END_THREE --[>]\r\n/s.replace(template, "");
        }
        else
        {
            template = ~/[ \t]*[<][!]-- NANOFL_BEGIN_THREE --[>]\r\n/s.replace(template, "");
            template = ~/[ \t]*[<][!]-- NANOFL_END_THREE --[>]\r\n/s.replace(template, "");
        }

        if (!hasTextureAtlases)
        {
            template = template.replace('\t\t<script defer src="texture-atlases.js"></script>\r\n', '');
            template = template.replace('                    textureAtlasesData: null,\r\n', '');
        }
            
        if (!addLinkToApplicationJs)
        {
            template = template.replace('\t\t<script defer src="scripts/application.js"></script>\r\n', '');
        }

        if (properties.publishSettings.useLocalScripts)
        {
            template = ~/https:[^"]+?\/easeljs[.]js/.replace(template, "scripts/easeljs-1.0.0.js");
            template = ~/https:[^"]+?\/nanofl-[0-9.]+?[.]js/.replace(template, "scripts/nanofl-" + Version.player + ".js");
            template = ~/https:[^"]+?\/three[.]module[.]js/.replace(template, "./scripts/three-r161.js");
            template = ~/https:[^"]+?\/three[@0-9.]*?\/examples\/jsm\//.replace(template, "./scripts/three-addons/");
        }
		
		fileSystem.saveContent(destDir + "/index.html", template);
		
		prepareLocalScriptFiles(addLinkToThreeJs);
	}
	
	function prepareLocalScriptFiles(addLinkToThreeJs:Bool)
	{
        if (properties.publishSettings.useLocalScripts)
        {
            exportScriptFile("easeljs-1.0.0.js");
            if (addLinkToThreeJs)
            {
                exportScriptFile("three-r161.js");
                exportScriptFile("three-addons/loaders/GLTFLoader.js");
                exportScriptFile("three-addons/utils/BufferGeometryUtils.js");
            }
            fileSystem.copyFile(supportDir + "/scripts/nanofl-" + Version.player + ".js", destDir + "/scripts/nanofl-" + Version.player + ".js");
        }
        else
        {
            fileSystem.deleteFile(destDir + "/scripts/easeljs-1.0.0.js");
            fileSystem.deleteFile(destDir + "/scripts/three-r161.js");
            fileSystem.deleteDirectoryRecursively(destDir + "/scripts/three-addons");
            fileSystem.deleteFile(destDir + "/scripts/nanofl-" + Version.player + ".js");
            try { fileSystem.deleteEmptyDirectory(destDir + "/scripts"); } catch (_) {}
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