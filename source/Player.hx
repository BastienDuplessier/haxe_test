package;

import flixel.FlxSprite;
import flixel.FlxObject;

class Player extends FlxSprite {

	private var name:String;

	public function new(asset):Void {
		super();
		maxVelocity.x = 160;
		maxVelocity.y = 400;
		acceleration.y = 400;
		// drag.x = player.maxVelocity.x * 4;
	}
	
}
