package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	import sacrifice.managers.EntityManager;
	import sacrifice.managers.LevelManager;
	import sacrifice.managers.WeaponManager;
	import sacrifice.states.PlayState;
	import sacrifice.states.SplashState;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class Game extends FlxGame
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Game()
		{
			super(160, 120, GameModel.DEBUG ? PlayState : SplashState, 4);
			
			if (GameModel.DEBUG) {
				FlxG.visualDebug = true;
				forceDebugger = true;
			}
			
			EntityManager.init();
			LevelManager.init();
			WeaponManager.init();
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var mosaic:Bitmap;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			
			if (mosaic == null) {
				mosaic = new Bitmap(new BitmapData(640, 480));
				mosaic.blendMode = BlendMode.OVERLAY;
				mosaic.alpha = 0.2;
				
				var b:BitmapData = new BitmapData(4, 4, true, 0x808080);
				var s:Sprite = new Sprite;
				var g:Graphics = s.graphics;
				var x:uint;
				var y:uint;
				
				b.setPixel32(0, 0, 0xFFE0E0E0);
				b.setPixel32(3, 3, 0xFF000000);
				
				for (x = 1; x < 4; ++x) {
					b.setPixel32(x, 0, 0xFFE0E0E0);
					b.setPixel32(x, 1, 0xFFFFFFFF);
					b.setPixel32(x, 3, 0xFF000000);
				}
				
				for (y = 1; y < 4; ++y) {
					b.setPixel32(0, y, 0xFFFFFFFF);
					b.setPixel32(3, y, 0xFF000000);
				}
				
				g.beginBitmapFill(b);
				g.drawRect(0, 0, 640, 480);
				g.endFill();
				
				mosaic.bitmapData.draw(s);
				addChild(mosaic);
			} else {
				setChildIndex(mosaic, numChildren -1);
			}
			
			return child;
		}
	}
}