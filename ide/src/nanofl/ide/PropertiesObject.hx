package nanofl.ide;

import nanofl.engine.movieclip.KeyFrame;
import nanofl.ide.editor.Figure;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.elements.EditorElementInstance;
import nanofl.ide.editor.elements.EditorElementText;

enum PropertiesObject
{
	NONE;
	INSTANCE(item:EditorElementInstance);
	TEXT(item:EditorElementText, newObjectParams:NewObjectParams);
	SHAPE(figure:Figure, newObjectParams:NewObjectParams, options:ShapePropertiesOptions);
	KEY_FRAME(keyFrame:KeyFrame);
}