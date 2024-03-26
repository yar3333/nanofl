package nanofl.engine.movieclip;

import datatools.NullTools;
import datatools.ArrayRO;
import nanofl.engine.Library;
import datatools.ArrayTools;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Elements;
import nanofl.engine.elements.ShapeElement;
import stdlib.Debug;
using stdlib.Lambda;
using stdlib.StringTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class KeyFrame
{
	public var layer : Layer;
	
	public var label : String;
	public var duration : Int;
	
	var motionTween : MotionTween;
	
	var _elements : Array<Element>;
	public var elements(get, never) : ArrayRO<Element>;
	function get_elements() : ArrayRO<Element> return _elements;

	public function new(label="", duration=1, ?motionTween:MotionTween, ?elements:Array<Element>)
	{
        this.label = label;
		this.duration = duration;
		this._elements = elements ?? [];
		
        for (element in this.elements)
		{
			element.parent = this;
		}
		
		if (motionTween != null)
		{
			this.motionTween = motionTween;
			motionTween.keyFrame = this;
		}
	}

	public function getNextKeyFrame() : KeyFrame
    {
        return layer.keyFrames[getKeyIndex() + 1];
    }

	public function getPrevKeyFrame() : KeyFrame
    {
        final n = getKeyIndex();
        return n > 0 ? layer.keyFrames[n - 1] : null;
    }
    
    function getKeyIndex() : Int return layer.keyFrames.indexOf(this);
    
    public function addElement(element:Element, ?index:Int)
    {
        if (index == null) _elements.push(element);
        else               _elements.insert(index, element);
        element.parent = this;
    }
    
    public function removeElementAt(n:Int)
    {
        _elements.splice(n, 1);
    }
    
    public function removeElement(element:Element)
    {
        var n = elements.indexOf(element);
        if (n >= 0) removeElementAt(n);
    }
    
    public function swapElement(i:Int, j:Int)
    {
        var element = elements[i];
        _elements[i] = elements[j];
        _elements[j] = element;
    }
    
    public function isEmpty() : Bool
    {
        return elements.length == 0 || elements.length == 1 && Std.isOfType(elements[0], ShapeElement) && (cast elements[0]:ShapeElement).isEmpty();
    }
    
    public function getElementsState() : { elements:Array<Element> }
    {
        return { elements:_elements.copy() };
    }
    
    public function setElementsState(state:{ elements:Array<Element> })
    {
        _elements = state.elements.copy();
    }
    
    public function getTweenedElements(frameSubIndex:Int) : Array<TweenedElement>
    {
        if (motionTween != null && frameSubIndex != 0)
        {
            return motionTween.apply(frameSubIndex);
        }
        else
        {
            return elements.map(x -> new TweenedElement(x, x));
        }
    }
    
    public function setLibrary(library:Library)
    {
        for (element in elements) element.setLibrary(library);
    }
    
    public function toString() return (layer != null ? layer.toString() + " / " : "") + "frame";
    
    public function getIndex() : Int
    {
        var r = 0;
        for (i in 0...getKeyIndex()) r += layer.keyFrames[i].duration;
        return r;
    }
    
    public function hasGoodMotionTween() : Bool
    {
        if (motionTween == null) return false;
        if (getNextKeyFrame() == null) return false;
        return motionTween.isGood();
    }
    
    public function getParentLayerFrame(frameSubIndex:Int) : Frame
    {
        var parentLayer = layer.parentLayer;
        if (parentLayer == null) return null;
        return parentLayer.getFrame(getIndex() + frameSubIndex);
    }
    
    #if ide
    public function save(out:XmlBuilder)
    {
        out.begin("frame")
            .attr("label", label, "")
            .attr("duration", duration, 1);
        if (motionTween != null) motionTween.save(out);
        
        for (element in _elements) element.save(out);
        
        out.end();
    }
    
    public function saveJson() : Dynamic
    {
        final r : Dynamic = {};

        if (!StringTools.isNullOrEmpty(label)) r.label = label;
        if (duration != 1) r.duration = duration;
        if (motionTween != null) r.motionTween =  motionTween.saveJson();
        
        final elementsToSave = elements.filter(x -> !x.type.match(ElementType.shape) || !(cast x:ShapeElement).isEmpty());
        if (elementsToSave.length > 0) r.elements = elementsToSave.map(x -> x.saveJson());
        
        return r;
    }
    #end
    
    public function clone() : KeyFrame return duplicate();
    
    public function hasMotionTween() : Bool return motionTween != null;
    public function removeMotionTween() : Void motionTween = null;
    
	public function getGuideLine() : GuideLine return new GuideLine(getShape(false));
	
	public function getShape(createIfNotExist:Bool) : ShapeElement
	{
		if (elements.length > 0 && Std.isOfType(elements[0], ShapeElement)) return cast elements[0];
		if (createIfNotExist)
		{
			final shape = new ShapeElement();
			addElement(shape, 0);
			return shape;
		}
		return null;
	}
	
	public function duplicate(?label:String, ?duration:Int, ?elements:Array<Element>) : KeyFrame
	{
		return new KeyFrame
		(
			label != null ? label : this.label,
			duration != null ? duration : this.duration,
			motionTween != null ? (cast motionTween.clone() : MotionTween) : null,
			elements != null ? ArrayTools.clone(elements) : ArrayTools.clone(this._elements),
		);
	}
	
	public function equ(keyFrame:KeyFrame) : Bool
	{
        if (keyFrame.label != label) return false;
        if (keyFrame.duration != duration) return false;
        if (!NullTools.equ(keyFrame.motionTween, motionTween)) return false;
        if (!ArrayTools.equ(getElementsWithoutEmptyShapes(keyFrame._elements), getElementsWithoutEmptyShapes(_elements))) return false;
		return true;
	}
	
	public function getMotionTween() : MotionTween return (cast motionTween : MotionTween);
	
	public function addDefaultMotionTween() : Void
	{
		var mt = new MotionTween(0, false, 0, 0, 0, 0, 0);
		mt.keyFrame = this;
		this.motionTween = mt;
	}
	
    #if ide
	public static function parse(node:HtmlNodeElement, version:String) : KeyFrame
	{
		Debug.assert(node.name == "frame");
		
		var frame = new KeyFrame(node.getAttr("label", ""), Std.int(node.getAttr("duration", 1)), MotionTween.load(node));
		for (element in Elements.parse(node, version))
		{
			frame.addElement(element);
		}

		return frame;
	}
    #end

    public static function parseJson(obj:Dynamic, version:String) : KeyFrame
    {
        return new KeyFrame(obj.label, obj.duration, MotionTween.loadJson(obj.motionTween), Elements.parseJson(obj.elements, version));
    }
	
	function getElementsWithoutEmptyShapes(elements:Array<Element>) : Array<Element>
	{
		return elements.filter(x -> !Std.isOfType(x, ShapeElement) || !(cast x:ShapeElement).isEmpty());
	}
}