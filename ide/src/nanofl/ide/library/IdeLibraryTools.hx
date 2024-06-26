package nanofl.ide.library;

import nanofl.engine.LayerType;
import nanofl.ide.MovieClipItemTools;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.geom.Matrix;
import nanofl.ide.libraryitems.*;
import nanofl.engine.movieclip.KeyFrame;
using stdlib.Lambda;
using StringTools;

class IdeLibraryTools
{
	public static function optimize(library:IdeLibrary)
	{
		trace("Optimize library");
		
		while (true)
		{
			var libraryItemCount = library.getItemCount();
			var uses = getSymbolUseCount(library, getMovieClipItems(library));
			
			var itemsToRemove = new Array<String>();
			
			MovieClipItemTools.findInstances(library.getSceneItem(), (instance, parent) ->
			{
				if (uses.get(instance.namePath) == 1)
				{
					if (instance.matrix.isIdentity() && instance.filters.length == 0)
					{
						var element = tryItemContentToOneElement(cast(instance.symbol, IIdeInstancableItem));
						if (element != null)
						{
							if (Std.isOfType(element, ShapeElement))
							{
								var keyFrame : KeyFrame = parent.item.layers[parent.layerIndex].keyFrames[parent.keyFrameIndex];
								if (keyFrame.getShape(false) == null || keyFrame.getShape(false).isEmpty())
								{
									trace("Combine shapes (" + instance.namePath + ")");
									stdlib.Debug.assert(keyFrame.getShape(true).matrix.isIdentity());
									stdlib.Debug.assert((cast element:ShapeElement).matrix.isIdentity());
									keyFrame.getShape(true).combine((cast element:ShapeElement));
									itemsToRemove.push(instance.namePath);
								}
							}
							else
							if (Std.isOfType(element, Instance))
							{
								trace("Rearrange instance (" + instance.namePath + ")");
								itemsToRemove.push(instance.namePath);
								instance.namePath = (cast element:Instance).namePath;
								instance.matrix.appendMatrix((cast element:Instance).matrix);
							}
						}
					}
				}
			});
			
			for (namePath in uses.keys())
			{
				if (uses.get(namePath) == 0)
				{
					if (itemsToRemove.indexOf(namePath) < 0)
					{
						trace("Unused item (" + namePath + ")");
						itemsToRemove.push(namePath);
					}
				}
			}
			
			for (namePath in itemsToRemove)
			{
				library.removeItem(namePath);
			}
			
			for (item in library.getInstancableItemsAsIde())
			{
				if (item.namePath == nanofl.engine.Library.SCENE_NAME_PATH) continue;
				
				var element = tryItemContentToOneElement(item);
				if (Std.isOfType(element, Instance)
				 && Std.isOfType((cast element:Instance).symbol, MovieClipItem)
				 && (cast element:Instance).filters.length == 0
				) {
					trace("Avoid simple item (" + (cast element:Instance).namePath + " => " + item.namePath + ")");
					library.renameItem((cast element:Instance).namePath, item.namePath);
					if (item.namePath != nanofl.engine.Library.SCENE_NAME_PATH)
					{
						appendMatrixToAllInstances(library, item.namePath, element.matrix);
					}
					else
					{
						library.getSceneItem().transform(element.matrix);
					}
				}
			}
			
			if (library.getItemCount() == libraryItemCount) break;
		}
	}
	
