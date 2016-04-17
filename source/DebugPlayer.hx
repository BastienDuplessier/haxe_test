package;

import flixel.util.FlxColor;

class DebugPlayer extends Player {

	public function new():Void {
		super("");
		makeGraphic(25,38, FlxColor.BLUE);
		screenCenter();

	}
	
}
