package sacrifice.entities
{
	import flash.utils.getTimer;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
	import sacrifice.managers.WeaponManager;
	
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
		
		override public function create():void
		{
			super.create();
			
			bolt = WeaponManager.createWeapon("bolt");
			bolt.setParent(this, "x", "y", weaponOffset.x, weaponOffset.y);
			bolt.setPreFireCallback(bulletDirectionCallback(bolt));
			
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

		override public function update():void
		{
			super.update();
			/*
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