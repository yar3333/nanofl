package nanofl.ide.draganddrop;

typedef DragInfo = {
	/**
		
		        Dragged data. Accessible only on `drop`.
		    
	**/
	var data(default, never) : String;
	var effect(default, never) : nanofl.ide.draganddrop.AllowedDropEffect;
	/**
		
		        Object with any parameters. Must be safe for JSON serialization/deserialization.
		        You can access these parameters on `dragenter`/`dragover`.
		    
	**/
	var params(default, never) : nanofl.ide.draganddrop.DragInfoParams;
	var type(default, never) : nanofl.ide.draganddrop.DragDataType;
};