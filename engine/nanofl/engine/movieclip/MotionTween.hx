package nanofl.engine.movieclip;

import js.lib.Map;
import stdlib.Debug;
import stdlib.Std;
import nanofl.engine.geom.Matrix;
import nanofl.engine.libraryitems.MeshItem;
import nanofl.engine.movieclip.TweenedElement;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.coloreffects.ColorEffectDouble;
import nanofl.engine.elements.Instance;
import nanofl.engine.plugins.FilterPlugins;
using stdlib.Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class MotionTween
{
	public var keyFrame : KeyFrame;
	
	public var easing : Int;
	public var orientToPath : Bool;
	public var rotateCount : Int;
	public var rotateCountX : Int;
	public var rotateCountY : Int;

    public var directionalLightRotateCountX : Int;
	public var directionalLightRotateCountY : Int;
	
	public function new(easing:Int, orientToPath:Bool, rotateCount:Int, rotateCountX:Int, rotateCountY:Int, directionalLightRotateCountX:Int, directionalLightRotateCountY:Int)
	{
		this.easing = easing;
		this.orientToPath = orientToPath;
		this.rotateCount = rotateCount;
		this.rotateCountX = rotateCountX;
		this.rotateCountY = rotateCountY;
		
		this.directionalLightRotateCountX = directionalLightRotateCountX;
		this.directionalLightRotateCountY = directionalLightRotateCountY;
	}
	
    function getGuideLine(keyFrame:KeyFrame, frameSubIndex:Int) : GuideLine
    {
        if (keyFrame.layer.parentIndex == null) return null;
        
        final parentLayer = keyFrame.layer.parentLayer;
        if (parentLayer.type != LayerType.guide) return null;
        
        final frame = parentLayer.getFrame(keyFrame.getIndex() + frameSubIndex);
        return frame.keyFrame.getGuideLine();
    }
    
    public function apply(frameSubIndex:Int) : Array<TweenedElement>
    {
        final guideLine = getGuideLine(keyFrame, frameSubIndex);
        final guide = guideLine != null ? new Guide(guideLine) : null;
        
        final ease = Ease.get(easing / 100);
        final k = ease(frameSubIndex / (keyFrame.duration + 1));
        final instancesMap = getInstancesMap();
        
        final r = new Array<TweenedElement>();
        
        for (originalElement in keyFrame.elements)
        {
            if (instancesMap.has((cast originalElement:Instance)))
            {
                final startInstance = (cast originalElement:Instance);
                final finishInstance = instancesMap.get(startInstance);
                
                final currentInstance = getMovedInstance(startInstance, finishInstance, k, guide);
                
                final startFilters = startInstance.filters.filter(x -> FilterPlugins.plugins.exists(x.name));
                final finishFilters = finishInstance.filters.filter(x -> FilterPlugins.plugins.exists(x.name));
                
                fixFilterSequence(startFilters, finishFilters);
                fixFilterSequence(finishFilters, startFilters);
                
                Debug.assert(startFilters.length == finishFilters.length, "startFilters.length = " + startFilters.length + " != finishFilters.length = " + finishFilters.length);
                
                currentInstance.filters = startFilters.mapi((i, startFilter) -> startFilter.clone().tween(k, finishFilters[i]));
                
                r.push(new TweenedElement(originalElement, currentInstance));
            }
            else
            {
                r.push(new TweenedElement(originalElement, originalElement));
            }
        }
        
        return r;
    }
    
    function fixFilterSequence(src:Array<FilterDef>, dst:Array<FilterDef>)
    {
        for (i in 0...src.length)
        {
            if (i >= dst.length || dst[i].name != src[i].name)
            {
                dst.insert(i, src[i].clone().resetToNeutral());
            }
        }
    }
    
    public function getInstancesMap() : Map<Instance, Instance>
    {
        final startElements = keyFrame.elements;
        final finishElements = keyFrame.getNextKeyFrame()?.elements;

        final r = new Map<Instance, Instance>();
        
        if (finishElements == null) return r;
        
        final startInstances  =  startElements.filterByType(Instance);
        final finishInstances = finishElements.filterByType(Instance);
        
        for (instance in startInstances)
        {
            for (nextInstance in finishInstances)
            {
                if (nextInstance.namePath == instance.namePath)
                {
                    if (!instance.symbol.type.match(LibraryItemType.video) || instance.videoCurrentTime != null && nextInstance.videoCurrentTime != null)
                    {
                        r.set(instance, nextInstance);
                        finishInstances.remove(nextInstance);
                        break;
                    }
                }
            }
        }
        
        return r;
    }
    
    public function isGood() : Bool
    {
        return getInstancesMap().size > 0;
    }
    
    #if ide
	public static function load(node:HtmlNodeElement) : MotionTween
	{
		if (node.getAttr("tweenType") != "motion") return null;
		
        return new MotionTween
		(
			node.getAttr("motionTweenEasing", 0),
			node.getAttr("motionTweenOrientToPath", false),
			node.getAttr("motionTweenRotateCount", 0),
			node.getAttr("motionTweenRotateCountX", 0),
			node.getAttr("motionTweenRotateCountY", 0),
			node.getAttr("motionTweenDirectionalLightRotateCountX", 0),
			node.getAttr("motionTweenDirectionalLightRotateCountY", 0)
		);
	}
    #end
    
	public static function loadJson(obj:Dynamic) : MotionTween
	{
		if (obj?.tweenType != "motion") return null;
        
        return new MotionTween
		(
			obj.motionTweenEasing ?? 0,
			obj.motionTweenOrientToPath ?? false,
			obj.motionTweenRotateCount ?? 0,
			obj.motionTweenRotateCountX ?? 0,
			obj.motionTweenRotateCountY ?? 0,
			obj.motionTweenDirectionalLightRotateCountX ?? 0,
			obj.motionTweenDirectionalLightRotateCountY ?? 0,
		);
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
        out.attr("tweenType", "motion");
        out.attr("motionTweenEasing", easing, 0);
        out.attr("motionTweenOrientToPath", orientToPath, false);
        out.attr("motionTweenRotateCount", rotateCount, 0);
        out.attr("motionTweenRotateCountX", rotateCountX, 0);
        out.attr("motionTweenRotateCountY", rotateCountY, 0);
		out.attr("motionTweenDirectionalLightRotateCountX", directionalLightRotateCountX, 0);
		out.attr("motionTweenDirectionalLightRotateCountY", directionalLightRotateCountY, 0);
	}
    
    public function saveJson() : Dynamic
	{
        return
        {
            tweenType : "motion",
            motionTweenEasing : easing ?? 0,
            motionTweenOrientToPath : orientToPath ?? false,
            motionTweenRotateCount : rotateCount ?? 0,
            motionTweenRotateCountX : rotateCountX ?? 0,
            motionTweenRotateCountY : rotateCountY ?? 0,
		    motionTweenDirectionalLightRotateCountX : directionalLightRotateCountX ?? 0,
		    motionTweenDirectionalLightRotateCountY : directionalLightRotateCountY ?? 0,
        };
    }
    #end
	
	function getMovedInstance(startInstance:Instance, finishInstance:Instance, k:Float, guide:Guide) : Instance
	{
        if (guide == null) guide = new Guide(null);

		var targetInstance = cast(startInstance.clone(), Instance);
		
		var startProps  = translatedMatrixByLocalVector(startInstance .matrix.clone(), startInstance.regX, startInstance.regY).decompose();
		var finishProps = translatedMatrixByLocalVector(finishInstance.matrix.clone(), startInstance.regX, startInstance.regY).decompose();
		
		var props = guide.get(startProps, finishProps, orientToPath, k);
		
		targetInstance.matrix.setTransform
		(
			props.x,
			props.y,
			startProps.scaleX + (finishProps.scaleX - startProps.scaleX) * k,
			startProps.scaleY + (finishProps.scaleY - startProps.scaleY) * k,
			props.rotation + rotateCount * 360 * k,
			startProps.skewX + (finishProps.skewX - startProps.skewX) * k,
			startProps.skewY + (finishProps.skewY - startProps.skewY) * k
		);
		translatedMatrixByLocalVector(targetInstance.matrix, -startInstance.regX, -startInstance.regY);
		
        if (Std.isOfType(startInstance.symbol, MeshItem) && Std.isOfType(finishInstance.symbol, MeshItem))
        {
            targetInstance.meshParams.rotationX += (finishInstance.meshParams.rotationX - startInstance.meshParams.rotationX) * k + rotateCountX * 360 * k;
            targetInstance.meshParams.rotationY += (finishInstance.meshParams.rotationY - startInstance.meshParams.rotationY) * k + rotateCountY * 360 * k;
            targetInstance.meshParams.cameraFov += Math.round((finishInstance.meshParams.cameraFov - startInstance.meshParams.cameraFov) * k);
            targetInstance.meshParams.ambientLightColor = ColorTools.getTweened(startInstance.meshParams.ambientLightColor, k, finishInstance.meshParams.ambientLightColor);
            targetInstance.meshParams.directionalLightColor = ColorTools.getTweened(startInstance.meshParams.directionalLightColor, k, finishInstance.meshParams.directionalLightColor);
            targetInstance.meshParams.directionalLightRotationX += (finishInstance.meshParams.directionalLightRotationX - startInstance.meshParams.directionalLightRotationX) * k + directionalLightRotateCountX * 360 * k;
            targetInstance.meshParams.directionalLightRotationY += (finishInstance.meshParams.directionalLightRotationY - startInstance.meshParams.directionalLightRotationY) * k + directionalLightRotateCountY * 360 * k;
        }
        
        if (startInstance.symbol.type.match(LibraryItemType.video) 
         && finishInstance.symbol.type.match(LibraryItemType.video)
         && startInstance.videoCurrentTime != null
         && finishInstance.videoCurrentTime != null)
        {
            targetInstance.videoCurrentTime += (finishInstance.videoCurrentTime - startInstance.videoCurrentTime) * k;
        }

		if (startInstance.colorEffect != null || finishInstance.colorEffect != null)
		{
			var startCE = startInstance.colorEffect != null ? startInstance.colorEffect : finishInstance.colorEffect.getNeutralClone();
			var finishCE = finishInstance.colorEffect != null ? finishInstance.colorEffect : startInstance.colorEffect.getNeutralClone();
			
			if (Type.getClass(startCE) == Type.getClass(finishCE))
			{
				targetInstance.colorEffect = startCE.getTweened(k, finishCE);
			}
			else
			{
				targetInstance.colorEffect = new ColorEffectDouble
				(
					startCE.getTweened(k, startCE.getNeutralClone()),
					finishCE.getNeutralClone().getTweened(k, finishCE)
				);
			}
		}
		
		return targetInstance;
	}
	
	function translatedMatrixByLocalVector(m:Matrix, dx:Float, dy:Float) : Matrix
	{
		var v = m.transformPoint(dx, dy);
		m.tx = v.x;
		m.ty = v.y;
		return m;
	}
	
	public function clone() : MotionTween
	{
		return new MotionTween
		(
			easing,
			orientToPath,
			rotateCount,
			rotateCountX,
			rotateCountY,
			directionalLightRotateCountX,
			directionalLightRotateCountY
		);
	}
	
	public function equ(_motionTween:MotionTween) : Bool
	{
		stdlib.Debug.assert(Std.isOfType(_motionTween, MotionTween));
		
		var motionTween = (cast _motionTween : MotionTween);
        
        if (motionTween.easing != easing) return false;
        if (motionTween.rotateCount != rotateCount) return false;
        if (motionTween.orientToPath != orientToPath) return false;
        if (motionTween.rotateCountX != rotateCountX) return false;
        if (motionTween.rotateCountY != rotateCountY) return false;
		if (motionTween.directionalLightRotateCountX != directionalLightRotateCountX) return false;
		if (motionTween.directionalLightRotateCountY != directionalLightRotateCountY) return false;
		return true;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}