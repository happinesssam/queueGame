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
	private var groceries:Group;
	
	private var unboughtItems:Array<GroceryItem>;
	private var boughtItems:Array<GroceryItem>;
	
	private var moveSpeed:Float;
	private var processSpeed:Float;
	private var takeTime:Float;
	
	private static var items:Array<String> = ["box", "bread", "carrot", "crisps", "juice", "bananas", "ketchup", "lettuce", "toiletPaper"];
	
	public function new(game:Game) 
	{
		super(game);
		
		x = 70;
		
		feet = new Sprite(game, 35, 85, Main.SPRITES, "feet");
		feet.anchor.x = 0.5;
		add(feet);
		
		cart = new Sprite(game, 0, 0, Main.SPRITES, "cart");
		add(cart);
		
		groceries = new Group(game);
		add(groceries);
		
		var bodyFrame:String = "body" + Math.floor(Math.random() * 4);
		body = new Sprite(game, 10, 94, Main.SPRITES, bodyFrame);
		add(body);
		
		var headFrame:String = "head" + Math.floor(Math.random() * 5);
		head = new Sprite(game, 20, 94, Main.SPRITES, headFrame);
		add(head);
		
		unboughtItems = [];
		boughtItems = [];
		takeTime = 100;
	}	
	
	public function init(numItems:Int, moveSpeed:Float, processSpeed:Float):Void
	{
		this.moveSpeed = moveSpeed;
		this.processSpeed = processSpeed;
		
		for (i in 0...numItems)
		{
			var item = new GroceryItem(game, 0, 0, Main.SPRITES, items[Math.floor(Math.random() * items.length)]);
			addItem(item, false);
		}
	}
	
	public function move(minY:Float):Void
	{
		y = Math.max(minY, y - moveSpeed);
	}
	
	public function getBot():Float
	{
		return y + height;
	}
	
	public function canTakeBack():Bool
	{
		if (takeTime <= 0)
		{
			takeTime = 100;
			return true;
		}
		else
		{
			takeTime-= processSpeed;
		}
		return false;
	}
	
	public function addItem(item:GroceryItem, bought:Bool):Void
	{
		groceries.add(item);
		if (bought)
		{
			boughtItems.push(item);
		}
		else
		{
			unboughtItems.push(item);
		}
		item.x = 5 + Math.random() * 35;
		item.y = 5 + Math.random() * 70;
	}
	
	public function canTakeBoughtItem():Bool
	{
		return false;
	}
	
	public function hasUnboughtItem():Bool
	{
		return (unboughtItems.length > 0);
	}
	public function getUnboughtItem():GroceryItem
	{
		if (unboughtItems.length > 0)
		{
			var item = unboughtItems.shift();
			groceries.remove(item);
			return item;
		}
		return null;
	}
}