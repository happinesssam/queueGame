package com.utterlySuperb.queueGame.states.game.gameObjects;

import phaser.core.Game;
import phaser.core.Group;
import phaser.core.Signal;
import phaser.gameobjects.Sprite;
import phaser.pixi.display.DisplayObject;
import phaser.sound.Sound;

/**
 * ...
 * @author Sam Bellman
 */
class Counter extends Group
{
	private var counter:Sprite;
	private var groceries:Group;
	private var groceriesArray:Array<GroceryItem>;
	public var itemForUnload:GroceryItem;
	private var teller:Sprite;
	private var processSpeed:Float;
	private var unloadY:Float = 10;
	private var maxY:Float = 0;
	public var itemDoneSignal:Signal;
	public var scanY:Int = 50;
	public var scanItem:GroceryItem;
	public var scanTime:Float;
	private var beep:Sound;
	
	public function new(game:Game, x:Int = 0, y:Int = 0) 
	{
		super(game);
		this.x = x;
		this.y = y;
		
		counter = new Sprite(game, 20, 0, Main.SPRITES, "counter");
		add(counter);
		
		groceries = new Group(game);
		add(groceries);
		groceries.x = 14;
		
		teller = new Sprite(game, 0, 40, Main.SPRITES, "teller");
		add(teller);
		
		processSpeed = 1 + Math.random();
		
		groceriesArray = [];
		
		beep = game.add.audio('beep');
	}
	public function addNewItem(item:GroceryItem):Void
	{
		groceries.add(item);
		groceriesArray.push(item);
		item.x = 10;
		item.y = 120;
	}
	public function allItemsGone():Bool
	{
		return groceriesArray.length == 0;
	}
	
	public function updateItems():Void
	{
		maxY = 0;
		for (i in 0...groceriesArray.length)
		{
			if (!groceriesArray[i].beenScanned)
			{
				groceriesArray[i].y = Math.max(Math.max(maxY, scanY), groceriesArray[i].y - processSpeed);
				if (groceriesArray[i].y <= scanY)
				{
					if (groceriesArray[i] == scanItem)
					{
						scanTime-= processSpeed;
						if (scanTime <= 0)
						{
							groceriesArray[i].beenScanned = true;
							beep.play();
						}
					}
					else
					{
						scanTime = 100;
						scanItem = groceriesArray[i];
					}
				}
			}
			else
			{
				groceriesArray[i].y = Math.max(Math.max(maxY, unloadY), groceriesArray[i].y - processSpeed);
				if (groceriesArray[i].y == unloadY) itemForUnload = groceriesArray[i];
			}
			
			maxY = groceriesArray[i].y + groceriesArray[i].height;
		}		
	}
	
	public function takeItem():GroceryItem
	{
		groceries.remove(itemForUnload);
		groceriesArray.remove(itemForUnload);
		var item = itemForUnload;
		itemForUnload = null;
		return item;
	}
	
	public function hasSpaceForItem():Bool
	{
		return maxY < 90;
	}
}