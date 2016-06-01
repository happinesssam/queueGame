package com.utterlySuperb.queueGame.states;

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
		
	}
	
	override public function create():Void
	{
		game.state.start(PreloadState.PRELOAD_STATE);
	}
}