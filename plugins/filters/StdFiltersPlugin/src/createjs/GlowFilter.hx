package createjs;

/**
* Applies a GlowFilter to DisplayObjects of EaselJS. This filter has inherited the Filter class of EaselJS and has used BlurFilter of EaselJS at the blurring process.
* @class GlowFilter
* @extends Filter
* @constructor
* @param [color=0xFF0000] {uint} The color of the glow. The default value is 0xFF0000. Valid values are in the hexadecimal format 0xRRGGBB.
* @param [alpha=1] {Number} The alpha transparency value for the glow color. Valid values are 0 to 1.
* @param [blurX=0] {Number} The amount of horizontal blur. The default value is 0. This value is passed to BlurFilter of EaselJS.
* @param [blurY=0] {Number} The amount of vertical blur. The default value is 0. This value is passed to BlurFilter of EaselJS.
* @param [strength=1] {uint} The strength of the glow. The default value is 1. Valid values are 0 to 255. But as for this value, a low value is more preferable.
* @param [quality=1] {Number} The number of blur iterations. The default value is 1. This value is passed to BlurFilter of EaselJS.
* @param [inner=false] {Boolean} Specifies whether the glow is an inner glow. The default value is false, expressing outer glow.
* @param [knockout=false] {Boolean} Specifies whether the object has a knockout effect. The default value is false, expressing no knockout effect.
* @example
* <pre><code>_shape = new easeljs.display.Shape().set({x:centerX, y:centerY});
_shape.graphics.f("rgba(0,0,255,1)").dp(0, 0, 100, 5, 0.6, -90).ef();
var color = 0x00FFFF;
var alpha = 1;
var blurX = 32;
var blurY = 32;
var strength = 1;
var quality = 1;
var inner = false;
var knockout = false;
_glowFilter = new createjs.GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
_shape.filters = [_glowFilter];
_shape.cache(-100, -100, 200, 200);
_stage.addChild(_shape);</code></pre>
*/
@:expose
extern class GlowFilter extends easeljs.filters.Filter
{
	private static function __init__() : Void
	{
		haxe.macro.Compiler.includeFile("createjs/GlowFilter.js", "inline");
	}
	
	/**
	 * The color of the shadow. The default value is 0x000000. Valid values are in the hexadecimal format 0xRRGGBB.
	 */
	var color : Int;
	/**
	 * The alpha transparency value for the shadow color. Valid values are 0 to 1. The default value is 1.
	 */
	var alpha : Float;
	/**
	 * The amount of horizontal blur. The default value is 0. This value is passed to BlurFilter of EaselJS.
	 */
	var blurX : Float;
	/**
	 * The amount of vertical blur. The default value is 0. This value is passed to BlurFilter of EaselJS.
	 */
	var blurY : Float;
	/**
	 * The strength of the shadow. The default value is 1. Valid values are 0 to 255. But as for this value, a low value is more preferable.
	 */
	var strength : Int;
	/**
	 * The number of blur iterations. The default value is 1. This value is passed to BlurFilter of EaselJS.
	 */
	var quality : Int;
	/**
	 * Specifies whether or not the shadow is an inner shadow. The default value is false, expressing outer shadow.
	 */
	var inner : Bool;
	/**
	 * Specifies whether or not the object has a knockout effect. The default value is false, expressing no knockout effect.
	 */
	var knockout : Bool;

	function new(?color:Int, ?alpha:Float, ?blurX:Float, ?blurY:Float, ?strength:Int, ?quality:Int, ?inner:Bool, ?knockout:Bool) : Void;
}