package sacrifice.entities
{
	import org.flixel.FlxG;
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
			
			originalOffset = new FlxPoint;
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		protected var attackCooldown:Number = 0;
		
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
		public var originalOffset:FlxPoint;
		public var flying:Boolean;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------

		override public function update():void
		{
			if (attackCooldown > 0) {
				attackCooldown -= FlxG.elapsed * 6;
				play("attack");
			} else if (0 != velocity.y) {
				play("jump");
			} else if (0 != velocity.x) {
				play("walk");
			} else {
				play("idle");
			}
			
			if (RIGHT == facing) {
				offset.x = originalOffset.x;
			} else {
				offset.x = frameWidth - originalOffset.x - width;
			}
			
			super.update();
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		public function create():void
		{
			originalOffset.copyTo(offset);
			updateMetrics();
		}
		
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