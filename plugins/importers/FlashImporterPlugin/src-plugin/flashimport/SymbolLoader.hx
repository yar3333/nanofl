package flashimport;

import js.Browser.console;
import haxe.ds.ObjectMap;
import haxe.io.Path;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlDocument;
import nanofl.engine.coloreffects.ColorEffect;
import nanofl.engine.coloreffects.ColorEffectAdvanced;
import nanofl.engine.coloreffects.ColorEffectAlpha;
import nanofl.engine.coloreffects.ColorEffectBrightness;
import nanofl.engine.coloreffects.ColorEffectTint;
import nanofl.engine.ColorTools;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.elements.TextElement;
import nanofl.engine.fills.BitmapFill;
import nanofl.engine.fills.IFill;
import nanofl.engine.fills.LinearFill;
import nanofl.engine.fills.RadialFill;
import nanofl.engine.fills.SolidFill;
import nanofl.engine.FilterDef;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.PointTools;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.library.IdeLibrary;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.engine.movieclip.MotionTween;
import nanofl.engine.strokes.IStroke;
import nanofl.engine.strokes.SolidStroke;
import nanofl.TextRun;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Fonts;
import stdlib.Std;
import stdlib.Utf8;
using htmlparser.HtmlParserTools;
using StringTools;
using stdlib.Lambda;

class SymbolLoader
{
	static var EPS = 1e-10;
	
	var fileSystem : FileSystem;
	var doc : XmlDocument;
	var srcLibDir : String;
	var library : IdeLibrary;
	
	var fontMap = new Map<String, { face:String, style:String }>();
	var morphingNotSupported = new Array<String>();
	var fontConvertor : FontConvertor;
	
	var generatedAutoIDs = new Array<String>();
	
	public function new(fileSystem:FileSystem, fonts:Fonts, doc:XmlDocument, srcLibDir:String, library:IdeLibrary)
	{
		this.fileSystem = fileSystem;
		this.doc = doc;
		this.srcLibDir = srcLibDir;
		this.library = library;
		
		this.fontConvertor = new FontConvertor(fonts.getFontNames());
	}
	
	public function loadFromFile(href:String) : Void
	{
		var namePath = PathTools.unescape(Path.withoutExtension(href));
		
		if (!library.hasItem(namePath))
		{
			log("Load item \"" + namePath + "\"");
			if (fileSystem.exists(srcLibDir + "/" + href))
			{
				loadFromXml(namePath, new XmlDocument(fileSystem.getContent(srcLibDir + "/" + href)));
			}
		}
	}
	
	public function loadFromXml(namePath:String, src:HtmlNodeElement) : MovieClipItem
	{
		if (library.hasItem(namePath))
		{
			return cast(library.getItem(namePath), MovieClipItem);
		}
		
		var symbolItemXml = src.findOne(">DOMSymbolItem");
		if (symbolItemXml == null) symbolItemXml = src.findOne(">DOMDocument");
		
		var r = new MovieClipItem(namePath);
		r.likeButton = symbolItemXml.getAttr("symbolType") == "button";
		loadLinkage(r, symbolItemXml);
		for (layer in symbolItemXml.find(">timeline>DOMTimeline>layers>DOMLayer").concat(symbolItemXml.find(">timelines>DOMTimeline>layers>DOMLayer")))
		{
			r.addLayer(loadLayer(namePath, layer));
		}
		library.addItem(r);
		
		return r;
	}
	
	/*function loadBitmap(namePath:String) : BitmapItem
	{
		var r = new BitmapItem(namePath, "png");
		for (node in doc.find(">DOMDocument>media>DOMBitmapItem"))
		{
			if (node.getAttr("name") == namePath)
			{
				loadLinkage(r, node);
				break;
			}
		}
		return r;
	}*/
	
	function loadLayer(namePath:String, layer:HtmlNodeElement) : Layer
	{
		var r = new Layer
		(
			layer.getAttr("name"),
			layer.getAttr("layerType", "normal"),
			layer.getAttr("visible", true),
			layer.getAttr("locked", false),
			layer.getAttrInt("parentLayerIndex")
		);
		for (frame in layer.find(">frames>DOMFrame"))
		{
			r.addKeyFrame(loadFrame(namePath, frame));
		}
		return r;
	}
	
	function loadFrame(namePath:String, frame:HtmlNodeElement)
	{
		return new KeyFrame
		(
			frame.getAttr("name", ""),
			Std.int(frame.getAttr("duration", 1)),
			loadMotionTween(namePath, frame),
			loadElements(namePath, frame.find(">elements>*"), new Matrix())
		);
	}
	
