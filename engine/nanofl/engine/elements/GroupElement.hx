package nanofl.engine.elements;

import datatools.ArrayRO;
import datatools.ArrayTools;
import nanofl.engine.ITimeline;
import nanofl.engine.Library;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Elements;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.movieclip.Layer;
import stdlib.Debug;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class GroupElement extends Element
	implements IPathElement
	implements IElementsContainer
{
	function get_type() return ElementType.group;

	@:allow(nanofl.engine.GroupKeyFrame.new)
	var _elements : Array<Element>;
	public var elements(get, never) : ArrayRO<Element>;
	function get_elements() : ArrayRO<Element> return _elements;
	
	public var name = "";
	
	public var currentFrame(get, set) : Int;
	function get_currentFrame() return 0;
	function set_currentFrame(v:Int) return v;
	
	var _layers : Array<Layer>;
	public var layers(get, never) : ArrayRO<Layer>;
	@:noCompletion public function get_layers()
	{
		if (_layers == null)
		{
			var layer = new Layer("auto");
			layer.layersContainer = this;
			layer.addKeyFrame(new GroupKeyFrame(this));
			_layers = [ layer ];
		}
		return _layers;
	}
	
	public function new(elements:Array<Element>)
	{
		super();
		
		this._elements = elements != null ? elements : [];
		
		for (element in this.elements)
		{
			element.parent = this;
		}
	}
	
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
	
	#if ide
	override function loadProperties(node:HtmlNodeElement, version:String) : Bool
	{
		if (!super.loadProperties(node, version)) return false;
		
		name = node.getAttr("name", "");
		_elements = [];
		for (element in Elements.parse(node, version)) addElement(element);
		return elements.length > 0;
	}
    #end

	override function loadPropertiesJson(obj:Dynamic, version:String) : Bool
	{
		if (!super.loadPropertiesJson(obj, version)) return false;
		
		name = obj.name ?? "";
		_elements = Elements.parseJson(obj.elements, version);
		return elements.length > 0;
	}

	#if ide
	override function saveProperties(out:XmlBuilder)
	{
		out.attr("name", name, "");
		super.saveProperties(out);
		for (element in elements) element.save(out);
	}

	override function savePropertiesJson(obj:Dynamic) : Void
    {
        obj.name = name;
        super.savePropertiesJson(obj);
        obj.elements = elements.map(x -> x.saveJson());
	}
    #end
	
	public function clone() : GroupElement
	{
		var obj = new GroupElement(ArrayTools.clone(_elements));
		copyBaseProperties(obj);
		obj.name = name;
		return obj;
	}
	
	override function setLibrary(library:Library)
	{
		for (element in elements) element.setLibrary(library);
	}
	
	public function getChildren() : ArrayRO<Element> return elements;
	
	public function createDisplayObject(frameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
        final container = new easeljs.display.Container();

		Debug.assert(elements.length > 0, toString());
		
		if (frameIndexes != null && frameIndexes.length > 0 && frameIndexes[0].element == this)
			frameIndexes = frameIndexes.slice(1);
		else
			frameIndexes = null;
		
		elementUpdateDisplayObjectBaseProperties(container);
		
		container.removeAllChildren();
		
		var topElement : Element = null;
		
		for (element in elements)
		{
			if (frameIndexes == null || frameIndexes.length == 0 || frameIndexes[0].element != cast element)
			{
				container.addChild(element.createDisplayObject(frameIndexes));
			}
			else
			if (frameIndexes != null && frameIndexes.length != 0 && frameIndexes[0].element == cast element)
			{
				topElement = element;
			}
		}
		
		if (topElement != null)
		{
			container.addChild(topElement.createDisplayObject(frameIndexes));
		}
		
		return container;
	}
	
	public function getMaskFilter(layer:Layer, frameIndex:Int) : easeljs.display.Container return null;
	
	public function isScene() return false;
	
	public function getNavigatorName() return "group";
	
	public function getNavigatorIcon() return "custom-icon-group";
	
	
	public function getTimeline() : ITimeline return null;
	
	override public function transform(m:Matrix, applyToStrokeAndFill=true)
	{
		for (e in elements) e.transform(m, applyToStrokeAndFill);
	}
	
	override function getNearestPointsLocal(pos:Point) : Array<Point>
	{
		return elements.map(element -> element.getNearestPoint(pos));
	}
	
	#if ide
	override public function getUsedSymbolNamePaths() : Array<String> 
	{
		var r = [];
		for (element in elements)
		{
			ArrayTools.appendUniqueFast(r, element.getUsedSymbolNamePaths());
		}
		return r;
	}
	#end
	
	override public function equ(element:Element):Bool 
	{
		if (!super.equ(element)) return false;
		if ((cast element:GroupElement).name != name) return false;
		if (!ArrayTools.equ((cast element:GroupElement)._elements, _elements)) return false;
		return true;
	}
}