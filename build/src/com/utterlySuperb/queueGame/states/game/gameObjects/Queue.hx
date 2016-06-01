package com.utterlySuperb.queueGame.states.game.gameObjects;

import phaser.core.Game;
import phaser.core.Group;
import phaser.pixi.display.DisplayObject;

/**
 * ...
 * @author Sam Bellman
 */
class Queue extends Group
{
	public var index:Int;
	private var counter:Counter;
	private var shoppers:Array<Shopper>;
	private var unloadY:Int = 180;
	public var finished:Bool;

	public function new(game:phaser.core.Game, index:Int) 
	{
		super(game);
		this.index = index;
		
		x = 15 + 165 * index;
		
		counter = new Counter(game, 0, 175);
		add(counter);
		
		shoppers = [];
		
		setUp();
	}
	
	public function setUp():Void
	{
		var numShoppers:Int = 2 + Math.floor(Math.random() * 3);
		for (i in 0...numShoppers) {
			var shopper = new Shopper(game);
			shoppers.push(shopper);
			shopper.init(4 + Math.floor(Math.random() * 9), 2 + Math.random() * 2, 1 + Math.random());
			add(shopper);
		}
		shoppers[0].y = unloadY + 30;
		for (i in 1...shoppers.length)
		{
			shoppers[i].y = shoppers[i - 1].getBot();
		}
		finished = false;
	}
	
	public function updateActors():Void
	{
		if (shoppers[0].y > unloadY)
		{
			shoppers[0].move(unloadY);
		}
		else
		{
			//doShopping
			if (counter.hasSpaceForItem() && shoppers[0].hasUnboughtItem())
			{
				counter.addNewItem(shoppers[0].getUnboughtItem());
			}
			if (counter.itemForUnload != null && shoppers[0].canTakeBack())
			{
				shoppers[0].addItem(counter.takeItem(), true);
			}
			counter.updateItems();
			if (!shoppers[0].hasUnboughtItem() && counter.allItemsGone())
			{
				//pay for items then next shopper
			}
		}
		//check if shopper has finished
		for (i in 1...shoppers.length)
		{
			shoppers[i].move(shoppers[i - 1].getBot());
		}
	}
}