package sacrifice.entities
{
	import flash.utils.getTimer;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
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
			
			if (FlxG.getPlugin(FlxControl) == null) {
				FlxG.addPlugin(new FlxControl);
			}
			
			facing = RIGHT;
			invincibleDrag = 5;
			
			bolt = new FlxWeapon("bolt", this);
			bolt.makePixelBullet(20);
			bolt.setPreFireCallback(bulletDirectionCallback(bolt));
			bolt.setFireRate(1);
			
			fireCone = new FlxWeapon("fireCone", this);
			fireCone.setPreFireCallback(bulletDirectionCallback(fireCone));
			
			meteorites = new FlxWeapon("meteorites", this);
			meteorites.setPreFireCallback(bulletDirectionCallback(meteorites));
			
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			FlxControl.player1.setCursorControl(false, false, true, true);
			FlxControl.player1.setJumpButton("UP", FlxControlHandler.KEYMODE_PRESSED, 200, FLOOR, 250, 200);
			FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
			FlxControl.player1.setGravity(0, 700);
			FlxControl.player1.setFireButton("X", FlxControlHandler.KEYMODE_JUST_DOWN, fireDuration, bolt.fire)
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

		//----------------------------------
		//  Weapons
		//----------------------------------
		
		public var bolt:FlxWeapon;
		public var fireCone:FlxWeapon;
		public var meteorites:FlxWeapon;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------

		override public function update():void
		{
			super.update();
			/*
			updateMetrics();
			super.update();

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
			*/
		}
		
		override protected function onHurt():void
		{
			FlxG.camera.shake(0.005, 0.25);
			FlxG.camera.flash(0x77700000, 0.07);
		}
		
		private function bulletDirectionCallback(weapon:FlxWeapon):Function
		{
			return function():void {
				fireTime = getTimer() + fireDuration;
				weapon.setBulletDirection(LEFT == facing ? FlxWeapon.BULLET_LEFT : FlxWeapon.BULLET_RIGHT, 200);
			}
		}
	}
}