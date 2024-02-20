package js.three.renderers.webgl;

@:native("THREE.WebGLAttributes") extern class WebGLAttributes {
	function new(gl:haxe.extern.EitherType<js.html.webgl.RenderingContext, js.html.webgl.WebGL2RenderingContext>, capabilities:js.three.renderers.webgl.WebGLCapabilities):Void;
	function get(attribute:haxe.extern.EitherType<js.three.core.BufferAttribute, haxe.extern.EitherType<js.three.core.InterleavedBufferAttribute, js.three.core.GLBufferAttribute>>):{ var buffer : js.html.webgl.WebGLBuffer; var bytesPerElement : Float; var size : Float; var type : Float; var version : Float; };
	function remove(attribute:haxe.extern.EitherType<js.three.core.BufferAttribute, haxe.extern.EitherType<js.three.core.InterleavedBufferAttribute, js.three.core.GLBufferAttribute>>):Void;
	function update(attribute:haxe.extern.EitherType<js.three.core.BufferAttribute, haxe.extern.EitherType<js.three.core.InterleavedBufferAttribute, js.three.core.GLBufferAttribute>>, bufferType:Float):Void;
}