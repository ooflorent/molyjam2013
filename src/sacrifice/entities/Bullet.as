package sacrifice.entities
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	import sacrifice.managers.AssetManager;
	
	public class Bullet extends FlxSprite
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Bullet()
		{
			super();
			
			loadGraphic(AssetManager.getClass("BulletProjectile"), true, true, 5, 3, true);
			addAnimation("normal", [0, 1], 5, true);
			play("normal");
			
			width = 1;
			height = 1;
			
			offset.x = 4;
			offset.y = 1;
			
			exists = false;
			speed = 150;
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var speed:int;

		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function update():void
		{
			super.update();
			
			if (exists && NONE != touching) {
				exists = false;
			}
		}

		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		public function shoot(origin:FlxPoint, aim:uint):void
		{
			reset(origin.x, origin.y);
			
			if (LEFT == aim) {
				facing = LEFT;
				velocity.x = -speed;
				offset.x = 0;
			} else {
				facing = RIGHT;
				velocity.x = speed;
				offset.x = 4;
			}
			
			exists = true;
		}
	}
}