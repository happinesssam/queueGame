# queueGame
A quick game made using Haxe + Phaser
To build the project download the phaser externs, either from github - https://github.com/Blank101/haxe-phaser or haxelib - haxelib install phaser
Link to them in your classpaths.
The externs are missing some of the overloads I was using so you will need to make some changes:
phaser/core/Signal.hx - add another optional param to dispatch
ln 88: function dispatch (?params:Dynamic,?params:Dynamic,?params:Dynamic,?params:Dynamic):Void;

phaser/gameobjects/Button.hx - add a constructor anywhere
function new (game:phaser.core.Game, ?x:Float = 0, ?y:Float = 0, ?key:String, ?callback:Button->Void, ?callbackContext:Dynamic, ?overFrame:String, ?outFrame:String, ?downFrame:String, upFrame:String);

phaser/gameobjects/Sprite.hx - make frame optional in constructor
ln 32: @:overload(function (game:phaser.core.Game, x:Float, y:Float, key:String, ?frame:String):Void {})
add function crop+updateCrop. These should actually be in Crop component but I don't have time to update everything so stick them at the bottom of Sprite
function crop(rect:phaser.geom.Rectangle, ?copy:Bool):Void;
function updateCrop():Void;

phaser/core/State.hx remove params from init if using github version
The github version of the externs has a load of params for State.init(). I used the haxelib version which doesn't so if you have the github version, remove the params (ln 107).