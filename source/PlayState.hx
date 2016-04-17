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
		var speed = 0.04;
		var rects = [[500, 0, 50, 800]];
		
		if(FlxG.keys.anyPressed([LEFT, A]))
			hero.dx -= speed;
			
		if(FlxG.keys.anyPressed([RIGHT, D]))
			hero.dx += speed;

		if(FlxG.keys.anyPressed([W, UP, SPACE]) && hero.onGround())
			hero.dy = -1;
			
		hero.update(rects);
		// player.acceleration.x = 0;
		// if (FlxG.keys.anyPressed([LEFT, A]))
		// {
		// 	player.acceleration.x -= player.maxVelocity.x * 4;
		// 	logo.x -= 2;
		// }
		// if (FlxG.keys.anyPressed([RIGHT, D]))
		// {
		// 	player.acceleration.x += player.maxVelocity.x * 4;
		// 	logo.x += 2;
		// }
		// if (FlxG.keys.anyPressed([W, UP, SPACE]) && player.isTouching(FlxObject.FLOOR))
		// {
		// 	player.velocity.y = -player.maxVelocity / 2;
		// }
		// super.update(elapsed);
	}

}