package sacrifice.states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	
	import sacrifice.entities.Bullet;
	import sacrifice.entities.HUD;
	import sacrifice.entities.Player;
	import sacrifice.managers.AssetManager;
	import sacrifice.managers.EntityManager;
	import sacrifice.managers.LevelManager;
	
	public class PlayState extends FlxState
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		// Entities
		private var hud:HUD;
		private var player:Player;
		
		// Layer groups
		private var background:FlxGroup;
		private var blocks:FlxGroup;
		private var lethal:FlxGroup;
		private var foreground:FlxGroup;
		
		// Entity groups
		private var enemies:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var playerBullets:FlxGroup;
		
		// Collision groups
		private var bullets:FlxGroup;
		private var hazards:FlxGroup;
		private var objects:FlxGroup;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function create():void
		{
			FlxG.mouse.hide();
			
			background = new FlxGroup;
			blocks = new FlxGroup;
			lethal = new FlxGroup;
			foreground = new FlxGroup;
			enemies = new FlxGroup;
			enemyBullets = new FlxGroup;
			playerBullets = new FlxGroup;
			
			player = EntityManager.createPlayer("wizard");
			player.bullets = playerBullets;
			
			generateLevel(3);
			
			FlxG.camera.follow(player);
			
			add(background);
			add(blocks);
			add(enemies);
			add(player);
			add(foreground);
			
			if (FlxG.visualDebug) {
				add(lethal);
			}
			
			add(enemyBullets);
			add(playerBullets);
			
			// Build HUD
			add(hud = new HUD);
			
			// Destructible but dangerous entities
			hazards = new FlxGroup;
			hazards.add(enemies);
			hazards.add(enemyBullets);
			
			// Solid entities
			objects = new FlxGroup;
			objects.add(enemies);
			objects.add(player);
			objects.add(enemyBullets);
			objects.add(playerBullets);
			
			// Bullets
			bullets = new FlxGroup;
			bullets.add(enemyBullets);
			bullets.add(playerBullets);
		}
		
		override public function update():void
		{
			super.update();
			
			// Collisions
			FlxG.collide(blocks, objects);
			FlxG.overlap(blocks, bullets, overlap);
			FlxG.overlap(lethal, objects, lethalOverlap);
			FlxG.overlap(hazards, player, overlap);
			FlxG.overlap(playerBullets, hazards, overlap);
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		private function overlap(object1:FlxObject, object2:FlxObject):void
		{
			if (object1 is Bullet) {
				if (object2.touching != FlxObject.NONE) {
					object2.kill();
				}
			}
			
			if (object2 is Bullet) {
				if (object2.touching != FlxObject.NONE) {
					object2.kill();
				}
			}
		}
		
		private function lethalOverlap(object1:FlxObject, object2:FlxObject):void
		{
		}
		
		private function generateLevel(length:uint):void
		{
			var maps:Object;
			var map:FlxTilemap;
			var farAway:FlxSprite;
			var layer:String;
			var screen:uint;
			var offset:uint;
			
			// Level
			for (; screen < length; ++screen) {
				farAway = new FlxSprite(0, 0, AssetManager.getClass("Background"));
				background.add(farAway);
				
				maps = LevelManager.generate();
				for (layer in maps) {
					map = maps[layer];
					map.x = map.width * screen;
					FlxGroup(this[layer]).add(map);
				}
				
				farAway.x = map.width * screen;
			}

			// Level bounds
			blocks.add(new FlxTileblock(-8, 0, 8, map.height));
			blocks.add(new FlxTileblock(map.x + map.width, 0, 8, map.height));
			blocks.add(new FlxTileblock(0, -8, map.x + map.width, 8));
			
			// Death zone
			blocks.add(lethal.add(new FlxTileblock(0, map.height, map.x + map.width, 8)));
			
			// Camera
			FlxG.camera.setBounds(-8, -8, map.x + map.width + 16, map.height + 16, true);
		}
	}
}