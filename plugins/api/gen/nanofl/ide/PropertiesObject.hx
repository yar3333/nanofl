package nanofl.ide;

extern enum PropertiesObject {
	NONE;
	INSTANCE(item:nanofl.ide.editor.elements.EditorElementInstance);
	TEXT(item:nanofl.ide.editor.elements.EditorElementText, newObjectParams:nanofl.ide.editor.NewObjectParams);
	GROUP(items:Array<nanofl.ide.editor.elements.EditorElement>);
	SHAPE(figure:nanofl.ide.editor.Figure, newObjectParams:nanofl.ide.editor.NewObjectParams, options:nanofl.ide.editor.ShapePropertiesOptions);
	KEY_FRAME(keyFrame:nanofl.engine.movieclip.KeyFrame);
}