	function loadMotionTween(namePath:String, frame:HtmlNodeElement) : MotionTween
	{
		var type = frame.getAttr("tweenType", "none");
		switch (type)
		{
			case "none": // do nothing
				return null;
			
			case "motion":
				return new MotionTween
				(
					- frame.getAttrInt("acceleration", 0),
					frame.getAttr("motionTweenOrientToPath", false),
					parseMotionTweenRotate(frame.getAttr("motionTweenRotate"), frame.getAttr("motionTweenRotateTimes", 1)),
					0,
					0,
					0,
					0
				);
				
			case "shape":
				if (!morphingNotSupported.has(namePath))
				{
					morphingNotSupported.push(namePath);
					console.warn("Shape morphing tween is not supported (symbol '" + namePath + "').");
				}
				return null;
				
			case _:
				console.warn("Unknow tween type '" + type + "' (symbol '" + namePath + "').");
				return null;
		}
	}
	
	function loadElements(namePath:String, elements:Array<HtmlNodeElement>, parentMatrix:Matrix)
	{
		var r = new Array<Element>();
		for (element in elements)
		{
			switch (element.name)
			{
				case "DOMSymbolInstance", "DOMBitmapInstance":
					var instance = new Instance
					(
						PathTools.unescape(element.getAttr("libraryItemName")),
						element.getAttr("name", ""),
						loadColorEffect(element.findOne(">color>Color")),
						element.find(">filters>*").map(function(f) return loadFilter(f)),
						element.getAttr("blendMode", "normal")
					);
					instance.matrix = MatrixParser.load(element.findOne(">matrix>Matrix")).prependMatrix(parentMatrix);
					loadRegPoint(instance, element.findOne(">transformationPoint>Point"));
					r.push(instance);
					
				case "DOMShape":
					if (!element.getAttr("isDrawingObject", false))
					{
						r = r.concat(loadShape(namePath, element, parentMatrix));
					}
					else
					{
						r.addRange(loadShape(namePath, element, parentMatrix));
					}
					
				case "DOMRectangleObject":
					r.addRange(loadDrawing(namePath, element, parentMatrix, (strokes, fills) ->
					{
						return ShapeElement.createRectangle
						(
							element.getAttrFloat("x"),
							element.getAttrFloat("y"),
							element.getAttrFloat("objectWidth"),
							element.getAttrFloat("objectHeight"),
							element.getAttrFloat("topLeftRadius", 0.0),
							element.getAttrFloat("topRightRadius", 0.0),
							element.getAttrFloat("bottomRightRadius", 0.0),
							element.getAttrFloat("bottomLeftRadius", 0.0),
							strokes.length > 0 ? strokes[0] : null,
							fills.length > 0 ? fills[0] : null
						);
					}));
					
				case "DOMOvalObject":
					r.addRange(loadDrawing(namePath, element, parentMatrix, (strokes, fills) ->
					{
						return ShapeElement.createOval
						(
							element.getAttrFloat("x") + element.getAttrFloat("objectWidth") / 2,
							element.getAttrFloat("y") + element.getAttrFloat("objectHeight") / 2,
							element.getAttrFloat("objectWidth") / 2,
							element.getAttrFloat("objectHeight") / 2,
							element.getAttrFloat("startAngle", 0.0),
							element.getAttrFloat("endAngle", 360.0),
							element.getAttrFloat("innerRadius", 0.0),
							element.getAttrBool("closePath", true),
							strokes.length > 0 ? strokes[0] : null,
							fills.length > 0 ? fills[0] : null
						);
					}));
					
				case "DOMStaticText", "DOMDynamicText", "DOMInputText":
					r.push(loadText(element, parentMatrix));
					
				case "DOMGroup":
					var elements = element.find(">members>*");
					if (elements.length > 0)
					{
						final m = MatrixParser.load(element.findOne(">matrix>Matrix"));
                        r.addRange(loadElements(namePath, elements, parentMatrix.appendMatrix(m))); // TODO: check matrix
					}
					
				case "DOMTLFText":
					console.warn("DOMTLFText is not supported. Please, resave original document in Flash Pro CC.");
					
				case _:
					console.warn("Unknow element node: '" + element.name + "'.");
			}
		}
		return r;
	}
	
	function loadShape(namePath:String, element:HtmlNodeElement, parentMatrix:Matrix) : Array<Element>
	{
		return loadDrawing(namePath, element, parentMatrix, (strokes, fills) ->
		{
			return new ShapeConvertor(strokes, fills, loadEdgeDatas(element)).convert();
		});
	}
	
