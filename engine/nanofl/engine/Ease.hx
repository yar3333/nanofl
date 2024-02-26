package nanofl.engine;

class Ease
{
	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
	public static function linear(t:Float)
    {
        return t;
    }

	/**
	 * Mimics the simple -100 to 100 easing in Adobe Flash/Animate.
	 * @param {Number} amount A value from -1 (ease in) to 1 (ease out) indicating the strength and direction of the ease.
	 * @return {Function}
	 **/
	public static function get(amount:Float) : Float->Float
    {
		if      (amount < -1) amount = -1;
		else if (amount >  1) amount =  1;
		
        return t ->
        {
			if (amount == 0) return t;
			if (amount <  0) return t*(t*-amount+1+amount);
			return t*((2-t)*amount+(1-amount));
		};
	}

	/**
	 * Configurable exponential ease.
	 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
	 * @return {Function}
	 **/
	public static function getPowIn(pow:Float) : Float->Float
    {
		return t -> Math.pow(t, pow);
	}

	/**
	 * Configurable exponential ease.
	 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
	 * @return {Function}
	 **/
    public static function getPowOut(pow:Float) : Float->Float
    {
        return t -> 1.0 - Math.pow(1.0 - t, pow);
    }

	/**
	 * Configurable exponential ease.
	 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
	 * @return {Function}
	 **/
	public static function getPowInOut(pow:Float) : Float->Float
    {
		return t ->
        {
			if ((t *= 2) < 1) return 0.5 * Math.pow(t, pow);
			return 1 - 0.5 * Math.abs(Math.pow(2 - t, pow));
		};
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quadIn = Ease.getPowIn(2);
	
     /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quadOut = Ease.getPowOut(2);
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quadInOut = Ease.getPowInOut(2);

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final cubicIn = Ease.getPowIn(3);
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final cubicOut = Ease.getPowOut(3);
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final cubicInOut = Ease.getPowInOut(3);

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quartIn = Ease.getPowIn(4);
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quartOut = Ease.getPowOut(4);
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quartInOut = Ease.getPowInOut(4);

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quintIn = Ease.getPowIn(5);
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quintOut = Ease.getPowOut(5);
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final quintInOut = Ease.getPowInOut(5);

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function sineIn(t:Float) : Float
    {
		return 1 - Math.cos(t * Math.PI / 2);
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function sineOut(t:Float) : Float
    {
		return Math.sin(t * Math.PI / 2);
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function sineInOut(t:Float) : Float
    {
		return -0.5 * (Math.cos(Math.PI * t) - 1);
	}

	/**
	 * Configurable "back in" ease.
	 * @param {Number} amount The strength of the ease.
	 * @return {Function}
	 **/
	public static function getBackIn(amount:Float) : Float->Float
    {
        return t -> t * t * ((amount + 1) * t - amount);
    }
	
    /**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final backIn : Float->Float = Ease.getBackIn(1.7);

	/**
	 * Configurable "back out" ease.
	 * @param {Number} amount The strength of the ease.
	 * @return {Function}
	 **/
    public static function getBackOut(amount:Float) : Float->Float
    {
        return t -> (--t * t * ((amount + 1) * t + amount) + 1);
    }

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final backOut = Ease.getBackOut(1.7);

	/**
	 * Configurable "back in out" ease.
	 * @param {Number} amount The strength of the ease.
	 * @return {Function}
	 **/
	public static function getBackInOut(amount:Float) : Float->Float
    {
		amount *= 1.525;
		return t ->
        {
			if ((t *= 2) < 1) return 0.5 * (t * t * ((amount+ 1) * t - amount));
			return 0.5 * ((t -= 2) * t * ((amount + 1) * t + amount) + 2);
		};
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static final backInOut = Ease.getBackInOut(1.7);

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function circIn(t:Float) : Float
    {
		return -(Math.sqrt(1 - t * t) - 1);
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function circOut(t:Float) : Float
    {
		return Math.sqrt(1 - (--t) * t);
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function circInOut(t:Float) : Float
    {
		if ((t *= 2) < 1) return -0.5 * (Math.sqrt(1 - t * t) - 1);
		return 0.5 * (Math.sqrt(1 - (t -= 2) * t) + 1);
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function bounceIn(t:Float) : Float
    {
		return 1 - Ease.bounceOut(1 - t);
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function bounceOut(t:Float) : Float
    {
		if (t < 1/2.75) {
			return (7.5625*t*t);
		} else if (t < 2/2.75) {
			return (7.5625*(t-=1.5/2.75)*t+0.75);
		} else if (t < 2.5/2.75) {
			return (7.5625*(t-=2.25/2.75)*t+0.9375);
		} else {
			return (7.5625*(t-=2.625/2.75)*t +0.984375);
		}
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
    public static function bounceInOut(t:Float) : Float
    {
		if (t < 0.5) return Ease.bounceIn(t * 2) * 0.5;
		return Ease.bounceOut(t * 2 - 1) * 0.5 + 0.5;
	}

	/**
	 * Configurable elastic ease.
	 * @param {Number} amplitude
	 * @param {Number} period
	 * @return {Function}
	 **/
    public static function getElasticIn(amplitude:Float, period:Float) : Float->Float
    {
		var pi2 = Math.PI * 2;
		return t ->
        {
			if (t==0 || t==1) return t;
			var s = period/pi2*Math.asin(1/amplitude);
			return -(amplitude*Math.pow(2,10*(t-=1))*Math.sin((t-s)*pi2/period));
		};
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
	public static final elasticIn = Ease.getElasticIn(1,0.3);

	/**
	 * Configurable elastic ease.
	 * @param {Number} amplitude
	 * @param {Number} period
	 * @return {Function}
	 **/
    public static function getElasticOut(amplitude:Float, period:Float) : Float->Float
    {
		var pi2 = Math.PI * 2;
		return t ->
        {
			if (t == 0 || t == 1) return t;
			var s = period / pi2 * Math.asin(1.0 / amplitude);
			return (amplitude*Math.pow(2,-10*t)*Math.sin((t-s)*pi2/period ) + 1);
		};
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
	public static final elasticOut = Ease.getElasticOut(1,0.3);

	/**
	 * Configurable elastic ease.
	 * @param {Number} amplitude
	 * @param {Number} period
	 * @return {Function}
	 **/
	public static function getElasticInOut(amplitude:Float, period:Float) : Float->Float
    {
		var pi2 = Math.PI * 2;
		return t ->
        {
			var s = period/pi2 * Math.asin(1/amplitude);
			if ((t*=2)<1) return -0.5*(amplitude*Math.pow(2,10*(t-=1))*Math.sin( (t-s)*pi2/period ));
			return amplitude*Math.pow(2,-10*(t-=1))*Math.sin((t-s)*pi2/period)*0.5+1;
		};
	}

	/**
	 * @param {Number} t
	 * @return {Number}
	 **/
	public static final elasticInOut = Ease.getElasticInOut(1, 0.3 * 1.5);
}
