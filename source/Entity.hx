package;

import flixel.FlxSprite;

class Entity {
	public static inline var GRID_SQUARE = 32.0;

	public var sprite		: FlxSprite;
	
	public var cx			: Int;
	public var cy			: Int;
	public var xr			: Float;
	public var yr			: Float;
	
	public var dx			: Float;
	public var dy			: Float;
	public var xx			: Float;
	public var yy			: Float;
	
	public function new():Void {
		cx = 0;
		cy = 0;
		xr = yr = 0.5;
		dx = dy = 0;
		
		sprite = new FlxSprite();
		sprite.loadGraphic("assets/sprites/coin.png");
	}
	
	public function setCoordinates(x,y):Void {
		xx = x;
		yy = y;
		cx = Std.int(xx/GRID_SQUARE);
		cy = Std.int(yy/GRID_SQUARE);
		xr = (xx-cx*GRID_SQUARE) / GRID_SQUARE;
		yr = (yy-cy*GRID_SQUARE) / GRID_SQUARE;
	}
	
	
	public function hasCollision(cx,cy, rects:Array<Array<Int>>):Bool {
		return collide_with_border(cx, cy) || collide_with_map(cx, cy, rects);
	}

	public function collide_with_border(cx, cy):Bool {
		return cx<0 || cx>=32 || cy>18;
	}
	
	public function collide_with_map(cx, cy, rects:Array<Array<Int>>):Bool { 
		for(rect in rects) {
			var x1 = rect[0]/GRID_SQUARE;
			var x2 = rect[0]/GRID_SQUARE + rect[2]/GRID_SQUARE;
			var y1 = rect[1]/GRID_SQUARE;
			var y2 = rect[1]/GRID_SQUARE + rect[3]/GRID_SQUARE;
			if(cx > x1 && cx < x2 && cy > y1 && cy < y2) { return true; }
		}
		return false;
	}

	public function onGround():Bool {
		return hasCollision(cx,cy+1, []) && yr>=0.5;
	}
	
	public function update(rects):Void {
		var frictX = 0.92;
		var frictY = 0.94;
		var gravity = 0.04;
		
		// X component
		xr+=dx;
		dx*=frictX;
		if( hasCollision(cx-1,cy, rects) && xr<=0.3 ) {
			dx = 0;
			xr = 0.3;
		}
		if( hasCollision(cx+1,cy, rects) && xr>=0.7 ) {
			dx = 0;
			xr = 0.7;
		}
		while( xr<0 ) {
			cx--;
			xr++;
		}
		while( xr>1 ) {
			cx++;
			xr--;
		}
		
		// Y component
		dy+=gravity;
		yr+=dy;
		dy*=frictY;
		if( hasCollision(cx,cy-1, rects) && yr<=0.4 ) {
			dy = 0;
			yr = 0.4;
		}
		if( hasCollision(cx,cy+1, rects) && yr>=0.5 ) {
			dy  = 0;
			yr = 0.5;
		}
		while( yr<0 ) {
			cy--;
			yr++;
		}
		while( yr>1 ) {
			cy++;
			yr--;
		}
			
			
		xx = Std.int((cx+xr)*GRID_SQUARE);
		yy = Std.int((cy+yr)*GRID_SQUARE);
		sprite.x = xx;
		sprite.y = yy;
	}
	
}
