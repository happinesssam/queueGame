package com.utterlySuperb.queueGame.states;

import com.utterlySuperb.queueGame.states.game.GameState;
import com.utterlySuperb.queueGame.ui.PhaserTextButton;
import com.utterlySuperb.queueGame.ui.TextHelper;
import phaser.core.State;
import phaser.gameobjects.Button;

/**
 * ...
 * @author Sam Bellman
 */
class MainMenuState extends State
{
	public static var MAIN_MENU_STATE:String = "mainMenuState";
	
	private var startButton:PhaserTextButton;
	
	public function new() 
	{
		super();
		
	}
	
	override public function create():Void 
	{
		var title = TextHelper.getText(game, 0, 100, 40, "#FFFFFF", "Queueueuz");
		game.add.existing(title);
		title.x = (stage.width - title.width) / 2;
		
		startButton = new  PhaserTextButton(game, 200, 200, PhaserTextButtonType.bigBlue, "Start", clickStart, this);
		startButton.addClickSound(game.add.audio('sell'));
		startButton.x = (stage.width - startButton.width) / 2;
		game.add.existing(startButton);
	}
	
	private function clickStart(button:Button):Void
	{
		game.state.start(GameState.GAME_STATE);
	}
}