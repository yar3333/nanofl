package nanofl.engine;

import stdlib.Std;

class CustomPropertiesTools
{
	public static function equ(params1:Dynamic, params2:Dynamic) : Bool
	{
		var fields1 = Reflect.fields(params1);
		var fields2 = Reflect.fields(params2);
		
		if (fields1.length != fields2.length) return false;
		
		fields1.sort(Reflect.compare);
		fields2.sort(Reflect.compare);
		
		for (i in 0...fields1.length)
		{
			if (fields1[i] != fields2[i]) return false;
			if (Reflect.field(params1, fields1[i]) != Reflect.field(params2, fields1[i])) return false;
		}
		
		return true;
	}
	
	public static function tween(start:Dynamic, t:Float, finish:Dynamic, properties:Array<CustomProperty>)
	{
		if (t == 0.0 || properties == null) return;
		
		for (p in properties)
		{
			if (p.type == "delimiter" || p.type == "info") continue;
			
			var startV : Dynamic = Reflect.field(start, p.name);
			var finishV : Dynamic = finish != null
				? Reflect.field(finish, p.name)
				: (p.neutralValue != null ? p.neutralValue : startV);
			switch (p.type.toLowerCase())
			{
				case "int", "float":
					Reflect.setField(start, p.name, startV + (finishV - startV) * t);
					
				case "color":
					Reflect.setField(start, p.name, ColorTools.rgbaToString(ColorTools.tweenRgba(ColorTools.parse(startV), ColorTools.parse(finishV), t)));
					
				case _:
					Reflect.setField(start, p.name, startV);
			}
		}
	}
	
	public static function fix(params:Dynamic, properties:Array<CustomProperty>) : Dynamic
	{
		if (properties == null) return params;
		
		for (p in properties)
		{
			if (p.type == "delimiter" || p.type == "info") continue;
			
			var v = Reflect.field(params, p.name);
			if (v == null)
			{
				Reflect.setField(params, p.name, p.defaultValue);
			}
			else
			{
				switch (p.type)
				{
					case "int":		Reflect.setField(params, p.name, Std.isOfType(v, String) ? Std.parseInt(v) : v);
					case "float":	Reflect.setField(params, p.name, Std.isOfType(v, String) ? Std.parseFloat(v) : v);
					case "bool":	Reflect.setField(params, p.name, Std.isOfType(v, String) ? Std.bool(v) : v);
					case _:			Reflect.setField(params, p.name, v);
				}
			}
		}
		
		return params;
	}
	
	public static function resetToNeutral(params:Dynamic, properties:Array<CustomProperty>) : Void
	{
		for (p in properties)
		{
			if (p.type == "delimiter" || p.type == "info") continue;
			
			if (p.neutralValue != null)
			{
				Reflect.setField(params, p.name, p.neutralValue);
			}
		}
	}
}