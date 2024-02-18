package nanofl.ide.editor;

import nanofl.engine.fills.TypedFill;
import nanofl.ide.editor.gradients.IBitmapGradient;
import nanofl.ide.editor.gradients.ILinearGradient;
import nanofl.ide.editor.gradients.IRadialGradient;
import nanofl.engine.strokes.TypedStroke;
import nanofl.ide.editor.FigureElement;

class FigureElementTools
{
	public static function select(figureElement:FigureElement)
	{
		switch (figureElement)
		{
			case FigureElement.STROKE_EDGE(e): e.selected = true;
			case FigureElement.POLYGON(e): e.selected = true;
		}
	}
	
	public static function processLinearGradient(figureElement:FigureElement, handler:ILinearGradient->Void)
	{
		switch (figureElement)
		{
			case FigureElement.STROKE_EDGE(e):
				switch (e.stroke.getTyped())
				{
					case TypedStroke.linear(s):
						e.stroke = e.stroke.clone();
						handler(cast e.stroke);
					case _:
				}
				
			case FigureElement.POLYGON(e):
				switch (e.fill.getTyped())
				{
					case TypedFill.linear(_):
						e.fill = e.fill.clone();
						handler(cast e.fill);
					case _:
				}
		}
	}
	
	public static function processRadialGradient(figureElement:FigureElement, handler:IRadialGradient->Void)
	{
		switch (figureElement)
		{
			case FigureElement.STROKE_EDGE(e):
				switch (e.stroke.getTyped())
				{
					case TypedStroke.radial(_):
						e.stroke = e.stroke.clone();
						handler(cast e.stroke);
					case _:
				}
				
			case FigureElement.POLYGON(e):
				switch (e.fill.getTyped())
				{
					case TypedFill.radial(s):
						e.fill = e.fill.clone();
						handler(cast e.fill);
					case _:
				}
		}
	}
	
	public static function processBitmapGradient(figureElement:FigureElement, handler:IBitmapGradient->Void)
	{
		switch (figureElement)
		{
			case FigureElement.STROKE_EDGE(e):
				// nothing to do
				
			case FigureElement.POLYGON(e):
				switch (e.fill.getTyped())
				{
					case TypedFill.bitmap(_):
						e.fill = e.fill.clone();
						handler(cast e.fill);
					case _:
				}
		}
	}
}
