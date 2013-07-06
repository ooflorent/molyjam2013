package states 
{
	import entities.HUD;
	import entities.Player;
	
	import managers.LevelManager;
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
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
		
		// Entity groups
		private var blocks:FlxGroup;
		private var enemies:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var lethal:FlxGroup;
		private var playerBullets:FlxGroup;
		
		// Collision groups
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
			
			blocks = new FlxGroup;
			lethal = new FlxGroup;
			enemies = new FlxGroup;
			enemyBullets = new FlxGroup;
			playerBullets = new FlxGroup;
			
			player = new Player(40, 40, playerBullets);
			
			generateLevel(3);
			
			FlxG.camera.follow(player);
			
			add(lethal);
			add(blocks);
			add(enemies);
			add(player);
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
		}
		
		override public function update():void
		{
			super.update();
			
			// Collisions
			FlxG.collide(blocks, objects);
			FlxG.overlap(lethal, objects, overlapped);
			FlxG.overlap(hazards, player, overlapped);
			FlxG.overlap(playerBullets, hazards, overlapped);
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		private function overlapped(sprite1:FlxSprite, sprite2:FlxSprite):void
		{
			
		}
		
		private function generateLevel(length:uint):void
		{
			var map:FlxTilemap;
			var screen:uint;
			
			for (; screen < length; ++screen) {
				map = LevelManager.generate();
				map.x = map.width * screen;
				blocks.add(map);
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