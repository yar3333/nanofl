// Generated by Haxe 4.3.3
(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {},$_;
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var GifImporterPlugin = function() {
	this.properties = [];
	this.fileFilterExtensions = ["gif"];
	this.fileFilterDescription = "GIF image files (*.svg)";
	this.menuItemIcon = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAC5ElEQVQozz2LbUxbZQBGn7ctLVDpZQKi4KJjAYTGLBIEYU2gxTlKhAhZ0MQxZupMNoPBBbP5gX/QaKIGTDSaiM5snciHwB0lHTKENWxZMAxi1LBunSKDNh2jwAps7e199kPnv5Occ0ASqqoKkiIWi2lIoqev356akhJ4cFty8JSz6wWSuO/+a/E/THgmnz7cfLx1QB62PZmf+/tIaxbPt2XTnLvD2z/oqjjy5tvvjY5NlNyfQRKeyYuFaQ8I5WhlAh/dplVMRr0S6itVNwd3q6lSvJJu0igt9kSmGcGfz43vJgkNAJwZGrXWW5O0n31ftfXlG3lifSOi9c1viL9ubInltTvaz1/PFZ+csG81ViVDPjNSAeDfsbj4qdne8XW4v5qLr9mbLj4++DiUGBGJqmjb/xherH5EnPvGa3CeXcUzxQUzAIDu3p+qzE/s9D6UbFABsOPQTvK8jVHZwqhsIT02fn0kmwCYJhnU/JwdvpOnfqgVGRmZvvaXdFkFWYkcuxwQkiTBkmeEMcEAIQQ2Nu/g4pVN3AqFUL4rnVeWIuK1724vaQXUD2eurug12ytF7aEP8OPZWQSTrHBOLGPwchSRjGpc+OMmDhz9AkPTW6Ld6WFg5W68ABC2WCzGru5eDMgu7LFasBlew6h7COHwbdTVvwytzoBL07/heftzeNXxCtxut6IF8K61vDyupKQYDfvsmByToY1LQEFhISSThLsRBaYkI/bvq8HUr1NY8gcQDAYJvT4uLIRgT3cXSbLj049oNpu5eOMfeuf+ZMtbx3jpgofvNDtIkgcaGwkgCiFEODMzkznZ2Xw41US/389nK2y8dtVLv3+J9sq9vO7zEQBH3MNsbX2fACIA4CstLWUoFFI7O7/lwsICkyWJ47+McXZmhvEGPf+en6fz9Gn6/QHVZrMRwCI0Gs1BAKt1dXUxl8sVLSsrUwAoDodDaWpqUgAoRUVFiizL0YaGhhiAdZ1O57gHue+ALxPHGYEAAAAASUVORK5CYII=)";
	this.menuItemName = "GIF (*.gif)";
	this.name = "GifImporter";
};
GifImporterPlugin.__name__ = true;
GifImporterPlugin.main = function() {
	nanofl.ide.plugins.ImporterPlugins.register(new GifImporterPlugin());
};
GifImporterPlugin.prototype = {
	importDocument: function(api,args) {
		var scene = args.library.addSceneWithFrame();
		var layer = scene.get_layers()[0];
		layer.get_keyFrames().splice(0,layer.get_keyFrames().length);
		var n = 0;
		return VideoImporter.run(api.videoUtils,api.processManager,api.folders,args.srcFilePath,function(canvas) {
			if(n == 0) {
				args.documentProperties.width = canvas.width;
				args.documentProperties.height = canvas.height;
			}
			api.fileSystem.saveBinary(args.library.libraryDir + "/Frame " + n + ".png",haxe_crypto_Base64.decode(canvas.toDataURL("image/png").split(",")[1]));
			layer.addKeyFrame(new nanofl.engine.movieclip.KeyFrame(null,1,null,[new nanofl.engine.elements.Instance("Frame " + n)]));
			n += 1;
		}).then(function(success) {
			if(success) {
				return args.library.loadItems().then(function(_) {
					return true;
				});
			} else {
				return Promise.resolve(false);
			}
		});
	}
	,getPublishDirectoryBasePath: function(originalPath) {
		return haxe_io_Path.withoutExtension(originalPath);
	}
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
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
Lambda.find = function(it,f) {
	var v = $getIterator(it);
	while(v.hasNext()) {
		var v1 = v.next();
		if(f(v1)) {
			return v1;
		}
	}
	return null;
};
Math.__name__ = true;
var VideoImporter = function() { };
VideoImporter.__name__ = true;
VideoImporter.run = function(videoUtils,processManager,folders,srcFilePath,processFrame) {
	var fileInfo = videoUtils.getFileInfo(srcFilePath);
	var tmp = fileInfo != null ? fileInfo.streams : null;
	var videoInfo = tmp != null ? Lambda.find(tmp,function(x) {
		return x.type == "video";
	}) : null;
	if(videoInfo == null) {
		$global.console.warn("VideoImporter.run: video stream not found.");
		return Promise.resolve(false);
	}
	var args = ["-i",srcFilePath,"-f","rawvideo","-pix_fmt","rgb24","pipe:1"];
	$global.console.log("FFmpeg: ",args);
	var width = videoInfo.videoWidth;
	var height = videoInfo.videoHeight;
	var chunkSize = width * height * 3;
	var canvas = window.document.createElement("canvas");
	canvas.width = width;
	canvas.height = height;
	var imageData = canvas.getContext("2d",null).getImageData(0,0,width,height);
	var data = imageData.data;
	var ctx = canvas.getContext("2d",null);
	try {
		return processManager.runPipedStdOut(folders.get_tools() + "/ffmpeg.exe",args,null,null,null,chunkSize,function(buffer) {
			var view = new Uint8Array(buffer);
			var pView = 0;
			var pImg = 0;
			var _g = 0;
			var _g1 = width * height;
			while(_g < _g1) {
				var i = _g++;
				data[pImg++] = view[pView++];
				data[pImg++] = view[pView++];
				data[pImg++] = view[pView++];
				data[pImg++] = 255;
			}
			ctx.putImageData(imageData,0,0);
			processFrame(canvas);
		}).then(function(r) {
			return r.code == 0;
		});
	} catch( _g ) {
		var e = haxe_Exception.caught(_g);
		$global.console.error(e);
		return Promise.resolve(false);
	}
};
VideoImporter.imageDataToRgbArray = function(imageData,outBuffer) {
	var pixIn = imageData.data;
	var pIn = 0;
	var pOut = 0;
	var _g = 0;
	var _g1 = imageData.width * imageData.height;
	while(_g < _g1) {
		var _ = _g++;
		outBuffer[pOut++] = pixIn[pIn++];
		outBuffer[pOut++] = pixIn[pIn++];
		outBuffer[pOut++] = pixIn[pIn++];
		++pIn;
	}
};
var haxe_Exception = function(message,previous,native) {
	Error.call(this,message);
	this.message = message;
	this.__previousException = previous;
	this.__nativeException = native != null ? native : this;
};
haxe_Exception.__name__ = true;
haxe_Exception.caught = function(value) {
	if(((value) instanceof haxe_Exception)) {
		return value;
	} else if(((value) instanceof Error)) {
		return new haxe_Exception(value.message,null,value);
	} else {
		return new haxe_ValueException(value,null,value);
	}
};
haxe_Exception.thrown = function(value) {
	if(((value) instanceof haxe_Exception)) {
		return value.get_native();
	} else if(((value) instanceof Error)) {
		return value;
	} else {
		var e = new haxe_ValueException(value);
		return e;
	}
};
haxe_Exception.__super__ = Error;
haxe_Exception.prototype = $extend(Error.prototype,{
	get_native: function() {
		return this.__nativeException;
	}
});
var haxe_ValueException = function(value,previous,native) {
	haxe_Exception.call(this,String(value),previous,native);
	this.value = value;
};
haxe_ValueException.__name__ = true;
haxe_ValueException.__super__ = haxe_Exception;
haxe_ValueException.prototype = $extend(haxe_Exception.prototype,{
});
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
haxe_io_Bytes.__name__ = true;
haxe_io_Bytes.ofString = function(s,encoding) {
	if(encoding == haxe_io_Encoding.RawNative) {
		var buf = new Uint8Array(s.length << 1);
		var _g = 0;
		var _g1 = s.length;
		while(_g < _g1) {
			var i = _g++;
			var c = s.charCodeAt(i);
			buf[i << 1] = c & 255;
			buf[i << 1 | 1] = c >> 8;
		}
		return new haxe_io_Bytes(buf.buffer);
	}
	var a = [];
	var i = 0;
	while(i < s.length) {
		var c = s.charCodeAt(i++);
		if(55296 <= c && c <= 56319) {
			c = c - 55232 << 10 | s.charCodeAt(i++) & 1023;
		}
		if(c <= 127) {
			a.push(c);
		} else if(c <= 2047) {
			a.push(192 | c >> 6);
			a.push(128 | c & 63);
		} else if(c <= 65535) {
			a.push(224 | c >> 12);
			a.push(128 | c >> 6 & 63);
			a.push(128 | c & 63);
		} else {
			a.push(240 | c >> 18);
			a.push(128 | c >> 12 & 63);
			a.push(128 | c >> 6 & 63);
			a.push(128 | c & 63);
		}
	}
	return new haxe_io_Bytes(new Uint8Array(a).buffer);
};
var haxe_io_Encoding = $hxEnums["haxe.io.Encoding"] = { __ename__:true,__constructs__:null
	,UTF8: {_hx_name:"UTF8",_hx_index:0,__enum__:"haxe.io.Encoding",toString:$estr}
	,RawNative: {_hx_name:"RawNative",_hx_index:1,__enum__:"haxe.io.Encoding",toString:$estr}
};
haxe_io_Encoding.__constructs__ = [haxe_io_Encoding.UTF8,haxe_io_Encoding.RawNative];
var haxe_crypto_Base64 = function() { };
haxe_crypto_Base64.__name__ = true;
haxe_crypto_Base64.decode = function(str,complement) {
	if(complement == null) {
		complement = true;
	}
	if(complement) {
		while(HxOverrides.cca(str,str.length - 1) == 61) str = HxOverrides.substr(str,0,-1);
	}
	return new haxe_crypto_BaseCode(haxe_crypto_Base64.BYTES).decodeBytes(haxe_io_Bytes.ofString(str));
};
var haxe_crypto_BaseCode = function(base) {
	var len = base.length;
	var nbits = 1;
	while(len > 1 << nbits) ++nbits;
	if(nbits > 8 || len != 1 << nbits) {
		throw haxe_Exception.thrown("BaseCode : base length must be a power of two.");
	}
	this.base = base;
	this.nbits = nbits;
};
haxe_crypto_BaseCode.__name__ = true;
haxe_crypto_BaseCode.prototype = {
	initTable: function() {
		var tbl = [];
		var _g = 0;
		while(_g < 256) {
			var i = _g++;
			tbl[i] = -1;
		}
		var _g = 0;
		var _g1 = this.base.length;
		while(_g < _g1) {
			var i = _g++;
			tbl[this.base.b[i]] = i;
		}
		this.tbl = tbl;
	}
	,decodeBytes: function(b) {
		var nbits = this.nbits;
		var base = this.base;
		if(this.tbl == null) {
			this.initTable();
		}
		var tbl = this.tbl;
		var size = b.length * nbits >> 3;
		var out = new haxe_io_Bytes(new ArrayBuffer(size));
		var buf = 0;
		var curbits = 0;
		var pin = 0;
		var pout = 0;
		while(pout < size) {
			while(curbits < 8) {
				curbits += nbits;
				buf <<= nbits;
				var i = tbl[b.b[pin++]];
				if(i == -1) {
					throw haxe_Exception.thrown("BaseCode : invalid encoded char");
				}
				buf |= i;
			}
			curbits -= 8;
			out.b[pout++] = buf >> curbits & 255;
		}
		return out;
	}
};
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
haxe_crypto_Base64.CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
haxe_crypto_Base64.BYTES = haxe_io_Bytes.ofString(haxe_crypto_Base64.CHARS);
GifImporterPlugin.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
