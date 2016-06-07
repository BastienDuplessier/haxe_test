package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class MapElement extends FlxSprite
{
  public function new(_x:Int, _y:Int, w:Int, h:Int):Void
  {
    super();
    makeGraphic(w, h, FlxColor.WHITE);
    x = _x;
    y = _y;
    immovable = true;
  }
}