import js.Browser.document;
import js.Browser.window;

class Main
{
	static function main() 
	{
		document.addEventListener("DOMContentLoaded", () -> runApp());
	}

    static function runApp(): Void
    {
		var injector = new js.injecting.Injector();
        nanofl.ide.sys.SysStuff.registerInInjector(injector);
        nanofl.ide.Globals.setInjector(injector);
        (cast window).app = new nanofl.ide.Application(injector);
    }
}