package com.utterlySuperb.queueGame.states.game;

import com.utterlySuperb.queueGame.states.game.gameObjects.Queue;
import com.utterlySuperb.queueGame.states.game.gameObjects.Shopper;
import com.utterlySuperb.queueGame.states.game.hud.Hud;
import phaser.core.State;
import phaser.sound.Sound;

/**
 * ...
 * @author Sam Bellman
 */
class GameState extends State
{
	public static var GAME_STATE:String = "gameState";
	
	private var queues:Array<Queue>;
	private var hud:Hud;
	private var theme:Sound;
	private var themeFast:Sound;
	private var currentTheme:Sound;
	private var chosenQueue:Int;
	private var speed:Int;
	private var gameStage:GameStageType;
	
	public function new() 
	{
		super();
		
	}
	
	override public function create():Void 
	{
		var floor = game.add.tileSprite(0, 0, game.width, game.height, Main.SPRITES, "floorTile");
		
		queues = [];
		for (i in 0...3)
		{
			queues.push(new Queue(game, i));
			game.add.existing(queues[i]);
		}
		
		hud = new Hud(game);
		game.add.existing(hud);
		hud.clickSignal.add(hudEvent, this);
		
		theme = game.add.audio('theme', 1, true);
		themeFast = game.add.audio('themeFast', 1, true);
		
		gameStage = preGame;
	}
	
	override public function update():Void 
	{
		switch(gameStage)
		{
			case preGame, postGame, isPaused:
			case inGame:
				playUpdate();
		}
	}
	
	private function playUpdate():Void
	{
		for (j in 0...speed)
		{
			for (i in 0...queues.length)
			{
				queues[i].updateActors();
				if (queues[i].finished)
				{
					gameStage = postGame;
					return;
				}
			}
		}
	}
	
	private function hudEvent(eventType:String, eventParam:String):Void
	{
		switch(eventType)
		{
			case Hud.CLICK_BET:
				startGame(Std.parseInt(eventParam));
			case Hud.SWITCH_SPEED:
				var newSpeed = Std.parseInt(eventParam);
				if (speed != newSpeed)
				{
					speed = newSpeed;
					checkTheme();
				}
			case Hud.CLICK_PLAY_PAUSE:
				if (gameStage == inGame)
				{
					gameStage = isPaused;
					hud.setPlayPause(true);
					currentTheme.pause();
				}
				else if (gameStage == isPaused)
				{
					gameStage = inGame;
					hud.setPlayPause(false);
					currentTheme.resume();
				}
		}
	}
	
	private function checkTheme():Void
	{
		if (speed > 1)
		{
			switchTheme(theme, themeFast);
		}
		else if (speed == 1)
		{
			switchTheme(themeFast, theme);
		}
	}
	
	private function switchTheme(theme0:Sound, theme1:Sound):Void
	{
		if (currentTheme != theme1)
		{
			currentTheme.stop();
			theme1.play("", 0, 1, true, false);
			currentTheme = theme1;
		}
	}
	
	private function startGame(queue:Int):Void
	{
		chosenQueue = queue;
		currentTheme = theme;
		speed = 1;
		theme.play("", 0, 1, true);
		hud.showInGame();
		gameStage = inGame;
	}
}
enum GameStageType
{
	preGame;
	inGame;
	postGame;
	isPaused;
}