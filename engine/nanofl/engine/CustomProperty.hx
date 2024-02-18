package nanofl.engine;

typedef CustomProperty =
{
	/**
	 * int / float / string / color / bool / list / delimiter / info / file
	 */
	var type : String;
	
	/**
	 * Used as field name in params.
	 */
	@:optional var name : String;
	
	/**
	 * Used to display in form. If not specified then name will be used.
	 */
	@:optional var label : String;
	
	/**
	 * Long description. Used for tooltip.
	 */
	@:optional var description : String;
	
	/**
	 * Like 123, 10.3, "myStr", true, "#00aaff", "rgb(1,2,3)" or "rgba(12,32,255,128)".
	 */
	@:optional var defaultValue : Dynamic;
	
	/**
	 * Value for neutral case.
	 * Used to detect finish value in tween when finish filter is absent.
	 * Don't specify or set to null if not need.
	 */
	@:optional var neutralValue : Dynamic;
	
	/**
	 * Units to display ("px", "%").
	 */
	@:optional var units : String;
	
	/**
	 * Minimum value to validate on input. Used for int/float only.
	 */
	@:optional var minValue : Dynamic;
	
	/**
	 * Maximum value to validate on input. Used for int/float only.
	 */
	@:optional var maxValue : Dynamic;
	
	/**
	 * List options. Used for list only.
	 */
	@:optional var values : Array<String>;
	
	/**
	 * For file type only.
	 */
	@:optional var fileFilters : Array<{ description:String, extensions:Array<String> }>;
}
