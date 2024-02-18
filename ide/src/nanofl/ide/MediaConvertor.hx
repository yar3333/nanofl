package nanofl.ide;

import haxe.io.Path;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.ProcessManager;
import nanofl.ide.sys.Folders;
using stdlib.Lambda;

@:rtti
class MediaConvertor extends InjectContainer
{
	@inject var fileSystem : FileSystem;
	@inject var processManager : ProcessManager;
	@inject var folders : Folders;
	
	public function convertImage(srcFile:String, destFile:String, quality:Int) : Bool
	{
		var convertToolPath = folders.tools + "/image_converter/convert.exe";
		
		var destDir = Path.directory(destFile);
		if (destDir != null && destDir != "") fileSystem.createDirectory(destDir);
		var args = [ srcFile, "-quality", Std.string(quality), destFile ];
		
		var result = processManager.runCaptured(convertToolPath, args);
		
		if (result.exitCode != 0)
		{
			trace("ERROR: convert " + args.join(" ") + ": " + result.exitCode + "\n" + result.output + "\n" + result.error);
			return false;
		}
		
		return true;
	}
	
	public function convertAudio(srcFile:String, destFile:String, quality:Int) : Bool
	{
		var ffmpegToolPath = folders.tools + "/audio_converter/ffmpeg.exe";
		
		var destDir = Path.directory(destFile);
		if (destDir != null && destDir != "") fileSystem.createDirectory(destDir);
		
		if (fileSystem.exists(destFile)) fileSystem.deleteFile(destFile);
		
		var args : Array<String> = null;
		
		switch (Path.extension(destFile).toLowerCase())
		{
			case "mp3":
				var codes =
				[
					{ q:9, kbps: 65 },
					{ q:8, kbps: 85 },
					{ q:7, kbps:100 },
					{ q:6, kbps:115 },
					{ q:5, kbps:130 },
					{ q:4, kbps:165 },
					{ q:3, kbps:175 },
					{ q:2, kbps:190 },
					{ q:1, kbps:225 },
					{ q:0, kbps:245 }
				];
				var n = codes.findIndex(x -> x.kbps >= quality);
				if (n < 0) n = codes.length - 1;
				args = [ "-i", srcFile, "-codec:a", "libmp3lame", "-qscale:a", Std.string(codes[n].q),  destFile ];
				
			case "ogg":
				var codes =
				[
					{ q:-2, kbps: 32 },
					{ q:-1, kbps: 48 },
					{ q: 0, kbps: 64 },
					{ q: 1, kbps: 80 },
					{ q: 2, kbps: 96 },
					{ q: 3, kbps:112 },
					{ q: 4, kbps:128 },
					{ q: 5, kbps:160 },
					{ q: 6, kbps:192 },
					{ q: 7, kbps:224 },
					{ q: 8, kbps:256 },
					{ q: 9, kbps:320 },
					{ q:10, kbps:500 }
				];
				var n = codes.findIndex(x -> x.kbps >= quality);
				if (n < 0) n = codes.length - 1;
				args = [ "-i", srcFile, "-codec:a", "libvorbis", "-qscale:a", Std.string(codes[n].q),  destFile ];
				
			case "wav":
				/*
					Freq.   bits	kbit/s
					11,025	16		176.4
					8,000	16		128
					11,025	8		88.2
					8,000	8		64
					11,025	4		44.1
					8,000	4		32
					
					-codec:a pcm_***:
						alaw            PCM A-law
						f32be           PCM 32-bit floating-point big-endian
						f32le           PCM 32-bit floating-point little-endian
						f64be           PCM 64-bit floating-point big-endian
						f64le           PCM 64-bit floating-point little-endian
						mulaw           PCM mu-law
						s16be           PCM signed 16-bit big-endian
						s16le           PCM signed 16-bit little-endian
						s24be           PCM signed 24-bit big-endian
						s24le           PCM signed 24-bit little-endian
						s32be           PCM signed 32-bit big-endian
						s32le           PCM signed 32-bit little-endian
						s8              PCM signed 8-bit
						u16be           PCM unsigned 16-bit big-endian
						u16le           PCM unsigned 16-bit little-endian
						u24be           PCM unsigned 24-bit big-endian
						u24le           PCM unsigned 24-bit little-endian
						u32be           PCM unsigned 32-bit big-endian
						u32le           PCM unsigned 32-bit little-endian
						u8              PCM unsigned 8-bit
					
					-ac <number of channels>
					
					-ar <freq>
						8000
						11025
						22050
						44100
				*/
				
				args = [ "-i", srcFile, "-codec:a", "pcm_s16le", destFile ];
				
			case _:
				trace("Unsupported output file format '" + destFile + "'.");
				return false;
		}
		
		var result = processManager.runCaptured(ffmpegToolPath, args);
		if (result.exitCode != 0)
		{
			trace("ERROR: ffmpeg " + args.join(" ") + ": " + result.exitCode + "\n" + result.output + "\n" + result.error);
			return false;
		}
		
		return true;
	}
}