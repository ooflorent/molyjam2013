package sacrifice.entities
{
	import flash.display.Graphics;
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
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
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public var map:FlxTilemap;
		public var chaseTarget:FlxSprite;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
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
				if (distance <= perceptionDistance && map.ray(getMidpoint(), chaseTarget.getMidpoint())) {
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
			
			if (!flying && isTouching(FLOOR)) {
				// Will the enemy fall?
				if (!overlapsAt(x + (facing == RIGHT ? 1 : -1) * width, y + 1, map)) {
					// Yes! Let's jump!
					if (0 == velocity.y) {
						velocity.y = -200;
						acceleration.y = 700;
					}
				}
			}
			
			super.update();
		}
		
		override public function drawDebug(camera:FlxCamera = null):void
		{
			if (camera == null) {
				camera = FlxG.camera;
			}
			
			super.drawDebug(camera);
			
			var centerX:Number = x - int(camera.scroll.x * scrollFactor.x);
			var centerY:Number = y - int(camera.scroll.y * scrollFactor.y);
			
			var gfx:Graphics = FlxG.flashGfx;
			
			gfx.clear();
			gfx.lineStyle(1, 0xffffffff, 0.5);
			gfx.drawCircle(centerX, centerY, perceptionDistance);
			
			camera.buffer.draw(FlxG.flashGfxSprite);
		}
	}
}