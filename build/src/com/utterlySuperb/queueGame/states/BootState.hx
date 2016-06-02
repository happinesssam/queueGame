package com.utterlySuperb.queueGame.states;

import com.utterlySuperb.queueGame.data.SaveManager;
import phaser.core.ScaleManager;
import phaser.core.State;

/**
 * ...
 * @author Sam Bellman
 */
class BootState extends State
{
	static public inline var BOOT_STATE:String = "bootState";

	public function new() 
	{
		super();
		Main.gameData = SaveManager.getGame();
	}
	
	override public function preload():Void
	{
		load.spritesheet("preloadAssets", "assets/images/preloadAssets.png", 190, 49);
	}
	
	override public function create():Void
	{
		scale.scaleMode = ScaleManager.SHOW_ALL;
		this.scale.setMinMax(250, 400, 500, 800);
		game.state.start(PreloadState.PRELOAD_STATE);
	}
}