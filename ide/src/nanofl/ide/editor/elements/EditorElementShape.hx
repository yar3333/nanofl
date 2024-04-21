package nanofl.ide.editor.elements;

import nanofl.engine.elements.ShapeElement;
import nanofl.ide.editor.elements.EditorElement;

class EditorElementShape extends EditorElement
{
	public var element(get, never) : ShapeElement;
	@:noCompletion function get_element() return cast originalElement;

    public function getPropertiesObject(newObjectParams:NewObjectParams) : PropertiesObject
    {
        // TODO: getPropertiesObject / shape ????
        return PropertiesObject.NONE;
    }

    override function update()
    {
        setDispObj(createDisplayObject());
        super.update();
    }
}