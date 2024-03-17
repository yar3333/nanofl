package nanofl.ide;

import js.lib.Promise;
import nanofl.ide.Document;
import nanofl.ide.plugins.Importer;

class DocumentImporterHelper
{
	public static function run(path:String, document:Document, importer:Importer) : Promise<Bool>
	{
        trace("Import document " + path + " => " + document.path);
        return importer.run(path, document.path, document.properties, document.library.getRawLibrary());
	}
}