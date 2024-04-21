package nanofl.ide.editor.elements;

import nanofl.TextField;
import nanofl.TextRun;
import nanofl.engine.elements.TextElement;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.editor.elements.EditorElementSelectBox;
import nanofl.ide.editor.tools.TextEditorTool;
using nanofl.engine.geom.PointTools;

class EditorElementText extends EditorElementSelectBox
{
	public var element(get, never) : TextElement;
	@:noCompletion function get_element() return cast originalElement;
	
	var tf(get, never) : TextField;
	@:noCompletion function get_tf() return cast dispObj;

	override public function update()
	{
        log("EditorElementText.update stage = " + (tf.stage != null) + "; tf.id = " + tf.id);

		super.update(); // tf recreated if need
        log("stage = " + (tf.stage != null) + "; tf.id = " + tf.id);
		
		tf.dashedBorder = !selected && layer.isShowSelection();
	}

    override function createDisplayObject()
    {
        log("EditorElementText: recreate tf");
        
        final dispObj : TextField = cast super.createDisplayObject();
        
        dispObj.resize.bind((_, e) ->
        {
            element.width = PointTools.roundGap(e.width);
            element.height = PointTools.roundGap(e.height);
            editor.tool.itemChanged(this);
            update();
        });
        
        dispObj.change.bind((_, e) ->
        {
            editor.tool.itemChanged(this);
            update();
        });

        return dispObj;
    }
	
	public function getPropertiesObject(newObjectParams:NewObjectParams) : PropertiesObject
	{
		return PropertiesObject.TEXT(this, newObjectParams);
	}
	
	override function onDoubleClickInner(e:EditorMouseEvent)
	{
		editor.deselectAll();
		view.properties.activate();
		editor.switchTool(TextEditorTool).beginEditing(this);
		e.invalidateEditorLight();
	}
	
	public function beginEditing()
	{
		tf.editing = true;
	}
	
	public function endEditing()
	{
		tf.editing = false;
	}
	
	public function setSelectionFormat(format:TextRun)
	{
		stdlib.Debug.assert(format != null);
		
		if (tf.selectionStart != tf.selectionEnd || !tf.editing)
		{
			tf.setSelectionFormat(format);
		}
		else
		{
			element.newTextFormat = tf.newTextFormat = element.newTextFormat.duplicate().applyFormat(format);
		}
	}
	
	public function getSelectionFormat() : TextRun
	{
		var r = tf.getSelectionFormat();
		if (r != null) return r;
		return element.newTextFormat = tf.newTextFormat;
	}
	
	public function setPosAndSize(obj:{ x:Float, y:Float, width:Float, height:Float })
	{
		element.matrix.tx = obj.x;
		element.matrix.ty = obj.y;
		element.width = obj.width;
		element.height = obj.height;
		
		tf.x = obj.x;
		tf.y = obj.y;
		tf.width = obj.width;
		tf.height = obj.height;
	}
	
	public function getMinSize() : { width:Float, height:Float }
	{
		return { width:tf.minWidth, height:tf.minHeight };
	}

	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}