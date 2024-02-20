package js.html.webgl;

/**
 The `WebGLRenderingContext` interface provides the OpenGL ES 2.0 rendering context for the drawing surface of an HTML `canvas` element.
 
 Documentation [WebGLRenderingContext](https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext>
 */
/**
	
		The `WebGLRenderingContext` interface provides the OpenGL ES 2.0 rendering context for the drawing surface of an HTML `canvas` element.
	
		Documentation [WebGLRenderingContext](https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext>
	
**/
@:native("WebGLRenderingContext") extern class RenderingContext {
	/**
		
				A read-only back-reference to the `HTMLCanvasElement`. Might be `null` if it is not associated with a `canvas` element.
			
	**/
	var canvas(default, null) : js.html.CanvasElement;
	/**
		
				The read-only width of the current drawing buffer. Should match the width of the canvas element associated with this context.
			
	**/
	var drawingBufferWidth(default, null) : Int;
	/**
		
				The read-only height of the current drawing buffer. Should match the height of the canvas element associated with this context.
			
	**/
	var drawingBufferHeight(default, null) : Int;
	/**
		
				Updates buffer data.
			
	**/
	@:overload(function(target:Int, size:Int, usage:Int):Void { })
	@:overload(function(target:Int, data:js.lib.ArrayBuffer, usage:Int):Void { })
	function bufferData(target:Int, data:js.lib.ArrayBufferView, usage:Int):Void;
	/**
		
				Updates buffer data starting at a passed offset.
			
	**/
	@:overload(function(target:Int, offset:Int, data:js.lib.ArrayBuffer):Void { })
	function bufferSubData(target:Int, offset:Int, data:js.lib.ArrayBufferView):Void;
	/**
		
				Specifies a 2D texture image in a compressed format.
			
	**/
	function compressedTexImage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, data:js.lib.ArrayBufferView):Void;
	/**
		
				Specifies a 2D texture sub-image in a compressed format.
			
	**/
	function compressedTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, data:js.lib.ArrayBufferView):Void;
	/**
		
				Reads a block of pixels from the `WebGLFrameBuffer`.
				@throws DOMError
			
	**/
	function readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int, pixels:js.lib.ArrayBufferView):Void;
	/**
		
				Specifies a 2D texture image.
				@throws DOMError
			
	**/
	@:overload(function(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, pixels:js.lib.ArrayBufferView):Void { })
	@:overload(function(target:Int, level:Int, internalformat:Int, format:Int, type:Int, pixels:js.html.ImageBitmap):Void { })
	@:overload(function(target:Int, level:Int, internalformat:Int, format:Int, type:Int, pixels:js.html.ImageData):Void { })
	@:overload(function(target:Int, level:Int, internalformat:Int, format:Int, type:Int, image:js.html.ImageElement):Void { })
	@:overload(function(target:Int, level:Int, internalformat:Int, format:Int, type:Int, canvas:js.html.CanvasElement):Void { })
	function texImage2D(target:Int, level:Int, internalformat:Int, format:Int, type:Int, video:js.html.VideoElement):Void;
	/**
		
				Updates a sub-rectangle of the current `WebGLTexture`.
				@throws DOMError
			
	**/
	@:overload(function(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, pixels:js.lib.ArrayBufferView):Void { })
	@:overload(function(target:Int, level:Int, xoffset:Int, yoffset:Int, format:Int, type:Int, pixels:js.html.ImageBitmap):Void { })
	@:overload(function(target:Int, level:Int, xoffset:Int, yoffset:Int, format:Int, type:Int, pixels:js.html.ImageData):Void { })
	@:overload(function(target:Int, level:Int, xoffset:Int, yoffset:Int, format:Int, type:Int, image:js.html.ImageElement):Void { })
	@:overload(function(target:Int, level:Int, xoffset:Int, yoffset:Int, format:Int, type:Int, canvas:js.html.CanvasElement):Void { })
	function texSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, format:Int, type:Int, video:js.html.VideoElement):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Float>):Void { })
	function uniform1fv(location:js.html.webgl.UniformLocation, data:js.lib.Float32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Float>):Void { })
	function uniform2fv(location:js.html.webgl.UniformLocation, data:js.lib.Float32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Float>):Void { })
	function uniform3fv(location:js.html.webgl.UniformLocation, data:js.lib.Float32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Float>):Void { })
	function uniform4fv(location:js.html.webgl.UniformLocation, data:js.lib.Float32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Int>):Void { })
	function uniform1iv(location:js.html.webgl.UniformLocation, data:js.lib.Int32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Int>):Void { })
	function uniform2iv(location:js.html.webgl.UniformLocation, data:js.lib.Int32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Int>):Void { })
	function uniform3iv(location:js.html.webgl.UniformLocation, data:js.lib.Int32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, data:Array<Int>):Void { })
	function uniform4iv(location:js.html.webgl.UniformLocation, data:js.lib.Int32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, transpose:Bool, data:Array<Float>):Void { })
	function uniformMatrix2fv(location:js.html.webgl.UniformLocation, transpose:Bool, data:js.lib.Float32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, transpose:Bool, data:Array<Float>):Void { })
	function uniformMatrix3fv(location:js.html.webgl.UniformLocation, transpose:Bool, data:js.lib.Float32Array):Void;
	@:overload(function(location:js.html.webgl.UniformLocation, transpose:Bool, data:Array<Float>):Void { })
	function uniformMatrix4fv(location:js.html.webgl.UniformLocation, transpose:Bool, data:js.lib.Float32Array):Void;
	/**
		
				Returns a `WebGLContextAttributes` object that contains the actual context parameters. Might return `null`, if the context is lost.
			
	**/
	function getContextAttributes():js.html.webgl.ContextAttributes;
	/**
		
				Returns `true` if the context is lost, otherwise returns `false`.
			
	**/
	function isContextLost():Bool;
	/**
		
				Returns an `Array` of `DOMString` elements with all the supported WebGL extensions.
			
	**/
	function getSupportedExtensions():Array<String>;
	/**
		
				Returns an extension object.
				@throws DOMError
			
	**/
	function getExtension<T>(name:js.html.webgl.Extension<T>):T;
	/**
		
				Selects the active texture unit.
			
	**/
	function activeTexture(texture:Int):Void;
	/**
		
				Attaches a `WebGLShader` to a `WebGLProgram`.
			
	**/
	function attachShader(program:js.html.webgl.Program, shader:js.html.webgl.Shader):Void;
	/**
		
				Binds a generic vertex index to a named attribute variable.
			
	**/
	function bindAttribLocation(program:js.html.webgl.Program, index:Int, name:String):Void;
	/**
		
				Binds a `WebGLBuffer` object to a given target.
			
	**/
	function bindBuffer(target:Int, buffer:js.html.webgl.Buffer):Void;
	/**
		
				Binds a `WebGLFrameBuffer` object to a given target.
			
	**/
	function bindFramebuffer(target:Int, framebuffer:js.html.webgl.Framebuffer):Void;
	/**
		
				Binds a `WebGLRenderBuffer` object to a given target.
			
	**/
	function bindRenderbuffer(target:Int, renderbuffer:js.html.webgl.Renderbuffer):Void;
	/**
		
				Binds a `WebGLTexture` object to a given target.
			
	**/
	function bindTexture(target:Int, texture:js.html.webgl.Texture):Void;
	/**
		
				Sets the source and destination blending factors.
			
	**/
	function blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void;
	/**
		
				Sets both the RGB blend equation and alpha blend equation to a single equation.
			
	**/
	function blendEquation(mode:Int):Void;
	/**
		
				Sets the RGB blend equation and alpha blend equation separately.
			
	**/
	function blendEquationSeparate(modeRGB:Int, modeAlpha:Int):Void;
	/**
		
				Defines which function is used for blending pixel arithmetic.
			
	**/
	function blendFunc(sfactor:Int, dfactor:Int):Void;
	/**
		
				Defines which function is used for blending pixel arithmetic for RGB and alpha components separately.
			
	**/
	function blendFuncSeparate(srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void;
	/**
		
				Returns the status of the framebuffer.
			
	**/
	function checkFramebufferStatus(target:Int):Int;
	/**
		
				Clears specified buffers to preset values.
			
	**/
	function clear(mask:Int):Void;
	/**
		
				Specifies the color values used when clearing color buffers.
			
	**/
	function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;
	/**
		
				Specifies the depth value used when clearing the depth buffer.
			
	**/
	function clearDepth(depth:Float):Void;
	/**
		
				Specifies the stencil value used when clearing the stencil buffer.
			
	**/
	function clearStencil(s:Int):Void;
	/**
		
				Sets which color components to enable or to disable when drawing or rendering to a `WebGLFramebuffer`.
			
	**/
	function colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void;
	/**
		
				Compiles a `WebGLShader`.
			
	**/
	function compileShader(shader:js.html.webgl.Shader):Void;
	/**
		
				Copies a 2D texture image.
			
	**/
	function copyTexImage2D(target:Int, level:Int, internalformat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void;
	/**
		
				Copies a 2D texture sub-image.
			
	**/
	function copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void;
	/**
		
				Creates a `WebGLBuffer` object.
			
	**/
	function createBuffer():js.html.webgl.Buffer;
	/**
		
				Creates a `WebGLFrameBuffer` object.
			
	**/
	function createFramebuffer():js.html.webgl.Framebuffer;
	/**
		
				Creates a `WebGLProgram`.
			
	**/
	function createProgram():js.html.webgl.Program;
	/**
		
				Creates a `WebGLRenderBuffer` object.
			
	**/
	function createRenderbuffer():js.html.webgl.Renderbuffer;
	/**
		
				Creates a `WebGLShader`.
			
	**/
	function createShader(type:Int):js.html.webgl.Shader;
	/**
		
				Creates a `WebGLTexture` object.
			
	**/
	function createTexture():js.html.webgl.Texture;
	/**
		
				Specifies whether or not front- and/or back-facing polygons can be culled.
			
	**/
	function cullFace(mode:Int):Void;
	/**
		
				Deletes a `WebGLBuffer` object.
			
	**/
	function deleteBuffer(buffer:js.html.webgl.Buffer):Void;
	/**
		
				Deletes a `WebGLFrameBuffer` object.
			
	**/
	function deleteFramebuffer(framebuffer:js.html.webgl.Framebuffer):Void;
	/**
		
				Deletes a `WebGLProgram`.
			
	**/
	function deleteProgram(program:js.html.webgl.Program):Void;
	/**
		
				Deletes a `WebGLRenderBuffer` object.
			
	**/
	function deleteRenderbuffer(renderbuffer:js.html.webgl.Renderbuffer):Void;
	/**
		
				Deletes a `WebGLShader`.
			
	**/
	function deleteShader(shader:js.html.webgl.Shader):Void;
	/**
		
				Deletes a `WebGLTexture` object.
			
	**/
	function deleteTexture(texture:js.html.webgl.Texture):Void;
	/**
		
				Specifies a function that compares incoming pixel depth to the current depth buffer value.
			
	**/
	function depthFunc(func:Int):Void;
	/**
		
				Sets whether writing into the depth buffer is enabled or disabled.
			
	**/
	function depthMask(flag:Bool):Void;
	/**
		
				Specifies the depth range mapping from normalized device coordinates to window or viewport coordinates.
			
	**/
	function depthRange(zNear:Float, zFar:Float):Void;
	/**
		
				Detaches a `WebGLShader`.
			
	**/
	function detachShader(program:js.html.webgl.Program, shader:js.html.webgl.Shader):Void;
	/**
		
				Disables specific WebGL capabilities for this context.
			
	**/
	function disable(cap:Int):Void;
	/**
		
				Disables a vertex attribute array at a given position.
			
	**/
	function disableVertexAttribArray(index:Int):Void;
	/**
		
				Renders primitives from array data.
			
	**/
	function drawArrays(mode:Int, first:Int, count:Int):Void;
	/**
		
				Renders primitives from element array data.
			
	**/
	function drawElements(mode:Int, count:Int, type:Int, offset:Int):Void;
	/**
		
				Enables specific WebGL capabilities for this context.
			
	**/
	function enable(cap:Int):Void;
	/**
		
				Enables a vertex attribute array at a given position.
			
	**/
	function enableVertexAttribArray(index:Int):Void;
	/**
		
				Blocks execution until all previously called commands are finished.
			
	**/
	function finish():Void;
	/**
		
				Empties different buffer commands, causing all commands to be executed as quickly as possible.
			
	**/
	function flush():Void;
	/**
		
				Attaches a `WebGLRenderingBuffer` object to a `WebGLFrameBuffer` object.
			
	**/
	function framebufferRenderbuffer(target:Int, attachment:Int, renderbuffertarget:Int, renderbuffer:js.html.webgl.Renderbuffer):Void;
	/**
		
				Attaches a textures image to a `WebGLFrameBuffer` object.
			
	**/
	function framebufferTexture2D(target:Int, attachment:Int, textarget:Int, texture:js.html.webgl.Texture, level:Int):Void;
	/**
		
				Specifies whether polygons are front- or back-facing by setting a winding orientation.
			
	**/
	function frontFace(mode:Int):Void;
	/**
		
				Generates a set of mipmaps for a `WebGLTexture` object.
			
	**/
	function generateMipmap(target:Int):Void;
	/**
		
				Returns information about an active attribute variable.
			
	**/
	function getActiveAttrib(program:js.html.webgl.Program, index:Int):js.html.webgl.ActiveInfo;
	/**
		
				Returns information about an active uniform variable.
			
	**/
	function getActiveUniform(program:js.html.webgl.Program, index:Int):js.html.webgl.ActiveInfo;
	/**
		
				Returns a list of `WebGLShader` objects attached to a `WebGLProgram`.
			
	**/
	function getAttachedShaders(program:js.html.webgl.Program):Array<js.html.webgl.Shader>;
	/**
		
				Returns the location of an attribute variable.
			
	**/
	function getAttribLocation(program:js.html.webgl.Program, name:String):Int;
	/**
		
				Returns information about the buffer.
			
	**/
	function getBufferParameter(target:Int, pname:Int):Dynamic;
	/**
		
				Returns a value for the passed parameter name.
				@throws DOMError
			
	**/
	function getParameter(pname:Int):Dynamic;
	/**
		
				Returns error information.
			
	**/
	function getError():Int;
	/**
		
				Returns information about the framebuffer.
				@throws DOMError
			
	**/
	function getFramebufferAttachmentParameter(target:Int, attachment:Int, pname:Int):Dynamic;
	/**
		
				Returns information about the program.
			
	**/
	function getProgramParameter(program:js.html.webgl.Program, pname:Int):Dynamic;
	/**
		
				Returns the information log for a `WebGLProgram` object.
			
	**/
	function getProgramInfoLog(program:js.html.webgl.Program):String;
	/**
		
				Returns information about the renderbuffer.
			
	**/
	function getRenderbufferParameter(target:Int, pname:Int):Dynamic;
	/**
		
				Returns information about the shader.
			
	**/
	function getShaderParameter(shader:js.html.webgl.Shader, pname:Int):Dynamic;
	/**
		
				Returns a `WebGLShaderPrecisionFormat` object describing the precision for the numeric format of the shader.
			
	**/
	function getShaderPrecisionFormat(shadertype:Int, precisiontype:Int):js.html.webgl.ShaderPrecisionFormat;
	/**
		
				Returns the information log for a `WebGLShader` object.
			
	**/
	function getShaderInfoLog(shader:js.html.webgl.Shader):String;
	/**
		
				Returns the source code of a `WebGLShader` as a string.
			
	**/
	function getShaderSource(shader:js.html.webgl.Shader):String;
	/**
		
				Returns information about the texture.
			
	**/
	function getTexParameter(target:Int, pname:Int):Dynamic;
	/**
		
				Returns the value of a uniform variable at a given location.
			
	**/
	function getUniform(program:js.html.webgl.Program, location:js.html.webgl.UniformLocation):Dynamic;
	/**
		
				Returns the location of a uniform variable.
			
	**/
	function getUniformLocation(program:js.html.webgl.Program, name:String):js.html.webgl.UniformLocation;
	/**
		
				Returns information about a vertex attribute at a given position.
				@throws DOMError
			
	**/
	function getVertexAttrib(index:Int, pname:Int):Dynamic;
	/**
		
				Returns the address of a given vertex attribute.
			
	**/
	function getVertexAttribOffset(index:Int, pname:Int):Int;
	/**
		
				Specifies hints for certain behaviors. The interpretation of these hints depend on the implementation.
			
	**/
	function hint(target:Int, mode:Int):Void;
	/**
		
				Returns a Boolean indicating if the passed buffer is valid.
			
	**/
	function isBuffer(buffer:js.html.webgl.Buffer):Bool;
	/**
		
				Tests whether a specific WebGL capability is enabled or not for this context.
			
	**/
	function isEnabled(cap:Int):Bool;
	/**
		
				Returns a Boolean indicating if the passed `WebGLFrameBuffer` object is valid.
			
	**/
	function isFramebuffer(framebuffer:js.html.webgl.Framebuffer):Bool;
	/**
		
				Returns a Boolean indicating if the passed `WebGLProgram` is valid.
			
	**/
	function isProgram(program:js.html.webgl.Program):Bool;
	/**
		
				Returns a Boolean indicating if the passed `WebGLRenderingBuffer` is valid.
			
	**/
	function isRenderbuffer(renderbuffer:js.html.webgl.Renderbuffer):Bool;
	/**
		
				Returns a Boolean indicating if the passed `WebGLShader` is valid.
			
	**/
	function isShader(shader:js.html.webgl.Shader):Bool;
	/**
		
				Returns a Boolean indicating if the passed `WebGLTexture` is valid.
			
	**/
	function isTexture(texture:js.html.webgl.Texture):Bool;
	/**
		
				Sets the line width of rasterized lines.
			
	**/
	function lineWidth(width:Float):Void;
	/**
		
				Links the passed `WebGLProgram` object.
			
	**/
	function linkProgram(program:js.html.webgl.Program):Void;
	/**
		
				Specifies the pixel storage modes
			
	**/
	function pixelStorei(pname:Int, param:Int):Void;
	/**
		
				Specifies the scale factors and units to calculate depth values.
			
	**/
	function polygonOffset(factor:Float, units:Float):Void;
	/**
		
				Creates a renderbuffer data store.
			
	**/
	function renderbufferStorage(target:Int, internalformat:Int, width:Int, height:Int):Void;
	/**
		
				Specifies multi-sample coverage parameters for anti-aliasing effects.
			
	**/
	function sampleCoverage(value:Float, invert:Bool):Void;
	/**
		
				Defines the scissor box.
			
	**/
	function scissor(x:Int, y:Int, width:Int, height:Int):Void;
	/**
		
				Sets the source code in a `WebGLShader`.
			
	**/
	function shaderSource(shader:js.html.webgl.Shader, source:String):Void;
	/**
		
				Sets the both front and back function and reference value for stencil testing.
			
	**/
	function stencilFunc(func:Int, ref:Int, mask:Int):Void;
	/**
		
				Sets the front and/or back function and reference value for stencil testing.
			
	**/
	function stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int):Void;
	/**
		
				Controls enabling and disabling of both the front and back writing of individual bits in the stencil planes.
			
	**/
	function stencilMask(mask:Int):Void;
	/**
		
				Controls enabling and disabling of front and/or back writing of individual bits in the stencil planes.
			
	**/
	function stencilMaskSeparate(face:Int, mask:Int):Void;
	/**
		
				Sets both the front and back-facing stencil test actions.
			
	**/
	function stencilOp(fail:Int, zfail:Int, zpass:Int):Void;
	/**
		
				Sets the front and/or back-facing stencil test actions.
			
	**/
	function stencilOpSeparate(face:Int, fail:Int, zfail:Int, zpass:Int):Void;
	function texParameterf(target:Int, pname:Int, param:Float):Void;
	function texParameteri(target:Int, pname:Int, param:Int):Void;
	function uniform1f(location:js.html.webgl.UniformLocation, x:Float):Void;
	function uniform2f(location:js.html.webgl.UniformLocation, x:Float, y:Float):Void;
	function uniform3f(location:js.html.webgl.UniformLocation, x:Float, y:Float, z:Float):Void;
	function uniform4f(location:js.html.webgl.UniformLocation, x:Float, y:Float, z:Float, w:Float):Void;
	function uniform1i(location:js.html.webgl.UniformLocation, x:Int):Void;
	function uniform2i(location:js.html.webgl.UniformLocation, x:Int, y:Int):Void;
	function uniform3i(location:js.html.webgl.UniformLocation, x:Int, y:Int, z:Int):Void;
	function uniform4i(location:js.html.webgl.UniformLocation, x:Int, y:Int, z:Int, w:Int):Void;
	/**
		
				Uses the specified `WebGLProgram` as part the current rendering state.
			
	**/
	function useProgram(program:js.html.webgl.Program):Void;
	/**
		
				Validates a `WebGLProgram`.
			
	**/
	function validateProgram(program:js.html.webgl.Program):Void;
	function vertexAttrib1f(indx:Int, x:Float):Void;
	@:overload(function(indx:Int, values:Array<Float>):Void { })
	function vertexAttrib1fv(indx:Int, values:js.lib.Float32Array):Void;
	function vertexAttrib2f(indx:Int, x:Float, y:Float):Void;
	@:overload(function(indx:Int, values:Array<Float>):Void { })
	function vertexAttrib2fv(indx:Int, values:js.lib.Float32Array):Void;
	function vertexAttrib3f(indx:Int, x:Float, y:Float, z:Float):Void;
	@:overload(function(indx:Int, values:Array<Float>):Void { })
	function vertexAttrib3fv(indx:Int, values:js.lib.Float32Array):Void;
	function vertexAttrib4f(indx:Int, x:Float, y:Float, z:Float, w:Float):Void;
	@:overload(function(indx:Int, values:Array<Float>):Void { })
	function vertexAttrib4fv(indx:Int, values:js.lib.Float32Array):Void;
	/**
		
				Specifies the data formats and locations of vertex attributes in a vertex attributes array.
			
	**/
	function vertexAttribPointer(indx:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void;
	/**
		
				Sets the viewport.
			
	**/
	function viewport(x:Int, y:Int, width:Int, height:Int):Void;
	static var DEPTH_BUFFER_BIT(default, never) : Int;
	static var STENCIL_BUFFER_BIT(default, never) : Int;
	static var COLOR_BUFFER_BIT(default, never) : Int;
	static var POINTS(default, never) : Int;
	static var LINES(default, never) : Int;
	static var LINE_LOOP(default, never) : Int;
	static var LINE_STRIP(default, never) : Int;
	static var TRIANGLES(default, never) : Int;
	static var TRIANGLE_STRIP(default, never) : Int;
	static var TRIANGLE_FAN(default, never) : Int;
	static var ZERO(default, never) : Int;
	static var ONE(default, never) : Int;
	static var SRC_COLOR(default, never) : Int;
	static var ONE_MINUS_SRC_COLOR(default, never) : Int;
	static var SRC_ALPHA(default, never) : Int;
	static var ONE_MINUS_SRC_ALPHA(default, never) : Int;
	static var DST_ALPHA(default, never) : Int;
	static var ONE_MINUS_DST_ALPHA(default, never) : Int;
	static var DST_COLOR(default, never) : Int;
	static var ONE_MINUS_DST_COLOR(default, never) : Int;
	static var SRC_ALPHA_SATURATE(default, never) : Int;
	static var FUNC_ADD(default, never) : Int;
	static var BLEND_EQUATION(default, never) : Int;
	static var BLEND_EQUATION_RGB(default, never) : Int;
	static var BLEND_EQUATION_ALPHA(default, never) : Int;
	static var FUNC_SUBTRACT(default, never) : Int;
	static var FUNC_REVERSE_SUBTRACT(default, never) : Int;
	static var BLEND_DST_RGB(default, never) : Int;
	static var BLEND_SRC_RGB(default, never) : Int;
	static var BLEND_DST_ALPHA(default, never) : Int;
	static var BLEND_SRC_ALPHA(default, never) : Int;
	static var CONSTANT_COLOR(default, never) : Int;
	static var ONE_MINUS_CONSTANT_COLOR(default, never) : Int;
	static var CONSTANT_ALPHA(default, never) : Int;
	static var ONE_MINUS_CONSTANT_ALPHA(default, never) : Int;
	static var BLEND_COLOR(default, never) : Int;
	static var ARRAY_BUFFER(default, never) : Int;
	static var ELEMENT_ARRAY_BUFFER(default, never) : Int;
	static var ARRAY_BUFFER_BINDING(default, never) : Int;
	static var ELEMENT_ARRAY_BUFFER_BINDING(default, never) : Int;
	static var STREAM_DRAW(default, never) : Int;
	static var STATIC_DRAW(default, never) : Int;
	static var DYNAMIC_DRAW(default, never) : Int;
	static var BUFFER_SIZE(default, never) : Int;
	static var BUFFER_USAGE(default, never) : Int;
	static var CURRENT_VERTEX_ATTRIB(default, never) : Int;
	static var FRONT(default, never) : Int;
	static var BACK(default, never) : Int;
	static var FRONT_AND_BACK(default, never) : Int;
	static var CULL_FACE(default, never) : Int;
	static var BLEND(default, never) : Int;
	static var DITHER(default, never) : Int;
	static var STENCIL_TEST(default, never) : Int;
	static var DEPTH_TEST(default, never) : Int;
	static var SCISSOR_TEST(default, never) : Int;
	static var POLYGON_OFFSET_FILL(default, never) : Int;
	static var SAMPLE_ALPHA_TO_COVERAGE(default, never) : Int;
	static var SAMPLE_COVERAGE(default, never) : Int;
	static var NO_ERROR(default, never) : Int;
	static var INVALID_ENUM(default, never) : Int;
	static var INVALID_VALUE(default, never) : Int;
	static var INVALID_OPERATION(default, never) : Int;
	static var OUT_OF_MEMORY(default, never) : Int;
	static var CW(default, never) : Int;
	static var CCW(default, never) : Int;
	static var LINE_WIDTH(default, never) : Int;
	static var ALIASED_POINT_SIZE_RANGE(default, never) : Int;
	static var ALIASED_LINE_WIDTH_RANGE(default, never) : Int;
	static var CULL_FACE_MODE(default, never) : Int;
	static var FRONT_FACE(default, never) : Int;
	static var DEPTH_RANGE(default, never) : Int;
	static var DEPTH_WRITEMASK(default, never) : Int;
	static var DEPTH_CLEAR_VALUE(default, never) : Int;
	static var DEPTH_FUNC(default, never) : Int;
	static var STENCIL_CLEAR_VALUE(default, never) : Int;
	static var STENCIL_FUNC(default, never) : Int;
	static var STENCIL_FAIL(default, never) : Int;
	static var STENCIL_PASS_DEPTH_FAIL(default, never) : Int;
	static var STENCIL_PASS_DEPTH_PASS(default, never) : Int;
	static var STENCIL_REF(default, never) : Int;
	static var STENCIL_VALUE_MASK(default, never) : Int;
	static var STENCIL_WRITEMASK(default, never) : Int;
	static var STENCIL_BACK_FUNC(default, never) : Int;
	static var STENCIL_BACK_FAIL(default, never) : Int;
	static var STENCIL_BACK_PASS_DEPTH_FAIL(default, never) : Int;
	static var STENCIL_BACK_PASS_DEPTH_PASS(default, never) : Int;
	static var STENCIL_BACK_REF(default, never) : Int;
	static var STENCIL_BACK_VALUE_MASK(default, never) : Int;
	static var STENCIL_BACK_WRITEMASK(default, never) : Int;
	static var VIEWPORT(default, never) : Int;
	static var SCISSOR_BOX(default, never) : Int;
	static var COLOR_CLEAR_VALUE(default, never) : Int;
	static var COLOR_WRITEMASK(default, never) : Int;
	static var UNPACK_ALIGNMENT(default, never) : Int;
	static var PACK_ALIGNMENT(default, never) : Int;
	static var MAX_TEXTURE_SIZE(default, never) : Int;
	static var MAX_VIEWPORT_DIMS(default, never) : Int;
	static var SUBPIXEL_BITS(default, never) : Int;
	static var RED_BITS(default, never) : Int;
	static var GREEN_BITS(default, never) : Int;
	static var BLUE_BITS(default, never) : Int;
	static var ALPHA_BITS(default, never) : Int;
	static var DEPTH_BITS(default, never) : Int;
	static var STENCIL_BITS(default, never) : Int;
	static var POLYGON_OFFSET_UNITS(default, never) : Int;
	static var POLYGON_OFFSET_FACTOR(default, never) : Int;
	static var TEXTURE_BINDING_2D(default, never) : Int;
	static var SAMPLE_BUFFERS(default, never) : Int;
	static var SAMPLES(default, never) : Int;
	static var SAMPLE_COVERAGE_VALUE(default, never) : Int;
	static var SAMPLE_COVERAGE_INVERT(default, never) : Int;
	static var COMPRESSED_TEXTURE_FORMATS(default, never) : Int;
	static var DONT_CARE(default, never) : Int;
	static var FASTEST(default, never) : Int;
	static var NICEST(default, never) : Int;
	static var GENERATE_MIPMAP_HINT(default, never) : Int;
	static var BYTE(default, never) : Int;
	static var UNSIGNED_BYTE(default, never) : Int;
	static var SHORT(default, never) : Int;
	static var UNSIGNED_SHORT(default, never) : Int;
	static var INT(default, never) : Int;
	static var UNSIGNED_INT(default, never) : Int;
	static var FLOAT(default, never) : Int;
	static var DEPTH_COMPONENT(default, never) : Int;
	static var ALPHA(default, never) : Int;
	static var RGB(default, never) : Int;
	static var RGBA(default, never) : Int;
	static var LUMINANCE(default, never) : Int;
	static var LUMINANCE_ALPHA(default, never) : Int;
	static var UNSIGNED_SHORT_4_4_4_4(default, never) : Int;
	static var UNSIGNED_SHORT_5_5_5_1(default, never) : Int;
	static var UNSIGNED_SHORT_5_6_5(default, never) : Int;
	static var FRAGMENT_SHADER(default, never) : Int;
	static var VERTEX_SHADER(default, never) : Int;
	static var MAX_VERTEX_ATTRIBS(default, never) : Int;
	static var MAX_VERTEX_UNIFORM_VECTORS(default, never) : Int;
	static var MAX_VARYING_VECTORS(default, never) : Int;
	static var MAX_COMBINED_TEXTURE_IMAGE_UNITS(default, never) : Int;
	static var MAX_VERTEX_TEXTURE_IMAGE_UNITS(default, never) : Int;
	static var MAX_TEXTURE_IMAGE_UNITS(default, never) : Int;
	static var MAX_FRAGMENT_UNIFORM_VECTORS(default, never) : Int;
	static var SHADER_TYPE(default, never) : Int;
	static var DELETE_STATUS(default, never) : Int;
	static var LINK_STATUS(default, never) : Int;
	static var VALIDATE_STATUS(default, never) : Int;
	static var ATTACHED_SHADERS(default, never) : Int;
	static var ACTIVE_UNIFORMS(default, never) : Int;
	static var ACTIVE_ATTRIBUTES(default, never) : Int;
	static var SHADING_LANGUAGE_VERSION(default, never) : Int;
	static var CURRENT_PROGRAM(default, never) : Int;
	static var NEVER(default, never) : Int;
	static var LESS(default, never) : Int;
	static var EQUAL(default, never) : Int;
	static var LEQUAL(default, never) : Int;
	static var GREATER(default, never) : Int;
	static var NOTEQUAL(default, never) : Int;
	static var GEQUAL(default, never) : Int;
	static var ALWAYS(default, never) : Int;
	static var KEEP(default, never) : Int;
	static var REPLACE(default, never) : Int;
	static var INCR(default, never) : Int;
	static var DECR(default, never) : Int;
	static var INVERT(default, never) : Int;
	static var INCR_WRAP(default, never) : Int;
	static var DECR_WRAP(default, never) : Int;
	static var VENDOR(default, never) : Int;
	static var RENDERER(default, never) : Int;
	static var VERSION(default, never) : Int;
	static var NEAREST(default, never) : Int;
	static var LINEAR(default, never) : Int;
	static var NEAREST_MIPMAP_NEAREST(default, never) : Int;
	static var LINEAR_MIPMAP_NEAREST(default, never) : Int;
	static var NEAREST_MIPMAP_LINEAR(default, never) : Int;
	static var LINEAR_MIPMAP_LINEAR(default, never) : Int;
	static var TEXTURE_MAG_FILTER(default, never) : Int;
	static var TEXTURE_MIN_FILTER(default, never) : Int;
	static var TEXTURE_WRAP_S(default, never) : Int;
	static var TEXTURE_WRAP_T(default, never) : Int;
	static var TEXTURE_2D(default, never) : Int;
	static var TEXTURE(default, never) : Int;
	static var TEXTURE_CUBE_MAP(default, never) : Int;
	static var TEXTURE_BINDING_CUBE_MAP(default, never) : Int;
	static var TEXTURE_CUBE_MAP_POSITIVE_X(default, never) : Int;
	static var TEXTURE_CUBE_MAP_NEGATIVE_X(default, never) : Int;
	static var TEXTURE_CUBE_MAP_POSITIVE_Y(default, never) : Int;
	static var TEXTURE_CUBE_MAP_NEGATIVE_Y(default, never) : Int;
	static var TEXTURE_CUBE_MAP_POSITIVE_Z(default, never) : Int;
	static var TEXTURE_CUBE_MAP_NEGATIVE_Z(default, never) : Int;
	static var MAX_CUBE_MAP_TEXTURE_SIZE(default, never) : Int;
	static var TEXTURE0(default, never) : Int;
	static var TEXTURE1(default, never) : Int;
	static var TEXTURE2(default, never) : Int;
	static var TEXTURE3(default, never) : Int;
	static var TEXTURE4(default, never) : Int;
	static var TEXTURE5(default, never) : Int;
	static var TEXTURE6(default, never) : Int;
	static var TEXTURE7(default, never) : Int;
	static var TEXTURE8(default, never) : Int;
	static var TEXTURE9(default, never) : Int;
	static var TEXTURE10(default, never) : Int;
	static var TEXTURE11(default, never) : Int;
	static var TEXTURE12(default, never) : Int;
	static var TEXTURE13(default, never) : Int;
	static var TEXTURE14(default, never) : Int;
	static var TEXTURE15(default, never) : Int;
	static var TEXTURE16(default, never) : Int;
	static var TEXTURE17(default, never) : Int;
	static var TEXTURE18(default, never) : Int;
	static var TEXTURE19(default, never) : Int;
	static var TEXTURE20(default, never) : Int;
	static var TEXTURE21(default, never) : Int;
	static var TEXTURE22(default, never) : Int;
	static var TEXTURE23(default, never) : Int;
	static var TEXTURE24(default, never) : Int;
	static var TEXTURE25(default, never) : Int;
	static var TEXTURE26(default, never) : Int;
	static var TEXTURE27(default, never) : Int;
	static var TEXTURE28(default, never) : Int;
	static var TEXTURE29(default, never) : Int;
	static var TEXTURE30(default, never) : Int;
	static var TEXTURE31(default, never) : Int;
	static var ACTIVE_TEXTURE(default, never) : Int;
	static var REPEAT(default, never) : Int;
	static var CLAMP_TO_EDGE(default, never) : Int;
	static var MIRRORED_REPEAT(default, never) : Int;
	static var FLOAT_VEC2(default, never) : Int;
	static var FLOAT_VEC3(default, never) : Int;
	static var FLOAT_VEC4(default, never) : Int;
	static var INT_VEC2(default, never) : Int;
	static var INT_VEC3(default, never) : Int;
	static var INT_VEC4(default, never) : Int;
	static var BOOL(default, never) : Int;
	static var BOOL_VEC2(default, never) : Int;
	static var BOOL_VEC3(default, never) : Int;
	static var BOOL_VEC4(default, never) : Int;
	static var FLOAT_MAT2(default, never) : Int;
	static var FLOAT_MAT3(default, never) : Int;
	static var FLOAT_MAT4(default, never) : Int;
	static var SAMPLER_2D(default, never) : Int;
	static var SAMPLER_CUBE(default, never) : Int;
	static var VERTEX_ATTRIB_ARRAY_ENABLED(default, never) : Int;
	static var VERTEX_ATTRIB_ARRAY_SIZE(default, never) : Int;
	static var VERTEX_ATTRIB_ARRAY_STRIDE(default, never) : Int;
	static var VERTEX_ATTRIB_ARRAY_TYPE(default, never) : Int;
	static var VERTEX_ATTRIB_ARRAY_NORMALIZED(default, never) : Int;
	static var VERTEX_ATTRIB_ARRAY_POINTER(default, never) : Int;
	static var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING(default, never) : Int;
	static var IMPLEMENTATION_COLOR_READ_TYPE(default, never) : Int;
	static var IMPLEMENTATION_COLOR_READ_FORMAT(default, never) : Int;
	static var COMPILE_STATUS(default, never) : Int;
	static var LOW_FLOAT(default, never) : Int;
	static var MEDIUM_FLOAT(default, never) : Int;
	static var HIGH_FLOAT(default, never) : Int;
	static var LOW_INT(default, never) : Int;
	static var MEDIUM_INT(default, never) : Int;
	static var HIGH_INT(default, never) : Int;
	static var FRAMEBUFFER(default, never) : Int;
	static var RENDERBUFFER(default, never) : Int;
	static var RGBA4(default, never) : Int;
	static var RGB5_A1(default, never) : Int;
	static var RGB565(default, never) : Int;
	static var DEPTH_COMPONENT16(default, never) : Int;
	static var STENCIL_INDEX8(default, never) : Int;
	static var DEPTH_STENCIL(default, never) : Int;
	static var RENDERBUFFER_WIDTH(default, never) : Int;
	static var RENDERBUFFER_HEIGHT(default, never) : Int;
	static var RENDERBUFFER_INTERNAL_FORMAT(default, never) : Int;
	static var RENDERBUFFER_RED_SIZE(default, never) : Int;
	static var RENDERBUFFER_GREEN_SIZE(default, never) : Int;
	static var RENDERBUFFER_BLUE_SIZE(default, never) : Int;
	static var RENDERBUFFER_ALPHA_SIZE(default, never) : Int;
	static var RENDERBUFFER_DEPTH_SIZE(default, never) : Int;
	static var RENDERBUFFER_STENCIL_SIZE(default, never) : Int;
	static var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE(default, never) : Int;
	static var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME(default, never) : Int;
	static var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL(default, never) : Int;
	static var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE(default, never) : Int;
	static var COLOR_ATTACHMENT0(default, never) : Int;
	static var DEPTH_ATTACHMENT(default, never) : Int;
	static var STENCIL_ATTACHMENT(default, never) : Int;
	static var DEPTH_STENCIL_ATTACHMENT(default, never) : Int;
	static var NONE(default, never) : Int;
	static var FRAMEBUFFER_COMPLETE(default, never) : Int;
	static var FRAMEBUFFER_INCOMPLETE_ATTACHMENT(default, never) : Int;
	static var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT(default, never) : Int;
	static var FRAMEBUFFER_INCOMPLETE_DIMENSIONS(default, never) : Int;
	static var FRAMEBUFFER_UNSUPPORTED(default, never) : Int;
	static var FRAMEBUFFER_BINDING(default, never) : Int;
	static var RENDERBUFFER_BINDING(default, never) : Int;
	static var MAX_RENDERBUFFER_SIZE(default, never) : Int;
	static var INVALID_FRAMEBUFFER_OPERATION(default, never) : Int;
	static var UNPACK_FLIP_Y_WEBGL(default, never) : Int;
	static var UNPACK_PREMULTIPLY_ALPHA_WEBGL(default, never) : Int;
	static var CONTEXT_LOST_WEBGL(default, never) : Int;
	static var UNPACK_COLORSPACE_CONVERSION_WEBGL(default, never) : Int;
	static var BROWSER_DEFAULT_WEBGL(default, never) : Int;
}