package nanofl.ide.sys.node.core;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.fs.FSWatcher;
import js.node.fs.ReadStream;
import js.node.fs.Stats;
import js.node.fs.WriteStream;
import js.lib.Error;
import js.node.Fs;

extern class NodeFs
{
	/**
		An object containing commonly used constants for file system operations.
	**/
	var constants(default, null):FsConstants;

	/**
		Asynchronous rename(2).
	**/
	function rename(oldPath:FsPath, newPath:FsPath, callback:Error->Void):Void;

	/**
		Synchronous rename(2).
	**/
	function renameSync(oldPath:FsPath, newPath:FsPath):Void;

	/**
		Asynchronous ftruncate(2).
	**/
	function ftruncate(fd:Int, len:Int, callback:Error->Void):Void;

	/**
		Synchronous ftruncate(2).
	**/
	function ftruncateSync(fd:Int, len:Int):Void;

	/**
		Asynchronous truncate(2).
	**/
	function truncate(path:FsPath, len:Int, callback:Error->Void):Void;

	/**
		Synchronous truncate(2).
	**/
	function truncateSync(path:FsPath, len:Int):Void;

	/**
		Asynchronous chown(2).
	**/
	function chown(path:FsPath, uid:Int, gid:Int, callback:Error->Void):Void;

	/**
		Synchronous chown(2).
	**/
	function chownSync(path:FsPath, uid:Int, gid:Int):Void;

	/**
		Asynchronous fchown(2).
	**/
	function fchown(fd:Int, uid:Int, gid:Int, callback:Error->Void):Void;

	/**
		Synchronous fchown(2).
	**/
	function fchownSync(fd:Int, uid:Int, gid:Int):Void;

	/**
		Asynchronous lchown(2).
	**/
	function lchown(path:FsPath, uid:Int, gid:Int, callback:Error->Void):Void;

	/**
		Synchronous lchown(2).
	**/
	function lchownSync(path:FsPath, uid:Int, gid:Int):Void;

	/**
		Asynchronous chmod(2).
	**/
	function chmod(path:FsPath, mode:FsMode, callback:Error->Void):Void;

	/**
		Synchronous chmod(2).
	**/
	function chmodSync(path:FsPath, mode:FsMode):Void;

	/**
		Asynchronous fchmod(2).
	**/
	function fchmod(fd:Int, mode:FsMode, callback:Error->Void):Void;

	/**
		Synchronous fchmod(2).
	**/
	function fchmodSync(fd:Int, mode:FsMode):Void;

	/**
		Asynchronous lchmod(2).
		Only available on Mac OS X.
	**/
	function lchmod(path:FsPath, mode:FsMode, callback:Error->Void):Void;

	/**
		Synchronous lchmod(2).
	**/
	function lchmodSync(path:FsPath, mode:FsMode):Void;

	/**
		Asynchronous stat(2).
	**/
	function stat(path:FsPath, callback:Error->Stats->Void):Void;

	/**
		Asynchronous lstat(2).

		lstat() is identical to stat(), except that if path is a symbolic link,
		then the link itself is stat-ed, not the file that it refers to.
	**/
	function lstat(path:FsPath, callback:Error->Stats->Void):Void;

	/**
		Asynchronous fstat(2).

		fstat() is identical to stat(), except that the file to be stat-ed
		is specified by the file descriptor fd.
	**/
	function fstat(fd:Int, callback:Error->Stats->Void):Void;

	/**
		Synchronous stat(2).
	**/
	function statSync(path:FsPath):Stats;

	/**
		Synchronous lstat(2).
	**/
	function lstatSync(path:FsPath):Stats;

	/**
		Synchronous fstat(2).
	**/
	function fstatSync(fd:Int):Stats;

	/**
		Asynchronous link(2).
	**/
	function link(srcpath:FsPath, dstpath:FsPath, callback:Error->Void):Void;

	/**
		Synchronous link(2).
	**/
	function linkSync(srcpath:FsPath, dstpath:FsPath):Void;

	/**
		Asynchronous symlink(2).

		The `type` argument can be set to 'dir', 'file', or 'junction' (default is 'file')
		and is only available on Windows (ignored on other platforms). Note that Windows junction
		points require the destination path to be absolute. When using 'junction', the destination
		argument will automatically be normalized to absolute path.
	**/
	@:overload(function(srcpath:FsPath, dstpath:FsPath, callback:Error->Void):Void {})
	function symlink(srcpath:FsPath, dstpath:FsPath, type:SymlinkType, callback:Error->Void):Void;

	/**
		Synchronous symlink(2).
	**/
	@:overload(function(srcpath:FsPath, dstpath:FsPath):Void {})
	function symlinkSync(srcpath:FsPath, dstpath:FsPath, type:SymlinkType):Void;

	/**
		Asynchronous readlink(2).
	**/
	function readlink(path:FsPath, callback:Error->String->Void):Void;

	/**
		Synchronous readlink(2).
		Returns the symbolic link's string value.
	**/
	function readlinkSync(path:FsPath):String;

	/**
		Asynchronous realpath(2).

		The callback gets two arguments (err, resolvedPath).

		May use process.cwd to resolve relative paths.

		`cache` is an object literal of mapped paths that can be used to force a specific path resolution
		or avoid additional `stat` calls for known real paths.
	**/
	@:overload(function(path:FsPath, callback:Error->String->Void):Void {})
	function realpath(path:FsPath, cache:DynamicAccess<String>, callback:Error->String->Void):Void;

	/**
		Synchronous realpath(2).
		Returns the resolved path.
	**/
	@:overload(function(path:FsPath):String {})
	function realpathSync(path:FsPath, cache:DynamicAccess<String>):String;

	/**
		Asynchronous unlink(2).
	**/
	function unlink(path:FsPath, callback:Error->Void):Void;

	/**
		Synchronous unlink(2).
	**/
	function unlinkSync(path:FsPath):Void;

	/**
		Asynchronous rmdir(2).
	**/
	function rmdir(path:FsPath, callback:Error->Void):Void;

	/**
		Synchronous rmdir(2).
	**/
	function rmdirSync(path:FsPath):Void;

	/**
		Asynchronous mkdir(2).
		`mode` defaults to 0777.
	**/
	@:overload(function(path:FsPath, callback:Error->Void):Void {})
	function mkdir(path:FsPath, mode:FsMode, callback:Error->Void):Void;

	/**
		Synchronous mkdir(2).
	**/
	function mkdirSync(path:FsPath, ?mode:FsMode):Void;

	/**
		Creates a unique temporary directory.

		Generates six random characters to be appended behind a required `prefix` to create a unique temporary directory.

		The created folder path is passed as a string to the `callback`'s second parameter.
	**/
	function mkdtemp(prefix:String, callback:Error->String->Void):Void;

	/**
		The synchronous version of `mkdtemp`.

		Returns the created folder path.
	**/
	function mkdtempSync(template:String):String;

	/**
		Asynchronous readdir(3).
		Reads the contents of a directory.

		The callback gets two arguments (err, files) where files is an array of the
		names of the files in the directory excluding '.' and '..'.
	**/
	function readdir(path:FsPath, callback:Error->Array<String>->Void):Void;

	/**
		Synchronous readdir(3).
		Returns an array of filenames excluding '.' and '..'.
	**/
	function readdirSync(path:FsPath):Array<String>;

	/**
		Asynchronous close(2).
	**/
	function close(fd:Int, callback:Error->Void):Void;

	/**
		Synchronous close(2).
	**/
	function closeSync(fd:Int):Void;

	/**
		Asynchronous file open. See open(2).

		See `FsOpenFlag` for description of possible `flags`.

		`mode` sets the file mode (permission and sticky bits), but only if the file was created.
		It defaults to 0666, readable and writeable.

		The `callback` gets two arguments (err, fd).
	**/
	@:overload(function(path:FsPath, flags:FsOpenFlag, callback:Error->Int->Void):Void {})
	function open(path:FsPath, flags:FsOpenFlag, mode:FsMode, callback:Error->Int->Void):Void;

	/**
		Synchronous version of open().
	**/
	@:overload(function(path:FsPath, flags:FsOpenFlag):Int {})
	function openSync(path:FsPath, flags:FsOpenFlag, mode:FsMode):Int;

	/**
		Change file timestamps of the file referenced by the supplied path.
	**/
	function utimes(path:FsPath, atime:Date, mtime:Date, callback:Error->Void):Void;

	/**
		Change file timestamps of the file referenced by the supplied path.
	**/
	function utimesSync(path:FsPath, atime:Date, mtime:Date):Void;

	/**
		Change the file timestamps of a file referenced by the supplied file descriptor.
	**/
	function futimes(fd:Int, atime:Date, mtime:Date, callback:Error->Void):Void;

	/**
		Change the file timestamps of a file referenced by the supplied file descriptor.
	**/
	function futimesSync(fd:Int, atime:Date, mtime:Date):Void;

	/**
		Asynchronous fsync(2).
	**/
	function fsync(fd:Int, callback:Error->Void):Void;

	/**
		Synchronous fsync(2).
	**/
	function fsyncSync(fd:Int):Void;

	/**
		Documentation for the overloads with the `buffer` argument:

		Write `buffer` to the file specified by `fd`.

		`offset` and `length` determine the part of the `buffer` to be written.

		`position` refers to the offset from the beginning of the file where this data should be written.
		If position is null, the data will be written at the current position. See pwrite(2).

		The `callback` will be given three arguments (err, written, buffer)
		where `written` specifies how many bytes were written from `buffer`.

		---

		Documentation for the overloads with the `data` argument:

		Write `data` to the file specified by `fd`. If `data` is not a `Buffer` instance then
		the value will be coerced to a string.

		`position` refers to the offset from the beginning of the file where this data should be written.
		If omitted, the data will be written at the current position. See pwrite(2).

		`encoding` is the expected string encoding.

		The `callback` will receive the arguments (err, written, string) where written specifies how many bytes
		the passed string required to be written. Note that bytes written is not the same as string characters.
		See `Buffer.byteLength`.

		Unlike when writing `buffer`, the entire string must be written. No substring may be specified.
		This is because the byte offset of the resulting data may not be the same as the string offset.

		---

		Common notes:

		Note that it is unsafe to use `write` multiple times on the same file without waiting for the callback.
		For this scenario, `createWriteStream` is strongly recommended.

		On Linux, positional writes don't work when the file is opened in append mode. The kernel ignores the position
		argument and always appends the data to the end of the file.
	**/
	@:overload(function(fd:Int, data:Dynamic, position:Int, encoding:String, callback:Error->Int->String->Void):Void {})
	@:overload(function(fd:Int, data:Dynamic, position:Int, callback:Error->Int->String->Void):Void {})
	@:overload(function(fd:Int, data:Dynamic, callback:Error->Int->String->Void):Void {})
	@:overload(function(fd:Int, buffer:NodeBuffer, offset:Int, length:Int, callback:Error->Int->NodeBuffer->Void):Void {})
	function write(fd:Int, buffer:NodeBuffer, offset:Int, length:Int, position:Int, callback:Error->Int->NodeBuffer->Void):Void;

	/**
		Synchronous version of `write`. Returns the number of bytes written.
	**/
	@:overload(function(fd:Int, data:Dynamic, position:Int, encoding:String):Int {})
	@:overload(function(fd:Int, data:Dynamic, ?position:Int):Int {})
	function writeSync(fd:Int, buffer:NodeBuffer, offset:Int, length:Int, ?position:Int):Int;

	/**
		Read data from the file specified by `fd`.

		`buffer` is the buffer that the data will be written to.

		`offset` is the offset in the `buffer` to start writing at.

		`length` is an integer specifying the number of bytes to read.

		`position` is an integer specifying where to begin reading from in the file.
		If position is null, data will be read from the current file position.

		The `callback` is given the three arguments, (err, bytesRead, buffer).
	**/
	function read(fd:Int, buffer:NodeBuffer, offset:Int, length:Int, position:Null<Int>, callback:Error->Int->NodeBuffer->Void):Void;

	/**
		Synchronous version of `read`. Returns the number of bytes read.
	**/
	function readSync(fd:Int, buffer:NodeBuffer, offset:Int, length:Int, position:Null<Int>):Int;

	/**
		Asynchronously reads the entire contents of a file.

		The `callback` is passed two arguments (err, data), where data is the contents of the file.
		If no `encoding` is specified, then the raw buffer is returned.

		If `options` is a string, then it specifies the encoding.
	**/
	@:overload(function(filename:FsPath, callback:Error->NodeBuffer->Void):Void {})
	@:overload(function(filename:FsPath, options:{flag:FsOpenFlag}, callback:Error->NodeBuffer->Void):Void {})
	@:overload(function(filename:FsPath, options:String, callback:Error->String->Void):Void {})
	function readFile(filename:FsPath, options:{encoding:String, ?flag:FsOpenFlag}, callback:Error->String->Void):Void;

	/**
		Synchronous version of `readFile`. Returns the contents of the filename.
		If the `encoding` option is specified then this function returns a string. Otherwise it returns a buffer.
	**/
	@:overload(function(filename:FsPath):NodeBuffer {})
	@:overload(function(filename:FsPath, options:{flag:FsOpenFlag}):NodeBuffer {})
	@:overload(function(filename:FsPath, options:String):String {})
	function readFileSync(filename:FsPath, options:{encoding:String, ?flag:FsOpenFlag}):String;

	/**
		Asynchronously writes data to a file, replacing the file if it already exists.

		`data` can be a string or a buffer.

		The encoding option is ignored if data is a buffer. It defaults to 'utf8'.
	**/
	@:overload(function(filename:FsPath, data:NodeBuffer, callback:Error->Void):Void {})
	@:overload(function(filename:FsPath, data:String, callback:Error->Void):Void {})
	@:overload(function(filename:FsPath, data:NodeBuffer, options:EitherType<String, FsWriteFileOptions>, callback:Error->Void):Void {})
	function writeFile(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>, callback:Error->Void):Void;

	/**
		The synchronous version of `writeFile`.
	**/
	@:overload(function(filename:FsPath, data:NodeBuffer):Void {})
	@:overload(function(filename:FsPath, data:String):Void {})
	@:overload(function(filename:FsPath, data:NodeBuffer, options:EitherType<String, FsWriteFileOptions>):Void {})
	function writeFileSync(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>):Void;

	/**
		Asynchronously append data to a file, creating the file if it not yet exists.
		`data` can be a string or a buffer.
	**/
	@:overload(function(filename:FsPath, data:NodeBuffer, callback:Error->Void):Void {})
	@:overload(function(filename:FsPath, data:String, callback:Error->Void):Void {})
	@:overload(function(filename:FsPath, data:NodeBuffer, options:EitherType<String, FsWriteFileOptions>, callback:Error->Void):Void {})
	function appendFile(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>, callback:Error->Void):Void;

	/**
		The synchronous version of `appendFile`.
	**/
	@:overload(function(filename:FsPath, data:NodeBuffer):Void {})
	@:overload(function(filename:FsPath, data:String):Void {})
	@:overload(function(filename:FsPath, data:NodeBuffer, options:EitherType<String, FsWriteFileOptions>):Void {})
	function appendFileSync(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>):Void;

	/**
		Unstable. Use `watch` instead, if possible.

		Watch for changes on `filename`.
		The callback `listener` will be called each time the file is accessed.

		The `options` if provided should be an object containing two members:
			- `persistent` indicates whether the process should continue to run as long as files are being watched.
			- `interval` indicates how often the target should be polled, in milliseconds.
		The default is { persistent: true, interval: 5007 }.

		The `listener` gets two arguments: the current stat object and the previous stat object.
	**/
	@:overload(function(filename:FsPath, listener:Stats->Stats->Void):Void {})
	function watchFile(filename:FsPath, options:FsWatchFileOptions, listener:Stats->Stats->Void):Void;

	/**
		Unstable. Use `watch` instead, if possible.

		Stop watching for changes on filename.
		If `listener` is specified, only that particular listener is removed.
		Otherwise, all listeners are removed and you have effectively stopped watching filename.
		Calling `unwatchFile` with a `filename` that is not being watched is a no-op, not an error.
	**/
	function unwatchFile(filename:FsPath, ?listener:Stats->Stats->Void):Void;

	/**
		Watch for changes on `filename`, where filename is either a file or a directory.

		`persistent` indicates whether the process should continue to run as long as files are being watched. Default is `true`.

		The `listener` callback gets two arguments (event, filename). event is either 'rename' or 'change', and filename
		is the name of the file which triggered the event.
	**/
	@:overload(function(filename:FsPath):FSWatcher {})
	@:overload(function(filename:FsPath, options:{persistent:Bool, ?recursive:Bool}, listener:FSWatcherChangeType->String->Void):FSWatcher {})
	function watch(filename:FsPath, listener:FSWatcherChangeType->FsPath->Void):FSWatcher;

	/**
		Test whether or not the given `path` exists by checking with the file system.
		Then call the `callback` argument with either `true` or `false`.

		`exists` is an anachronism and exists only for historical reasons.
		There should almost never be a reason to use it in your own code.

		In particular, checking if a file exists before opening it is an anti-pattern that leaves you vulnerable to race conditions:
		another process may remove the file between the calls to `exists` and `open`.

		Just open the file and handle the error when it's not there.
	**/
	@:deprecated("Use Fs.stat or Fs.access instead")
	function exists(path:FsPath, callback:Bool->Void):Void;

	/**
		Synchronous version of `exists`.
	**/
	function existsSync(path:FsPath):Bool;

	/**
		Tests a user's permissions for the file or directory specified by `path`.

		The `mode` argument is an optional integer that specifies the accessibility checks to be performed.
		The following constants define the possible values of `mode`. It is possible to create a mask consisting
		of the bitwise OR of two or more values.

		* `Fs.constants.F_OK` - path is visible to the calling process. This is useful for determining if a file exists,
		  but says nothing about `rwx` permissions. Default if no `mode` is specified.
		* `Fs.constants.R_OK` - path can be read by the calling process.
		* `Fs.constants.W_OK` - path can be written by the calling process.
		* `Fs.constants.X_OK` - path can be executed by the calling process.
		  This has no effect on Windows (will behave like `Fs.constants.F_OK`).

		The final argument, `callback`, is a callback function that is invoked with a possible error argument.
		If any of the accessibility checks fail, the error argument will be populated.
	**/
	@:overload(function(path:FsPath, callback:Error->Void):Void {})
	function access(path:FsPath, mode:Int, callback:Error->Void):Void;

	/**
		A mode flag for `access` and `accessSync` methods:

		File is visible to the calling process.
		This is useful for determining if a file exists, but says nothing about rwx permissions.
	**/
	var F_OK(default, null):Int;

	/**
		A mode flag for `access` and `accessSync` methods:

		File can be read by the calling process.
	**/
	var R_OK(default, null):Int;

	/**
		A mode flag for `access` and `accessSync` methods:

		File can be written by the calling process.
	**/
	var W_OK(default, null):Int;

	/**
		A mode flag for `access` and `accessSync` methods:

		File can be executed by the calling process.
		This has no effect on Windows.
	**/
	var X_OK(default, null):Int;

	/**
		Synchronous version of `access`.
		This throws if any accessibility checks fail, and does nothing otherwise.
	**/
	function accessSync(path:FsPath, ?mode:Int):Void;

	/**
		Returns a new ReadStream object (See Readable Stream).

		`options` can include `start` and `end` values to read a range of bytes from the file instead of the entire file.
		Both `start` and `end` are inclusive and start at 0.

		The encoding can be 'utf8', 'ascii', or 'base64'.

		If `autoClose` is `false`, then the file descriptor won't be closed, even if there's an error.
		It is your responsiblity to close it and make sure there's no file descriptor leak.
		If `autoClose` is set to true (default behavior), on error or end the file descriptor will be closed automatically.
	**/
	function createReadStream(path:FsPath, ?options:EitherType<String, FsCreateReadStreamOptions>):ReadStream;

	/**
		Returns a new WriteStream object (See Writable Stream).

		`options` may also include a `start` option to allow writing data at some position past the beginning of the file.

		Modifying a file rather than replacing it may require a flags mode of r+ rather than the default mode w.
	**/
	function createWriteStream(path:FsPath, ?options:FsCreateWriteStreamOptions):WriteStream;
}
