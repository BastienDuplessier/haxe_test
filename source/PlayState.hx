package; 

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;

class PlayState extends FlxState
{
	public var players:Array<Player>;
	public var map:Array<FlxObject>;

	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		// ONLY ON TEST
		FlxG.debugger.visible = true;

		bgColor = 0xffaaaaaa;

		players = new Array<Player>();
		players.push(new DebugPlayer());
		for(player in players) { add(player); }
		map = new Array<FlxObject>();
		var ground = new FlxObject(0, 500, 1024, 100);
		map.push(ground);
		add(ground);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}

}