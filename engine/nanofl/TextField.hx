package nanofl;

import haxe.Json;
import haxe.Timer;
import js.Browser;
import js.html.CanvasRenderingContext2D;
import stdlib.Event;
import stdlib.Std;
import easeljs.display.Container;
import easeljs.events.MouseEvent;
import easeljs.geom.Point;
import easeljs.display.Shape;
import easeljs.display.Text;
import nanofl.engine.TextChunk;
import nanofl.engine.TextLine;
using nanofl.engine.DrawTools;
using StringTools;
using stdlib.Lambda;

@:expose
@:build(JsProp.marked())
class TextField extends SolidContainer
{
	public static var PADDING = 2.0;
	
	static var fontHeightCache = new Map<String, Float>();
	static var fontBaselineCoefCache = new Map<String, Float>();
	
	var _minWidth : Float;
    @:property
	public var minWidth(get, never) : Float;
	function get_minWidth() { update(); return _minWidth; }
	
	var _minHeight : Float;
    @:property
	public var minHeight(get, never) : Float;
	function get_minHeight() { update(); return _minHeight; }
	
	var _width : Float;
    @:property
	public var width(get, set) : Float;
	function get_width() return _width;
	function set_width(v) { if (_width != v) { _width = v; needUpdate = true; } return v; }
	
	var _height : Float;
    @:property
	public var height(get, set) : Float;
	function get_height() return _height;
	function set_height(v) { if (_height != v) { _height = v; needUpdate = true; } return v; }
	
	public var selectable : Bool;
	
	var _border : Bool;
    @:property
	public var border(get, set) : Bool;
	function get_border() return _border;
	function set_border(v) { if (_border != v) { _border = v; optionsChanged(); } return v; }
	
	var _dashedBorder : Bool;
    @:property
	public var dashedBorder(get, set) : Bool;
	function get_dashedBorder() return _dashedBorder;
	function set_dashedBorder(v) { if (_dashedBorder != v) { _dashedBorder = v; optionsChanged(); } return v; }
	
	var textRunsOnLastUpdate : Array<TextRun>;
	
	public var textRuns : Array<TextRun>;
	
	var needUpdate : Bool;
	
	@:allow(nanofl.engine.elements.TextElement.breakApart)
	var textLines : Array<TextLine>;
	
	#if ide
	
	var caretTimer : Timer;
	var caretStartPos : Point;
	var caretEndPos : Point;
	var textarea : js.JQuery;
	
    var _editing : Bool;
	public var editing(get, set) : Bool;
	function get_editing() return _editing;
	function set_editing(v) { if (_editing != v) { _editing = v; optionsChanged(); } return v; }
	
	var _selectionStart : Int;
	public var selectionStart(get, set) : Int;
	function get_selectionStart() : Int return _selectionStart;
	function set_selectionStart(v:Int) : Int { if (_selectionStart != v) { needUpdate = true; _selectionStart = v; } return v; }
	
	var _selectionEnd : Int;
	public var selectionEnd(get, set) : Int;
	function get_selectionEnd() : Int return _selectionEnd;
	function set_selectionEnd(v:Int) : Int { if (_selectionEnd != v) { needUpdate = true; _selectionEnd = v; } return v; }
	
	#else
	
	static inline var editing = false;
	static inline var selectionStart = 0;
	static inline var selectionEnd = 0;
	
	#end
	
	var _newTextFormat : TextRun;
    @:property
	public var newTextFormat(get, set) : TextRun;
	function get_newTextFormat() return _newTextFormat != null ? _newTextFormat : _newTextFormat = new TextRun();
	function set_newTextFormat(format:TextRun)
	{
		stdlib.Debug.assert(format != null, "TextField.newTextFormat must not be null." + haxe.CallStack.toString(haxe.CallStack.callStack()));
		return _newTextFormat = format;
	}
	
	var globalBackground : Shape;
	var background : Shape;
	var textsContainer : Container;
	var borders : Shape;
	var caret : Shape;
	
