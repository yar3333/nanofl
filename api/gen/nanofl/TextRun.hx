package nanofl;

extern class TextRun {
	function new(?characters:String, ?fillColor:String, ?size:Float):Void;
	var characters : String;
	var fillColor : String;
	var family : String;
	var style : String;
	var size : Float;
	var align : String;
	var strokeSize : Float;
	var strokeColor : String;
	var kerning : Bool;
	var letterSpacing : Float;
	var lineSpacing : Float;
	function getFontString():String;
	function clone():nanofl.TextRun;
	function duplicate(?characters:String):nanofl.TextRun;
	function equ(textRun:nanofl.TextRun):Bool;
	function createText(?color:String, ?outline:Float):easeljs.display.Text;
	function isFilled():Bool;
	function isStroked():Bool;
	function applyFormat(format:nanofl.TextRun):nanofl.TextRun;
	static function create(characters:String, fillColor:String, family:String, style:String, size:Float, align:String, strokeSize:Float, strokeColor:String, kerning:Bool, letterSpacing:Float, lineSpacing:Float):nanofl.TextRun;
	static function optimize(textRuns:Array<nanofl.TextRun>):Array<nanofl.TextRun>;
}