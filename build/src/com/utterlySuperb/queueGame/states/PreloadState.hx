package com.utterlySuperb.queueGame.states;

import com.utterlySuperb.queueGame.ui.PhaserTextButton;
import com.utterlySuperb.queueGame.ui.TextHelper;
import phaser.core.State;
import phaser.gameobjects.Button;
import phaser.gameobjects.Sprite;
import phaser.geom.Rectangle;

/**
 * ...
 * @author Sam Bellman
 */
class PreloadState extends State
{
	static public inline var PRELOAD_STATE:String = "preloadState";
	
	private var bar:Sprite;
	private var cropRect:Rectangle;

	public function new() 
	{
		super();
		
	}
	
	override public function init():Void
	{
		var tx:Int = 155;
		var ty:Int = 250;
		
		var bg:Sprite = new Sprite(game, tx, ty, "preloadAssets", 0);
		game.add.existing(bg);
		
		bar = new Sprite(game, tx, ty, "preloadAssets", 1);
		game.add.existing(bar);
		
		cropRect = new Rectangle(0, 0, 0, 49);
		bar.crop(cropRect);
		bar.updateCrop();
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
	
	override public function loadUpdate():Void 
	{
		cropRect.width = 190 * load.progress / 100;
		bar.updateCrop();
	}
}