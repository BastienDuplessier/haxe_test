package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.addons.util.FlxFSM;

class Robot extends FlxSprite
{
  public var jumping:Bool = false;
  public var fsm:FlxFSM<FlxSprite>;

	public function new(sprSht:String):Void
  {
		super();
		initSpriteSheet(sprSht);
		initPhysics();

    fsm = new FlxFSM<FlxSprite>(this, new RobotStop());
		fsm.transitions
      .add(RobotStop, RobotWake, RobotConditions.call)
      .add(RobotIdle, RobotFaint, RobotConditions.call)
      .add(RobotWake, RobotIdle, RobotConditions.animationFinished)
      .add(RobotFaint, RobotStop, RobotConditions.animationFinished)
      .add(RobotIdle, RobotWalk, RobotConditions.moving)
      .add(RobotWalk, RobotIdle, RobotConditions.stopped)
			.add(RobotJump, RobotIdle, RobotConditions.grounded)
			.add(RobotIdle, RobotJump, RobotConditions.jumping)
			.add(RobotWalk, RobotJump, RobotConditions.jumping)
			.add(RobotIdle, RobotExplode, RobotConditions.die)
			.add(RobotWalk, RobotExplode, RobotConditions.die);
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
	}

	public override function update(elapsed:Float)
  {
    updatePhysics();
    fsm.update(elapsed);
    FlxG.watch.addQuick("Current state", Type.getClassName(fsm.stateClass));
    FlxG.watch.addQuick("Moving", RobotConditions.moving(this));
    FlxG.watch.addQuick("Stopped", RobotConditions.stopped(this));
    FlxG.watch.addQuick("Grounded", RobotConditions.grounded(this));
    FlxG.watch.addQuick("Jumping", RobotConditions.jumping(this));
    FlxG.watch.addQuick("Falling", RobotConditions.falling(this));
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

class RobotConditions
{
  public static function call(Owner:FlxSprite):Bool
  {
    return FlxG.keys.justPressed.SHIFT;
  }

  public static function die(Owner:FlxSprite):Bool
  {
    return FlxG.keys.justPressed.CONTROL;
  }

	public static function jumping(Owner:FlxSprite):Bool
	{
		return Owner.velocity.y < 0;
	}

	public static function falling(Owner:FlxSprite):Bool
	{
		return Owner.velocity.y > 0;
	}
	
	public static function stopped(Owner:FlxSprite):Bool
	{
		return (grounded(Owner) && (Owner.velocity.x == 0));
	}
	
	public static function moving(Owner:FlxSprite):Bool
	{
		return (grounded(Owner) && (Owner.velocity.x != 0));
	}
	
	public static function grounded(Owner:FlxSprite):Bool
	{
		return Owner.isTouching(FlxObject.DOWN);
	}
	
	public static function animationFinished(Owner:FlxSprite):Bool
	{
		return Owner.animation.finished;
	}
}


class RobotIdle extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("idling");
	}
}

class RobotWalk extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("walking");
	}
	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.facing = FlxG.keys.pressed.LEFT ? FlxObject.LEFT : FlxObject.RIGHT;
	}
}

class RobotJump extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("jumping");
	}

}

class RobotStop extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
	}
	override public function exit(owner:FlxSprite):Void 
	{
	} 
}

class RobotWake extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("waking");
	}
}

class RobotFaint extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("fainting");
	}
}

class RobotExplode extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("exploding");
	}
}
