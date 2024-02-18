package js.three.renderers.webgl;

@:native("THREE.WebGLBindingStates") extern class WebGLBindingStates {
	function new(gl:js.html.webgl.RenderingContext, extensions:js.three.renderers.webgl.WebGLExtensions, attributes:js.three.renderers.webgl.WebGLAttributes, capabilities:js.three.renderers.webgl.WebGLCapabilities):Void;
	function setup(object:js.three.core.Object3D<js.three.core.Object3DEventMap>, material:js.three.materials.Material, program:js.three.renderers.webgl.WebGLProgram, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, index:js.three.core.BufferAttribute):Void;
	function reset():Void;
	function resetDefaultState():Void;
	function dispose():Void;
	function releaseStatesOfGeometry():Void;
	function releaseStatesOfProgram():Void;
	function initAttributes():Void;
	function enableAttribute(attribute:Float):Void;
	function disableUnusedAttributes():Void;
}