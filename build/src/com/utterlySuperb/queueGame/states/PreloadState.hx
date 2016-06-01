package com.utterlySuperb.queueGame.states;

import com.utterlySuperb.queueGame.ui.PhaserTextButton;
import com.utterlySuperb.queueGame.ui.TextHelper;
import phaser.core.State;
import phaser.gameobjects.Button;

/**
 * ...
 * @author Sam Bellman
 */
class PreloadState extends State
{
	var ching:phaser.sound.Sound;
	static public inline var PRELOAD_STATE:String = "preloadState";

	public function new() 
	{
		super();
		
	}
	
	override public function preload():Void
	{
		load.atlasXML(Main.SPRITES, 'assets/images/atlas_0.png', 'assets/images/atlas_0.xml');
		load.audio('beep', ['assets/sounds/beep.mp3', 'assets/sounds/beep.ogg']);
		load.audio('sell', ['assets/sounds/sell_buy_item.mp3', 'assets/sounds/sell_buy_item.ogg']);
		load.audio('theme', ['assets/sounds/williamTell.mp3', 'assets/sounds/williamTell.ogg']);
		load.audio('themeFast', ['assets/sounds/williamTell_fast.mp3', 'assets/sounds/williamTell_fast.ogg']);
	}
	
	override public function create():Void
	{
		game.state.start(MainMenuState.MAIN_MENU_STATE);		
	}
}