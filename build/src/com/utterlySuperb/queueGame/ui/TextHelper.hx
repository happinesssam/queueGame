package com.utterlySuperb.queueGame.ui;
import phaser.core.Game;
import phaser.gameobjects.Text;

/**
 * ...
 * @author Sam Bellman
 */
class TextHelper
{
	static public inline var HEADER:String = "header";
	static public inline var BODY:String = "body";

	public function new() 
	{
		
	}
	
	public static function getText(game:Game, x:Int = 0, y:Int = 0, size:Int = 18, colour:String = "#FFFFFF", copy:String = "", type:String = BODY, align:String = "left"):Text
	{
		var font:String = type == BODY ? "Arial" : "Georgia";
		
		var style :Dynamic = {font:size+"px " + font, fill:colour, align:align};
		var text = new Text(game, x, y, copy, style);
		return text;
	}
}