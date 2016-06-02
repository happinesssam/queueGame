package com.utterlySuperb.queueGame.states.game.gameObjects;

import phaser.core.Game;
import phaser.core.Group;
import phaser.gameobjects.Sprite;
import phaser.pixi.display.DisplayObject;
import phaser.sound.Sound;

/**
 * ...
 * @author Sam Bellman
 */
class Queue extends Group
{
	public var index:Int;
	private var counter:Counter;
	private var shoppers:Array<Shopper>;
	private var outShoppers:Array<Shopper>;
	private var unloadY:Int = 180;
	private var paying:Bool;
	private var maxPayTime:Float = 200;
	private var payTime:Float;
	private var payingDisplay:PayingDisplay;
	public var finished:Bool;
	private var ching:Sound;

	public function new(game:phaser.core.Game, index:Int) 
	{
		super(game);
		this.index = index;
		
		x = 15 + 165 * index;
		
		counter = new Counter(game, 0, 175);
		add(counter);
		
		shoppers = [];
		
		outShoppers = [];
		
		setUp();
		
		ching = game.add.audio('sell');
	}
	
	public function setUp():Void
	{
		var numItems:Int = 25 + Math.floor(Math.random() * 10);
		var numShoppers:Int = 2 + Math.floor(Math.random() * 3);
		for (i in 0...numShoppers) {
			var shopper = new Shopper(game);
			shoppers.push(shopper);
			shopper.init(Math.round(numItems/numShoppers), 2 + Math.random() * 2, 1 + Math.random());
			add(shopper);
		}
		shoppers[0].y = unloadY + 30;
		for (i in 1...shoppers.length)
		{
			shoppers[i].y = shoppers[i - 1].getBot();
		}
		payingDisplay = new PayingDisplay(game, 0, 155);
		add(payingDisplay);
		payingDisplay.setValue(0.75);
		payingDisplay.visible = false;
		finished = false;
	}
	
	public function updateActors():Void
	{
		var destY:Float = 0;
		//move any shopper who have finished off the screen
		if (outShoppers.length > 0)
		{
			for (i in 0...outShoppers.length)
			{
				outShoppers[i].move(destY);
				destY = outShoppers[i].getBot();
			}
			if (outShoppers[0].y <= 0)
			{
				remove(outShoppers[0]);
				outShoppers[0].destroy(true);
				outShoppers.shift();
			}
		}
		if (shoppers.length == 0) return;
		destY = Math.max(destY, unloadY);
		if (shoppers[0].y > unloadY)
		{
			shoppers[0].move(destY);
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
				if (!paying)
				{
					paying = true;
					payingDisplay.visible = true;
					payTime = maxPayTime;
				}
				else
				{
					payTime = Math.max(0, payTime - counter.processSpeed - shoppers[0].processSpeed);
					if (payTime <= 0)
					{
						if(!Main.gameData.soundMuted) ching.play();
						payingDisplay.visible = false;
						paying = false;
						outShoppers.push(shoppers.shift());
						finished = shoppers.length == 0;
					}
					else
					{
						payingDisplay.setValue(1 - payTime / maxPayTime);
					}
				}
			}
		}
		//check if shopper has finished
		for (i in 1...shoppers.length)
		{
			shoppers[i].move(shoppers[i - 1].getBot());
		}
	}
	
	public function setFinishPos(position:Int):Void
	{
		var medal = new Sprite(game, 100, 180, Main.SPRITES, "medal" + (position - 1));
		add(medal);
	}
	
	private function shopperOut(shopper:Shopper):Void
	{
		remove(shopper);
		shopper.destroy(true);
	}
	
	public function allShoppersOut():Bool
	{
		return shoppers.length == 0 && outShoppers.length == 0;
	}
}