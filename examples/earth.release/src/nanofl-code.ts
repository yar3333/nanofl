// This file is autogenerated by NanoFL

/// <reference types='nanofl-ts' />

export namespace base
{
	export class MySceneClass extends nanofl.MovieClip
	{
		constructor() {
			super(nanofl.Player.library.getItem("scene"));
		}
		get txtRenderer() { return this.getChildByName("txtRenderer") as nanofl.TextField }
		get txtFPS() { return this.getChildByName("txtFPS") as nanofl.TextField }
		get myEarth() { return this.getChildByName("myEarth") as nanofl.Mesh }
	}
}

export class Sounds
{
}
