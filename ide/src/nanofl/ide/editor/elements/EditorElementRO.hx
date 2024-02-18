package nanofl.ide.editor.elements;

import nanofl.ide.PropertiesObject;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.editor.elements.EditorElement;

class EditorElementRO extends EditorElement
{
	public function getPropertiesObject(newObjectParams:NewObjectParams) : PropertiesObject
	{
		return PropertiesObject.NONE;
	}
}