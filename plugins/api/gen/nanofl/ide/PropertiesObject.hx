package nanofl.ide;

extern enum PropertiesObject {
	TEXT(item:nanofl.ide.editor.elements.EditorElementText, newObjectParams:nanofl.ide.editor.NewObjectParams);
	SHAPE(figure:nanofl.ide.editor.Figure, newObjectParams:nanofl.ide.editor.NewObjectParams, options:nanofl.ide.editor.ShapePropertiesOptions);
	NONE;
	KEY_FRAME(keyFrame:nanofl.engine.movieclip.KeyFrame);
	INSTANCE(item:nanofl.ide.editor.elements.EditorElementInstance);
	GROUP(item:nanofl.ide.editor.elements.EditorElementGroup);
}