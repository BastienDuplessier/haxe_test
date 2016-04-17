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
	
}
