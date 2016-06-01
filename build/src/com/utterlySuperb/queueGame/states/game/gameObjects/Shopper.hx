package com.utterlySuperb.queueGame.states.game.gameObjects;

import phaser.core.Game;
import phaser.core.Group;
import phaser.gameobjects.Sprite;
import phaser.pixi.display.DisplayObject;

/**
 * ...
 * @author Sam Bellman
 */
class Shopper extends Group
{
	private var feet:Sprite;
	private var cart:Sprite;
	private var body:Sprite;
	private var head:Sprite;
	
	public function new(game:Game) 
	{
		super(game);
		
	}
	
}