	function loadDrawing(namePath:String, element:HtmlNodeElement, parentMatrix:Matrix, parseDrawData:Array<IStroke>->Array<IFill>->{ var edges(default, null):Array<StrokeEdge>; var polygons(default, null):Array<Polygon>; } ) : Array<Element>
	{
		var transformedStrokes = element.find(">strokes>StrokeStyle>*, >stroke>*").map(loadShapeStroke);
		var transformedFills = element.find(">fills>FillStyle>*, >fill>*").map(loadShapeFill);
		
		var matrixBy = new ObjectMap<Dynamic, Matrix>();
		var byMatrix = new MatrixMap<Array<Dynamic>>();
		for (z in transformedStrokes)
		{
			matrixBy.set(z.stroke, z.matrix);
			if (!byMatrix.exists(z.matrix)) byMatrix.set(z.matrix, []);
			byMatrix.get(z.matrix).push(z.stroke);
		}
		for (z in transformedFills)
		{
			matrixBy.set(z.fill, z.matrix);
			if (!byMatrix.exists(z.matrix)) byMatrix.set(z.matrix, []);
			byMatrix.get(z.matrix).push(z.fill);
		}
		
		var shapeData = parseDrawData
		(
			transformedStrokes.map(function(z) return z.stroke),
			transformedFills.map(function(z) return z.fill)
		);
		
		var objectMatrix = MatrixParser.load(element.findOne(">matrix>Matrix")).prependMatrix(parentMatrix);
		
		var r : Array<Element> = [];
		
		var edges = shapeData.edges.extract(function(edge) return matrixBy.get(edge.stroke).isIdentity());
		var polygons = shapeData.polygons.extract(function(polygon) return matrixBy.get(polygon.fill).isIdentity());
		if (edges.length > 0 || polygons.length > 0)
		{
			var shape = new ShapeElement(edges, polygons);
			loadRegPoint(shape, element.findOne(">transformationPoint>Point"));
			shape.transform(objectMatrix, true);
			r.push(shape);
		};
		
		for (matrix in byMatrix.keys())
		{
			if (matrix.isIdentity()) continue;
			
			var shape = new ShapeElement
			(
				shapeData.edges.extract(function(edge) return matrixBy.get(edge.stroke).equ(matrix)),
				shapeData.polygons.extract(function(polygon) return matrixBy.get(polygon.fill).equ(matrix))
			);
			shape.transform(matrix.clone().invert(), false);
			
			r.push(wrapElements(namePath, [ shape ], objectMatrix.clone().appendMatrix(matrix)));
		}
		
		return r;
	}
	
	function wrapElements(autoPrefixID:String, elements:Array<Element>, ?matrix:Matrix) : Instance
	{
        var mcItem = new MovieClipItem(generateNewID(autoPrefixID));
        library.addItem(mcItem);
		mcItem.addLayer(new Layer("auto"));
		mcItem.layers[0].addKeyFrame(new KeyFrame(elements));
		var r = mcItem.newInstance();
		if (matrix != null) r.matrix = matrix;
		return r;
	}
	
	function loadEdgeDatas(element:HtmlNodeElement) : Array<EdgeData>
	{
		var r = [];
		for (edge in element.find(">edges>Edge"))
		{
			var edgeData = new EdgeData(edge);
			if ((edgeData.fillStyle0 != null || edgeData.fillStyle1 != null || edgeData.strokeStyle != null) && edgeData.drawOps.length > 0)
			{
				r.push(edgeData);
			}
		}
		return r;
	}
	
