import createjs.GaussianBlurFilter;
import nanofl.engine.CustomProperty;
import nanofl.engine.plugins.IFilterPlugin;

class GaussianBlurFilterPlugin implements IFilterPlugin
{
	public function new() { }
	
	public var name = "GaussianBlurFilterPlugin";
	public var label = "Gaussian Blur";
	
	public var properties : Array<CustomProperty> =
	[
		{ type:"int", name:"radius", label:"Radius", defaultValue:10, neutralValue:0, units:"px", minValue:0 }
	];
	
	public function getFilter(params:Dynamic)
	{
		return new GaussianBlurFilter(params.radius);
	}
}