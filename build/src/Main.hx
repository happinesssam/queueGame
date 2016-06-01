package;

import com.utterlySuperb.queueGame.states.BootState;
import com.utterlySuperb.queueGame.states.game.GameState;
import com.utterlySuperb.queueGame.states.MainMenuState;
import com.utterlySuperb.queueGame.states.PreloadState;
import js.Lib;
import phaser.core.Game;
import phaser.Phaser;

/**
 * ...
 * @author Sam Bellman
 */

class Main 
{
	static public inline var SPRITES:String = "sprites";
	
	var game:Game;
	
	static function main() 
	{
		new Main();
	}
	
	public function new() 
	{
		game = new Game(500, 800, Phaser.AUTO, "test", null);
		
		game.state.add(BootState.BOOT_STATE, BootState);
		game.state.add(PreloadState.PRELOAD_STATE, PreloadState);
		game.state.add(MainMenuState.MAIN_MENU_STATE, MainMenuState);
		game.state.add(GameState.GAME_STATE, GameState);
		
		game.state.start(BootState.BOOT_STATE);
	}
	
}