	function loadShapeFill(fill:HtmlNodeElement) : { fill:IFill, matrix:Matrix }
	{
		switch (fill.name)
		{
			case "SolidColor":
				return
				{
					fill: new SolidFill(ColorTools.joinStringAndAlpha(fill.getAttr("color", "#000000"), fill.getAttr("alpha", 1.0))),
					matrix: new Matrix()
				};
				
			case "LinearGradient":
				var gradients = fill.find(">GradientEntry");
				var m = MatrixParser.load(fill.findOne(">matrix>Matrix"), 1 / 819.2);
				var p0 = m.transformPoint(-1, 0);
				var p1 = m.transformPoint( 1, 0);
				return
				{
					fill: new LinearFill
					(
						gradients.map(function(g) return ColorTools.joinStringAndAlpha(g.getAttr("color", "#000000"), g.getAttr("alpha", 1.0))),
						gradients.map(function(g) return g.getAttr("ratio")),
						p0.x,
						p0.y,
						p1.x,
						p1.y
					),
					matrix: new Matrix()
				};
				//writeRegPoint(element.findOne(">transformationPoint>Point"));
				
			case "RadialGradient":
				var focalPointRatio = fill.getAttr("focalPointRatio", 0.0);
				var gradients = fill.find(">GradientEntry");
				var m = MatrixParser.load(fill.findOne(">matrix>Matrix"), 1 / 819.2);
				
				var p0 = m.transformPoint(0, 0);
				var p1 = m.transformPoint(1, 0);
				var p2 = m.transformPoint(0, 1);
				
				var k = Math.abs(PointTools.getDist(p0.x, p0.y, p2.x, p2.y) - PointTools.getDist(p0.x, p0.y, p1.x, p1.y));
				if (k < EPS)
				{
					return
					{
						fill: new RadialFill
						(
							gradients.map(function(g) return ColorTools.joinStringAndAlpha(g.getAttr("color", "#000000"), g.getAttr("alpha", 1.0))),
							gradients.map(function(g) return g.getAttr("ratio")),
							p0.x,
							p0.y,
							PointTools.getDist(p0.x, p0.y, p1.x, p1.y),
							p0.x + (p1.x - p0.x) * focalPointRatio,
							p0.y + (p1.y - p0.y) * focalPointRatio
							
						),
						matrix: new Matrix()
					};
				}
				else
				{
					return
					{
						fill: new RadialFill
						(
							gradients.map(function(g) return ColorTools.joinStringAndAlpha(g.getAttr("color", "#000000"), g.getAttr("alpha", 1.0))),
							gradients.map(function(g) return g.getAttr("ratio")),
							0,
							0,
							1,
							focalPointRatio,
							0
						),
						matrix: m
					};
					
				}
				//writeRegPoint(element.findOne(">transformationPoint>Point"));
				
			case "BitmapFill":
				return
				{
					fill: new BitmapFill
					(
						fill.getAttr("bitmapPath"),
						fill.getAttr("bitmapIsClipped", true) ? "no-repeat" : "repeat",
						MatrixParser.load(fill.findOne(">matrix>Matrix"), 20)
					),
					matrix: new Matrix()
				};
				
			case _:
				console.warn("Unknow fill type '" + fill.name + "'.");
				return
				{
					fill: new SolidFill("#FFFFFF"),
					matrix: new Matrix()
				};
		}
		
	}
	
	function loadShapeStroke(stroke:HtmlNodeElement) : { stroke:IStroke, matrix:Matrix }
	{
		var isHairline = stroke.getAttr("solidStyle") == "hairline";
		var colorElem = stroke.findOne(">fill>SolidColor");
		switch (stroke.name)
		{
			case "SolidStroke":
				return
				{
					stroke: new SolidStroke
					(
						ColorTools.joinStringAndAlpha(colorElem.getAttr("color", "#000000"), colorElem.getAttr("alpha", 1.0)),
						!isHairline ? stroke.getAttr("weight", 1.0) : 1.0,
						stroke.getAttr("caps", "round"),
						stroke.getAttr("joins", "round"),
						stroke.getAttr("miterLimit", 3.0),
						isHairline
					),
					matrix: new Matrix()
				};
			
			case _:
				console.warn("Unknow stroke type '" + stroke.name + "'.");
				return 
				{
					stroke: new SolidStroke("#000000"),
					matrix: new Matrix()
				}
		}
	}
	
	function loadRegPoint(dest:{ regX:Float, regY:Float }, point:HtmlNodeElement)
	{
		if (point != null)
		{
			dest.regX = point.getAttr("x", 0);
			dest.regY = point.getAttr("y", 0);
		}
	}
	
	function loadText(text:HtmlNodeElement, parentMatrix:Matrix) : TextElement
	{
		var r = new TextElement
		(
			text.getAttr("name", ""),
			text.getAttr("width",  0.0) + 4.0,
			text.getAttr("height", 0.0) + 4.0,
			text.getAttr("isSelectable", true),
			false,
			TextRun.optimize(text.find(">textRuns>DOMTextRun").map(function(run) return loadTextRun(run)))
		);	
		r.matrix = MatrixParser.load(text.findOne(">matrix>Matrix"), 1.0, -2 + text.getAttr("left", 0.0), -2).prependMatrix(parentMatrix);
		loadRegPoint(r, text.findOne(">transformationPoint>Point"));
		return r;
	}
	