	public static function getUsedItems(library:IdeLibrary, useTextureAtlases:Bool) : Array<IIdeLibraryItem>
	{
        final symbolsWithLinkedClass = library.getInstancableItemsAsIde().filter(x -> x.linkedClass != "");
        final forcedUsedSymbols = [ (library.getSceneItem() : IIdeInstancableItem) ].concat(symbolsWithLinkedClass);

		var usedNamePaths = forcedUsedSymbols.map(x -> x.namePath);
        for (mc in forcedUsedSymbols.filterByType(MovieClipItem))
        {
            MovieClipItemTools.getUsedNamePaths(mc, true, useTextureAtlases, usedNamePaths);
        }

        usedNamePaths = usedNamePaths.concat(library.getSoundsAsIde().filter(x -> x.linkage != "" && !usedNamePaths.contains(x.namePath)).map(x -> x.namePath));
        usedNamePaths = usedNamePaths.concat(library.getFontItemsAsIde().map(x -> x.namePath));

        final folderNamePaths = library.getItemsAsIde().filterByType(FolderItem).map(x -> x.namePath);
        while (true)
        {
            var folderAdded = false;
            for (folderNamePath in folderNamePaths) 
            {
                if (!usedNamePaths.contains(folderNamePath) && usedNamePaths.exists(x -> x.startsWith(folderNamePath + "/")))
                {
                    usedNamePaths.push(folderNamePath);
                    folderAdded = true;
                }
            }
            if (!folderAdded) break;
        }

        return usedNamePaths.map(x -> library.getItem(x));
	}
	
	public static function getUnusedItems(library:IdeLibrary, useTextureAtlases:Bool) : Array<IIdeLibraryItem>
	{
        var usedNamePaths = getUsedItems(library, useTextureAtlases).map(x -> x.namePath);
		return library.getItemsAsIde().filter(x -> !usedNamePaths.contains(x.namePath));
	}
	
	public static function getItemsContainInstances(library:IdeLibrary, namePaths:Array<String>) : Array<IIdeLibraryItem>
	{
		final r = [];
		for (item in library.getItemsAsIde(true))
		{
			final hasInstance = namePaths.exists(namePath ->
			{
				if (item.namePath == namePath) return true;
				if (Std.isOfType(item, MovieClipItem) && MovieClipItemTools.getUsedNamePaths((cast item:MovieClipItem), false, false).contains(namePath)) return true;
				return false;
			});
			if (hasInstance) r.push(item);
		}
		return r;
	}
	
	public static function hasEquItems(library:IdeLibrary, items:Array<IIdeLibraryItem>) : Bool
	{
		return items.foreach(x -> library.hasItem(x.namePath) && library.getItem(x.namePath).equ(x));
	}
	
	static function getSymbolUseCount(library:IdeLibrary, roots:Array<MovieClipItem>) : Map<String, Int>
	{
		final r = new Map<String, Int>();
		
		for (root in roots)
		{
			MovieClipItemTools.getUsedNamePathCount(root, r);
		}
		
		for (item in library.getItems())
		{
			if (!r.exists(item.namePath) && Std.isOfType(item, IIdeInstancableItem))
			{
				r.set(item.namePath, 0);
			}
		}
		
		return r;
	}
	
	static function getMovieClipItems(library:IdeLibrary) : Array<MovieClipItem>
	{
		return library.getItems(true).filterByType(MovieClipItem);
	}
	
	static function tryItemContentToOneElement(item:IIdeInstancableItem) : Element
	{
		if (!Std.isOfType(item, MovieClipItem)) return null;
		
        final item = (cast item : MovieClipItem);
        if (item.layers.length == 1 && item.layers[0].keyFrames.length == 1 && item.layers[0].type == LayerType.normal)
        {
            final elements = item.layers[0].keyFrames[0].elements;
            final shape = item.layers[0].keyFrames[0].getShape(false);
            if (shape == null)
            {
                if (elements.length == 1) return elements[0];
            }
            else
            {
                stdlib.Debug.assert(Std.isOfType(elements[0], ShapeElement));
                if (elements.length == 1) return shape;
                if (elements.length == 2 && shape.isEmpty()) return elements[1];
            }
        }
		
		return null;
	}
	
	static function appendMatrixToAllInstances(library:IdeLibrary, namePath:String, matrix:Matrix)
	{
		for (item in getMovieClipItems(library))
		{
            for (instance in MovieClipItemTools.getInstances(item).filter(x -> x.namePath == namePath))
			{
				instance.matrix.appendMatrix(matrix);
			}
		}
	}
}