	var hitBox : Shape;
	
	public var resize(default, null) : Event<{ width:Float, height:Float }>;
	public var change(default, null) : Event<{}>;
	
    @:property
	public var text(get, set) : String;
	function get_text() return textRuns.map(run -> run.characters).join("");
	function set_text(v:String) : String
	{
		final format = textRuns.length > 0 ? textRuns[textRuns.length - 1] : newTextFormat;
		textRuns.splice(0, textRuns.length);
		textRuns.push(format.duplicate(v));
		return v;
	}
	
	public function new(width=0.0, height=0.0, selectable=false, border=false, dashedBorder=false, ?textRuns:Array<TextRun>, ?newTextFormat:TextRun)
	{
		super();

        #if ide
        _editing = false;
        _selectionStart = 0;
        _selectionEnd = 0;
        #end

        _border = false;
        _dashedBorder = false;
		
		this.width = width;
		this.height = height;
		this.selectable = selectable;
		this.border = border;
		this.dashedBorder = dashedBorder;
		this.textRuns = textRuns != null ? textRuns : [];
		this._newTextFormat = newTextFormat;
		
		resize = new Event<{ width:Float, height:Float }>(this);
		change = new Event<{}>(this);
		
		for (textRun in this.textRuns)
		{
			textRun.characters = textRun.characters.replace("\r\n", "\n").replace("\r", "\n");
		}
		
		textLines = [];
		
		#if ide
		addMouseDownEventListener(onMousePressDown);
		#end
		
		addChild(globalBackground = new Shape());
		addChild(background = new Shape());
		addChild(textsContainer = new Container());
		addChild(borders = new Shape());
		addChild(caret = new Shape());
		
		hitBox = new Shape();
		
		optionsChanged();
	}
	
	function getSplittedByPosition(runs:Array<TextRun>, position:Int, textToInsert="") : Array<TextRun>
	{
		final r = [];
		
		if (position > 0)
		{
			var charIndex = 0;
			for (run in runs)
			{
				var len = run.characters.length;
				if (position > charIndex && position < charIndex + len)
				{
					r.push(run.duplicate(run.characters.substr(0, position - charIndex)));
					if (textToInsert.length > 0) r.push(run.duplicate(textToInsert));
					r.push(run.duplicate(run.characters.substr(position - charIndex, len - (position - charIndex))));
					len += textToInsert.length;
				}
				else
				{
					r.push(run.clone());
					if (position == charIndex + len)
					{
						if (textToInsert.length > 0)
						{
							r.push(run.duplicate(textToInsert));
							len += textToInsert.length;
						}
					}
				}
				charIndex += len;
			}
		}
		else
		{
			if (textToInsert.length > 0) r.push(runs.length > 0 ? runs[0].duplicate(textToInsert) : newTextFormat.duplicate(textToInsert));
			for (run in runs) r.push(run);
		}
		
		return r;
	}
	