	function loadTextRun(textRun:HtmlNodeElement) : TextRun
	{
		var textAttrs = textRun.findOne(">textAttrs>DOMTextAttrs");
		
		var face = textAttrs.getAttr("face");
		if (!fontMap.exists(face))
		{
			var font = fontConvertor.convert(face);
			fontMap.set(face, font);
			console.log("FONT MAP: " + face +" -> " + font.face + " / " + (font.style != "" ? font.style : "regular"));
		}
		
		var font = fontMap.get(face);
		
		return TextRun.create
		(
			Utf8.htmlUnescape(textRun.findOne(">characters").innerHTML).replace("\r", "\n"),
			textAttrs.getAttr("fillColor", "#000000"),
			font.face,
			font.style,
			textAttrs.getAttrFloat("size", 12.0),
			textAttrs.getAttr("alignment", "left"),
			0,
			"#000000",
			textAttrs.getAttrBool("autoKern", false),
			textAttrs.getAttrFloat("letterSpacing", 0),
			textAttrs.getAttrFloat("lineSpacing", 2)
		);
	}
	
	function loadColorEffect(color:HtmlNodeElement) : ColorEffect
	{
		if (color == null) return null;
		
		if (color.hasAttribute("brightness"))
		{
			return new ColorEffectBrightness(color.getAttr("brightness", 1.0));
		}
		
		if (color.hasAttribute("tintMultiplier"))
		{
			return new ColorEffectTint(color.getAttr("tintColor"), color.getAttr("tintMultiplier", 1.0));
		}
		
		var props =
		[
			"alphaMultiplier", "redMultiplier", "greenMultiplier", "blueMultiplier",
			"alphaOffset", "redOffset", "greenOffset", "blueOffset"
		];
		var propCount = color.getAttributesAssoc().keys().count(function(s) return props.has(s));
		if (color.hasAttribute("alphaMultiplier") && propCount == 1)
		{
			return new ColorEffectAlpha(color.getAttr("alphaMultiplier", 1.0));
		}
		else
		if (propCount > 0)
		{
			return new ColorEffectAdvanced
			(
				color.getAttr("alphaMultiplier", 1.0),
				color.getAttr("redMultiplier", 1.0),
				color.getAttr("greenMultiplier", 1.0),
				color.getAttr("blueMultiplier", 1.0),
				color.getAttr("alphaOffset", 0.0),
				color.getAttr("redOffset", 0.0),
				color.getAttr("greenOffset", 0.0),
				color.getAttr("blueOffset", 0.0)
			);
		}
		return null;
	}
	
	function loadFilter(filter:HtmlNodeElement) : FilterDef
	{
		if (filter == null) return null;
		
		var params = filter.getAttributesObject();
		
		fixFilterParamFloat(params, "strength", 100, function(k) return Math.round(k * 100));
		fixFilterParamFloat(params, "blurX",    10,  function(k) return k * 2);
		fixFilterParamFloat(params, "blurY",    10,  function(k) return k * 2);
		
		filter.name = switch (filter.name)
		{
			case "BlurFilter": "BoxBlurFilter";
			case _: filter.name;
		};
		
		return new FilterDef(filter.name, params);
	}
	
	function parseMotionTweenRotate(motionTweenRotate:String, motionTweenRotateTimes:Int) : Int
	{
		switch (motionTweenRotate)
		{
			case "clockwise": return motionTweenRotateTimes;
			case "counter-clockwise": return -motionTweenRotateTimes;
			case _: return 0;
		}
	}
	
	function loadLinkage(item:InstancableItem, node:HtmlNodeElement)
	{
		if (node.getAttr("linkageExportForAS", false))
		{
			item.linkedClass = node.getAttr("linkageClassName", "");
			
			var linkageIdentifier = node.getAttr("linkageIdentifier", "");
			if (linkageIdentifier != "")
			{
				console.warn("Linkage identifier is not supported (symbol '" + item.namePath + "')");
				if (item.linkedClass == "") item.linkedClass = linkageIdentifier;
			}
		}
	}
	
	function fixFilterParamFloat(params:Dynamic, name:String, defValue:Float, f:Float->Float) : Void
	{
		Reflect.setField
		(
			params,
			name,
			Reflect.hasField(params, name) ? f(Std.parseFloat(Reflect.field(params, name))) : defValue
		);
	}
	
	function generateNewID(autoPrefixID="auto") : String
	{
		var i = 1;
		while (true)
		{
			var r = autoPrefixID + "_" + i;
			if (!library.hasItem(r) && generatedAutoIDs.indexOf(r) < 0)
			{
				generatedAutoIDs.push(r);
				return r;
			}
			i++;
		}
	}
	
	static function log(s:String, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(s, infos);
	}
}
