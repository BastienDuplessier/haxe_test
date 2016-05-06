package; 

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	public var robots:FlxTypedGroup<Robot>;
	public var map:FlxGroup;
  public static var cur_robo:DebugRobot;
  public static var cur_elt:FlxObject;

	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		// ONLY ON TEST
		FlxG.debugger.visible = true;
		bgColor = 0xffaaaaaa;

    // Create players
    createPlayers();
    // Create map physics
    createMap();
  }

  override public function update(elapsed:Float):Void 
  {
	  updateRobots(elapsed);
	  super.update(elapsed);
  }

  private function updateRobots(elapsed:Float):Void
  {
	  robots.update(elapsed);
    FlxG.overlap(map, robots, Test.separate);
  }

  private function createPlayers()
  {
		robots = new FlxTypedGroup<Robot>();
		robots.add(new DebugRobot());
    add(robots);

  }
  private function createMap()
  {
	  map = new FlxGroup();
	  map.add(new FlxObject(0, 416, 300, 184));
	  map.add(new FlxObject(352.25, 416, 208, 184));
	  map.add(new FlxObject(560.25, 379, 115, 221));
	  map.add(new FlxObject(675.25, 357, 46, 243));
	  map.add(new FlxObject(777, 370,247, 230));
	  // map.add(new FlxObject(0, FlxG.height - 100, FlxG.width, 10000));
	  map.add(new FlxObject(-10, -200, 10, 1000));
	  map.add(new FlxObject(FlxG.width, -200, 10, 1000));
	  for(elt in map)
    { 
      cast(elt, FlxObject).immovable = true;
    }
    add(map);
  }

  public static function fix_that_shit(mapElement, robot):Bool
  {
    // Fuck off
    trace("There was a problem");
    trace(mapElement);
    if(robot.isTouching(FlxObject.FLOOR))
    {
      robot.y = mapElement.y - robot.height;
    }
    return true;
  }

}