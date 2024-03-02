package nanofl.ide.filesystem;

import haxe.Json;
import stdlib.ExceptionTools;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlDocument;
import nanofl.ide.sys.FileSystem;

@:rtti
class CachedFile extends InjectContainer
{
	@inject var fileSystem : FileSystem;
	
	var libraryDir : String;
	
	var _text : String;
	public var text(get, never) : String;
	function get_text()
	{
		if (_text == null)
		{
			_text = fileSystem.getContent(libraryDir + "/" + relativePath);
		}
		return _text;
	}
	
	var _xml : HtmlNodeElement;
	public var xml(get, never) : HtmlNodeElement;
	function get_xml()
	{
		if (_xml == null)
		{
			try
			{
				var doc = new XmlDocument(text);
				if (doc.children.length == 1)
				{
					_xml = doc.children[0];
				}
				else
				{
					trace("Error XmlParser.parse(" + libraryDir + "/" + relativePath + "): must have exactly one root element (" + doc.children.length + ").");
				}
			}
			catch (e:Dynamic)
			{
				trace("Error XmlParser.parse(" + libraryDir + "/" + relativePath + "): " + ExceptionTools.string(e));
			}
		}
		return _xml;
	}
	
	var _json : Dynamic;
	public var json(get, never) : Dynamic;
	function get_json()
	{
		if (_json == null)
		{
			try
			{
				_json = Json.parse(text);
			}
			catch (e:Dynamic)
			{
				trace("Error Json.parse(" + libraryDir + "/" + relativePath + "): " + ExceptionTools.string(e));
			}
		}
		return _json;
	}
	
	public var relativePath(default, null) : String;
	
	public function new(libraryDir:String, relativePath:String)
	{
		super();
		
		this.libraryDir = libraryDir;
		this.relativePath = relativePath;
	}
}
