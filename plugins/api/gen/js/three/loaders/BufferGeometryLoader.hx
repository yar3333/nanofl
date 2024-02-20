package js.three.loaders;

@:native("THREE.BufferGeometryLoader") extern class BufferGeometryLoader extends js.three.loaders.Loader<haxe.extern.EitherType<js.three.core.InstancedBufferGeometry, js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>>, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	function parse(json:Dynamic):haxe.extern.EitherType<js.three.core.InstancedBufferGeometry, js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>>;
}