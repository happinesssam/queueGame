package com.utterlySuperb.queueGame.data;
import haxe.Json;
import js.Browser;
import js.html.Storage;

/**
 * ...
 * @author Sam Bellman
 */
class SaveManager
{

	public function new() 
	{
		
	}
	
	public static function saveGame():Void
	{
		var storage:Storage = Browser.getLocalStorage();
		if (storage == null) return;
    
		storage.setItem("gameData", Json.stringify(Main.gameData));
	}
	
	public static function getGame():GameData
	{
		var storage:Storage = Browser.getLocalStorage();
		if (storage == null) return new GameData();
		
		var gameState:String = storage.getItem("gameData");
    
		if(gameState!=null && gameState.length>0){
			return cast Json.parse(gameState);
		}
		else{
			return new GameData();
		}
	}
}