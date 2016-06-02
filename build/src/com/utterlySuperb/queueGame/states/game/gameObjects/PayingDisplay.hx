package com.utterlySuperb.queueGame.states.game.gameObjects;
import phaser.core.Game;
import phaser.core.Group;
import phaser.gameobjects.Sprite;
import phaser.geom.Rectangle;

/**
 * ...
 * @author Sam Bellman
 */
class PayingDisplay extends Group
{
	private var bar:Sprite;
	private var cropRect:Rectangle;

	public function new(game:Game, x:Int, y:Int) 
	{
		super(game);
		this.x = x;
		this.y = y;
		
		var bg:Sprite = new Sprite(game, 0, 0, Main.SPRITES, "paying1");
		add(bg);
		bar = new Sprite(game, 0, 0, Main.SPRITES, "paying0");
		add(bar);
		cropRect = new Rectangle(0, 0, 140, 49);
		bar.crop(cropRect);
	}
	
	public function setValue(value:Float):Void
	{
		cropRect.width = Math.floor(140 * value);
		bar.updateCrop();
	}
}