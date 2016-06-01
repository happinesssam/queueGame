package com.utterlySuperb.queueGame.ui;

import phaser.core.Game;
import phaser.core.Group;
import phaser.gameobjects.Button;
import phaser.gameobjects.Sprite;
import phaser.gameobjects.Text;
import phaser.pixi.display.DisplayObject;
import phaser.sound.Sound;

/**
 * ...
 * @author Sam Bellman
 */
class PhaserTextButton extends Group
{
	private var button:Button;
	private var text:Text;
	private var sprite:Sprite;

	public function new(game:Game, x:Int = 0, y:Int = 0, type:PhaserTextButtonType = null, copy:String="", callback:Button->Void = null, context:Dynamic = null) 
	{
		super(game);
		
		this.x = x;
		this.y = y;
		
		type = type == null ? bigYellow : type;
		
		var framePrefix = "buttonYellowBig";
		var size:Int =28;
		
		switch(type) {
			case bigYellow:
				framePrefix = "buttonYellowBig";
			case bigBlue:
				framePrefix = "buttonBlueBig";				
			case smallYellow:
				framePrefix = "buttonSmallYellow";
				size = 22;
			case smallBlue:
				framePrefix = "buttonSmallBlue";
				size = 22;				
		}
		
		button = new Button(game, 0, 0, Main.SPRITES, callback, context, framePrefix + "Over", framePrefix + "Up", framePrefix + "Down", framePrefix + "Over");
		add(button);		
		
		text = TextHelper.getText(game, 0, 0, size);
		add(text);
		
		if (copy.length > 0)
		{
			setText(copy);
		}
		
		sprite = new Sprite(game, 0, 0, Main.SPRITES);
		add(sprite);
		sprite.visible = false;
	}
	
	public function addOverSound(sound:Sound):Void
	{
		button.setOverSound(sound);
	}
	
	public function addClickSound(sound:Sound):Void
	{
		button.setUpSound(sound);
	}
	
	public function addSprite(frame:String):Void
	{
		sprite.frameName = frame;
		sprite.visible = true;
		sprite.x = Math.round((button.width - sprite.width) / 2);
		sprite.y = Math.round((button.height - sprite.height) / 2);
	}
	
	public function setText(copy:String):Void
	{
		text.text = copy;
		text.x = Math.round((button.width - text.width) / 2);
		text.y = Math.round((button.height - text.height) / 2);
	}
}
enum PhaserTextButtonType {
	bigYellow;
	smallYellow;
	bigBlue;
	smallBlue;
}