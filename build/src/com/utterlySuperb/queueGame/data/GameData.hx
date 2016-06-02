package com.utterlySuperb.queueGame.data;

/**
 * ...
 * @author Sam Bellman
 */
class GameData
{
	public var money:Int;
	public var soundMuted:Bool;
	public static var START_AMOUNT:Int = 50;
	
	public function new() 
	{
		money = START_AMOUNT;
		soundMuted = false;
	}

	
}