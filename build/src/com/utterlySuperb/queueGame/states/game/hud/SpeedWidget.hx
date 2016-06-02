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
	private var minSpeed:Int = 1;
	private var increment:Int = 1;
	var label:Text;
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
		
		label = TextHelper.getText(game, 40, -25, 24, "#FFFFFF", "Speed");
		add(label);
		TextHelper.setHudEffect(label);
		
		changeSignal = new Signal();
	}
	
	public function setUp(copy:String, defaultVal:Int, minVal:Int, maxVal:Int, increment:Int):Void
	{
		this.increment = increment;
		label.text = copy;
		currentSpeed = defaultVal;
		speedDisplay.text = Std.string(currentSpeed);
		maxSpeed = maxVal;
		minSpeed = minVal;
	}
	
	function speedUpClick(button:Button):Void
	{
		setSpeed(currentSpeed + increment);
	}
	
	function slowDownClick(button:Button) :Void
	{
		setSpeed(currentSpeed - increment);
	}
	
	public function setSpeed(speed:Int):Void
	{
		speed = Math.floor(Math.min(maxSpeed, Math.max(minSpeed, speed)));
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