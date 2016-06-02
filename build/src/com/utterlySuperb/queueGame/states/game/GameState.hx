package com.utterlySuperb.queueGame.states.game;

import com.utterlySuperb.queueGame.data.SaveManager;
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
	private var finishPositions:Array<Int>;
	private var bet:Int;
	
	public function new() 
	{
		super();
		
	}
	
	override public function create():Void 
	{
		var floor = game.add.tileSprite(0, 0, game.width, game.height, Main.SPRITES, "floorTile");
		
		finishPositions = [];
		queues = [];
		for (i in 0...3)
		{
			queues.push(new Queue(game, i));
			game.add.existing(queues[i]);
		}
		
		hud = new Hud(game);
		game.add.existing(hud);
		hud.clickSignal.add(hudEvent, this);
		bet = 10;
		hud.showStart(bet);
		hud.setStartmoney(Main.gameData.money - bet);
		
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
			var queuesDone:Int = 0;
			for (i in 0...queues.length)
			{
				queues[i].updateActors();
				if (queues[i].finished)
				{
					if (finishPositions.indexOf(i) == -1)
					{
						finishPositions.push(i);
						queues[i].setFinishPos(finishPositions.length);
					}
					else if (queues[i].allShoppersOut())
					{
						queuesDone++;
					}
				}
			}
			if (queuesDone == 3)
			{
				gameStage = postGame;
				var multiplier:Float = 0;
				if(chosenQueue==finishPositions[0])
				{
					multiplier = 2;
				}
				else if (chosenQueue == finishPositions[1])
				{
						multiplier = 0.5;
				}
				var winnings:Int = Math.round(multiplier * bet);
				Main.gameData.money += winnings;
				SaveManager.saveGame();
				hud.showEnd(finishPositions, chosenQueue, winnings);
				if(currentTheme!=null) currentTheme.stop();
				return;
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
				if (gameStage == inGame)
				{
					var newSpeed = Std.parseInt(eventParam);
					if (speed != newSpeed)
					{
						speed = newSpeed;
						checkTheme();
					}
				}
				else
				{
					bet = Std.parseInt(eventParam);
					hud.setStartmoney(Main.gameData.money - bet);
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
			case Hud.SOUND_CHANGE:
				if (gameStage == inGame)
				{
					if (Main.gameData.soundMuted)
					{
						currentTheme.stop();
						currentTheme = null;
					}
					else
					{
						checkTheme();						
					}
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
		if (currentTheme != theme1 && !Main.gameData.soundMuted)
		{
			if(currentTheme!=null) currentTheme.stop();
			theme1.play("", 0, 1, true, false);
			currentTheme = theme1;
		}
	}
	
	private function startGame(queue:Int):Void
	{
		chosenQueue = queue;
		speed = 1;
		if (!Main.gameData.soundMuted)
		{
			currentTheme = theme;		
			theme.play("", 0, 1, true);
		}
		hud.showInGame(chosenQueue, bet);
		Main.gameData.money -= bet;
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