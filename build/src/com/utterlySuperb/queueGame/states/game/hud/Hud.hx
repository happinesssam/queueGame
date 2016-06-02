package com.utterlySuperb.queueGame.states.game.hud;

import com.utterlySuperb.queueGame.data.GameData;
import com.utterlySuperb.queueGame.data.SaveManager;
import com.utterlySuperb.queueGame.ui.PhaserTextButton;
import com.utterlySuperb.queueGame.ui.TextHelper;
import phaser.core.Game;
import phaser.core.Group;
import phaser.core.Signal;
import phaser.gameobjects.BitmapData;
import phaser.gameobjects.Button;
import phaser.gameobjects.Graphics;
import phaser.gameobjects.Sprite;
import phaser.gameobjects.Text;
import phaser.pixi.display.DisplayObject;
import phaser.utils.Color;

/**
 * ...
 * @author Sam Bellman
 */
class Hud extends Group
{
	private var betButtons:Array<PhaserTextButton>;
	private var speedWidget:SpeedWidget;
	private var playPauseButton:PhaserTextButton;
	private var muteButton:PhaserTextButton;
	private var title:Text;
	private var info:Text;
	public var clickSignal:Signal;
	static public inline var CLICK_BET:String = "clickBet";
	static public inline var SWITCH_SPEED:String = "switchSpeed";
	static public inline var CLICK_PLAY_PAUSE:String = "clickPlayPause";
	static public inline var SOUND_CHANGE:String = "soundChange";
	
	public function new(game:Game) 
	{
		super(game);
		
		var bg:Graphics = new Graphics(game);
		bg.beginFill(0xFFF605);
		bg.drawRect(0, 0, game.width, 140);
		bg.beginFill(0xddaa00);
		bg.drawRect(0, 136, game.width, 4);
		bg.beginFill(0x000000, 0.5);
		bg.drawRect(0, 140, game.width, 4);
		add(bg);
		
		title = TextHelper.getText(game, 30, 15, 28, "#FFFFFF", "Place your bet!".toUpperCase(), TextHelper.BODY);
		add(title);
		TextHelper.setHudEffect(title);
		
		info = TextHelper.getText(game, 10, 15, 28, "#FFFFFF", "", TextHelper.BODY);
		add(info);
		TextHelper.setHudEffect(info);
		
		clickSignal = new Signal();
	}
	
	public function showStart(defaultBet:Int):Void
	{
		title.text = "Current: $" + Main.gameData.money;
		betButtons = [];
		for (i in 0...3)
		{
			var button = new PhaserTextButton(game, 31 + i * 156, 80, PhaserTextButtonType.bigBlue, "Bet!", clickBet, this);
			button.setButtonWidth(125);
			add(button);
			button.clickParam = Std.string(i);
			betButtons.push(button);
		}
		speedWidget = new SpeedWidget(game);
		add(speedWidget);
		speedWidget.x = 320; 
		speedWidget.y = 5; 
		speedWidget.setUp("", defaultBet, 10, Main.gameData.money, 10);
		speedWidget.changeSignal.add(speedChange, this);
		info.text = "Bet";
		info.x = 310 - info.width;
	}
	
	public function setStartmoney(amount:Int):Void
	{
		title.text = "Current: $" + amount;
	}
	
	public function showInGame(guess:Int, amount:Int) 
	{
		title.text = "Queue:" + (guess + 1);
		
		info.text = "Bet:" + amount;
		info.x = title.x;
		info.y = title.y + title.height + 10;
		
		for (i in 0...betButtons.length)
		{
			remove(betButtons[i]);
			betButtons[i].destroy(true);
			trace(betButtons[i]);
		}
		betButtons = null;		
		
		speedWidget.x = 250;
		speedWidget.y = 70;
		speedWidget.setUp("Speed", 1, 1, 3, 1);
		speedWidget.setSpeed(1);
		
		
		
		playPauseButton = new PhaserTextButton(game, 420, 80, PhaserTextButtonType.smallBlue, "", clickPlayPause, this);
		add(playPauseButton);
		setPlayPause(false);
		
		muteButton = new PhaserTextButton(game, 420, 20, PhaserTextButtonType.smallBlue, "", toggleSoundButton, this);
		add(muteButton);
		setSoundButton();
	}
	
	public function showEnd(finishPositions:Array<Int>, playerGuess:Int, winnings:Int):Void
	{
		speedWidget.cleanUp();
		remove(speedWidget);
		speedWidget.destroy(true);
		speedWidget = null;
		
		remove(playPauseButton);
		playPauseButton.destroy(true);
		playPauseButton = null;
		
		remove(muteButton);
		muteButton.destroy(true);
		muteButton = null;
		
		title.text = "Queue " + (finishPositions[0] + 1) +" wins! Queue " + (finishPositions[1] + 1) +" comes 2nd";
		var infoStr:String = "You guessed queue " + (playerGuess + 1);
		if (winnings > 0) infoStr += " and win " + winnings;
		info.text = infoStr;
		
		var feedback:Text = TextHelper.getText(game, 10, 320, 32);
		add(feedback);
		TextHelper.setHudEffect(feedback);
		
		if (Main.gameData.money > 10)
		{
			feedback.text = "Current cash: $" + Main.gameData.money;
		}
		else
		{
			feedback.text = "Game over";
		}
		feedback.x = (game.width - feedback.width) / 2;
		
		var continueButton = new PhaserTextButton(game, 120, 380, PhaserTextButtonType.bigBlue, "Continue", clickContinue, this);
		continueButton.x = (game.width - continueButton.width) / 2;
	}
	
	private function clickContinue(button:Button):Void
	{
		if (Main.gameData.money > 10)
		{
			game.state.start(GameState.GAME_STATE);
		}
		else
		{
			Main.gameData.money = GameData.START_AMOUNT;
			SaveManager.saveGame();
			game.state.start(MainMenuState.MAIN_MENU_STATE);
		}
	}
	
	public function setPlayPause(isPaused:Bool):Void
	{
		playPauseButton.addSprite(isPaused ? "play" : "pause");
	}
	
	private function toggleSoundButton(button:Button):Void
	{
		Main.gameData.soundMuted = !Main.gameData.soundMuted;
		setSoundButton();
		clickSignal.dispatch(SOUND_CHANGE);
	}
	
	public function setSoundButton():Void
	{
		muteButton.addSprite(Main.gameData.soundMuted ? "audioOff" : "audioOn");
	}
	
	private function clickBet(button:Button) 
	{
		clickSignal.dispatch(CLICK_BET, button.parent.clickParam);
	}
	
	private function clickPlayPause(button:Button) 
	{
		clickSignal.dispatch(CLICK_PLAY_PAUSE);
	}
	
	private function speedChange():Void
	{
		clickSignal.dispatch(SWITCH_SPEED, Std.string(speedWidget.currentSpeed));
	}
}