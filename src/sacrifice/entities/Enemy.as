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
				if (distance < perception * 10) {
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