package js.three.renderers.webgl;

@:native("THREE.WebGLUniforms") extern class WebGLUniforms {
	function new(gl:js.html.webgl.RenderingContext, program:js.three.renderers.webgl.WebGLProgram):Void;
	function setValue(gl:js.html.webgl.RenderingContext, name:String, value:Dynamic, textures:js.three.renderers.webgl.WebGLTextures):Void;
	function setOptional(gl:js.html.webgl.RenderingContext, object:Dynamic, name:String):Void;
	static function upload(gl:js.html.webgl.RenderingContext, seq:Dynamic, values:Array<Dynamic>, textures:js.three.renderers.webgl.WebGLTextures):Void;
	static function seqWithValue(seq:Dynamic, values:Array<Dynamic>):Array<Dynamic>;
}