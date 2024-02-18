package svgimport;

import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.geom.Matrix;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.libraryitems.MovieClipItem;
import svgimport.SvgElement;
import svgimport.SvgGroup;

class SvgGroupExporter extends BaseExporter
{
	var group : SvgGroup;
	
	var layers : Array<Layer>;
	
	public function new(svg:Svg, library:IdeLibrary, group:SvgGroup)
	{
		super(svg, library);
		this.group = group;
	}
	
	public function exportToLibrary() : MovieClipItem
	{
		trace("SvgGroupExporter.exportToLibrary " + group.id);
		
		layers = [];
		
		for (child in group.children)
		{
			switch (child)
			{
				case SvgElement.DisplayGroup(g):
					var item = !library.hasItem(g.id)
						? new SvgGroupExporter(svg, library, g).exportToLibrary()
						: library.getItem(g.id);
					
					if (item != null)
					{
						var instance = new Instance(item.namePath);
						instance.matrix = g.matrix.clone();
						addElement(instance, g.visible);
					}
					
				case SvgElement.DisplayPath(path):
					addElement(new SvgPathExporter(svg, library, path).exportAsElement());
					
				case SvgElement.DisplayText(text):
					addElement(new SvgTextExporter(svg, library, text).exportAsElement());
					
				case SvgElement.DisplayUse(use):
					addElement(new SvgUseExporter(svg, library, use).exportAsElement());
			}
		}
		
		var namePath = group.clipPathID == null
			? (group.id != "" ? group.id : getNextFreeID())
			: getNextFreeID(group.id);
		
		var mc = new MovieClipItem(namePath);
		layers.reverse();
		for (layer in layers) mc.addLayer(layer);
		library.addItem(mc);
		
		mc = wrapMovieClipItemWithFilter(mc, group.filterID, getNextFreeID(group.id));
		mc = wrapMovieClipItemWithMask(mc, new Matrix(), group.clipPathID, getNextFreeID(group.id));
		
		return mc;
	}
	
	function addElement(element:Element, visible=true) : Void
	{
		if (element == null) return;
		
		if (layers.length == 0) createLayerWithFrame("auto_" + layers.length);
		var frame = layers[layers.length - 1].keyFrames[0];
		
		if ((frame.elements.length > 0 && Std.is(element, ShapeElement)) || layers[layers.length - 1].visible != visible)
		{
			frame = createLayerWithFrame("auto_" + layers.length, visible);
		}
		
		frame.addElement(element);
	}
	
	function createLayerWithFrame(name:String, visible=true) : KeyFrame
	{
		var layer = new Layer(name, null, visible);
		var keyFrame = new KeyFrame();
		layer.addKeyFrame(keyFrame);
		layers.push(layer);
		return keyFrame;
	}
}