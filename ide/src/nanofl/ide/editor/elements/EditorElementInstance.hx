package nanofl.ide.editor.elements;

import nanofl.engine.LibraryItemType;
import nanofl.engine.elements.Instance;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.NewObjectParams;

class EditorElementInstance extends EditorElementSelectBox
{
	public var element(get, never) : Instance;
	@:noCompletion function get_element() return cast originalElement;
	
	public function getPropertiesObject(newObjectParams:NewObjectParams) : PropertiesObject
	{
		return PropertiesObject.INSTANCE(this);
	}
	
	override function onDoubleClickInner(e:EditorMouseEvent)
	{
		if (element.symbol.type == LibraryItemType.movieclip)
		{
			navigator.navigateDown(element);
		}
	}

    override function updateTransformations()
    {
        element.updateDisplayObjectTweenedProperties(dispObj);
        super.updateTransformations();
    }
}