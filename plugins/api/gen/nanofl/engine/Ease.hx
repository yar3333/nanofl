package nanofl.engine;

extern class Ease {
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function linear(t:Float):Float;
	/**
		
			 * Mimics the simple -100 to 100 easing in Adobe Flash/Animate.
			 * @param {Number} amount A value from -1 (ease in) to 1 (ease out) indicating the strength and direction of the ease.
			 * @return {Function}
			 
	**/
	static function get(amount:Float):Float -> Float;
	/**
		
			 * Configurable exponential ease.
			 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
			 * @return {Function}
			 
	**/
	static function getPowIn(pow:Float):Float -> Float;
	/**
		
			 * Configurable exponential ease.
			 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
			 * @return {Function}
			 
	**/
	static function getPowOut(pow:Float):Float -> Float;
	/**
		
			 * Configurable exponential ease.
			 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
			 * @return {Function}
			 
	**/
	static function getPowInOut(pow:Float):Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quadIn(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quadOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quadInOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var cubicIn(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var cubicOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var cubicInOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quartIn(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quartOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quartInOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quintIn(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quintOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var quintInOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function sineIn(t:Float):Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function sineOut(t:Float):Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function sineInOut(t:Float):Float;
	/**
		
			 * Configurable "back in" ease.
			 * @param {Number} amount The strength of the ease.
			 * @return {Function}
			 
	**/
	static function getBackIn(amount:Float):Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var backIn(default, never) : Float -> Float;
	/**
		
			 * Configurable "back out" ease.
			 * @param {Number} amount The strength of the ease.
			 * @return {Function}
			 
	**/
	static function getBackOut(amount:Float):Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var backOut(default, never) : Float -> Float;
	/**
		
			 * Configurable "back in out" ease.
			 * @param {Number} amount The strength of the ease.
			 * @return {Function}
			 
	**/
	static function getBackInOut(amount:Float):Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var backInOut(default, never) : Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function circIn(t:Float):Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function circOut(t:Float):Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function circInOut(t:Float):Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function bounceIn(t:Float):Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function bounceOut(t:Float):Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static function bounceInOut(t:Float):Float;
	/**
		
			 * Configurable elastic ease.
			 * @param {Number} amplitude
			 * @param {Number} period
			 * @return {Function}
			 
	**/
	static function getElasticIn(amplitude:Float, period:Float):Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var elasticIn(default, never) : Float -> Float;
	/**
		
			 * Configurable elastic ease.
			 * @param {Number} amplitude
			 * @param {Number} period
			 * @return {Function}
			 
	**/
	static function getElasticOut(amplitude:Float, period:Float):Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var elasticOut(default, never) : Float -> Float;
	/**
		
			 * Configurable elastic ease.
			 * @param {Number} amplitude
			 * @param {Number} period
			 * @return {Function}
			 
	**/
	static function getElasticInOut(amplitude:Float, period:Float):Float -> Float;
	/**
		
			 * @param {Number} t
			 * @return {Number}
			 
	**/
	static var elasticInOut(default, never) : Float -> Float;
}