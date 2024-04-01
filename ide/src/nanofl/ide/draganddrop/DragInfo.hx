package nanofl.ide.draganddrop;

typedef DragInfo =
{
    final effect : AllowedDropEffect;

    final type : DragDataType;
    
    /**
        Object with any parameters. Must be safe for JSON serialization/deserialization.
        You can access these parameters on `dragenter`/`dragover`.
    **/
    final params : DragInfoParams;
    
    /**
        Dragged data. Accessible only on `drop`.
    **/
    final data : String;
}