package nanofl.engine;

enum abstract BlendModes(String) from String to String
{
	var normal = "normal";
	var multiply = "multiply";
	var screen = "screen";
	var overlay = "overlay";
	var darken = "darken";
	var lighten = "lighten";
	var color_dodge = "color-dodge";
	var color_burn = "color-burn";
	var hard_light = "hard-light";
	var soft_light = "soft-light";
	var difference = "difference";
	var exclusion = "exclusion";
	var hue = "hue";
	var saturation = "saturation";
	var color = "color";
	var luminosity = "luminosity";
}