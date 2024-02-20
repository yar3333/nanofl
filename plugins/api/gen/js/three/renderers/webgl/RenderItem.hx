package js.three.renderers.webgl;

extern interface RenderItem {
	var id : Int;
	var object : js.three.core.Object3D<js.three.core.Object3DEventMap>;
	var geometry : js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>;
	var material : js.three.materials.Material;
	var program : js.three.renderers.webgl.WebGLProgram;
	var groupOrder : Float;
	var renderOrder : Float;
	var z : Float;
	var group : js.three.objects.Group<js.three.core.Object3DEventMap>;
}