	public function getTextLines() : Array<TextLine>
	{
		var runs = textRuns.copy();
		
		if (editing || selectable && !dashedBorder)
		{
			runs = getSplittedByPosition(runs, selectionEnd);
			if (selectionStart != selectionEnd)
			{
				runs = getSplittedByPosition(runs, selectionStart);
			}
		}
		
		final lines = getSplittedToLines(runs);
		
		final r = new Array<TextLine>();
		var charIndex = 0;
		for (i in 0...lines.length)
		{
			var runsLine = [];
			
			for (run in lines[i])
			{
				if (run.kerning)
				{
					runsLine.push(run);
				}
				else
				{
					for (j in 0...run.characters.length)
					{
						runsLine.push(run.duplicate(run.characters.charAt(j)));
					}
				}
			}
			
			var lineWidth = 0.0;
			var lineMinY = 1.0e10;
			var lineMaxY = -1.0e10;
			var lineSpacing = null;
			
			final chunks = new Array<TextChunk>();
			for (j in 0...runsLine.length)
			{
				final run = runsLine[j];
				
				final selected = ((selectable || editing) && (!dashedBorder || editing))
							&& charIndex >= Std.min(selectionStart, selectionEnd)
					        && charIndex < Std.max(selectionStart, selectionEnd);
				
				final text = createFirstText(run, selected);
				
				var bounds = text.getBounds();
				final fontHeight = measureFontHeight(run.family, run.style, run.size);
				final fontBaselineCoef = measureFontBaselineCoef(run.family, run.style);
				stdlib.Debug.assert(run.letterSpacing != null);
				text.setBounds
				(
					bounds.x,
					- fontHeight * fontBaselineCoef,
					bounds.width + (!run.kerning ? run.letterSpacing : 0),
					fontHeight
				);
				bounds = text.getBounds();
				
				if (i == lines.length - 1 || j < runsLine.length - 1)
				{
					lineWidth += bounds.width;
				}
				
				lineMinY = Math.min(lineMinY, bounds.y);
				lineMaxY = Math.max(lineMaxY, bounds.y + bounds.height);
				
				stdlib.Debug.assert(run.lineSpacing != null);
				lineSpacing = lineSpacing != null ? Math.max(lineSpacing, run.lineSpacing) : run.lineSpacing;
				
				chunks.push
				({
					text: text,
					textSecond: createSecondText(run, selected),
					charIndex: charIndex,
					bounds: bounds,
					backgroundColor: !selected ? run.backgroundColor : "darkblue",
					format: run
				});
				
				charIndex += run.characters.length;
			}
			
			r.push
			({
				chunks: chunks,
				width: lineWidth,
				minY: lineMinY,
				maxY: lineMaxY,
				align: runsLine[0].align.trim().toLowerCase(),
				spacing: lineSpacing - 2
			});
		}
		
		return r;
	}
	
	function getSplittedToLines(runs:Array<TextRun>) : Array<Array<TextRun>>
	{
		final runLines = new Array<Array<TextRun>>();
		var runLine = new Array<TextRun>();
		for (run in runs)
		{
			final lines = run.characters.split("\n");
			if (lines.length == 1)
			{
				if (run.characters != "") runLine.push(run);
			}
			else
			{
				for (i in 0...lines.length)
				{
					if (lines[i] != "") runLine.push(run.duplicate(lines[i]));
					if (i < lines.length - 1)
					{
						runLine.push(run.duplicate(" "));
						runLines.push(runLine);
						runLine = [];
					}
				}
			}
		}
		if (runLine.length == 0) runLine.push(runs.length > 0 ? runs[runs.length - 1].duplicate(" ") : newTextFormat.duplicate(" "));
		runLines.push(runLine);
		return runLines;
	}

