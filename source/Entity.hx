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
		sprite.makeGraphic(25, 38, 0xffaa1111);
	}
	
	public function setCoordinates(x,y):Void {
		cx = Std.int(x);
		cy = Std.int(y);
	}
	
	
	public function hasCollision(cx,cy, rects:Array<Array<Float>>):Bool {
		return collide_with_border(cx, cy) || collide_with_map(cx, cy, rects);
	}

	public function collide_with_border(cx, cy):Bool {
		return cx<0 || cx>=1024 || cy>=600;
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
		return hasCollision(cx,cy+Std.int(height)+1, []);
	}

	public function adjust_position_x(cx, cy, xx, rects):Int {
		var ix = xx;
		while(hasCollision(ix, cy, rects) || cx == ix) {
			if(cx > xx) {ix--;} else {ix++;}
		}
		return Std.int(ix); 
	}

	public function adjust_position_y(cx, cy, yy, rects):Int {
		var iy = yy;
		while(hasCollision(cx, iy, rects) || cy == iy) {
			if(cy < yy) {iy--;} else {iy++;}
		}
		return Std.int(iy); 
	}
	
	public function update(rects):Void {
		var frictX = 0.92;
		var frictY = 0.94;
		var gravity = 0.4;
		// X component
		dx*=frictX;
		xx = cx + Math.floor(dx);
		// Left colliding ?
		// if(hasCollision(xx, cy, rects)) {
		// 	yy = 0;
		// 	dy = 0;
		// }
		// // Bottom colliding ?
		// if(hasCollision(cx, Math.floor(yy + height), rects)) {
		// 	yy = 600 - height;
		// 	dy = 0;
		// }

		// Y component
		dy+=gravity;
		dy*=frictY;
		yy = cy + Math.floor(dy);
		// Top colliding ?
		if(hasCollision(cx, Math.floor(yy), rects)) {
			dy = gravity;
			yy = adjust_position_y(cx, cy, Math.floor(yy), rects);
		}
		// Bottom colliding ?
		if(hasCollision(cx, Math.floor(yy + height), rects)) {
			dy = gravity;
			yy = adjust_position_y(cx, cy, Math.floor(yy + height), rects) - height;
		}

		sprite.x = xx;
		sprite.y = yy;
		cx = Math.round(xx);
		cy = Math.round(yy);
	}
}
