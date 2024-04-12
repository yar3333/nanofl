import haxe.Json;
import utest.utils.Print;
import utest.Assert;
import nanofl.engine.geom.Matrix;

class BaseTest extends utest.Test
{
    public function testDecomposeA()
    {
        // flippedX, rotated, no skew
        final m = new Matrix
        (
            -0.9927903562267693,
            0.11986370836548031,
            0.11986370836548053,
            0.9927903562267691,
            640,
            0
        );
        final d = m.decompose();
        //Print.immediately(Json.stringify({ m:m, d:d }, "\t"));

        Assert.isTrue(d.scaleX < 0);
        Assert.isTrue(d.scaleY > 0);
        Assert.equals(0, d.skewX);
        Assert.equals(0, d.skewY);
        Assert.isTrue(d.rotation < 0);
        Assert.isTrue(d.x > 0);
        Assert.equals(0, d.y);
    }
}