	public function update() : Void
	{
		if (!needUpdate && !isTextChanged()) return;
		
		needUpdate = false;
		TextRun.optimize(textRuns);
		textRunsOnLastUpdate = textRuns.map(t -> t.clone());
		
		globalBackground.visible = false;
		borders.visible = false;
		
		var sizeChanged = false;
		
        log("text = " + Json.stringify(text));
        #if ide log("teAr = " + Json.stringify(textarea?.html() ?? "")); #end
		textLines = getTextLines();
		
		_minWidth = 0.0;
		_minHeight = PADDING * 2;
		for (line in textLines)
		{
            log(() -> "line = " + Json.stringify(line.chunks.fold((x, r) -> r += x.text.text, "")));
			
            _minWidth = Math.max(_minWidth, line.width + PADDING * 2);
			if (_minWidth > width)
			{
				switch (line.align)
				{
					case "center": x -= (line.width - (width - PADDING * 2)) / 2;
					case "right": x -= line.width - (width - PADDING * 2);
				}
				width = line.width + PADDING * 2;
				sizeChanged = true;
			}
			_minHeight += line.maxY - line.minY + line.spacing;
		}
		if (textLines.length > 0) _minHeight -= textLines[textLines.length - 1].spacing;
		if (_minHeight > height) { height = _minHeight; sizeChanged = true; }
		
		textsContainer.removeAllChildren();
		background.graphics.clear();
		
		var innerY = PADDING;
		for (i in 0...textLines.length)
		{
			final line = textLines[i];
			
			var innerX = PADDING + switch (line.align)
			{
				case "center": ((width - PADDING * 2) - line.width) / 2.0;
				case "right": (width - PADDING * 2) - line.width;
				case _: 0.0;
			};
			
			for (t in line.chunks)
			{
				if (t.textSecond != null) textsContainer.addChild(t.textSecond);
				textsContainer.addChild(t.text);
				
				t.text.x = innerX;
				t.text.y = innerY - line.minY;
				
				if (t.backgroundColor != null)
				{
					background.graphics
						.beginFill(t.backgroundColor)
						.rect(t.text.x + t.bounds.x, t.text.y + line.minY, t.bounds.width, line.maxY - line.minY)
						.endFill();
				}
				
				#if ide
                log("line = " + i + "; t.charIndex = " + t.charIndex + "; t.text.text = " + Json.stringify(t.text.text) + "; selection = " + selectionStart + " | " + selectionEnd);
				if (t.charIndex == selectionEnd)
				{
					caretStartPos = t.text.localToLocal(t.bounds.x, t.bounds.y, this);
					caretEndPos = t.text.localToLocal(t.bounds.x, t.bounds.y + t.bounds.height, this);
				}
				else
				if (t.charIndex + t.text.text.length == selectionEnd)
				{
					caretStartPos = t.text.localToLocal(t.bounds.x + t.bounds.width, t.bounds.y, this);
					caretEndPos = t.text.localToLocal(t.bounds.x + t.bounds.width, t.bounds.y + t.bounds.height, this);
				}
				#end
				
				if (t.textSecond != null)
				{
					t.textSecond.x = t.text.x;
					t.textSecond.y = t.text.y;
				}
				
				innerX += t.bounds.width;
			}
			
			innerY += line.maxY - line.minY + line.spacing;
		}
		
		if (border || dashedBorder)
		{
			var pt0 = localToGlobal(0, 0);
			pt0 = globalToLocal(Math.round(pt0.x) + 0.5, Math.round(pt0.y) + 0.5);
			
			var pt1 = localToGlobal(width, height);
			pt1 = globalToLocal(Math.round(pt1.x) + 0.5, Math.round(pt1.y) + 0.5);
			
			if (editing || border)
			{
				globalBackground.visible = true;
				globalBackground.graphics
					.clear()
					.beginFill("#FFFFFF")
					.rect(pt0.x, pt0.y, pt1.x - pt0.x, pt1.y - pt0.y)
					.endFill();
			}
			
			drawBorders(pt0, pt1);
		}
		
		if (sizeChanged)
		{
			resize.call( { width:width, height:height } );
		}
		
		updateHitArea();
		
		setBounds(0, 0, width, height);
		
		#if ide
		updateCaret();
		#end
	}
	
