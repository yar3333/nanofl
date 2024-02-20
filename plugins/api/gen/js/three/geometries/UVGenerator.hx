package js.three.geometries;

extern interface UVGenerator {
	function generateTopUV(geometry:js.three.geometries.ExtrudeGeometry, vertices:Array<Float>, indexA:Float, indexB:Float, indexC:Float):Array<js.three.math.Vector2>;
	function generateSideWallUV(geometry:js.three.geometries.ExtrudeGeometry, vertices:Array<Float>, indexA:Float, indexB:Float, indexC:Float, indexD:Float):Array<js.three.math.Vector2>;
}