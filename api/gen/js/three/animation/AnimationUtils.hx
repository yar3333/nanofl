package js.three.animation;

@:native("THREE") extern class AnimationUtils {
	static function convertArray(array:Dynamic, type:Dynamic, forceClone:Bool):Dynamic;
	static function isTypedArray(object:Dynamic):Bool;
	static function getKeyframeOrder(times:Array<Float>):Array<Float>;
	static function sortedArray(values:Array<Dynamic>, stride:Float, order:Array<Float>):Array<Dynamic>;
	static function flattenJSON(jsonKeys:Array<String>, times:Array<Dynamic>, values:Array<Dynamic>, valuePropertyName:String):Void;
	static function subclip(sourceClip:js.three.animation.AnimationClip, name:String, startFrame:Float, endFrame:Float, fps:Float):js.three.animation.AnimationClip;
	static function makeClipAdditive(targetClip:js.three.animation.AnimationClip, referenceFrame:Float, referenceClip:js.three.animation.AnimationClip, fps:Float):js.three.animation.AnimationClip;
}