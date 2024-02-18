package nanofl.ide.editor.elements;

import nanofl.engine.elements.GroupElement;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.NewObjectParams;

class EditorElementGroup extends EditorElementSelectBox
{
	public var element(get, never) : GroupElement;
	@:noCompletion function get_element() return cast originalElement;
	
	public function getPropertiesObject(newObjectParams:NewObjectParams) : PropertiesObject
	{
		return PropertiesObject.GROUP(this);
	}
	
	override function onDoubleClickInner(e:EditorMouseEvent)
	{
		navigator.navigateDown(element);
	}
}