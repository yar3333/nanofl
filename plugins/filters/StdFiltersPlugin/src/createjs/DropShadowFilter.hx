package createjs;

/**
* Applies a DropShadowFilter to DisplayObjects of EaselJS. This filter has inherited the Filter class of EaselJS and has used BlurFilter of EaselJS at the blurring process.
* @class DropShadowFilter
* @extends Filter
* @constructor
* @param [distance=4] {Number} The offset distance for the shadow. The default value is 4.
* @param [angle=45] {Number} The angle of the shadow. Valid values are 0 to 360 degrees. The default value is 45.
* @param [color=0x000000] {uint} The color of the shadow. The default value is 0x000000. Valid values are in the hexadecimal format 0xRRGGBB.
* @param [alpha=1] {Number} The alpha transparency value for the shadow color. Valid values are 0 to 1. The default value is 1.
* @param [blurX=0] {Number} The amount of horizontal blur. The default value is 0. This value is passed to BlurFilter of EaselJS.
* @param [blurY=0] {Number} The amount of vertical blur. The default value is 0. This value is passed to BlurFilter of EaselJS.
* @param [strength=1] {uint} The strength of the shadow. The default value is 1. Valid values are 0 to 255. But as for this value, a low value is more preferable.
* @param [quality=1] {Number} The number of blur iterations. The default value is 1. This value is passed to BlurFilter of EaselJS.
* @param [inner=false] {Boolean} Specifies whether or not the shadow is an inner shadow. The default value is false, expressing outer shadow.
* @param [knockout=false] {Boolean} Specifies whether or not the object has a knockout effect. The default value is false, expressing no knockout effect.
* @param [hideObject=false] {Boolean} Specifies whether or not the object is hidden. If the value is true, the object is hidden and only the shadow is visible. The default value is false, expressing the object is visible.
* @example
* <pre><code>_text = new easeljs.display.Text("DropShadowFilter", "bold 64px Arial", "#CC0000");
_text.set({x:centerX, y:centerY, textAlign:"center", textBaseline:"middle"});
var distance = 3;
var angle = 90;
var color = 0x000000;
var alpha = 0.5;
var blurX = 4;
var blurY = 4;
var strength = 1;
var quality = 2;
var inner = false;
var knockout = false;
var hideObject = false;
_dropShadowFilter = new createjs.DropShadowFilter(distance, angle, color, alpha, blurX, blurY, strength, quality, inner, knockout, hideObject);
_text.filters = [_dropShadowFilter];
var bounds = _text.getBounds();
_text.cache(bounds.x, bounds.y, bounds.width, bounds.height);
_stage.addChild(_text);</code></pre>
*/
@:expose
extern class DropShadowFilter extends easeljs.filters.Filter
{
	private static function __init__() : Void
	{
		haxe.macro.Compiler.includeFile("createjs/DropShadowFilter.js", "inline");
	}
	
	/**
	 * The offset distance for the shadow. The default value is 4.
	 */
	var distance : Float;
	/**
	 * The angle of the shadow. Valid values are 0 to 360 degrees. The default value is 45.
	 */
	var angle : Float;
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
	/**
	 * Specifies whether or not the object is hidden. If the value is true, the object is hidden and only the shadow is visible. The default value is false, expressing the object is visible.
	 */
	var hideObject : Bool;

	function new(?distance:Float, ?angle:Float, ?color:Int, ?alpha:Float, ?blurX:Float, ?blurY:Float, ?strength:Int, ?quality:Int, ?inner:Bool, ?knockout:Bool, ?hideObject:Bool) : Void;
}