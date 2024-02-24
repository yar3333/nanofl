// This file is regenerated by NanoFL on every publish.

/// <reference types='nanofl-ts' />

import * as linked from './linked-classes';

export namespace base
{
	export class Bucket extends nanofl.MovieClip
	{
		constructor() {
			super(nanofl.Player.library.getItem("bucket"));
		}
		get mcNeck() { return this.getChildByName("mcNeck") as nanofl.MovieClip }
		get tfLabel() { return this.getChildByName("tfLabel") as nanofl.TextField }
		get mcForeColor() { return this.getChildByName("mcForeColor") as nanofl.MovieClip }
		get mcBox() { return this.getChildByName("mcBox") as nanofl.MovieClip }
	}

	export class Game extends nanofl.MovieClip
	{
		constructor() {
			super(nanofl.Player.library.getItem("game"));
		}
	}

	export class MusicButton extends nanofl.MovieClip
	{
		constructor() {
			super(nanofl.Player.library.getItem("musicButton"));
		}
	}

	export class Scene extends nanofl.MovieClip
	{
		constructor() {
			super(nanofl.Player.library.getItem("scene"));
		}
		get btGotoGame() { return this.getChildByName("btGotoGame") as nanofl.Button }
		get btRules() { return this.getChildByName("btRules") as nanofl.Button }
		get btGotoOrigin() { return this.getChildByName("btGotoOrigin") as nanofl.Button }
		get tfLevel() { return this.getChildByName("tfLevel") as nanofl.TextField }
		get btNextLevel() { return this.getChildByName("btNextLevel") as nanofl.Button }
		get mcTrash() { return this.getChildByName("mcTrash") as linked.Trash }
		get game() { return this.getChildByName("game") as linked.Game }
		get tfTask() { return this.getChildByName("tfTask") as nanofl.TextField }
		get mcTap() { return this.getChildByName("mcTap") as nanofl.MovieClip }
	}

	export class Trash extends nanofl.MovieClip
	{
		constructor() {
			super(nanofl.Player.library.getItem("trash"));
		}
	}
}