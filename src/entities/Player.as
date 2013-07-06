package entities
{
	import components.Characteristics;
	
	import managers.AssetManager;
	import managers.DataManager;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Player(x:Number, y:Number, bullets:FlxGroup)
		{
			super(x, y);
			this.bullets = bullets;
			
			loadGraphic(AssetManager.getClass("Wizard"), true, true, 16, 8, true);
			
			addAnimation("idle", [0]);
			addAnimation("walk", [2, 3], 10, true);
			addAnimation("attack", [4]);
			addAnimation("death", [6]);
			addAnimation("jump", [8, 9], 20, true);
			
			width = 6;
			height = 8;
			
			moving = NONE;
			facing = RIGHT;
			
			play("idle");
			
			charateristics = DataManager.getCharacteristics("wizard");
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var bullets:FlxGroup;
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public var jumpCount:uint;
		public var moving:uint;
		
		public var charateristics:Characteristics;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function update():void
		{
			maxVelocity.x = 8 * (2 + charateristics.speed);
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
				if (0 == velocity.y || 4 <= charateristics.speed && 1 == jumpCount) {
					velocity.y = -maxVelocity.y;
					jumpCount++;
				}
			}
			
			if (0 != velocity.y) {
				play("jump");
			} else if (0 != velocity.x) {
				play("walk");
			} else {
				play("idle");
			}
			/*
			if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C") || FlxG.keys.justPressed("V")) {
				//getMidpoint(_point);
				//Bullet(bullets.recycle(Bullet)).shoot(_point);
				play("attack");
			}*/
			
			super.update();
		}
	}
}