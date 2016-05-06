package; 

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	public var robots:FlxGroup;
	public var map:FlxGroup;

	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		// ONLY ON TEST
		FlxG.debugger.visible = true;
		bgColor = 0xffaaaaaa;

		robots = new FlxGroup();
		robots.add(new DebugRobot());
		for(robot in robots) { add(robot); }
		map = new FlxGroup();
		map.add(new FlxObject(0, 416, 300, 184));
		map.add(new FlxObject(352.25, 416, 208, 184));
		map.add(new FlxObject(560.25, 379, 115, 221));
		map.add(new FlxObject(675.25, 357, 46, 243));
		map.add(new FlxObject(777, 370,247, 230));
		// map.add(new FlxObject(0, FlxG.height - 100, FlxG.width, 10000));
		map.add(new FlxObject(-10, -200, 10, 1000));
		map.add(new FlxObject(FlxG.width, -200, 10, 1000));
		for(elt in map) { cast(elt, FlxObject).immovable = true; add(elt); }
	}

	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		update_robots(elapsed);
	}

	public function update_robots(elapsed:Float):Void {
		for(robot in robots) {
			robot.update(elapsed);
			FlxG.collide(map, robot, FlxObject.separate);
		}
	}

}