package sacrifice.entities
{
	import flash.utils.getTimer;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Entity extends FlxSprite
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Entity(x:Number = 0, y:Number = 0)
		{
			super(x, y);
			
			addAnimation("idle", [0, 1], 10, true);
			addAnimation("walk", [2, 3], 10, true);
			addAnimation("jump", [4, 5], 20, true);
			addAnimation("attack", [6, 7], 20, true);
			play("idle");
			
			weaponOffset = new FlxPoint;
			originalWeaponOffset = new FlxPoint;
			originalOffset = new FlxPoint;
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		protected var fireDuration:uint = 0;
		protected var fireTimer:uint;
		protected var invincibleDuration:uint = 200;
		protected var invincibleTimer:uint;
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		private var _maxHealth:int;
		
		public function get maxHealth():int
		{
			return _maxHealth;
		}
		
		public function set maxHealth(value:int):void
		{
			_maxHealth = value;
			health = Math.min(health, value);
		}
		
		private var _maxMana:int;
		
		public function get maxMana():int
		{
			return _maxMana;
		}
		
		public function set maxMana(value:int):void
		{
			_maxMana = value;
			mana = Math.min(mana, value);
		}
		
		public var mana:int;
		public var magic:int;
		public var willpower:int;
		public var attack:int;
		public var speed:int;
		public var perception:int;
		public var flying:Boolean;
		public var weaponOffset:FlxPoint;
		public var originalOffset:FlxPoint;
		public var originalWeaponOffset:FlxPoint;
		public var gibs:FlxEmitter;
		public var invincible:Boolean;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------

		override public function update():void
		{
			if (RIGHT == facing) {
				offset.x = originalOffset.x;
				weaponOffset.x = originalWeaponOffset.x;
			} else {
				offset.x = frameWidth - originalOffset.x - width;
				weaponOffset.x = -originalWeaponOffset.x;
			}
			
			super.update();
			
			if (getTimer() < fireTimer) {
				play("attack");
			} else if (touching == FLOOR) {
				if (0 != velocity.x) {
					play("walk");
				} else {
					play("idle");
				}
			} else {
				play("jump");
			}
		}
		
		override public function hurt(damage:Number):void
		{
			if (!invincible && getTimer() > invincibleTimer) {
				invincibleTimer = getTimer() + invincibleDuration;
				onHurt();
				
				super.hurt(damage);
			}
		}
		
		override public function kill():void
		{
			gibs.at(this);
			gibs.start(true, 0.3, 0, width + height);
			
			super.kill();
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		public function create():void
		{
			originalOffset.copyTo(offset);
			originalWeaponOffset.copyTo(weaponOffset);
		}
		
		protected function onHurt():void {}
		
		protected function updateMetrics():void
		{
			maxVelocity.x = 8 * (2 + speed);
			maxVelocity.y = 200;

			drag.x = maxVelocity.x * 8;
			
			acceleration.x = 0;
			acceleration.y = 700;
		}
	}
}