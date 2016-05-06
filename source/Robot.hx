package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;

class Robot extends FlxSprite
{
  public var jumping:Bool = false;
  public var falling:Bool = false;
  public var lastVelocityY:Float = 0;
	public function new(sprSht:String):Void
  {
		super();
		initSpriteSheet(sprSht);
		initPhysics();
	}

	private function initPhysics()
  {
		maxVelocity.x = 100;
		maxVelocity.y = 600;
		acceleration.y = 400;
	}

	private function initSpriteSheet(sprSht:String)
  {
	}

	public override function update(elapsed:Float)
  {
    updatePhysics();
		super.update(elapsed);
	}

  // Robot was on the ground
  public function jump()
  {
    falling = false;
    jumping = true;
  }

  // Robot is jumping
	public function ascend()
  {
 	  if(!falling) {
      velocity.y -= 50;
      if(velocity.y <= -maxVelocity.y)
      fall();
    }
	}

  private function fall()
  {
    falling = true;
    jumping = false;
  }

  // Update physics on robot
  private function updatePhysics()
  {
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
