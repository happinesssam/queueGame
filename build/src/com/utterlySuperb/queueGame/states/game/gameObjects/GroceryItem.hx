package com.utterlySuperb.queueGame.states.game.gameObjects;

import phaser.core.Game;
import phaser.gameobjects.Sprite;
import phaser.pixi.textures.Texture;

/**
 * ...
 * @author Sam Bellman
 */
class GroceryItem extends Sprite
{
	public var beenScanned:Bool;
	public function new(game:Game, x:Float, y:Float, key:String, frame:String) 
	{
		super(game, x, y, key, frame);
		
	}
	
}