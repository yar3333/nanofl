package nanofl.ide.editor;

extern class FigureElementTools {
	static function select(figureElement:nanofl.ide.editor.FigureElement):Void;
	static function processLinearGradient(figureElement:nanofl.ide.editor.FigureElement, handler:nanofl.ide.editor.gradients.ILinearGradient -> Void):Void;
	static function processRadialGradient(figureElement:nanofl.ide.editor.FigureElement, handler:nanofl.ide.editor.gradients.IRadialGradient -> Void):Void;
	static function processBitmapGradient(figureElement:nanofl.ide.editor.FigureElement, handler:nanofl.ide.editor.gradients.IBitmapGradient -> Void):Void;
}