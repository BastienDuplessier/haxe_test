package;

import flixel.FlxSprite;

class Entity {
	public var sprite		: FlxSprite;
	
	public var cx			: Int;
	public var cy			: Int;

	public var width                : Float;
	public var height               : Float;
	
	public var dx			: Float;
	public var dy			: Float;

	public var xx			: Float;
	public var yy			: Float;
	
	public function new():Void {
		cx = cy  = 0;
		dx = dy = 0;
		width = 25;
		height = 38;
		
		sprite = new FlxSprite();
		sprite.loadGraphic("assets/sprites/coin.png");
	}
	
	public function setCoordinates(x,y):Void {
		cx = Std.int(x);
		cy = Std.int(y);
	}
	
	
	public function hasCollision(cx,cy, rects:Array<Array<Float>>):Bool {
		return collide_with_border(cx, cy) || collide_with_map(cx, cy, rects);
	}

	public function collide_with_border(cx, cy):Bool {
		return cx<0 || cx>=1024 || cy>600;
	}
	
	public function collide_with_map(cx, cy, rects:Array<Array<Float>>):Bool { 
		for(rect in rects) {
			var x1 = rect[0];
			var x2 = rect[0] + rect[2];
			var y1 = rect[1];
			var y2 = rect[1] + rect[3];
			if(cx > x1 && cx < x2 && cy > y1 && cy < y2) { return true; }
		}
		return false;
	}

	public function onGround():Bool {
		return hasCollision(cx,cy+1, []);
	}
	
	public function update(rects):Void {
		var frictX = 0.92;
		var frictY = 0.94;
		var gravity = 0.4;

		// X component
		// dx*=frictX;

		// Y component
		dy+=gravity;
		dy*=frictY;
		trace("dy");
		trace(dy);
		yy = cy + Math.floor(dy);
		trace("yy");
		trace(yy);

		// Bottom colliding ?
		if(hasCollision(cx, Math.floor(yy + height), rects)) {
			trace("yo");
			yy = 600 - height;
			dy = 0;
		}

		// sprite.x = xx;
		sprite.y = yy;
		// cx = Math.round(xx);
		cy = Math.round(yy);
	}
}
