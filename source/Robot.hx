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
		loadGraphic(sprSht, true, 35, 45);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		facing = FlxObject.RIGHT;

		animation.add("waking", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 10, false);
		animation.add("fainting", [20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], 10, false);
		animation.add("idling", [8, 9, 10, 11, 12, 13], 5, true);
		animation.add("walking", [19, 18, 17], 5, false);
		animation.add("exploding", [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58], 15,  false);
		animation.add("jumping", [64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79], 10, false);
    animation.add("landing", [80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95], 10, false);
    animation.add("appearing", [96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121], 10, false);
    animation.play("idling");
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
