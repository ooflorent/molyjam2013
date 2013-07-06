package entities
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Bullet extends FlxSprite
	{
		public function Bullet(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
		
		public function shoot(origin:FlxPoint):void
		{
			
		}
	}
}