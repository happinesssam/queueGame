package com.utterlySuperb.queueGame.states.game.hud;

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
	private var title:Text;
	public var clickSignal:Signal;
	static public inline var CLICK_BET:String = "clickBet";
	static public inline var SWITCH_SPEED:String = "switchSpeed";
	static public inline var CLICK_PLAY_PAUSE:String = "clickPlayPause";
	
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
		
		title = TextHelper.getText(game, 0, 10, 40, "#FFFFFF", "Place your bet!".toUpperCase(), TextHelper.HEADER);
		add(title);
		TextHelper.setHudEffect(title);
		
		showStart();

		clickSignal = new Signal();
	}
	
	public function showStart():Void
	{
		setTitle("Place your bet!".toUpperCase());
		betButtons = [];
		for (i in 0...3)
		{
			var button = new PhaserTextButton(game, 31 + i * 156, 80, PhaserTextButtonType.bigBlue, "Queue " + (i + 1), clickBet, this);
			button.setButtonWidth(125);
			add(button);
			button.clickParam = Std.string(i);
			betButtons.push(button);
		}
	}
	
	public function showInGame() 
	{
		for (i in 0...betButtons.length)
		{
			remove(betButtons[i]);
			betButtons[i].destroy(true);
			trace(betButtons[i]);
		}
		betButtons = null;
		setTitle("GO!");
		
		speedWidget = new SpeedWidget(game);
		speedWidget.setSpeed(1);
		speedWidget.changeSignal.add(speedChange, this);
		add(speedWidget);
		
		playPauseButton = new PhaserTextButton(game, 420, 80, PhaserTextButtonType.smallBlue, "", clickPlayPause, this);
		add(playPauseButton);
		setPlayPause(false);
	}
	
	public function setPlayPause(isPaused:Bool):Void
	{
		playPauseButton.addSprite(isPaused ? "play" : "pause");
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
	
	private function setTitle(copy:String):Void
	{
		title.text = copy;
		title.x = (game.width - title.width) / 2;
	}
}