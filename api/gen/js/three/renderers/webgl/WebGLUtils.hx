package js.three.renderers.webgl;

@:native("THREE.WebGLUtils") extern class WebGLUtils {
	function new(gl:haxe.extern.EitherType<js.html.webgl.RenderingContext, js.html.webgl.WebGL2RenderingContext>, extensions:Dynamic, capabilities:Dynamic):Void;
	function convert(p:haxe.extern.EitherType<js.three.PixelFormat, haxe.extern.EitherType<js.three.CompressedPixelFormat, js.three.TextureDataType>>, ?encoding:js.three.TextureEncoding):Float;
}