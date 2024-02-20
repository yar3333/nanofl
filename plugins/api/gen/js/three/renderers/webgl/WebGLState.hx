package js.three.renderers.webgl;

@:native("THREE.WebGLState") extern class WebGLState {
	function new(gl:js.html.webgl.RenderingContext, extensions:js.three.renderers.webgl.WebGLExtensions, capabilities:js.three.renderers.webgl.WebGLCapabilities):Void;
	var buffers : { var color : js.three.renderers.webgl.WebGLColorBuffer; var depth : js.three.renderers.webgl.WebGLDepthBuffer; var stencil : js.three.renderers.webgl.WebGLStencilBuffer; };
	function enable(id:Int):Void;
	function disable(id:Int):Void;
	function bindFramebuffer(target:Float, framebuffer:js.html.webgl.Framebuffer):Void;
	function drawBuffers(renderTarget:js.three.renderers.WebGLRenderTarget<js.three.textures.Texture>, framebuffer:js.html.webgl.Framebuffer):Void;
	function useProgram(program:Dynamic):Bool;
	function setBlending(blending:js.three.Blending, ?blendEquation:js.three.BlendingEquation, ?blendSrc:js.three.BlendingSrcFactor, ?blendDst:js.three.BlendingDstFactor, ?blendEquationAlpha:js.three.BlendingEquation, ?blendSrcAlpha:js.three.BlendingSrcFactor, ?blendDstAlpha:js.three.BlendingDstFactor, ?premultiplyAlpha:Bool):Void;
	function setMaterial(material:js.three.materials.Material, frontFaceCW:Bool):Void;
	function setFlipSided(flipSided:Bool):Void;
	function setCullFace(cullFace:js.three.CullFace):Void;
	function setLineWidth(width:Float):Void;
	function setPolygonOffset(polygonoffset:Bool, ?factor:Float, ?units:Float):Void;
	function setScissorTest(scissorTest:Bool):Void;
	function activeTexture(webglSlot:Float):Void;
	function bindTexture(webglType:Float, webglTexture:Dynamic):Void;
	function unbindTexture():Void;
	function compressedTexImage2D(target:Float, level:Float, internalformat:Float, width:Float, height:Float, border:Float, data:js.lib.ArrayBufferView):Void;
	@:overload(function(target:Float, level:Float, internalformat:Float, format:Int, type:Int, source:Dynamic):Void { })
	function texImage2D(target:Float, level:Float, internalformat:Float, width:Float, height:Float, border:Float, format:Int, type:Int, pixels:js.lib.ArrayBufferView):Void;
	function texImage3D(target:Float, level:Float, internalformat:Float, width:Float, height:Float, depth:Float, border:Float, format:Int, type:Int, pixels:Dynamic):Void;
	function scissor(scissor:js.three.math.Vector4):Void;
	function viewport(viewport:js.three.math.Vector4):Void;
	function reset():Void;
}