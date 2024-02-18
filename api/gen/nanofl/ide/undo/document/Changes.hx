package nanofl.ide.undo.document;

typedef Changes = {
	@:optional
	var document : Bool;
	@:optional
	var element : nanofl.engine.elements.Element;
	@:optional
	var elements : Bool;
	@:optional
	var figure : Bool;
	@:optional
	var libraryAddItems : Bool;
	@:optional
	var libraryChangeItems : Array<String>;
	@:optional
	var libraryRemoveItems : Array<String>;
	@:optional
	var libraryRenameItems : Array<{ public var oldNamePath(default, default) : String; public var newNamePath(default, default) : String; }>;
	@:optional
	var timeline : Bool;
	@:optional
	var transformations : Bool;
};