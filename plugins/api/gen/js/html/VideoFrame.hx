package js.html;

@:native("VideoFrame") extern class VideoFrame {
	@:overload(function(image:js.html.CanvasImageSource, ?init:js.html.VideoFrame.VideoFrameInit):js.html.VideoFrame { })
	function new(data:js.lib.BufferSource, init:js.html.VideoFrame.VideoFrameBufferInit):Void;
}

interface VideoFrameBufferInit {
	var codedHeight : Int;
	var codedWidth : Int;
	@:optional
	var colorSpace : js.html.VideoFrame.VideoColorSpaceInit;
	@:optional
	var displayHeight : Int;
	@:optional
	var displayWidth : Int;
	@:optional
	var duration : Float;
	var format : js.html.VideoFrame.VideoPixelFormat;
	@:optional
	var layout : Array<js.html.VideoFrame.PlaneLayout>;
	var timestamp : Float;
	@:optional
	var visibleRect : js.html.VideoFrame.DOMRectInit;
}

interface VideoColorSpaceInit {
	@:optional
	var fullRange : Bool;
	@:optional
	var matrix : js.html.VideoFrame.VideoMatrixCoefficients;
	@:optional
	var primaries : js.html.VideoFrame.VideoColorPrimaries;
	@:optional
	var transfer : Dynamic;
}

@:enum typedef VideoPixelFormat = String;

interface PlaneLayout {
	var offset : Int;
	var stride : Int;
}

interface DOMRectInit {
	@:optional
	var height : Int;
	@:optional
	var width : Int;
	@:optional
	var x : Int;
	@:optional
	var y : Int;
}

@:enum typedef VideoMatrixCoefficients = String;

@:enum typedef VideoColorPrimaries = String;

interface VideoFrameInit {
	@:optional
	var alpha : js.html.VideoFrame.AlphaOption;
	@:optional
	var displayHeight : Int;
	@:optional
	var displayWidth : Int;
	@:optional
	var duration : Float;
	@:optional
	var timestamp : Float;
	@:optional
	var visibleRect : js.html.VideoFrame.DOMRectInit;
}

@:enum typedef AlphaOption = String;