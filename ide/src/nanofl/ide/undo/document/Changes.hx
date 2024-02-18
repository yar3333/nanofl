package nanofl.ide.undo.document;

import nanofl.engine.elements.Element;

typedef Changes =
{
	?document: Bool,
	?figure: Bool,
	?transformations: Bool,
	?elements: Bool,
	?timeline: Bool,
	?element: Element,
	?libraryChangeItems: Array<String>,
	?libraryAddItems: Bool,
	?libraryRemoveItems: Array<String>,
	?libraryRenameItems: Array<{ oldNamePath:String, newNamePath:String }>
}