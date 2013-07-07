package sacrifice.entities
{
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
				var distance:int = FlxVelocity.distanceBetween(this, chaseTarget);
				if (distance < perception * 20) {
					var angle:Number = FlxVelocity.angleBetween(this, chaseTarget);
					velocity.x = Math.cos(angle) * 45;
					if (flying) {
						velocity.y = Math.sin(angle) * 45;
					}
				}
			} else {
				velocity.x = 0;
				velocity.y = 0;
			}
			
			facing = velocity.x > 0 ? RIGHT : LEFT;
			
			super.update();
		}
	}
}