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
AudioHelper.getFFmpegArgsForMixTracks = function(tracks,startInputIndex) {
	var args = [];
	if(tracks.length == 0) {
		return args;
	}
	var _g = 0;
	while(_g < tracks.length) {
		var tracks1 = tracks[_g];
		++_g;
		if(tracks1.durationMs != null) {
			if(tracks1.loop) {
				args.push("-stream_loop");
			}
			args.push("-1");
			if(tracks1.durationMs != null) {
				args.push("-t");
			}
			args.push(tracks1.durationMs + "ms");
		}
		args.push("-i");
		args.push(tracks1.filePath);
	}
	var filters = [];
	var _g = 0;
	var _g1 = tracks.length;
	while(_g < _g1) {
		var i = _g++;
		filters.push("[" + (i + startInputIndex) + ":a]adelay=" + tracks[i].delayBeforeStartMs + ":all=1[a" + i + "]");
	}
	var _g = [];
	var _g1 = 0;
	var _g2 = tracks.length;
	while(_g1 < _g2) {
		var i = _g1++;
		_g.push("[a" + i + "]");
	}
	filters.push(_g.join("") + "amix=inputs=" + tracks.length + "[a]");
	args.push("-filter_complex");
	args.push(filters.join(";"));
	args.push("-map");
	args.push("[a]");
	return args;
};
AudioHelper.getSceneTracks = function(framerate,library) {
	return AudioHelper.getMovieClipTracksInner(framerate,library.getSceneItem(),library,[],0,AudioHelper.MAX_DURATION);
};
AudioHelper.getMovieClipTracksInner = function(framerate,item,library,r,addDelayMs,mcLivingMs) {
	if(item.relatedSound != null && item.relatedSound != "") {
		var mcSound = library.getItem(item.relatedSound);
		r.push({ delayBeforeStartMs : addDelayMs, filePath : library.libraryDir + "/" + mcSound.namePath + "." + mcSound.ext, loop : mcSound.loop, durationMs : mcSound.loop ? Math.round(item.getTotalFrames() / framerate) : null});
	}
	nanofl.ide.MovieClipItemTools.iterateInstances(item,function(instance,data) {
		if(((instance.get_symbol()) instanceof nanofl.ide.libraryitems.MovieClipItem) || ((instance.get_symbol()) instanceof nanofl.ide.libraryitems.VideoItem)) {
			var layer = item.get_layers()[data.layerIndex];
			var delayMs = Math.round(AudioHelper.getFrameCoundBeforeKeyFrame(layer,data.keyFrameIndex) / framerate);
			var maxInnerLivingFrames = AudioHelper.getItemsMaxLivingFrames(item,layer,data.keyFrameIndex);
			var maxInnerLivingMs = maxInnerLivingFrames < AudioHelper.MAX_DURATION ? Math.round(Math.min(mcLivingMs - delayMs,maxInnerLivingFrames / framerate)) : AudioHelper.MAX_DURATION;
			if(((instance.get_symbol()) instanceof nanofl.ide.libraryitems.MovieClipItem)) {
				AudioHelper.getMovieClipTracksInner(framerate,instance.get_symbol(),library,r,addDelayMs + delayMs,maxInnerLivingMs);
			} else if(((instance.get_symbol()) instanceof nanofl.ide.libraryitems.VideoItem)) {
				var mcVideo = library.getItem(item.relatedSound);
				r.push({ delayBeforeStartMs : addDelayMs + delayMs, filePath : library.libraryDir + "/" + mcVideo.namePath + "." + mcVideo.ext, loop : mcVideo.loop, durationMs : maxInnerLivingMs});
			}
		}
	});
	return r;
};
AudioHelper.getFrameCoundBeforeKeyFrame = function(layer,keyFrameIndex) {
	var r = 0;
	var _g = 0;
	var _g1 = keyFrameIndex;
	while(_g < _g1) {
		var i = _g++;
		r += layer.get_keyFrames()[i].duration;
	}
	return r;
};
AudioHelper.getItemsMaxLivingFrames = function(item,layer,keyFrameIndex) {
	var keyFrame = layer.get_keyFrames()[keyFrameIndex];
	if(keyFrameIndex < layer.get_keyFrames().length - 1) {
		return keyFrame.duration;
	}
	if(AudioHelper.getFrameCoundBeforeKeyFrame(layer,keyFrameIndex) + keyFrame.duration < item.getTotalFrames()) {
		return keyFrame.duration;
	}
	return AudioHelper.MAX_DURATION;
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
		return VideoExporter.run(api.fileSystem,api.processManager,api.folders,args.destFilePath,args.documentProperties,args.library);
	}
};
var VideoExporter = function() { };
VideoExporter.__name__ = true;
VideoExporter.run = function(fileSystem,processManager,folders,destFilePath,documentProperties,library) {
	if(fileSystem.exists(destFilePath)) {
		fileSystem.deleteFile(destFilePath);
	}
	var videoArgs = ["-f","rawvideo","-pixel_format","rgb24","-video_size",documentProperties.width + "x" + documentProperties.height,"-framerate",documentProperties.framerate + "","-i","pipe:0"];
	var audioTracks = AudioHelper.getSceneTracks(documentProperties.framerate,library);
	var audioArgs = AudioHelper.getFFmpegArgsForMixTracks(audioTracks,1);
	var dataOut = new Uint8Array(documentProperties.width * documentProperties.height * 3);
	var sceneFramesIterator = library.getSceneFramesIterator(documentProperties,true);
	var args = videoArgs.concat(audioArgs).concat(["-map","0:v",destFilePath]);
	$global.console.log("FFmpeg: ",args);
	try {
		return processManager.runPipedStdIn(folders.get_tools() + "/ffmpeg.exe",args,null,null,function() {
			if(!sceneFramesIterator.hasNext()) {
				return Promise.resolve(null);
			}
			return sceneFramesIterator.next().then(function(ctx) {
				VideoExporter.imageDataToRgbArray(ctx.getImageData(0,0,documentProperties.width,documentProperties.height),dataOut);
				return dataOut.buffer;
			});
		}).then(function(r) {
			return r.code == 0;
		});
	} catch( _g ) {
		var e = haxe_Exception.caught(_g);
		$global.console.error(e);
		return Promise.resolve(false);
	}
};
VideoExporter.imageDataToRgbArray = function(imageData,outBuffer) {
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
		return VideoExporter.run(api.fileSystem,api.processManager,api.folders,args.destFilePath,args.documentProperties,args.library);
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
AudioHelper.MAX_DURATION = 2000000000;
Main.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