	override public function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool) : Bool
	{
		update();
		return super.draw(ctx, ignoreCache);
	}

	
	function drawBorders(pt0:Point, pt1:Point)
	{
		if (editing || border)
		{
			borders.visible = true;
			borders.graphics
				.clear()
				.setStrokeStyle(1.0, null, null, null, true)
				.beginStroke("#000000")
				.rect(pt0.x, pt0.y, pt1.x - pt0.x, pt1.y - pt0.y)
				.endStroke();
		}
		else
		if (dashedBorder)
		{
			borders.visible = true;
			
			final dashPt0 = globalToLocal(0, 0);
			final dashPt1 = globalToLocal(2, 2);
			final dashLen = (Math.abs(dashPt1.x - dashPt0.x) + Math.abs(dashPt1.y - dashPt0.y)) / 2;
			
			borders.graphics
				.clear()
				.setStrokeStyle(1.0, null, null, null, true)
				.drawDashedRect(pt0.x, pt0.y, pt1.x, pt1.y, "#000000", "#FFFFFF", dashLen);
		}
	}
	
	function updateHitArea()
	{
		if (!editing)
		{
			hitBox.graphics
				.clear()
				.beginFill("#000000")
				.rect(0, 0, width, height)
				.endFill();
		}
	}
	
	function optionsChanged()
	{
		hitArea = !editing ? hitBox : null;
		
		#if ide
		if (!editing)
		{
			if (textarea != null)
			{
				textarea.remove();
				textarea = null;
			}
		}
		#end
		
		needUpdate = true;
	}
	
	function updateStage()
	{
		update();
		if (stage != null) stage.update();
	}
	
	function isTextChanged()
	{
		if (textRunsOnLastUpdate.length != textRuns.length) return true;
		for (i in 0...textRuns.length)
		{
			if (!textRunsOnLastUpdate[i].equ(textRuns[i])) return true;
		}
		return false;
	}
	
	function createFirstText(run:TextRun, selected:Bool) : Text
	{
		if (!selected && run.isStroked())
		{
			return run.createText(run.strokeColor, run.strokeSize);
		}
		else
		{
			return run.createText(!selected ? run.fillColor : "white");
		}
	}
	
	function createSecondText(run:TextRun, selected:Bool) : Text
	{
		if (!selected && run.isFilled() && run.isStroked())
		{
			return run.createText();
		}
		else
		{
			return null;
		}
	}
	
	override public function clone(?recursive:Bool) : TextField 
	{
		return (cast this)._cloneProps
		(
			new TextField
			(
				width,
				height,
				selectable,
				border,
				dashedBorder,
				recursive ? textRuns.map(t -> t.clone()) : textRuns,
				recursive && newTextFormat != null ? newTextFormat.clone() : newTextFormat
			)
		);
	}
	
	public static function measureFontHeight(family:String, style:String, size:Float) : Float
	{
		final key = family + "|" + style + "|" + size;
		if (fontHeightCache.exists(key)) return fontHeightCache.get(key);
		
		final div = Browser.document.createElement("div");
		div.innerHTML = "Mp";
		div.style.position = "absolute";
		div.style.top  = "0";
		div.style.left = "0";
		div.style.fontFamily = family;
		div.style.fontWeight = style.indexOf("bold") >= 0 ? "bold" : "normal";
		div.style.fontStyle = style.indexOf("italic") >= 0 ? "italic" : "normal";
		div.style.fontSize = size + "px";
		div.style.lineHeight = "normal";
		
		if (Browser.document.body == null) Browser.document.body = cast Browser.document.querySelector("body");
		Browser.document.body.appendChild(div);
		final r = div.offsetHeight;
		Browser.document.body.removeChild(div);
		
		fontHeightCache.set(key, r);
		return r;
	}
	
	public static function measureFontBaselineCoef(family:String, style:String) : Float
	{
		final key = family + "|" + style;
		if (fontBaselineCoefCache.exists(key)) return fontBaselineCoefCache.get(key);
		
		final container = Browser.document.createElement("div");
		container.style.height = "100px";
		container.style.position = "absolute";
		container.style.top = "0";
		container.style.left = "0";
		
		final letter = Browser.document.createElement("span");
		letter.style.fontFamily = family;
		letter.style.fontWeight = style.indexOf("bold") >= 0 ? "bold" : "normal";
		letter.style.fontStyle = style.indexOf("italic") >= 0 ? "italic" : "normal";
		letter.style.fontSize = "100px";
		letter.style.lineHeight = "0";
		letter.innerHTML = "A";
		
		final strut = Browser.document.createElement("span");
		strut.style.fontFamily = family;
		strut.style.fontWeight = style.indexOf("bold") >= 0 ? "bold" : "normal";
		strut.style.fontStyle = style.indexOf("italic") >= 0 ? "italic" : "normal";
		strut.style.fontSize = "999px";
		strut.style.lineHeight = "normal";
		strut.style.display = "inline-block";
		strut.style.height = "100px";
		strut.innerHTML = "";
		
		container.appendChild(letter);
		container.appendChild(strut);
		Browser.document.body.appendChild(container);
		
		final r = 1 - (letter.offsetTop + letter.offsetHeight - container.offsetHeight - container.offsetTop) / 100;
		
		container.remove();
		
		fontBaselineCoefCache.set(key, r);
		return r;
	}
	
	#if ide
	
	function updateCaret()
	{
		if (editing && selectionStart == selectionEnd)
		{
			if (caretTimer != null) caretTimer.stop();
			
			var caretBlinkShow = true;
			caretTimer = new Timer(600);
			
			function updateCaretInner()
			{
				if (caretBlinkShow && textarea != null && Browser.document.activeElement == textarea[0])
				{
					caret.graphics
						.clear()
						.setStrokeStyle(1, null, null, null, true)
						.beginStroke("#000000")
						.moveTo(caretStartPos.x, caretStartPos.y)
						.lineTo(caretEndPos.x, caretEndPos.y)
						.endStroke();
					caret.visible = true;
				}
				else
				{
					caret.visible = false;
				}
				caretBlinkShow = !caretBlinkShow;
			}
			
			caretTimer.run = () -> { updateCaretInner(); if (stage != null) stage.update(); };
			updateCaretInner();
			
			if (textarea == null)
			{
				textarea = new js.JQuery
				(
					'<textarea autocorrect="off" autocapitalize="off" spellcheck="false" style="' +
						'position:absolute;' +
						'border:0;' +
						'margin:0;' +
						'padding:0;' +
						'outline:none !important;' +
						'box-shadow:none !important;' +
						'font-size:0;' +
						'background:transparent;' +
						'resize:none;' +
						'width:1000px;' +
						'height:0;' +
					'"></textarea>'
				);
				new js.JQuery(stage.canvas).after(textarea);
                log("set textarea.html = " + Json.stringify(text));
				textarea.html(text);
				setTextareaSelection();
				textarea.keydown(keydown);
				textarea.keypress(keypress);
				textarea.keyup(keyup);
				textarea.on("paste", paste);
				textarea.blur
				(
					function(_) Timer.delay
					(
						function()
						{
							final activeElement = Browser.document.activeElement;
							if (textarea != null && (activeElement == null || ["input", "textarea"].indexOf(activeElement.tagName.toLowerCase()) < 0))
							{
								textarea.focus();
							}
						},
						1
					)
				);
				textarea.focus();
			}
		}
		else
		{
			caret.visible = false;
			if (caretTimer != null)
			{
				caretTimer.stop();
				caretTimer = null;
			}
			
			if (!editing && textarea != null)
			{
				textarea.remove();
				textarea = null;
			}
		}
	}
	
	function getCharIndexByPoint(stageX:Float, stageY:Float) : Int
	{
		if (textLines.length == 0) return 0;
		
		final pt = globalToLocal(stageX, stageY);
		
		final bounds = textLines[0].chunks[0].text.getTransformedBounds();
		if (pt.y < bounds.y || pt.y < bounds.y  + bounds.height && pt.x <= bounds.x) return 0;
		
		for (lineIndex in 0...textLines.length)
		{
            final line = textLines[lineIndex];
			for (chunkIndex in 0...line.chunks.length)
			{
                final t = line.chunks[chunkIndex];
				final bounds = t.text.getTransformedBounds();
                if (pt.y < bounds.y + bounds.height)
                {
                    if (pt.x >= bounds.x && pt.x < bounds.x + bounds.width)
                    {
                        for (i in 0...t.text.text.length)
                        {
                            final w2 = new Text(t.text.text.substr(0, i + 1), t.text.font).getMeasuredWidth();
                            if (bounds.x + w2 > pt.x)
                            {
                                final w1 = new Text(t.text.text.substr(0, i), t.text.font).getMeasuredWidth();
                                final w = (w1 + w2) / 2;
                                return Std.min(text.length, t.charIndex + i + (pt.x < bounds.x + w ? 0 : 1));
                            }
                        }
    				}
                    else if (pt.y >= bounds.y && chunkIndex == 0 && pt.x < bounds.x)
                    {
                        return Std.min(text.length, t.charIndex);
                    }
                    else if (pt.y >= bounds.y && chunkIndex == line.chunks.length - 1 && pt.x >= bounds.x + bounds.width)
                    {
                        return Std.min(text.length, t.charIndex + t.text.text.length - (lineIndex < textLines.length - 1 ? 1 : 0));
                    }
				}
			}
		}
		
		final lastLine = textLines[textLines.length - 1];
		final lastText = lastLine.chunks[lastLine.chunks.length - 1];
		return Std.min(text.length, lastText.charIndex + lastText.text.text.length);
	}
	
	function onMousePressDown(e:MouseEvent)
	{
		if (dashedBorder && !editing) return;
		
		if (e.nativeEvent.which == 1)
		{
			selectionStart = selectionEnd = getCharIndexByPoint(e.stageX, e.stageY);
            log("onMousePressDown selectionStart = selectionEnd = " + selectionStart);
			setTextareaSelection();
			
			change.call(null);
			updateStage();
			
			stage.addStageMouseMoveEventListener(onMousePressMove);
			stage.addStageMouseUpEventListener(onMousePressUp);
		}
	}
		
	function onMousePressMove(e:MouseEvent)
	{
		if (dashedBorder && !editing) return;
		
		selectionEnd = getCharIndexByPoint(e.stageX, e.stageY);
		setTextareaSelection();
		change.call(null);
		updateStage();
	}
		
	function onMousePressUp(e:MouseEvent)
	{
		if (stage != null)
		{
			stage.removeStageMouseMoveEventListener(onMousePressMove);
			stage.removeStageMouseUpEventListener(onMousePressUp);
		}
		
		if (dashedBorder && !editing) return;
		
		selectionEnd = getCharIndexByPoint(e.stageX, e.stageY);
		setTextareaSelection();
		change.call(null);
		updateStage();
	}
	
	function insertToTextRuns(s:String)
	{
		removeSelectedFromTextRuns();
		
		final runs = getSplittedByPosition(textRuns, selectionEnd, s);
		
		textRuns.splice(0, textRuns.length);
		for (run in runs) textRuns.push(run);
		
		selectionEnd = selectionStart;
		
		needUpdate = true;
	}
	
	function removeSelectedFromTextRuns()
	{
		final runs = getSplittedByPosition(getSplittedByPosition(textRuns, selectionStart), selectionEnd);
		
		var charIndex = 0;
		var i = 0; while (i < runs.length && charIndex < selectionEnd)
		{
			final len = runs[i].characters.length;
			if (charIndex >= selectionStart && charIndex + len <= selectionEnd)
			{
				newTextFormat = runs.splice(i, 1)[0].clone();
				i--;
			}
			charIndex += len;
			i++;
		}
		
		textRuns.splice(0, textRuns.length);
		for (run in runs) textRuns.push(run);
		
		selectionEnd = selectionStart;
		
		needUpdate = true;
	}
	
	function setTextareaSelection() : Void
	{
		Timer.delay(() ->
		{
			if (textarea != null)
			{
				final ta : js.html.TextAreaElement = cast textarea[0];
				if (ta.setSelectionRange != null)
				{
					ta.focus();
					ta.setSelectionRange(Std.min(selectionStart, selectionEnd), Std.max(selectionStart, selectionEnd));
				}
				else
				if ((cast ta).createTextRange)
				{
					final range = (cast ta).createTextRange();
					range.collapse(true);
					range.moveEnd("character", Std.max(selectionStart, selectionEnd));
					range.moveStart("character", Std.min(selectionStart, selectionEnd));
					range.select();
				}
			}
		}, 1);
	}
	
	function restoreSelectionFromTextarea()
	{
		if (textarea == null) return;
		
		final ta : js.html.TextAreaElement = cast textarea[0];
		
		if (!Math.isNaN(ta.selectionStart))
		{
			selectionStart = ta.selectionStart;
			selectionEnd = ta.selectionEnd;
		}
		else
		if ((cast Browser.document).selection)
		{
			ta.focus();
			
			final r = (cast Browser.document).selection.createRange();
			if (r == null)
			{
				selectionStart = 0;
				selectionEnd = ta.value.length;
			}
			else
			{
				final re : Dynamic = (cast ta).createTextRange();
				final rc : Dynamic = re.duplicate();
				re.moveToBookmark(r.getBookmark());
				rc.setEndPoint('EndToStart', re);
				
				selectionStart = rc.text.length;
				selectionEnd = rc.text.length + r.text.length;
			}
		}
	}
	
	function keydown(e:js.JQuery.JqEvent)
	{
		final length = text.length;
		
        log("keydown: " + e.keyCode);
        
		switch (e.keyCode)
        {
			case 8: // backspace
				if (selectionStart == selectionEnd && selectionStart > 0) selectionStart--;
				removeSelectedFromTextRuns();
				
            case 46: // del
                if (selectionStart == selectionEnd && selectionEnd < length) selectionEnd++;
				removeSelectedFromTextRuns();
				
            case 90: // Z undo
                if (e.ctrlKey)
                {
                    //doc.performUndo();
                }
				
            case 89: // Y redo
                if (e.ctrlKey)
                {
                    //doc.performUndo(true);
                }
			
            case 88: // X - cut to clipboard
                if (e.ctrlKey)
                {
					removeSelectedFromTextRuns();
                }
				
            case 27: // Escape
                editing = false;
        }
		
		updateStage();
	}
	
	function keypress(e:js.JQuery.JqEvent)
	{
		if (!e.ctrlKey && !e.altKey  && e.charCode != 0)
		{
            final c = e.charCode != "\r".code ? String.fromCharCode(e.charCode) : "\n";
			log("keypress: " + Json.stringify(c));
			insertToTextRuns(c);
			restoreSelectionFromTextarea();
		}
	}
	
	function keyup(e:js.JQuery.JqEvent)
	{
		restoreSelectionFromTextarea();
		change.call(null);
		updateStage();
	}
	
	function paste(e:js.JQuery.JqEvent)
	{
		insertToTextRuns((cast e.originalEvent:js.html.ClipboardEvent).clipboardData.getData("text/plain"));
	}
	
	public function getSelectionFormat() : TextRun
	{
		var charIndex = 0;
		for (run in textRuns)
		{
			final len = run.characters.length;
			if (selectionEnd >= charIndex && selectionEnd < charIndex + len)
			{
				return run.duplicate("");
			}
			charIndex += len;
		}
		
		return textRuns.length > 0 ? textRuns[textRuns.length - 1].duplicate("") : null;
	}
	
	public function setSelectionFormat(format:TextRun) : Void
	{
		final startIndex = editing ? Std.min(selectionStart, selectionEnd) : 0;
		final finishIndex = editing ? Std.max(selectionStart, selectionEnd) : this.text.length;
		
		final runs = getSplittedByPosition(getSplittedByPosition(textRuns, startIndex), finishIndex);
		var charIndex = 0;
		for (run in runs)
		{
			final len = run.characters.length;
			if (startIndex == finishIndex || charIndex >= startIndex && charIndex + len <= finishIndex)
			{
				run.applyFormat(format);
			}
			charIndex += len;
		}
		textRuns.splice(0, textRuns.length);
		for (run in runs) textRuns.push(run);
		needUpdate = true;
	}
	
	public function dispose() : Void
	{
		editing = false;
	}
	
	#end
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.trace("TextField", Reflect.isFunction(v) ? v() : v);
	}
}
