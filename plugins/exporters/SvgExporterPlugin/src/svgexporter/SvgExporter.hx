package svgexporter;

import js.Browser.console;
import htmlparser.XmlBuilder;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.elements.TextElement;
import nanofl.engine.geom.Matrix;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.LayerType;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.engine.MovieClipItemTools;
import svgexporter.ShapeExporter;

class SvgExporter
{
	var library : IdeLibrary;
	
	var shapeExporter = new ShapeExporter();
	var layerItems = new Map<Layer, String>();
	var shapePaths = new Map<ShapeElement, Array<String>>();
	
	public function new(library:IdeLibrary)
	{
		this.library = library;
	}
	
	public function export(xml:XmlBuilder)
	{
		var scene = library.getSceneItem();
		var items : Array<MovieClipItem> = cast library.getItems().filter(x -> Std.is(x, MovieClipItem));
		var sceneWithItems = [scene].concat(items);
		
		xml.begin("defs");
			
			for (item in sceneWithItems)
			{
				for (layer in item.layers) if (layer.keyFrames.length > 0)
				{
					var shape = layer.keyFrames[0].getShape(false);
					if (shape != null)
					{
						shapeExporter.exportGradients(shape, xml);
					}
				}
			}
			
			for (item in sceneWithItems)
			{
				MovieClipItemTools.findShapes
				(
					item,
					false,
					(shape:ShapeElement, e) ->
					{
						if (e.insideMask && !shapePaths.exists(shape))
						{
							shapePaths.set(shape, shapeExporter.export(e.item.namePath + "_layer" + e.layerIndex + "_shape", shape, xml));
						}
					}
				);
			}
			
			for (item in sceneWithItems)
			{
				exportMaskLayers(item, xml);
			}
			
			for (item in items)
			{
				exportSvgGroup(item, xml);
			}
			
		xml.end();
		
		exportMovieClipLayers(scene, xml);
	}

	function exportMaskLayers(item:MovieClipItem, xml:XmlBuilder)
	{
		for (i in 0...item.layers.length)
		{
			var layer = item.layers[i];
			if (!layerItems.exists(layer) && layer.type == LayerType.mask && layer.keyFrames.length > 0)
			{
				var layerID = item.namePath + "_layer" + i;
				layerItems.set(layer, layerID);
				
				xml.begin("clipPath").attr("id", layerID);
				
				for (element in layer.keyFrames[0].elements)
				{
					if (Std.is(element, ShapeElement))
					{
						exportExistShapeElement((cast element:ShapeElement), null, xml);
					}
					else
					if (Std.is(element, Instance) && Std.is(asInstance(element).symbol, MovieClipItem))
					{
						MovieClipItemTools.findShapes
						(
							(cast asInstance(element).symbol:MovieClipItem),
							false,
							element.matrix,
							function(shape, e) exportExistShapeElement(shape, e.matrix, xml)
						);
					}
				}
				
				xml.end();
			}
		}
	}
	
	function exportSvgGroup(item:MovieClipItem, xml:XmlBuilder)
	{
		xml.begin("g").attr("id", item.namePath);
			exportMovieClipLayers(item, xml);
		xml.end();
	}
	
	function exportMovieClipLayers(item:MovieClipItem, xml:XmlBuilder)
	{
		for (layer in item.layers)
		{
			if (layer.type == LayerType.normal)
			{
				xml.begin("g").attr("title", layer.name);
				if (layer.keyFrames.length > 0)
				{
					if (layer.parentLayer != null && layer.parentLayer.type == LayerType.mask)
					{
						xml.attr("clip-path", "url(#" + layerItems.get(layer.parentLayer) + ")");
					}
					
					for (element in layer.keyFrames[0].elements)
					{
						exportElement(element, xml);
					}
				}
				xml.end();
			}
		}
	}
	
	function exportElement(element:Element, xml:XmlBuilder)
	{
		if (Std.is(element, Instance))
		{
			var instance : Instance = cast element;
			xml.begin("use");
				xml.attr("xlink:href", "#" + instance.symbol.namePath);
				exportMatrix(instance.matrix, xml);
			xml.end();
		}
		else
		if (Std.is(element, ShapeElement))
		{
			if (shapePaths.exists((cast element:ShapeElement)))
			{
				exportExistShapeElement((cast element:ShapeElement), null, xml);
			}
			else
			{
				shapeExporter.export(null, (cast element:ShapeElement), xml);
			}
		}
		else
		if (Std.is(element, TextElement))
		{
			exportTextElement((cast element:TextElement), xml);
		}
		else
		{
			console.warn("Unsupported element: " + element.toString());
		}
	}
	
	function exportTextElement(text:TextElement, xml:XmlBuilder)
	{
		#if !server
		
		var tf : nanofl.TextField = text.createDisplayObject();
		tf.update();
		
		var y = nanofl.TextField.PADDING;
		for (line in tf.getTextLines())
		{
			xml.begin("text");
			
			var m = text.matrix.clone();
			switch (line.align)
			{
				case "left":
					xml.attr("text-anchor", "start");
					m.appendTransform(nanofl.TextField.PADDING, 0);
					
				case "center":
					xml.attr("text-anchor", "middle");
					m.appendTransform(tf.width / 2, 0);
					
				case "right":
					xml.attr("text-anchor", "end");
					m.appendTransform(tf.width - nanofl.TextField.PADDING, 0);
			}
			m.appendTransform(0, y - line.minY);
			exportMatrix(m, xml);
			
			for (chunk in line.chunks)
			{
				xml.begin("tspan");
				xml.attr("fill", chunk.format.fillColor, "#000000");
				xml.attr("stroke", chunk.format.strokeColor, "rgba(0,0,0,0)");
				xml.attr("stroke-width", chunk.format.strokeSize, 1);
				xml.attr("font-family", chunk.format.family, "");
				xml.attr("font-size", chunk.format.size, 16);
				xml.attr("font-style", chunk.format.style.indexOf("italic") >= 0 ? "italic" : "", "");
				xml.attr("font-weight", chunk.format.style.indexOf("bold") >= 0 ? "bold" : "", "");
				xml.attr("kerning", chunk.format.kerning ? "auto" : "0", "auto");
				xml.attr("letter-spacing", chunk.format.letterSpacing, 0);
				xml.content(chunk.format.characters);
				xml.end();
			}
			
			xml.end();
			
			y += line.maxY - line.minY + line.spacing;
		}
		
		#else
		
		console.warn("Text is not supported on server.");
		
		#end
	}
	
	function exportExistShapeElement(shape:ShapeElement, matrix:Matrix, xml:XmlBuilder)
	{
		for (pathID in shapePaths.get(shape))
		{
			xml.begin("use");
				xml.attr("xlink:href", "#" + pathID);
				if (matrix != null) exportMatrix(matrix, xml);
			xml.end();
		}
	}
	
	function exportMatrix(matrix:Matrix, xml:XmlBuilder)
	{
		if (!matrix.isIdentity())
		{
			if (matrix.a == 1 && matrix.b == 0 && matrix.c == 0 && matrix.d == 1)
			{
				xml.attr("x", matrix.tx);
				xml.attr("y", matrix.ty);
			}
			else
			{
				xml.attr("transform", "matrix(" + matrix.toArray().join(",") + ")");
			}
		}
	}
	
	static inline function asInstance(element:Element) : Instance return cast element;
}