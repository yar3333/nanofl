// Generated by Haxe 4.3.3
(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {};
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var AudioHelper = function() { };
AudioHelper.__name__ = true;
AudioHelper.generateTempSoundFile = function(fileSystem,processManager,folders,documentProperties,library) {
	var sounds = AudioHelper.getSounds(documentProperties.framerate,library.getSceneItem(),library);
	if(sounds.length == 0) {
		return null;
	}
	var destFilePath = fileSystem.getTempFilePath(".ogg");
	if(!AudioHelper.mixSounds(processManager,folders,sounds,destFilePath)) {
		return null;
	}
	return destFilePath;
};
AudioHelper.mixSounds = function(processManager,folders,sounds,destFilePath) {
	var args = [];
	var _g = 0;
	while(_g < sounds.length) {
		var sound = sounds[_g];
		++_g;
		args.push("-i");
		args.push(sound.filePath);
	}
	var filters = [];
	var _g = 0;
	var _g1 = sounds.length;
	while(_g < _g1) {
		var i = _g++;
		filters.push("[" + i + ":a]adelay=" + sounds[i].delayBeforeStartMs + ":all=1[a" + i + "]");
	}
	var _g = [];
	var _g1 = 0;
	var _g2 = sounds.length;
	while(_g1 < _g2) {
		var i = _g1++;
		_g.push("[a" + i + "]");
	}
	filters.push(_g.join("") + "amix=inputs=" + sounds.length + "[a]");
	args.push("-filter_complex");
	args.push(filters.join(";"));
	args.push("-map");
	args.push("[a]");
	args.push(destFilePath);
	var r = processManager.runCaptured(folders.get_tools() + "/ffmpeg.exe",args,null,null);
	return r.exitCode == 0;
};
AudioHelper.getSounds = function(framerate,item,library,r,addDelayMs) {
	if(addDelayMs == null) {
		addDelayMs = 0;
	}
	if(r == null) {
		r = [];
	}
	if(item.relatedSound != null && item.relatedSound != "") {
		r.push({ delayBeforeStartMs : addDelayMs, filePath : library.getItem(item.relatedSound).getUrl()});
	}
	nanofl.ide.MovieClipItemTools.iterateInstances(item,function(instance,data) {
		if(((instance.get_symbol()) instanceof nanofl.ide.libraryitems.MovieClipItem)) {
			var layer = item.get_layers()[data.layerIndex];
			var frameCount = 0;
			var _g = 0;
			var _g1 = data.keyFrameIndex;
			while(_g < _g1) {
				var i = _g++;
				frameCount += layer.get_keyFrames()[i].duration;
			}
			var delayMs = addDelayMs + Math.round(frameCount * (1.0 / framerate));
			AudioHelper.getSounds(framerate,instance.get_symbol(),library,r,delayMs);
		}
	});
	return r;
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	nanofl.ide.plugins.ExporterPlugins.register(new Mp4VideoExporterPlugin());
	nanofl.ide.plugins.ExporterPlugins.register(new WebmVideoExporterPlugin());
};
Math.__name__ = true;
var Mp4VideoExporterPlugin = function() {
	this.properties = null;
	this.fileDefaultExtension = "mp4";
	this.fileFilterExtensions = ["mp4"];
	this.fileFilterDescription = "MP4 Video (*.mp4)";
	this.menuItemIcon = "custom-icon-film";
	this.menuItemName = "MP4 Video (*.mp4)";
	this.name = "Mp4VideoExporter";
};
Mp4VideoExporterPlugin.__name__ = true;
Mp4VideoExporterPlugin.prototype = {
	exportDocument: function(api,args) {
		return VideoExporter.run(api.fileSystem,api.processManager,api.folders,args.destFilePath,args.documentProperties,args.library,"libx264");
	}
};
var VideoExporter = function() { };
VideoExporter.__name__ = true;
VideoExporter.run = function(fileSystem,processManager,folders,destFilePath,documentProperties,library,videoCodec) {
	if(fileSystem.exists(destFilePath)) {
		fileSystem.deleteFile(destFilePath);
	}
	var args = ["-f","rawvideo","-pixel_format","rgb24","-video_size",documentProperties.width + "x" + documentProperties.height,"-framerate",documentProperties.framerate + "","-i","pipe:0","-c:v",videoCodec,destFilePath];
	var dataOut = new Uint8Array(documentProperties.width * documentProperties.height * 3);
	var sceneFramesIterator = library.getSceneFramesIterator(documentProperties,true);
	try {
		return processManager.runPipedStdIn(folders.get_tools() + "/ffmpeg.exe",args,null,null,function() {
			if(!sceneFramesIterator.hasNext()) {
				return null;
			}
			var ctx = sceneFramesIterator.next();
			var dataIn = ctx.getImageData(0,0,documentProperties.width,documentProperties.height).data;
			var pIn = 0;
			var pOut = 0;
			var i = 0;
			while(i < documentProperties.height) {
				var j = 0;
				while(j < documentProperties.width) {
					var r = dataIn[pIn++];
					var g = dataIn[pIn++];
					var b = dataIn[pIn++];
					var a = dataIn[pIn++];
					dataOut[pOut++] = r;
					dataOut[pOut++] = g;
					dataOut[pOut++] = b;
					++j;
				}
				++i;
			}
			return dataOut.buffer;
		}).then(function(r) {
			return r.code == 0;
		});
	} catch( _g ) {
		var e = haxe_Exception.caught(_g);
		$global.console.error(e);
		return Promise.resolve(false);
	}
};
var WebmVideoExporterPlugin = function() {
	this.properties = null;
	this.fileDefaultExtension = "webm";
	this.fileFilterExtensions = ["webm"];
	this.fileFilterDescription = "WEBM Video (*.webm)";
	this.menuItemIcon = "custom-icon-film";
	this.menuItemName = "WEBM Video (*.webm)";
	this.name = "WebmVideoExporter";
};
WebmVideoExporterPlugin.__name__ = true;
WebmVideoExporterPlugin.prototype = {
	exportDocument: function(api,args) {
		return VideoExporter.run(api.fileSystem,api.processManager,api.folders,args.destFilePath,args.documentProperties,args.library,"libvpx");
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
haxe_Exception.__super__ = Error;
haxe_Exception.prototype = $extend(Error.prototype,{
});
var haxe_ValueException = function(value,previous,native) {
	haxe_Exception.call(this,String(value),previous,native);
	this.value = value;
};
haxe_ValueException.__name__ = true;
haxe_ValueException.__super__ = haxe_Exception;
haxe_ValueException.prototype = $extend(haxe_Exception.prototype,{
});
var haxe_io_Bytes = function() { };
haxe_io_Bytes.__name__ = true;
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
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
js_Boot.__toStr = ({ }).toString;
Main.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
