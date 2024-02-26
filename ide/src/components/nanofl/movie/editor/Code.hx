package components.nanofl.movie.editor;

import easeljs.display.Container;
import easeljs.events.MouseEvent;
import easeljs.geom.Rectangle;
import easeljs.display.Shape;
import datatools.ArrayTools;
import js.html.CanvasElement;
import js.html.File;
import nanofl.DisplayObjectTools;
import nanofl.Stage;
import nanofl.engine.elements.Instance;
import nanofl.engine.geom.Matrix;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.ide.Application;
import nanofl.ide.Globals;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.draganddrop.IDragAndDrop;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.library.droppers.LibraryItemToEditorDropper;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.View;
import js.JQuery;
using js.jquery.MouseWheel;
using nanofl.engine.geom.PointTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Code extends wquery.Component
{
	static var imports =
	{
		"context-menu": components.nanofl.common.contextmenu.Code
	};
	
	static var MILK_POWER = 0.5;
	static var MILK_COLOR = 255;
	static var ZOOM_SENS = 0.25;
	
	@inject var app : Application;
	@inject var view : View;
	@inject var dragAndDrop : DragAndDrop;
	@inject var preferences : Preferences;
	
	var canvas : CanvasElement;
    var stage : Stage;
	
	var background : Shape;
	var sceneBox : Shape;
	
	var root : Container;
	
	var milk : Container;
	
	var field : Container;
	
	var container : Container;
	var shapeSelections : Shape;
	var itemSelections : Shape;
	var controls : Container;
	
	var centerCross : Shape;
	
	var lastMilkEditPath : Array<PathItem>;
	
	@:allow(nanofl.ide.editor.Editor)
	var zoomLevel(get, set) : Float;
	@:noCompletion function get_zoomLevel() return root.scaleX * 100;
	@:noCompletion function set_zoomLevel(value:Float) { zoom(canvas.width / 2, canvas.height / 2, value); return value; }
	
	@:allow(nanofl.ide.editor.Editor)
	var viewX(get, set) : Float;
	function get_viewX() return root.x;
	function set_viewX(value:Float) return root.x = value;
	
	@:allow(nanofl.ide.editor.Editor)
	var viewY(get, set) : Float;
	function get_viewY() return root.y;
	function set_viewY(value:Float) return root.y = value;
	
	var editPath(get, never) : Array<PathItem>; @:noCompletion function get_editPath() : Array<PathItem> return app.document.navigator.editPath;
	var pathItem(get, never) : PathItem; @:noCompletion function get_pathItem() : PathItem return editPath[editPath.length - 1];
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		canvas = cast template().content[0];
		
		stage = new Stage(canvas);
		
		stage.addChild(background = new Shape());
		stage.addChild(sceneBox = new Shape());
		stage.addChild(root = new Container());
		
		root.addChild(milk = new Container());
		milk.filters = [ new easeljs.filters.ColorFilter(1 - MILK_POWER, 1 - MILK_POWER, 1 - MILK_POWER, 1, MILK_COLOR * MILK_POWER, MILK_COLOR * MILK_POWER, MILK_COLOR * MILK_POWER, 0) ];
		
		root.addChild(field = new Container());
		field.addChild(container = new Container());
		field.addChild(shapeSelections = new Shape());
		field.addChild(itemSelections = new Shape()); itemSelections.x = 0.5; itemSelections.y = 0.5;
		field.addChild(controls = new Container());
		
		stage.addChild(centerCross = new Shape());
		centerCross.mouseEnabled = false;
		centerCross.graphics
			.beginStroke("#000")
			.moveTo(-5, 0).lineTo(5, 0)
			.moveTo(0, -5).lineTo(0, 5)
			.endStroke();
		
		dragAndDrop.ready.then(function(api:IDragAndDrop)
		{
			api.droppable
			(
				template().content,
				[
					"libraryItem" => new LibraryItemToEditorDropper()
				],
				function(files:Array<File>, e:JqEvent)
				{
					log("editor.drop files");
					app.document.library.addFiles(files, "").then(function(items:Array<IIdeLibraryItem>)
					{
						for (item in items) LibraryItemToEditorDropper.processItem(app, view, item, e);
					});
				}
			);
		});
		
		template().contextMenu.build(template().content, preferences.storage.getMenu("editorContextMenu"), function(menu:nanofl.ide.ui.menu.ContextMenu, e:JqEvent, _)
		{
			if (!app.document.editor.tool.allowContextMenu()) return false;
			
			var mpos = getMousePos(e);
			var pos = container.globalToLocal(mpos.x, mpos.y);
			
			var isForSelected = false;
			
			if (app.document.editor.isSelectedAtPos(pos))
			{
				isForSelected = true;
			}
			else
			{
				var obj = app.document.editor.getItemAtPos(pos);
				if (obj != null)
				{
					if (!obj.selected)
					{
						app.document.editor.select(obj);
					}
					isForSelected = true;
				}
			}
			
			menu.toggleItem("editor.convertToSymbol", isForSelected);
			menu.toggleItem("editor.group", isForSelected);
			menu.toggleItem("editor.remove", isForSelected);
			menu.toggleItem("editor.breakApart", isForSelected);
			menu.toggleItem("editor.removeTransform", isForSelected);
			menu.toggleItem("editor.moveFront", isForSelected);
			menu.toggleItem("editor.moveForwards", isForSelected);
			menu.toggleItem("editor.moveBackwards", isForSelected);
			menu.toggleItem("editor.moveBack", isForSelected);
			menu.toggleItem("editor.cut", isForSelected);
			menu.toggleItem("editor.copy", isForSelected);
			//menu.toggleItem("editor.paste", true);
			
			menu.toggleItem("document.properties", !isForSelected && isPathItemIsMovieClip() && pathItem.element.isScene());
			menu.toggleItem("editor.properties", !isForSelected && isPathItemIsMovieClip() && !pathItem.element.isScene());
			
			return true;
		});
		
		template().content.mousewheel(function(e:JqEvent, d:Int, dx:Int, dy:Int)
		{
			var mpos = getMousePos(e);
			
			var k = 1.0 + Math.abs(dy) * ZOOM_SENS;
			if (dy < 0) k = 1.0 / k;
			
			zoom(mpos.x, mpos.y, Math.round(root.scaleX * k * 100));
		});
		
		var rootMoving = false;
		var rootMove1 = { x:0.0, y:0.0 };
		
		template().content.on("mousedown", function(e:JqEvent)
		{
			if (e.which == 2)
			{
				e.preventDefault();
				
				rootMove1 = getMousePos(e);
				rootMoving = true;
			}
		});
		
		template().content.on("mousemove", function(e:JqEvent)
		{
			if (rootMoving)
			{
				#if profiler Profiler.measure("editor.Client", "rootMoving", function() { #end
					e.preventDefault();
					
					var rootMove2 = getMousePos(e);
					root.x += rootMove2.x - rootMove1.x;
					root.y += rootMove2.y - rootMove1.y;
					rootMove1 = rootMove2;
					
					update();
				#if profiler }); #end
			}
		});
		
		template().content.on("mouseup", function(e:JqEvent)
		{
			if (e.which == 2)
			{
				e.preventDefault();
				rootMoving = false;
			}
		});
		
		stage.addMouseDownEventListener(function(e:MouseEvent)
		{
			if (e.nativeEvent.which == 1 || e.nativeEvent.which == 3)
			{
				log("editor/stage mousedown e.nativeEvent.which = " + e.nativeEvent.which);
				
				#if profiler Profiler.measure("editor.Client", "stage.mouseDown", function() { #end
					var ee = new EditorMouseEvent(e, container);
					if (e.nativeEvent.which == 1) app.document.editor.tool.stageMouseDown(ee);
					else						  app.document.editor.tool.stageRightMouseDown(ee);
					ee.updateInvalidated(app.document.editor, view.movie.timeline, view.library);
				#if profiler }); #end
			}
		});
		
		stage.addStageMouseMoveEventListener(function(e:MouseEvent)
		{
			if (app == null || app.document == null || app.document.editor.tool == null) return;
			
			//#if profiler Profiler.measure("editor.Client", "stage.mouseMove", function() { #end
				var ee = new EditorMouseEvent(e, container);
				app.document.editor.tool.stageMouseMove(ee);
				ee.updateInvalidated(app.document.editor, view.movie.timeline, view.library);
			//#if profiler }); #end
		});
		
		stage.addStageMouseUpEventListener(function(e:MouseEvent)
		{
			if (e.nativeEvent.which == 1 || e.nativeEvent.which == 3) 
			{
				log("editor/stage mouseup e.nativeEvent.which = " + e.nativeEvent.which);
				
				#if profiler Profiler.measure("editor.Client", "stage.mouseUp", function() { #end
					var ee = new EditorMouseEvent(e, container);
					if (e.nativeEvent.which == 1) app.document.editor.tool.stageMouseUp(ee);
					else                          app.document.editor.tool.stageRightMouseUp(ee);
					ee.updateInvalidated(app.document.editor, view.movie.timeline, view.library);
				#if profiler }); #end
			}
		});
		
		stage.addClickEventListener(function(e:MouseEvent)
		{
			if (e.nativeEvent.which == 1)
			{
				log("editor/stage click");
				
				#if profiler Profiler.measure("editor.Client", "stage.click", function() { #end
					var ee = new EditorMouseEvent(e, container);
					app.document.editor.tool.stageClick(ee);
					ee.updateInvalidated(app.document.editor, view.movie.timeline, view.library);
				#if profiler }); #end
			}
		});
		
		stage.addDblClickEventListener(function(e:MouseEvent)
		{
			log("editor/stage doubleclick e.nativeEvent.which = " + e.nativeEvent.which);
			
			#if profiler Profiler.measure("editor.Client", "stage.doubleClick", function() { #end
				var ee = new EditorMouseEvent(e, container);
				
				var item = app.document.editor.getItemAtPos(ee);
				if (item != null)
				{
					item.onDoubleClick(e);
					if (e.propagationStopped) return;
				}
				
				app.document.editor.tool.stageDoubleClick(ee);
				ee.updateInvalidated(app.document.editor, view.movie.timeline, view.library);
			#if profiler }); #end
		});
	}
	
	@:allow(nanofl.ide.editor.Editor.rebind)
	@:profile
	function rebind(isCenterView=false)
	{
		updateBackground();
		
		updateMilk();
		
		var mat = new Matrix();
		for (pi in editPath)
		{
			mat.appendMatrix(pi.element.matrix);
		}
		field.set(mat.decompose());
		
		container.removeAllChildren();
		container.addChild(app.document.editor.container);
		
		if (isCenterView)
		{
			if (editPath.length == 1)
			{
				var bounds = pathItem.element.isScene()
					? new Rectangle(0, 0, app.document.properties.width, app.document.properties.height)
					: DisplayObjectTools.getOuterBounds(container);
				
				if (bounds == null) bounds = new Rectangle(0, 0, 0, 0);
				
				var pt1 = container.localToGlobal(bounds.x, bounds.y);
				var pt2 = container.localToGlobal(bounds.x + bounds.width, bounds.y + bounds.height);
				root.x += (canvas.width  - (pt1.x + pt2.x)) / 2;
				root.y += (canvas.height - (pt1.y + pt2.y)) / 2;
			}
		}
		
		update();
	}
	
	public function updateToolControls()
	{
		controls.removeAllChildren();
		app.document.editor.tool.createControls(controls);
	}
	
	@:allow(nanofl.ide.editor.Editor)
	@:profile
	function update()
	{
		#if profiler Profiler.measure("editor.Client", "updateMinors", function() { #end
			template().content.css("cursor", app.document.editor.tool.getCursor());
			
			var baseContainer = editPath[0].element.isScene() ? root : container;
			var pos = baseContainer.localToGlobal(0, 0);
			template().container.css("background-position", pos.x + "px " + pos.y + "px");
			
			centerCross.visible = !pathItem.element.isScene() && app.document.editor.tool.isShowCenterCross();
			if (centerCross.visible)
			{
				var pt = field.localToGlobal(0, 0).half();
				centerCross.x = pt.x;
				centerCross.y = pt.y;
			}
			
			sceneBox.visible = editPath[0].element.isScene();
			if (sceneBox.visible)
			{
				var pt1 = root.localToGlobal(0, 0).half();
				var pt2 = new easeljs.geom.Point(app.document.properties.width * root.scaleX, app.document.properties.height * root.scaleY).round();
				sceneBox.graphics
					.clear()
					.setStrokeStyle(1.0)
					.beginStroke("#000000")
					.drawRect(pt1.x, pt1.y, pt2.x, pt2.y)
					.endStroke();
			}
		#if profiler }); #end
		
		#if profiler Profiler.measure("editor.Client", "tool.drawSelections", function() { #end
			shapeSelections.graphics.clear();
			itemSelections.graphics.clear();
			app.document.editor.tool.draw(shapeSelections, itemSelections);
		#if profiler }); #end
		
		#if profiler Profiler.measure("editor.Client", "stage.update", function() { #end
			stage.update();
		#if profiler }); #end
	}
	
	@:profile
	function updateMilk()
	{
		if (lastMilkEditPath != null && ArrayTools.equ(editPath, lastMilkEditPath)) return;
		
		lastMilkEditPath = editPath.map(x -> x.clone());
		
		milk.uncache();
		milk.removeAllChildren();
		
		pathItem.element.visible = false;
		milk.addChild(editPath[0].element.createDisplayObject(editPath.map(x -> { element:x.element, frameIndex:x.frameIndex })));
		pathItem.element.visible = true;
	}
	
	@:profile
	public function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container.width(maxWidth);
		template().container.height(maxHeight);
		
		template().content.width(template().container.innerWidth());
		template().content.height(template().container.innerHeight());
		
		var oldCanvasWidth = canvas.width;
		var oldCanvasHeight = canvas.height;
		canvas.width = template().container.innerWidth();
		canvas.height = template().container.innerHeight();
		
		updateBackground();
		
		root.x += (canvas.width - oldCanvasWidth) / 2;
		root.y += (canvas.height - oldCanvasHeight) / 2;
		
		if (app.document != null && app.document.editor.ready) update();
	}
	
	@:profile
	function updateBackground()
	{
		background.graphics
			.clear()
			.beginFill(app.document != null ? app.document.properties.backgroundColor : "#FFFFFF")
			.drawRect(0, 0, canvas.width, canvas.height)
			.endFill();
		
		var hitArea = new Shape();
			hitArea.graphics
			.beginFill("#FFFFFF")
			.drawRect(0, 0, canvas.width, canvas.height)
			.endFill();
		
		background.hitArea = hitArea;
	}
	
	public function on(event:String, callb:JqEvent->Void)
	{
		template().container.on(event, callb);
	}
	
	function zoom(x:Float, y:Float, zoom:Float)
	{
		var pt1 = root.globalToLocal(x, y);
		root.scaleX = root.scaleY = zoom / 100;
		var pt2 = root.localToGlobal(pt1.x, pt1.y);
		root.x -= pt2.x - x;
		root.y -= pt2.y - y;
		update();
		view.movie.zoomer.update();
	}
	
	function getMousePos(e:JqEvent) : nanofl.engine.geom.Point
	{
		var offset = template().content.offset();
		return { x:e.pageX - offset.left, y:e.pageY - offset.top };
	}
	
	public function getMousePosOnDisplayObject(e:JqEvent) : nanofl.engine.geom.Point
	{
		var mpos = getMousePos(e.originalEvent);
		return container.globalToLocal(mpos.x, mpos.y);
	}
	
	public function show() template().container.show();
	public function hide() template().container.hide();
	
	function isPathItemIsMovieClip()
	{
		return Std.isOfType(pathItem.element, Instance)
		    && Std.isOfType((cast pathItem.element:Instance).symbol, MovieClipItem);
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}