package com.utterlySuperb.queueGame.states.game.hud;
import com.utterlySuperb.queueGame.ui.PhaserTextButton;
import com.utterlySuperb.queueGame.ui.TextHelper;
import phaser.core.Game;
import phaser.core.Group;
import phaser.core.Signal;
import phaser.gameobjects.Button;
import phaser.gameobjects.Text;

/**
 * ...
 * @author Sam Bellman
 */
class SpeedWidget extends Group
{
	private var title:Text;
	private var speedDisplay:Text;
	private var speedUp:PhaserTextButton;
	private var slowDown:PhaserTextButton;
	public var currentSpeed:Int = -1;
	private var maxSpeed:Int = 3;
	public var changeSignal:Signal;
	
	public function new(game:Game) 
	{
		super(game);
		this.x = 20;
		this.y = 70;
		slowDown = new PhaserTextButton(game, 0, 10, PhaserTextButtonType.smallBlue, "<", slowDownClick, this);
		add(slowDown);
		speedUp = new PhaserTextButton(game, 100, 10, PhaserTextButtonType.smallBlue, ">", speedUpClick, this);
		add(speedUp);
		
		speedDisplay = TextHelper.getText(game, 55, 10, 32);
		add(speedDisplay);
		TextHelper.setHudEffect(speedDisplay);
		
		var label:Text = TextHelper.getText(game, 40, -25, 24, "#FFFFFF", "Speed");
		add(label);
		TextHelper.setHudEffect(label);
		
		changeSignal = new Signal();
	}
	
	function speedUpClick(button:Button):Void
	{
		setSpeed(currentSpeed + 1);
	}
	
	function slowDownClick(button:Button) :Void
	{
		setSpeed(currentSpeed - 1);
	}
	
	public function setSpeed(speed:Int):Void
	{
		speed = Math.floor(Math.min(maxSpeed, Math.max(1, speed)));
		if (speed != currentSpeed)
		{
			currentSpeed = speed;
			speedDisplay.text = Std.string(currentSpeed);
			changeSignal.dispatch();
			speedDisplay.x = 75 - Math.floor(speedDisplay.width / 2);
		}
	}
	
	public function cleanUp():Void
	{
		changeSignal.dispose();
	}
	
	public function disable():Void
	{
		
	}
}