package;

import com.utterlySuperb.queueGame.states.BootState;
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
		
		game.state.start(BootState.BOOT_STATE);
	}
	
}