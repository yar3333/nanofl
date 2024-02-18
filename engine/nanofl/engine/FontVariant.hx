package nanofl.engine;

using datatools.MapTools;

class FontVariant
{
	/**
	 * "normal", "italic"
	 */
	public var style : String;
	
	/**
	 * 100=thin, 300=light, 400=normal, 600=semiBold, 700=bold, 800=extraBold
	 */
	public var weight : Int;
	
	/**
	 * Possible font name in system to prevent loading from web if exists locally ("Open Sans Bold", "OpenSans-Bold").
	 */
	public var locals : Array<String>;
	
	/**
	 * format => url (can be relative to the library directory).
	 */
	public var urls : Map<String, String>;
	
	public function new(style="normal", weight=400, ?locals:Array<String>, ?urls:Map<String, String>)
	{
		this.style = style;
		this.weight = weight;
		this.locals = locals != null ? locals : [];
		this.urls = urls != null ? urls : new Map();
	}
	
	public function equ(e:FontVariant) : Bool
	{
		return e.style == style && e.weight == weight && MapTools.equFast(e.urls, urls);
	}
	
	public function getUrlByFormats(formats:Array<String>) : String
	{
		for (format in formats)
		{
			if (urls.exists(format)) return urls.get(format);
		}
		return null;
	}
}
