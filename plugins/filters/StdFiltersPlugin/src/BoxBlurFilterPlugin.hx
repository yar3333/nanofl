import easeljs.filters.BlurFilter;
import nanofl.engine.CustomProperty;
import nanofl.engine.plugins.IFilterPlugin;

class BoxBlurFilterPlugin implements IFilterPlugin
{
	public function new() { }
	
	public var name = "BoxBlurFilter";
	public var label = "Box Blur";
	
	public var properties : Array<CustomProperty> =
	[
		{ type:"float",	 name:"blurX",	label:"Blur X",		defaultValue:10, neutralValue:0, units:"px",	minValue:0 },
		{ type:"float",	 name:"blurY",	label:"Blur Y",		defaultValue:10, neutralValue:0, units:"px",	minValue:0 },
		{ type:"slider", name:"quality", label:"Quality",	defaultValue:1, 								minValue:1, maxValue:3 }
	];
	
	public function getFilter(params:Dynamic)
	{
		return new BlurFilter(params.blurX, params.blurY, params.quality);
	}
}