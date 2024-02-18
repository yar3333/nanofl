class Main extends haxe.unit.TestCase
{
    static function main()
	{
		var r = new haxe.unit.TestRunner();
		r.add(new GeomCommonTest());
		r.add(new GeomBezierCurveTest());
		r.add(new GeomCombineTest());
		r.add(new GeomPolygonsTest());
		r.add(new GeomContoursTest());
		r.run();
	}
}