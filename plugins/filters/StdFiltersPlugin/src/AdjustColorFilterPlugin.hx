import easeljs.filters.ColorMatrix;
import easeljs.filters.ColorMatrixFilter;
import nanofl.engine.CustomProperty;
import nanofl.engine.plugins.IFilterPlugin;

class AdjustColorFilterPlugin implements IFilterPlugin
{
	public function new() { }
	
	public var name = "AdjustColorFilter";
	public var label = "Adjust Color";
	
	public var properties : Array<CustomProperty> =
	[
		{ type:"int",	name:"brightness",	label:"Brightness",	defaultValue:0,	minValue:-100,	maxValue:100,	units:"%" },
		{ type:"int",	name:"contrast",	label:"Contrast",	defaultValue:0,	minValue:-100,	maxValue:100,	units:"%" },
		{ type:"int",	name:"saturation", 	label:"Saturation",	defaultValue:0,	minValue:-100,	maxValue:100,	units:"%" },
		{ type:"int",	name:"hue", 		label:"Hue",		defaultValue:0,	minValue:-180,	maxValue:180,	units:"deg" },
	];
	
	public function getFilter(params:Dynamic)
	{
		return new ColorMatrixFilter(new ColorMatrix
		(
			Math.round(params.brightness/100*255 * 0.4),
			params.contrast,
			params.saturation,
			params.hue
		).toArray());
	}
}
