package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;

class Robot extends FlxSprite
{
  public var jumping:Bool = false;
	public function new(sprSht:String):Void
  {
		super();
		initSpriteSheet(sprSht);
		initPhysics();
	}

	private function initPhysics()
  {
		maxVelocity.x = 200;
		maxVelocity.y = 800;
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
    if(velocity.y == 0 && isTouching(FlxObject.FLOOR))
    {
      jumping = true;
    }
  }

  public function falling():Bool
  {
    return velocity.y > 0;
  }

  private function updatePhysics()
  {
 	  if(jumping && !falling()) {
      velocity.y -= maxVelocity.y / 5;
      if(velocity.y <= -maxVelocity.y / 2)
      {
        jumping = false;
      }
    }

  }

}
