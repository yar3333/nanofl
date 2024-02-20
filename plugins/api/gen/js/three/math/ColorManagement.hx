package js.three.math;

@:native("THREE.ColorManagement") extern class ColorManagement {
	/**
		
			 * @default false
			 
	**/
	static var enabled : Bool;
	static var workingColorSpace : js.three.math.WorkingColorSpace;
	static var convert : (color:js.three.math.Color, sourceColorSpace:js.three.math.DefinedColorSpace, targetColorSpace:js.three.math.DefinedColorSpace) -> js.three.math.Color;
	static var fromWorkingColorSpace : (color:js.three.math.Color, targetColorSpace:js.three.math.DefinedColorSpace) -> js.three.math.Color;
	static var toWorkingColorSpace : (color:js.three.math.Color, sourceColorSpace:js.three.math.DefinedColorSpace) -> js.three.math.Color;
	static var getPrimaries : (colorSpace:js.three.math.DefinedColorSpace) -> js.three.ColorSpacePrimaries;
	static var getTransfer : (colorSpace:js.three.ColorSpace) -> js.three.ColorSpaceTransfer;
}