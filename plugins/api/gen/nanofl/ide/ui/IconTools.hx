package nanofl.ide.ui;

extern class IconTools {
	static function parse(icon:String):{ var iconClass : String; var iconStyle : String; };
	static function toHtml(icon:String):String;
	static function write(icon:String, out:htmlparser.XmlBuilder):htmlparser.XmlBuilder;
}