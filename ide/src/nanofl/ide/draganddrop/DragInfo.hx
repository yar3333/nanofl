package nanofl.ide.draganddrop;

typedef DragInfo =
{
    final effect : AllowedDropEffect;

    /**
        Any string. Used in `drops` as key.
    **/
    final type : String;
    
    /**
        Object with any parameters. Must be safe for JSON serialization/deserialization.
        You can access these parameters on `dragenter`/`dragover`.
    **/
    final params : Dynamic;
    
    
    /**
        Dragged data. Accessible only on `drop`.
    **/
    final data : String;
}