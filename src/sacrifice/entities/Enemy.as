package sacrifice.entities
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	
	public class Enemy extends Entity
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Enemy()
		{
			super();
			facing = 0 == Math.round(Math.random()) ? LEFT : RIGHT;
		}
		
		public var map:FlxTilemap;
		public var chaseTarget:FlxSprite;
		
		override public function create():void
		{
			if (!flying) {
				acceleration.y = 700;
			}
		}
		
		override public function update():void
		{
			if (chaseTarget) {
				/*if (!path) {
					followPath(map.findPath(new FlxPoint(x, y), new FlxPoint(chaseTarget.x, chaseTarget.y)));
				}*/
				
				var angle:Number = FlxVelocity.angleBetween(this, chaseTarget);
				
				velocity.x = Math.cos(angle) * 60;
				
				if (flying) {
					velocity.y = Math.sin(angle) * 60;
				}
			}
			
			facing = velocity.x > 0 ? RIGHT : LEFT;
			
			super.update();
		}
	}
}