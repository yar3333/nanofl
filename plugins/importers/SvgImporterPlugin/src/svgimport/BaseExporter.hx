package svgimport;

#if js

import easeljs.geom.Rectangle;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.SolidFill;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Polygon;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.LayerType;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.libraryitems.MovieClipItem;
import svgimport.SvgElement;

class BaseExporter
{
	var svg : Svg;
	var library : IdeLibrary;
	
	public function new(svg:Svg, library:IdeLibrary)
	{
		this.svg = svg;
		this.library = library;
	}

	function elementsToLibraryItem(elements:Array<Element>, id:String) : MovieClipItem
	{
		stdlib.Debug.assert(id != null && id != "", "ID must not be empty (" + id + ").");
        var mc = MovieClipItem.createWithFrame(id, elements, "auto");
        library.addItem(mc);
		return mc;
	}
	
	function applyMaskToElement<T:Element>(element:T, matrix:Matrix, maskID:String, prefixID:String) : T
	{
		if (element == null) return null;
		
		if (maskID != null)
		{
			//if (!Std.is(element, Instance) || cast(library.getItem(cast(element, Instance).namePath), MovieClipItem).layers.length > 1)
			{
				element = cast elementsToLibraryItem([element], getNextFreeID(prefixID)).newInstance();
			}
			
			stdlib.Debug.assert(Std.is(element, Instance));
			stdlib.Debug.assert(library.getItem(cast(element, Instance).namePath) != null);
			
			var item = cast(library.getItem(cast(element, Instance).namePath), MovieClipItem);
			stdlib.Debug.assert(item != null);
			
			addMaskItemLayerToMovieClipItem(item, matrix, maskID);
		}
		
		return element;
	}
	
	function applyFilterToElement<T:Element>(element:T, filterID:String, prefixID:String) : T
	{
		if (element == null) return null;
		
		if (filterID != null)
		{
			var filter = svg.filters.get(filterID);
			if (filter != null)
			{
				var filterDefs = filter.export();
				if (filterDefs.length > 0)
				{
					element = cast elementsToLibraryItem([element], getNextFreeID(prefixID)).newInstance();
					cast(element, Instance).filters = filterDefs;
					
					#if !server
					var displayObject = element.createDisplayObject(null);
					var elemBounds =  displayObject.getBounds();
					//trace("elemBounds = " + elemBounds);
					if (elemBounds != null)
					{
						var maskBounds : Rectangle;
						if (filter.filterUnits == "userSpaceOnUse")
						{
							maskBounds = new Rectangle
							(
								elemBounds.x + (filter.x != null ? filter.x : -elemBounds.width  * 0.1),
								elemBounds.y + (filter.y != null ? filter.y : -elemBounds.height * 0.1),
								filter.width  != null ? filter.width  : elemBounds.width  * 1.2,
								filter.height != null ? filter.height : elemBounds.height * 1.2
							);
						}
						else
						{
							maskBounds = new Rectangle
							(
								elemBounds.x + (filter.x != null ? filter.x * elemBounds.width  : -elemBounds.width  * 0.1),
								elemBounds.y + (filter.y != null ? filter.y * elemBounds.height : -elemBounds.height * 0.1),
								(filter.width  != null ? filter.width  : 1.2) * elemBounds.width,
								(filter.height != null ? filter.height : 1.2) * elemBounds.height
							);
						}
						
						//trace("maskBounds = " + maskBounds);
						if (!isRectangleNested(nanofl.DisplayObjectTools.getOuterBounds(displayObject), maskBounds))
						{
							var mask = new ShapeElement([ new Polygon(new SolidFill("red"), [ Contour.fromRectangle(maskBounds) ]) ]);
							var item = elementsToLibraryItem([element], getNextFreeID(prefixID));
							addMaskElementLayerToMovieClipItem(item, mask);
							element = cast item.newInstance();
						}
					}
					#end
				}
			}
			else
			{
				trace("Filter reference '" + filterID + "' is not found.");
			}
		}
		
		return element;
	}
	
	function wrapMovieClipItemWithMask(item:MovieClipItem, matrix:Matrix, maskID:String, id:String) : MovieClipItem
	{
		if (maskID == null) return item;
		
		var r = elementsToLibraryItem([item.newInstance()], id);
		addMaskItemLayerToMovieClipItem(r, matrix, maskID);
		
		return r;
	}
	
	function wrapMovieClipItemWithFilter(item:MovieClipItem, filterID:String, id:String) : MovieClipItem
	{
		if (filterID == null) return item;
		
		var instance = item.newInstance();
		instance = applyFilterToElement(instance, filterID, id);
		
		return elementsToLibraryItem([instance], id);
	}
	
	function addMaskItemLayerToMovieClipItem(item:MovieClipItem, matrix:Matrix, maskID:String) : Void
	{
		if (maskID != null)
		{
			//trace("addMaskLayerToMovieClipItem maskID = " + maskID);
			
			var maskItem = library.hasItem(maskID)
				? library.getItem(maskID)
				: exportSvgElementToLibrary(svg.elements.get(maskID));
			var mask = cast(maskItem, MovieClipItem).newInstance();
			mask.matrix = matrix.clone();
			addMaskElementLayerToMovieClipItem(item, mask);
		}
	}
	
	function addMaskElementLayerToMovieClipItem(item:MovieClipItem, mask:Element) : Void
	{
		stdlib.Debug.assert(mask != null);
		
		var maskLayer = new Layer("auto_clip-path", LayerType.mask, true, true);
		maskLayer.addKeyFrame(new KeyFrame([ mask ]));
		
		stdlib.Debug.assert(item.layers.length == 1);
		
		item.addLayersBlock([maskLayer], 0);
		item.layers[1].parentIndex = 0;
		item.layers[1].locked = true;
	}
	
	function exportSvgElementToLibrary(element:SvgElement) : MovieClipItem
	{
		return switch (element)
		{
			case SvgElement.DisplayGroup(g): new SvgGroupExporter(svg, library, g).exportToLibrary();
			case SvgElement.DisplayPath(p): new SvgPathExporter(svg, library, p).exportToLibrary();
			case _: null;
		};
	}
	
	function getNextFreeID(prefix="") : String
	{
		if (prefix == "") prefix = "auto";
		
		prefix += "_";
		
		var i = -1;
		var s : String;
		
		do s = prefix + (++i)
		while (svg.elements.exists(s) || library.hasItem(s) || svg.usedIDs.indexOf(s) >= 0);
		
		svg.usedIDs.push(s);
		
		return s;
	}
	
	function isRectangleNested(inner:Rectangle, outer:Rectangle) : Bool
	{
		return inner.x >= outer.x && inner.x + inner.width  <= outer.x + outer.width
		    && inner.y >= outer.y && inner.y + inner.height <= outer.y + outer.height;
	}
}

#end