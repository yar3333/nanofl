package flashimport;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.ExprTools;

class Macro
{
	public static macro function embedFile(filePath:Expr)
	{
		var path = haxe.io.Path.directory(Context.getPosInfos(Context.currentPos()).file) + "/" + ExprTools.getValue(filePath);
		Context.registerModuleDependency(Context.getLocalModule(), path);
		return macro $v{sys.io.File.getContent(path)};
	}
}