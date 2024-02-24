package nanofl.ide;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import datatools.MapTools;
import nanofl.ide.textureatlas.TextureAtlasParams;
import nanofl.ide.textureatlas.TextureAtlases;
import stdlib.Std;

class PublishSettings
{
	public var useTextureAtlases : Bool;
	public var textureAtlases : Map<String, TextureAtlasParams>;
	public var isConvertImagesIntoJpeg : Bool;
	public var jpegQuality : Int;
	public var audioQuality : Int;
	public var urlOnClick : String;
	public var useLocalScripts : Bool;
	
	public function new(useTextureAtlases=false, ?textureAtlases:Map<String, TextureAtlasParams>, isConvertImagesIntoJpeg=true, jpegQuality=80,  audioQuality=128, urlOnClick="", useLocalScripts=false)
	{
		this.useTextureAtlases = useTextureAtlases;
		this.textureAtlases = textureAtlases != null ? textureAtlases : new Map();
		this.isConvertImagesIntoJpeg = isConvertImagesIntoJpeg;
		this.jpegQuality = jpegQuality;
		this.audioQuality = audioQuality;
		this.urlOnClick = urlOnClick;
		this.useLocalScripts = useLocalScripts;
	}
	
	public function equ(p:PublishSettings) : Bool
	{
		if (this == p) return true;
		return p.useTextureAtlases == useTextureAtlases
			&& MapTools.equ(p.textureAtlases, textureAtlases)
			&& p.isConvertImagesIntoJpeg == isConvertImagesIntoJpeg 
			&& p.jpegQuality == jpegQuality
			&& p.audioQuality == audioQuality
			&& p.urlOnClick == urlOnClick
			&& p.useLocalScripts == useLocalScripts;
	}
	
	public function clone() : PublishSettings
	{
		return new PublishSettings
		(
			useTextureAtlases,
			MapTools.clone(textureAtlases),
			isConvertImagesIntoJpeg,
			jpegQuality,
			audioQuality,
			urlOnClick,
			useLocalScripts,
		);
	}
	
	public static function load(xml:HtmlNodeElement) : PublishSettings
	{
		var r = new PublishSettings();
		
		for (node in xml.find(">publishSettings>param"))
		{
			var name = node.getAttribute("name");
			var value = node.getAttribute("value");
			
			switch (name)
			{
				case "useTextureAtlases":		r.useTextureAtlases = Std.bool(value);
				case "isConvertImagesIntoJpeg":	r.isConvertImagesIntoJpeg = Std.bool(value);
				case "jpegQuality":				r.jpegQuality = Std.parseInt(value);
				case "audioQuality":			r.audioQuality = Std.parseInt(value);
				case "urlOnClick":				r.urlOnClick = value;
				case "useLocalScripts":			r.useLocalScripts = Std.bool(value);
			}
		}
		
		r.textureAtlases = TextureAtlases.load(xml);
		
		return r;
	}
	
	public function save(out:XmlBuilder)
	{
		out.begin("publishSettings");
			
			out.begin("param").attr("name", "useTextureAtlases")		.attr("value", useTextureAtlases)		.end();
			out.begin("param").attr("name", "isConvertImagesIntoJpeg")	.attr("value", isConvertImagesIntoJpeg)	.end();
			out.begin("param").attr("name", "jpegQuality")				.attr("value", jpegQuality)				.end();
			out.begin("param").attr("name", "audioQuality")				.attr("value", audioQuality)			.end();
			out.begin("param").attr("name", "urlOnClick")				.attr("value", urlOnClick)				.end();
			out.begin("param").attr("name", "useLocalScripts")			.attr("value", useLocalScripts)			.end();
			
		out.end();
		
		TextureAtlases.save(textureAtlases, out);
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}