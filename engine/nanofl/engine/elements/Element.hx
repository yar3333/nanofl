package nanofl.engine.elements;

import nanofl.engine.Library;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.PointTools;
import nanofl.engine.movieclip.KeyFrame;
using StringTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
using stdlib.Lambda;
#end

abstract class Element
{
	public var parent : KeyFrame;

    public var type(get, never) : ElementType;
	abstract function get_type() : ElementType;

	public var visible = true;	
	
	public var matrix = new Matrix();
	public var regX = 0.0;
	public var regY = 0.0;
	
    function new() {}
	
	public function setLibrary(library:Library) {}
	
	#if ide
	public function getState() : nanofl.ide.undo.states.ElementState return null;
	
	public function setState(state:nanofl.ide.undo.states.ElementState) : Void { }
	#end
	
	#if (ide || test)
	public function fixErrors() : Bool return false;
	#end
	
	#if ide
	public function getUsedSymbolNamePaths() : Array<String> return [];
	#end
	
	public abstract function clone() : Element;
	
	public function toString()
	{
		var className = Type.getClassName(Type.getClass(this));
		className = className.substr(className.lastIndexOf(".") + 1);
		var parents = parent != null ? parent.toString() : "";
		if (parents.endsWith(" / layer / frame")) parents = parents.substring(0, parents.length - " / layer / frame".length);
		return (parents != "" ? parents + " / " : "") + className;
	}
	
	#if ide
    public static function parse(node:HtmlNodeElement, version:String) : Element
	{
        final type = try ElementType.createByName(node.name)
        catch (e) { js.Browser.console.warn("Unexpected element: " + node.name); return null; }

        var element : Element = switch (type)
		{
			case ElementType.instance: new Instance(null);
			case ElementType.text: new TextElement(null, null, null, null, null, null);
			case ElementType.shape: new ShapeElement();
		};

        if (!element.loadProperties(node, version))
        {
            js.Browser.console.warn("Error loading properties for: " + node.name);
            return null;
        }

        if (element.matrix == null)
        {
            js.Browser.console.warn("Error loading matrix for: " + node.name);
            return null;
        }
		
		return element;
	}
    #end

    public static function parseJson(obj:Dynamic, version:String) : Element
    {
        final type = try ElementType.createByName(obj.type)
        catch (e) { js.Browser.console.warn("Unexpected element: " + obj.type); return null; }
        
        var element : Element = switch (type)
        {
            case ElementType.instance: new Instance(null);
            case ElementType.text: new TextElement(null, null, null, null, null, null);
            case ElementType.shape: new ShapeElement();
        };

        if (!element.loadPropertiesJson(obj, version))
        {
            js.Browser.console.warn("Error loading properties for: " + obj.type);
            return null;
        }

        if (element.matrix == null)
        {
            js.Browser.console.warn("Error loading matrix for: " + obj.type);
            return null;
        }
        
        return element;
    }
        
	#if ide
	function loadProperties(node:HtmlNodeElement, version:String) : Bool
	{
		matrix = Matrix.load(node);
		regX = node.getAttr("regX", 0.0);
		regY = node.getAttr("regY", 0.0);
		return true;
	}
    #end
    
	function loadPropertiesJson(obj:Dynamic, version:String) : Bool
	{
		matrix = Matrix.loadJson(obj);
		regX = obj.regX ?? 0.0;
		regY = obj.regY ?? 0.0;
		return true;
	}
	
	#if ide
    public final function save(out:XmlBuilder) : Void
    {
        if (Std.isOfType(this, ShapeElement) && (cast this : ShapeElement).isEmpty()) return;

        out.begin(type.getName());
        saveProperties(out);
        out.end();
    }
    
	public final function saveJson() : { type:String }
    {
        var obj = { type: type.getName() };
        savePropertiesJson(obj);
        return obj;
    }
    
	function saveProperties(out:XmlBuilder) : Void
	{
		matrix.save(out);
		out.attr("regX", regX, 0.0);
		out.attr("regY", regY, 0.0);
	}

	function savePropertiesJson(obj:Dynamic) : Void
	{
        matrix.saveJson(obj);
        obj.regX = regX ?? 0.0;
        obj.regY = regY ?? 0.0;
	}
    #end
	
	function copyBaseProperties(obj:Element) : Void
	{
        obj.parent = parent;
		obj.visible = visible;
		
		obj.matrix = matrix.clone();
		obj.regX = regX;
		obj.regY = regY;
	}
	
	public function translate(dx:Float, dy:Float)
	{
		matrix.translate(dx, dy);
	}
	
	public abstract function createDisplayObject() : easeljs.display.DisplayObject;
	
	function elementUpdateDisplayObjectBaseProperties(dispObj:easeljs.display.DisplayObject)
	{
		dispObj.visible = visible;
		dispObj.set(matrix.decompose());
		dispObj.filters = [];
	}
	
	public function transform(m:Matrix, applyToStrokeAndFill=true) : Void
	{
		matrix.prependMatrix(m);
	}
	
	public function equ(element:Element) : Bool
	{
        if (Type.getClass(element) != Type.getClass((cast this:Element))) return false;
		if (element.visible != visible) return false;
		
		if (!element.matrix.equ(matrix)) return false;
		if (element.regX != regX) return false;
		if (element.regY != regY) return false;
		
		return true;
	}
	
	public function getNearestPoint(pos:Point) : Point
	{
		var pos = matrix.clone().invert().transformPointP(pos);
		
		var points = getNearestPointsLocal(pos);
		
		if (points.length == 0 || points.length == 1 && points[0].x == 1e100 && points[0].y == 1e100) return { x:1e100, y:1e100 };
		
		points.sort((a, b) ->
		{
			return Reflect.compare(PointTools.getDistP(pos, a), PointTools.getDistP(pos, b));
		});
		
		return matrix.transformPointP(points[0]);
	}
	
	/**
	 * Override this method.
	 */
	function getNearestPointsLocal(pos:Point) : Array<Point>
	{
		return [];
	}
}