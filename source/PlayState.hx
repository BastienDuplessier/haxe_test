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

		var shape = new FlxSprite();
		shape.makeGraphic(100, 20, 0x11aa1ff);
		shape.x = 10;
		shape.y = 400;
		add(shape);
		// Load hero
		hero = new Entity();
		add(hero.sprite);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		var speed = 2;
		var rects = [[10.0, 400.0, 100.0, 20.0]];

		
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