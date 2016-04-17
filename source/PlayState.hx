package; 

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	public var players:FlxGroup;
	public var map:FlxGroup;

	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		// ONLY ON TEST
		FlxG.debugger.visible = true;

		bgColor = 0xffaaaaaa;

		players = new FlxGroup();
		players.add(new DebugPlayer());
		for(player in players) { add(player); }
		map = new FlxGroup();
		map.add(new FlxObject(0, 416, 300, 184));
		map.add(new FlxObject(352.25, 416, 208, 184));
		map.add(new FlxObject(560.25, 379, 115, 221));
		map.add(new FlxObject(675.25, 357, 46, 243));
		map.add(new FlxObject(777, 370,247, 230));
		for(elt in map) { cast(elt, FlxObject).immovable = true; add(elt); }
	}

	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		update_players(elapsed);
	}

	public function update_players(elapsed:Float):Void {
		for(player in players) {
			player.update(elapsed);
			FlxG.collide(map, player, FlxObject.separate);
		}
	}

}