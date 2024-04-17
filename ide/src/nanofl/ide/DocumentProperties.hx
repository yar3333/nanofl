package nanofl.ide;

import stdlib.Std;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlDocument;
import nanofl.ide.sys.FileSystem;
import nanofl.engine.Version;
import nanofl.ide.PublishSettings;
import nanofl.ide.textureatlas.TextureAtlases;
using StringTools;
using stdlib.Lambda;

@:rtti
class DocumentProperties extends InjectContainer
{
	@inject var fileSystem : FileSystem;

    var version : String = Version.document;
	
	public var title : String;
	public var width : Int;
	public var height : Int;
	public var backgroundColor : String;
	public var framerate : Float;
	public var scaleMode : String;
	public var clickToStart : Bool;
	public var publishSettings : PublishSettings;
	
	public function new(title="", width=1280, height=720, backgroundColor="#FFFFFF", framerate=30.0, scaleMode="fit", clickToStart=false, ?publishSettings:PublishSettings)
	{
		super();
		
		this.title = title;
		this.width = width;
		this.height = height;
		this.backgroundColor = backgroundColor;
		this.framerate = framerate;
		this.scaleMode = scaleMode;
		this.clickToStart = clickToStart;
		this.publishSettings = publishSettings ?? new PublishSettings();
	}
	
	public static function load(filePath:String, fileSystem:FileSystem) : DocumentProperties
	{
		var content = fileSystem.getContent(filePath);
        
        //if (content.startsWith("<")) // expected project in XML format - version <= 2.x.x
        //{
            var xml = new XmlDocument(content);
		
            var version = xml.children[0].getAttribute("version");
            if (version == null || version == "") version = Version.document;
            
            var r = new DocumentProperties();
            Version.handle(version,
            [
                "1.0.0" => function() loadFromXml_1_0_0(xml.children[0], r),
                "2.2.0" => function() loadFromXml_2_2_0(xml.children[0], r)
            ]);
            return r;
        //}
        // else // expected JSON - version >= 3.x.x
        // {
        //     var r = Json.parseTyped(content, DocumentProperties);
        //     if (r.version == null || r.version == "") r.version = "0.0.0";
        //     return r;
        // }
	}
	
	static function loadFromXml_1_0_0(root:HtmlNodeElement, r:DocumentProperties)
	{
		for (node in root.find(">param"))
		{
			loadBaseParam(node.getAttribute("name"), node.getAttribute("value"), r);
		}
		
		r.publishSettings.textureAtlases = TextureAtlases.load(root);
	}
	
	static function loadFromXml_2_2_0(root:HtmlNodeElement, r:DocumentProperties)
	{
		for (node in root.find(">general>param"))
		{
			loadBaseParam(node.getAttribute("name"), node.getAttribute("value"), r);
		}
		
		r.publishSettings = PublishSettings.load(root);
	}
	
	static function loadBaseParam(name:String, value:String, r:DocumentProperties) : Bool
	{
		switch (name)
		{
			case "title":
				r.title = value;
				
			case "width":
				var n = Std.parseInt(value);
				if (n != null && n > 0) r.width = n;
				
			case "height":
				var n = Std.parseInt(value);
				if (n != null && n > 0) r.height = n;
				
			case "backgroundColor":
				r.backgroundColor = value;
				
			case "framerate":
				r.framerate = Std.parseFloat(value);
				
			case "scaleMode":
				r.scaleMode = value;
				
			case "clickToStart":
				r.clickToStart = Std.bool(value);
				
			case _:
				return false;
		}
		return true;
	}
	
	public function save(filePath:String)
	{
		var out = new htmlparser.XmlBuilder();
		
		out.begin("nanofl").attr("version", Version.document);
			
			out.begin("general");
				out.begin("param").attr("name", "title").attr("value", title).end();
				out.begin("param").attr("name", "width").attr("value", width).end();
				out.begin("param").attr("name", "height").attr("value", height).end();
				out.begin("param").attr("name", "backgroundColor").attr("value", nanofl.engine.ColorTools.normalize(backgroundColor)).end();
				out.begin("param").attr("name", "framerate").attr("value", framerate).end();
				out.begin("param").attr("name", "scaleMode").attr("value", scaleMode).end();
				out.begin("param").attr("name", "clickToStart").attr("value", clickToStart).end();
			out.end();
			
			publishSettings.save(out);
			
		out.end();
		
		fileSystem.saveContent(filePath, out.toString());

        // version = Version.document;
        // fileSystem.saveContent(filePath, Json.encode(this, Indented));
	}
	
	public function equ(p:DocumentProperties) : Bool
	{
		if (p == this) return true;
		
		return p.version == version
            && p.title == title
			&& p.width == width
			&& p.height == height
			&& p.backgroundColor == backgroundColor
			&& p.framerate == framerate
			&& p.scaleMode == scaleMode
			&& p.clickToStart == clickToStart
			&& p.publishSettings.equ(publishSettings);
	}
	
	public function clone() : DocumentProperties
	{
		return new DocumentProperties
		(
			title,
			width,
			height,
			backgroundColor,
			framerate,
			scaleMode,
			clickToStart,
			publishSettings.clone()
		);
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}
