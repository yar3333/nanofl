package nanofl.ide;

import haxe.io.Path;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.TextElement;
import nanofl.ide.libraryitems.IIdeInstancableItem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.FileSystem;
using stdlib.Lambda;
using stdlib.StringTools;

@:rtti
class CodeGenerator extends InjectContainer
{
	@inject var fileSystem : FileSystem;
	@inject var folders : Folders;

    var library : IdeLibrary;

    function new(library:IdeLibrary)
    {
        super();
        this.library = library;
    }
	
	public static function generate(library:IdeLibrary, destDir:String)
	{
        var generator = new CodeGenerator(library);
        generator.generateBaseTsFile(destDir + "/base.ts");
        generator.generateSoundsTsFile(destDir + "/Sounds.ts");
        generator.generateUserTsFiles(Path.directory(destDir));
    }

    function generateUserTsFiles(destDir:String)
    {
        var instancableItems = library.getInstancableItemsAsIde().filter(x -> !StringTools.isNullOrEmpty(x.linkedClass));
        for (item in instancableItems)
        {
            generateUserTsFile(item, destDir + "/" + item.linkedClass + ".ts");
        }
    }

    function generateUserTsFile(item:IIdeInstancableItem, destTsFilePath:String)
    {
        if (fileSystem.exists(destTsFilePath)) return;

        fileSystem.saveContent
        (
            destTsFilePath,
            "// This file is autogenerated by NanoFL\n\n"
            + "/// <reference types='nanofl-ts' />\n\n"
            + "import { base } from './autogenerated/base.ts';\n\n"
            + "export class " + item.linkedClass + " extends base." + item.linkedClass + "\n"
            + "{\n"
            + "\t\n"
            + "}\n"
        );
    }

	function generateBaseTsFile(destTsFilePath:String)
	{
        var instancableItems = library.getInstancableItemsAsIde().filter(x -> !StringTools.isNullOrEmpty(x.linkedClass));
        
		fileSystem.createDirectory(Path.directory(destTsFilePath));
        fileSystem.saveContent
        (
            destTsFilePath,
            "// This file is autogenerated by NanoFL\n\n"
            + "/// <reference types='nanofl-ts' />\n\n"
            + getImportsUserClasses(instancableItems)
            + "export namespace base\n"
            + "{\n"
            + instancableItems.map(x -> getInstanceBaseClassDefinition(x)).join("\n")
            + "}\n"
        );
	}

	function generateSoundsTsFile(destTsFilePath:String)
	{
		fileSystem.createDirectory(Path.directory(destTsFilePath));
        fileSystem.saveContent
        (
            destTsFilePath,
            "// This file is autogenerated by NanoFL\n\n"
            + "/// <reference types='nanofl-ts' />\n\n"
            + getSoundsClass(library.getSoundsAsIde())
        );
	}

    function getImportsUserClasses(items:Array<IIdeInstancableItem>) : String
    {
        if (items.length == 0) return "";
        return items.map(x -> "import { " + x.linkedClass + " as _" + x.linkedClass + " } from '../" + x.linkedClass + "';\n").join("") + "\n";
    }
	
	function getInstanceBaseClassDefinition(item:IIdeInstancableItem) : String
	{
        var klass = splitFullClassName(item.linkedClass);
        
        var text = "";
        if (klass.pack != "") text += "declare namespace " + klass.pack + " {\n";
        text += "\texport class " + klass.name + " extends " + item.getDisplayObjectClassName() + "\n";
        text += "\t{\n";
        text += "\t\tconstructor() {\n";
        text += "\t\t\tsuper(nanofl.Player.library.getItem(\"" + item.namePath + "\"));\n";
        text += "\t\t}\n";
        text += getInstanceChildByNameGetters(item);
        text += "\t}\n";

        // var classFile = baseDir + "/src/" + item.linkedClass.replace(".", "/") + ".hx";
        // if (!fileSystem.exists(classFile))
        // {
        //     fileSystem.saveContent
        //     (
        //         classFile,
        //         (klass.pack != "" ? "package " + klass.pack + ";\n\n" : "") +
        //         movieClipTemplate
        //             .replace("{className}", klass.name)
        //             .replace("{baseClassName}", "base." + item.linkedClass)
        //     );
        // }

        return text;
	}
	
	function getInstanceChildByNameGetters(item:IIdeInstancableItem) : String
	{
        var r = [];

		if (Std.isOfType(item, MovieClipItem))
		{
            for (element in MovieClipItemTools.getElements((cast item : MovieClipItem)))
            {
                var k = getNamedElementData(element);
                if (k != null)
                {
                    var str = "\t\tget " + k.name + "() { return this.getChildByName(\"" + k.name + "\") as " + k.klass + " }\n";
                    if (!r.contains(str)) r.push(str);
                }
            }
		}
		
		return r.join("");
	}
	
	function getNamedElementData(element:Element) : { name:String, klass:String }
	{
		if (Std.isOfType(element, TextElement))
		{
			var elem : TextElement = cast element;
			if (!elem.name.isNullOrEmpty())
			{
				return { name:elem.name, klass:"nanofl.TextField" };
			}
		}
		else
		if (Std.isOfType(element, Instance))
		{
			var elem : Instance = cast element;
			if (!elem.name.isNullOrEmpty())
			{
				if (elem.symbol.linkedClass.isNullOrEmpty())
				{
					return { name:elem.name, klass:elem.symbol.getDisplayObjectClassName() };
				}
				
				return { name:elem.name, klass:"_" + elem.symbol.linkedClass };
			}
		}
		
		return null;
	}
	
	function getSoundsClass(sounds:Array<SoundItem>) : String
	{
        sounds = sounds.filter(x -> !StringTools.isNullOrEmpty(x.linkage));

		var text = "";
		text += "export class Sounds\n";
		text += "{\n";
		
		for (sound in sounds)
		{
			text += "\tstatic " + sound.linkage + "(interrupt?:any, delay?:number, offset?:number, loop?:number, volume?:number, pan?:number) : createjs.AbstractSoundInstance { return createjs.Sound.play(\"" + sound.linkage + "\", interrupt, delay, offset, loop, volume, pan) }\n";
		}
		
		text += "}\n";

		return text;
	}
	
	function splitFullClassName(fullClassName:String) : { pack:String, name:String }
	{
		var n = fullClassName.lastIndexOf(".");
		return
		{
			pack: n >= 0 ? fullClassName.substring(0, n) : "",
			name: n >= 0 ? fullClassName.substring(n + 1) : fullClassName
		};
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
