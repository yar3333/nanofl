package nanofl.ide;

import js.lib.Promise;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Polygon;
import nanofl.ide.Document;
import nanofl.ide.plugins.Exporter;
using stdlib.Lambda;

class DocumentExporterHelper
{
	public static function run(document:Document, path:String, exporter:Exporter) : Promise<Bool>
	{
		Edges.showSelection = false;
		Polygon.showSelection = false;
		
        var r = exporter.run
        (
            document.path,
            path,
            document.properties,
            document.library.getRawLibrary(),
            document.originalPath,
        );
		
        Edges.showSelection = true;
		Polygon.showSelection = true;
		
		return r;
	}
}