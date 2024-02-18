package nanofl.engine;

extern class FontVariant {
	function new(?style:String, ?weight:Int, ?locals:Array<String>, ?urls:Map<String, String>):Void;
	/**
		
			 * "normal", "italic"
			 
	**/
	var style : String;
	/**
		
			 * 100=thin, 300=light, 400=normal, 600=semiBold, 700=bold, 800=extraBold
			 
	**/
	var weight : Int;
	/**
		
			 * Possible font name in system to prevent loading from web if exists locally ("Open Sans Bold", "OpenSans-Bold").
			 
	**/
	var locals : Array<String>;
	/**
		
			 * format => url (can be relative to the library directory).
			 
	**/
	var urls : Map<String, String>;
	function equ(e:nanofl.engine.FontVariant):Bool;
	function getUrlByFormats(formats:Array<String>):String;
}