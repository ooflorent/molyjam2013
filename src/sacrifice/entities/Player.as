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
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var attackCooldown:Number = 0;
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
			maxVelocity.x = 8 * (2 + speed);
			maxVelocity.y = 200;
			
			drag.x = maxVelocity.x * 8;
			
			acceleration.x = 0;
			acceleration.y = 700;
			
			if (FlxG.keys.LEFT) {
				facing = LEFT;
				acceleration.x -= drag.x;
			} else if (FlxG.keys.RIGHT) {
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			
			if (LEFT == facing) {
				offset.x = 9;
			} else {
				offset.x = 1;
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
			
			if (attackCooldown > 0) {
				attackCooldown -= FlxG.elapsed * 6;
			} else {
				if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C") || FlxG.keys.justPressed("V")) {
					getMidpoint(_point);
					Bullet(bullets.recycle(Bullet)).shoot(_point, facing);
					attackCooldown = 1;
				}
			}
			
			if (attackCooldown > 0) {
				play("attack");
			} else if (0 != velocity.y) {
				play("jump");
			} else if (0 != velocity.x) {
				play("walk");
			} else {
				play("idle");
			}
			
			super.update();
		}
	}
}