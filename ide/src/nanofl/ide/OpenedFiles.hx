package nanofl.ide;

import js.lib.Promise;
import nanofl.ide.ui.View;

class OpenedFiles extends InjectContainer
{
    @inject var view : View;

    public var active(get, never) : Document;
    function get_active() return view.openedFiles.active;
    
    public var length(get, never) : Int;
    function get_length() : Int return view.openedFiles.length;    

    public function iterator() : Iterator<Document> return view.openedFiles.iterator();
    
    public function closeAll(?force:Bool) : Promise<{}> return view.openedFiles.closeAll(force);
	
    public function add(doc:Document) : Void view.openedFiles.add(doc);
	
    public function close(doc:Document) : Void view.openedFiles.close(doc);
	
    public function activate(id:String) : Void view.openedFiles.activate(id);
	
    public function titleChanged(doc:Document) : Void view.openedFiles.titleChanged(doc);
}