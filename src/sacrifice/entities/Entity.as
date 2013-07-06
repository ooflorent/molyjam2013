package sacrifice.entities
{
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
			addAnimation("attack", [4, 5], 20, true);
			addAnimation("death", [6, 7], 10, true);
			addAnimation("jump", [8, 9], 20, true);
			play("idle");
			
			facing = RIGHT;
		}
		
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
	}
}