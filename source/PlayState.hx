package; 

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	public var hero:Entity;

	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		bgColor = 0xffaaaaaa;
		
		// Load hero
		hero = new Entity();
		add(hero.sprite);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		var speed = 0.9;
		var rects = [[500.0, 0.0, 50.0, 800.0]];
		
		if(FlxG.keys.anyPressed([LEFT, A]))
			hero.dx -= speed;
			
		if(FlxG.keys.anyPressed([RIGHT, D]))
			hero.dx += speed;

		if(FlxG.keys.anyPressed([W, UP, SPACE]) && hero.onGround()) {
			hero.dy = -10;
		}

		hero.update(rects);
	}

}