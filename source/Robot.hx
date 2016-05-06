package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;

class Robot extends FlxSprite {

  public var jumping:Bool;
  public var falling:Bool;
  private var lastVelocityY:Float;

	public function new(sprSht:String):Void {
		super();
		initSpriteSheet(sprSht);
		initPhysics();
	}

	private function initPhysics() {
		maxVelocity.x = 100;
		maxVelocity.y = 400;
		acceleration.y = 400;
		jumping = false;
		falling = false;
    lastVelocityY = 0;
    FlxG.watch.add(velocity, "y");
    FlxG.watch.add(this, "jumping");
    FlxG.watch.add(this, "falling");
    FlxG.watch.add(this, "lastVelocityY");
	}

	private function initSpriteSheet(sprSht:String) {
	}

	public override function update(elapsed:Float) {
    updatePhysics();
		super.update(elapsed);
	}

  // Robot was on the ground
  public function jump() {
    falling = false;
    jumping = true;
  }

  // Robot is jumping
	public function ascend() {
 	  if(!falling) {
      velocity.y -= 50;
      if(velocity.y == -maxVelocity.y)
        fall();
    }
	}

  private function fall() {
    falling = true;
    jumping = false;
  }

  // Update physics on robot
  private function updatePhysics() {
    if(velocity.y == 0) {
      falling = false;
    }
    if(jumping && (lastVelocityY < velocity.y)) {
      falling = true;
      jumping = false;
    }
    lastVelocityY = velocity.y;
  }
}
