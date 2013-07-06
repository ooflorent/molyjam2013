package sacrifice.entities
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	public class Player extends Entity
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Player()
		{
			super();
			facing = RIGHT;
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var jumpCount:uint;
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------

		public var bullets:FlxGroup;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function update():void
		{
			updateMetrics();
			
			if (FlxG.keys.LEFT) {
				facing = LEFT;
				acceleration.x -= drag.x;
			} else if (FlxG.keys.RIGHT) {
				facing = RIGHT;
				acceleration.x += drag.x;
			}

			if (isTouching(FLOOR)) {
				jumpCount = 0;
			}
			
			if (FlxG.keys.justPressed("UP")) {
				// Double jump available only when speed >= 4
				if (0 == velocity.y || 4 <= speed && 1 == jumpCount) {
					velocity.y = -maxVelocity.y;
					jumpCount++;
				}
			}
			
			if (0 >= attackCooldown) {
				if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C") || FlxG.keys.justPressed("V")) {
					getMidpoint(_point);
					Bullet(bullets.recycle(Bullet)).shoot(_point, facing);
					attackCooldown = 1;
				}
			}
			
			super.update();
		}
	}
}