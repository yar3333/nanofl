package js.three.geometries;

@:native("THREE.WebGLGeometries") extern class WebGLGeometries {
	function new(gl:js.html.webgl.RenderingContext, attributes:js.three.renderers.webgl.WebGLAttributes, info:js.three.renderers.webgl.WebGLInfo):Void;
	function get(object:js.three.core.Object3D<js.three.core.Object3DEventMap>, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>):js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>;
	function update(geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>):Void;
	function getWireframeAttribute(geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>):js.three.core.BufferAttribute;
}