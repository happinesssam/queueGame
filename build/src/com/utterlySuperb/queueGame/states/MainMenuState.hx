package com.utterlySuperb.queueGame.states;

import com.utterlySuperb.queueGame.data.GameData;
import com.utterlySuperb.queueGame.states.game.GameState;
import com.utterlySuperb.queueGame.ui.PhaserTextButton;
import com.utterlySuperb.queueGame.ui.TextHelper;
import phaser.core.State;
import phaser.gameobjects.Button;
import phaser.gameobjects.Text;

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
		var title:Text = TextHelper.getText(game, 0, 100, 40, "#FFFFFF", "Queueueuz");
		game.add.existing(title);
		title.x = (stage.width - title.width) / 2;
		
		startButton = new  PhaserTextButton(game, 200, 200, PhaserTextButtonType.bigYellow, "Start", clickStart, this);
		startButton.x = (stage.width - startButton.width) / 2;
		game.add.existing(startButton);
		
		if (Main.gameData.money != GameData.START_AMOUNT)
		{
			startButton.setText("Continue");
			
			var newButton = new  PhaserTextButton(game, 200, 270, PhaserTextButtonType.bigYellow, "New Game", clickNewGame, this);
			newButton.x = (stage.width - startButton.width) / 2;
			game.add.existing(newButton);
		}
		
		var attr:Text = TextHelper.getText(game, 0, 770, 16, "#FFFFFF", "Art assets by Sunisa Thondaengdee");
		game.add.existing(attr);
		attr.x = (game.width -  attr.width) / 2;
	}
	
	private function clickNewGame(button:Button):Void
	{
		Main.gameData.money = GameData.START_AMOUNT;
		game.state.start(GameState.GAME_STATE);
	}
	
	private function clickStart(button:Button):Void
	{
		game.state.start(GameState.GAME_STATE);
	}
}