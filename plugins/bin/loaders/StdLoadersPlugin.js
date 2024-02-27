// Generated by Haxe 4.3.3
(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {};
var BitmapLoaderPlugin = function() {
	this.properties = null;
	this.menuItemIcon = "";
	this.menuItemName = "Bitmap";
	this.priority = 100;
	this.name = "BitmapLoader";
};
BitmapLoaderPlugin.__name__ = true;
BitmapLoaderPlugin.prototype = {
	load: function(api,params,baseDir,files) {
		var r = [];
		var h = files.h;
		var file_h = h;
		var file_keys = Object.keys(h);
		var file_length = file_keys.length;
		var file_current = 0;
		while(file_current < file_length) {
			var file = file_h[file_keys[file_current++]];
			if(file.excluded) {
				continue;
			}
			var ext = haxe_io_Path.extension(file.path);
			if(ext != null && BitmapLoaderPlugin.extensions.indexOf(ext.toLowerCase()) >= 0) {
				var namePath = [haxe_io_Path.withoutExtension(file.path)];
				if(!Lambda.exists(r,(function(namePath) {
					return function(item) {
						return item.namePath == namePath[0];
					};
				})(namePath))) {
					var tmp = files.h[namePath[0] + ".xml"];
					var xmlFile = tmp != null ? tmp : files.h[namePath[0] + ".bitmap"];
					var item = xmlFile != null && xmlFile.get_xml() != null && xmlFile.get_xml().name == "bitmap" ? nanofl.ide.libraryitems.BitmapItem.parse(namePath[0],xmlFile.get_xml()) : new nanofl.ide.libraryitems.BitmapItem(namePath[0],ext);
					if(xmlFile != null) {
						xmlFile.exclude();
					}
					r.push(item);
				}
				file.exclude();
			}
		}
		return Promise.resolve(r);
	}
};
var FontLoaderPlugin = function() {
	this.properties = null;
	this.menuItemIcon = "";
	this.menuItemName = "Font";
	this.priority = 400;
	this.name = "FontLoader";
};
FontLoaderPlugin.__name__ = true;
FontLoaderPlugin.prototype = {
	load: function(api,params,baseDir,files) {
		var r = [];
		var h = files.h;
		var file_h = h;
		var file_keys = Object.keys(h);
		var file_length = file_keys.length;
		var file_current = 0;
		while(file_current < file_length) {
			var file = file_h[file_keys[file_current++]];
			if(file.excluded) {
				continue;
			}
			if(["xml","font"].indexOf(haxe_io_Path.extension(file.path)) >= 0) {
				var namePath = [haxe_io_Path.withoutExtension(file.path)];
				if(!Lambda.exists(r,(function(namePath) {
					return function(item) {
						return item.namePath == namePath[0];
					};
				})(namePath))) {
					if(file.get_xml() != null) {
						var font = nanofl.ide.libraryitems.FontItem.parse(namePath[0],file.get_xml());
						if(font != null) {
							r.push(font);
							file.exclude();
						}
					}
				}
			}
		}
		return Promise.resolve(r);
	}
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.substr = function(s,pos,len) {
	if(len == null) {
		len = s.length;
	} else if(len < 0) {
		if(pos == 0) {
			len = s.length + len;
		} else {
			return "";
		}
	}
	return s.substr(pos,len);
};
HxOverrides.now = function() {
	return Date.now();
};
var Lambda = function() { };
Lambda.__name__ = true;
Lambda.exists = function(it,f) {
	var x = $getIterator(it);
	while(x.hasNext()) {
		var x1 = x.next();
		if(f(x1)) {
			return true;
		}
	}
	return false;
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	nanofl.ide.plugins.LoaderPlugins.register(new BitmapLoaderPlugin());
	nanofl.ide.plugins.LoaderPlugins.register(new FontLoaderPlugin());
	nanofl.ide.plugins.LoaderPlugins.register(new SoundLoaderPlugin());
	nanofl.ide.plugins.LoaderPlugins.register(new MovieClipLoaderPlugin());
	nanofl.ide.plugins.LoaderPlugins.register(new MeshLoaderPlugin());
};
Math.__name__ = true;
var MeshLoaderPlugin = function() {
	this.properties = null;
	this.menuItemIcon = "";
	this.menuItemName = "Mesh";
	this.priority = 600;
	this.name = "MeshLoader";
};
MeshLoaderPlugin.__name__ = true;
MeshLoaderPlugin.prototype = {
	load: function(api,params,baseDir,files) {
		var r = [];
		var extensions = ["xml","gltf"];
		var h = files.h;
		var file_h = h;
		var file_keys = Object.keys(h);
		var file_length = file_keys.length;
		var file_current = 0;
		while(file_current < file_length) {
			var file = file_h[file_keys[file_current++]];
			if(file.excluded) {
				continue;
			}
			var ext = haxe_io_Path.extension(file.path);
			if(extensions.indexOf(ext) != -1) {
				var item = nanofl.ide.libraryitems.MeshItem.load(haxe_io_Path.withoutExtension(file.path),ext,files);
				if(item != null) {
					r.push(item);
				}
			}
		}
		return Promise.resolve(r);
	}
};
var MovieClipLoaderPlugin = function() {
	this.properties = null;
	this.menuItemIcon = "";
	this.menuItemName = "MovieClip";
	this.priority = 200;
	this.name = "MovieClipLoader";
};
MovieClipLoaderPlugin.__name__ = true;
MovieClipLoaderPlugin.prototype = {
	load: function(api,params,baseDir,files) {
		var r = [];
		var h = files.h;
		var file_h = h;
		var file_keys = Object.keys(h);
		var file_length = file_keys.length;
		var file_current = 0;
		while(file_current < file_length) {
			var file = file_h[file_keys[file_current++]];
			if(file.excluded) {
				continue;
			}
			if(["json","xml","movieclip"].indexOf(haxe_io_Path.extension(file.path)) >= 0) {
				var namePath = [haxe_io_Path.withoutExtension(file.path)];
				if(!Lambda.exists(r,(function(namePath) {
					return function(item) {
						return item.namePath == namePath[0];
					};
				})(namePath))) {
					if(file.get_xml() != null) {
						var mc = nanofl.ide.libraryitems.MovieClipItem.parse(namePath[0],file.get_xml());
						if(mc != null) {
							r.push(mc);
							file.exclude();
						}
					} else if(file.get_json() != null) {
						var mc1 = nanofl.ide.libraryitems.MovieClipItem.parseJson(namePath[0],file.get_xml());
						if(mc1 != null) {
							r.push(mc1);
							file.exclude();
						}
					}
				}
			}
		}
		return Promise.resolve(r);
	}
};
var SoundLoaderPlugin = function() {
	this.properties = null;
	this.menuItemIcon = "";
	this.menuItemName = "Sound";
	this.priority = 300;
	this.name = "SoundLoader";
};
SoundLoaderPlugin.__name__ = true;
SoundLoaderPlugin.prototype = {
	load: function(api,params,baseDir,files) {
		var r = [];
		var h = files.h;
		var file_h = h;
		var file_keys = Object.keys(h);
		var file_length = file_keys.length;
		var file_current = 0;
		while(file_current < file_length) {
			var file = file_h[file_keys[file_current++]];
			if(file.excluded) {
				continue;
			}
			var ext = haxe_io_Path.extension(file.path);
			if(ext != null && SoundLoaderPlugin.extensions.indexOf(ext.toLowerCase()) >= 0) {
				var namePath = [haxe_io_Path.withoutExtension(file.path)];
				if(!Lambda.exists(r,(function(namePath) {
					return function(item) {
						return item.namePath == namePath[0];
					};
				})(namePath))) {
					var tmp = files.h[namePath[0] + ".xml"];
					var xmlFile = tmp != null ? tmp : files.h[namePath[0] + ".sound"];
					var item = xmlFile != null && xmlFile.get_xml() != null && xmlFile.get_xml().name == "sound" ? nanofl.ide.libraryitems.SoundItem.parse(namePath[0],xmlFile.get_xml()) : new nanofl.ide.libraryitems.SoundItem(namePath[0],ext);
					if(xmlFile != null) {
						xmlFile.exclude();
					}
					r.push(item);
				}
				file.exclude();
			}
		}
		return Promise.resolve(r);
	}
};
var haxe_ds_StringMap = function() {
	this.h = Object.create(null);
};
haxe_ds_StringMap.__name__ = true;
var haxe_io_Bytes = function() { };
haxe_io_Bytes.__name__ = true;
var haxe_io_Path = function(path) {
	switch(path) {
	case ".":case "..":
		this.dir = path;
		this.file = "";
		return;
	}
	var c1 = path.lastIndexOf("/");
	var c2 = path.lastIndexOf("\\");
	if(c1 < c2) {
		this.dir = HxOverrides.substr(path,0,c2);
		path = HxOverrides.substr(path,c2 + 1,null);
		this.backslash = true;
	} else if(c2 < c1) {
		this.dir = HxOverrides.substr(path,0,c1);
		path = HxOverrides.substr(path,c1 + 1,null);
	} else {
		this.dir = null;
	}
	var cp = path.lastIndexOf(".");
	if(cp != -1) {
		this.ext = HxOverrides.substr(path,cp + 1,null);
		this.file = HxOverrides.substr(path,0,cp);
	} else {
		this.ext = null;
		this.file = path;
	}
};
haxe_io_Path.__name__ = true;
haxe_io_Path.withoutExtension = function(path) {
	var s = new haxe_io_Path(path);
	s.ext = null;
	return s.toString();
};
haxe_io_Path.extension = function(path) {
	var s = new haxe_io_Path(path);
	if(s.ext == null) {
		return "";
	}
	return s.ext;
};
haxe_io_Path.prototype = {
	toString: function() {
		return (this.dir == null ? "" : this.dir + (this.backslash ? "\\" : "/")) + this.file + (this.ext == null ? "" : "." + this.ext);
	}
};
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o.__enum__) {
			var e = $hxEnums[o.__enum__];
			var con = e.__constructs__[o._hx_index];
			var n = con._hx_name;
			if(con.__params__) {
				s = s + "\t";
				return n + "(" + ((function($this) {
					var $r;
					var _g = [];
					{
						var _g1 = 0;
						var _g2 = con.__params__;
						while(true) {
							if(!(_g1 < _g2.length)) {
								break;
							}
							var p = _g2[_g1];
							_g1 = _g1 + 1;
							_g.push(js_Boot.__string_rec(o[p],s));
						}
					}
					$r = _g;
					return $r;
				}(this))).join(",") + ")";
			} else {
				return n;
			}
		}
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
function $getIterator(o) { if( o instanceof Array ) return new haxe_iterators_ArrayIterator(o); else return o.iterator(); }
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
js_Boot.__toStr = ({ }).toString;
BitmapLoaderPlugin.extensions = ["jpg","jpeg","png","gif","svg"];
SoundLoaderPlugin.extensions = ["ogg","mp3","wav"];
Main.main();
})({});
