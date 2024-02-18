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
			_text = fileSystem.getContent(libraryDir + "/" + path);
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
					trace("Error XmlParser.parse(" + libraryDir + "/" + path + "): must have exactly one root element (" + doc.children.length + ").");
				}
			}
			catch (e:Dynamic)
			{
				trace("Error XmlParser.parse(" + libraryDir + "/" + path + "): " + ExceptionTools.string(e));
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
				trace("Error Json.parse(" + libraryDir + "/" + path + "): " + ExceptionTools.string(e));
			}
		}
		return _json;
	}
	
	/**
	 * Relative file path.
	 */
	public var path(default, null) : String;
	
	/**
	 * If true - skip this file.
	 */
	public var excluded(default, null) = false;
	
	public function new(libraryDir:String, path:String)
	{
		super();
		
		this.libraryDir = libraryDir;
		this.path = path;
	}
	
	public function exclude() excluded = true;
}
