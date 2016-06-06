package;

import flixel.util.FlxColor;
import flixel.FlxG;

class DebugRobot extends Robot {
  public function new():Void {
    super("assets/sprites/orange.png");
    screenCenter();
    x = Std.random(FlxG.width);
  }

  public override function update(elapsed:Float) {
    // Horizontal movement
    if (FlxG.keys.anyPressed([LEFT, A])) {
      velocity.x -= maxVelocity.x / 10;
    } else if (FlxG.keys.anyPressed([RIGHT, D])) {
      velocity.x += maxVelocity.x / 10;
    } else {
      var res = velocity.x / 2;
      velocity.x = res > maxVelocity.x/200 ? res : 0;
    }
    // Vertical movement
    if (FlxG.keys.anyPressed([SPACE, UP])) {
      jump();
    }
    super.update(elapsed);
  }
}
