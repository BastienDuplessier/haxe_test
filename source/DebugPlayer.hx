package;

import flixel.util.FlxColor;
import flixel.FlxG;

class DebugPlayer extends Player {

	public function new():Void {
		super("");
		makeGraphic(25,38, FlxColor.BLUE);
		screenCenter();
		x = Std.random(FlxG.width);
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);
		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			velocity.x -= maxVelocity.x / 10;
		} else if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			velocity.x += maxVelocity.x / 10;
		} else
		{
			var res = velocity.x / 2;
			velocity.x = res > maxVelocity.x/200 ? res : 0;
		} 
	}
	
	
}
