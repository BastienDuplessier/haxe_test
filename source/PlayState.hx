package; 

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{

	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		bgColor = 0xffaaaaaa;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}

}