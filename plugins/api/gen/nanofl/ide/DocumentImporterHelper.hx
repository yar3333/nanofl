package nanofl.ide;

extern class DocumentImporterHelper {
	static function run(path:String, document:nanofl.ide.Document, importer:nanofl.ide.plugins.Importer):js.lib.Promise<nanofl.ide.Document>;
}