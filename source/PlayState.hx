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
	  super.update(elapsed);
    FlxG.overlap(map, robots, FlxObject.separate);
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
	  // map.add(new MapElement(0, 416, 300, 184));
	  // map.add(new MapElement(352.25, 416, 208, 184));
	  // map.add(new MapElement(560.25, 379, 115, 221));
	  // map.add(new MapElement(675.25, 357, 46, 243));
	  // map.add(new MapElement(777, 370,247, 230));
	  map.add(new MapElement(0, FlxG.height - 100, FlxG.width, 10000));
	  map.add(new MapElement(-10, -200, 10, 1000));
	  map.add(new MapElement(FlxG.width, -200, 10, 1000));
	  for(elt in map)
    { 
      cast(elt, FlxObject).immovable = true;
    }
    add(map);
  }
}
