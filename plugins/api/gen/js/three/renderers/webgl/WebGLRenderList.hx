package js.three.renderers.webgl;

@:native("THREE.WebGLRenderList") extern class WebGLRenderList {
	function new(properties:js.three.renderers.webgl.WebGLProperties):Void;
	/**
		
			 * @default []
			 
	**/
	var opaque : Array<js.three.renderers.webgl.RenderItem>;
	/**
		
			 * @default []
			 
	**/
	var transparent : Array<js.three.renderers.webgl.RenderItem>;
	/**
		
			 * @default []
			 
	**/
	var transmissive : Array<js.three.renderers.webgl.RenderItem>;
	function init():Void;
	function push(object:js.three.core.Object3D<js.three.core.Object3DEventMap>, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, material:js.three.materials.Material, groupOrder:Float, z:Float, group:js.three.objects.Group<js.three.core.Object3DEventMap>):Void;
	function unshift(object:js.three.core.Object3D<js.three.core.Object3DEventMap>, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, material:js.three.materials.Material, groupOrder:Float, z:Float, group:js.three.objects.Group<js.three.core.Object3DEventMap>):Void;
	function sort(opaqueSort:(Dynamic, Dynamic) -> Float, transparentSort:(Dynamic, Dynamic) -> Float):Void;
	function finish():Void;
}