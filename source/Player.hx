package;

import flixel.FlxSprite;
import flixel.FlxObject;

class Player extends FlxSprite {

	private var name:String;
	
	public function new(sprSht:String):Void {
		super();
		initSpritesheet(sprSht);
		initPhysics();
	}

	private function initPhysics() {
		maxVelocity.x = 100;
		maxVelocity.y = 400;
		acceleration.y = 400;
	}

	private function initSpritesheet(sprSht:String) {
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);
	}
	
}
