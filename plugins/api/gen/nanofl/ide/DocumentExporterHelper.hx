package nanofl.ide;

extern class DocumentExporterHelper {
	static function run(document:nanofl.ide.Document, path:String, exporter:nanofl.ide.plugins.Exporter):js.lib.Promise<Bool>;
}