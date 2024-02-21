package nanofl.ide;

import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Polygon;
import nanofl.ide.Document;
import nanofl.ide.SafeCode;
import nanofl.ide.plugins.Exporter;
import stdlib.Std;
using stdlib.Lambda;

class DocumentExporterHelper
{
	public static function run(document:Document, path:String, exporter:Exporter) : Bool
	{
		Edges.showSelection = false;
		Polygon.showSelection = false;
		
		var r = false;
		
		var success = SafeCode.run("Error during exporting", () ->
		{
			r = exporter.run
			(
				document.path,
				path,
				document.properties,
				document.library.getRawLibrary()
			);
		});
		
        Edges.showSelection = true;
		Polygon.showSelection = true;
		
		return success && r;
	}
}