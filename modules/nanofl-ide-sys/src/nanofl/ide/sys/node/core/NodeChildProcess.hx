package nanofl.ide.sys.node.core;

import haxe.extern.EitherType;
import js.node.ChildProcess;
import js.node.child_process.ChildProcess as ChildProcessObject;

extern class NodeChildProcess
{
	/**
		Launches a new process with the given `command`, with command line arguments in `args`.
		If omitted, `args` defaults to an empty `Array`.

		The third argument is used to specify additional options, which defaults to:
			{ cwd: null,
			  env: process.env
			}

		Note that if spawn receives an empty options object, it will result in spawning the process with an empty
		environment rather than using `process.env`. This due to backwards compatibility issues with a deprecated API.
	**/
	@:overload(function(command:String, ?options:ChildProcessSpawnOptions):ChildProcessObject {})
	@:overload(function(command:String, args:Array<String>, ?options:ChildProcessSpawnOptions):ChildProcessObject {})
	function spawn(command:String, ?args:Array<String>):ChildProcessObject;

	/**
		Runs a command in a shell and buffers the output.

		`command` is the command to run, with space-separated arguments.

		The default `options` are:
			{ encoding: 'utf8',
			  timeout: 0,
			  maxBuffer: 200*1024,
			  killSignal: 'SIGTERM',
			  cwd: null,
			  env: null }
	**/
	@:overload(function(command:String, options:ChildProcessExecOptions, callback:ChildProcessExecCallback):ChildProcessObject {})
	function exec(command:String, callback:ChildProcessExecCallback):ChildProcessObject;

	/**
		This is similar to `exec` except it does not execute a subshell but rather the specified file directly.
		This makes it slightly leaner than `exec`
	**/
	@:overload(function(file:String, args:Array<String>, options:ChildProcessExecFileOptions, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	@:overload(function(file:String, options:ChildProcessExecFileOptions, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	@:overload(function(file:String, args:Array<String>, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	function execFile(file:String, ?callback:ChildProcessExecCallback):ChildProcessObject;

	/**
		This is a special case of the `spawn` functionality for spawning Node processes.
		In addition to having all the methods in a normal `ChildProcess` instance,
		the returned object has a communication channel built-in.
		See `send` for details.
	**/
	@:overload(function(modulePath:String, args:Array<String>, options:ChildProcessForkOptions):ChildProcessObject {})
	@:overload(function(modulePath:String, options:ChildProcessForkOptions):ChildProcessObject {})
	function fork(modulePath:String, ?args:Array<String>):ChildProcessObject;

	/**
		Synchronous version of `spawn`.

		`spawnSync` will not return until the child process has fully closed.
		When a timeout has been encountered and `killSignal` is sent, the method won't return until the process
		has completely exited. That is to say, if the process handles the SIGTERM signal and doesn't exit,
		your process will wait until the child process has exited.
	**/
	@:overload(function(command:String, args:Array<String>, ?options:ChildProcessSpawnSyncOptions):ChildProcessSpawnSyncResult {})
	function spawnSync(command:String, ?options:ChildProcessSpawnSyncOptions):ChildProcessSpawnSyncResult;

	/**
		Synchronous version of `execFile`.

		`execFileSync` will not return until the child process has fully closed.
		When a timeout has been encountered and `killSignal` is sent, the method won't return until the process
		has completely exited. That is to say, if the process handles the SIGTERM signal and doesn't exit,
		your process will wait until the child process has exited.

		If the process times out, or has a non-zero exit code, this method will throw.
		The Error object will contain the entire result from `spawnSync`
	**/
	@:overload(function(command:String, ?options:ChildProcessSpawnSyncOptions):EitherType<String, NodeBuffer> {})
	@:overload(function(command:String, args:Array<String>, ?options:ChildProcessSpawnSyncOptions):EitherType<String, NodeBuffer> {})
	function execFileSync(command:String, ?args:Array<String>):EitherType<String, NodeBuffer>;

	/**
		Synchronous version of `exec`.

		`execSync` will not return until the child process has fully closed.
		When a timeout has been encountered and `killSignal` is sent, the method won't return until the process
		has completely exited. That is to say, if the process handles the SIGTERM signal and doesn't exit,
		your process will wait until the child process has exited.

		If the process times out, or has a non-zero exit code, this method will throw.
		The Error object will contain the entire result from `spawnSync`
	**/
	function execSync(command:String, ?options:ChildProcessSpawnSyncOptions):EitherType<String, NodeBuffer>;
}
