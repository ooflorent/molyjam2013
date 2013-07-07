package sacrifice.states 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxState;
	
	import sacrifice.entities.Bullet;
	import sacrifice.entities.Entity;
	import sacrifice.entities.Level;
	import sacrifice.entities.Player;
	import sacrifice.hud.HUD;
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
			player.x = 30;
			
			playerBullets.add(player.bolt.group);
			playerBullets.add(player.fireCone.group);
			playerBullets.add(player.meteorites.group);
			
			generateLevel(3);
			
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
			
			var enemy:Entity = EntityManager.createEnemy("skeleton");
			enemy.x = 100;
			enemies.add(enemy);
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
				if (object1.touching != FlxObject.NONE) {
					object1.kill();
				}
				
				if (object2 is Entity) {
					object1.kill();
					object2.hurt(1);
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
			var screen:uint;
			var level:Level;
			
			// Level
			for (; screen < length; ++screen) {
				level = LevelManager.getRandomMap();
				level.setAll("x", screen * FlxG.width);
				
				if (level.background) {
					background.add(level.background);
				}
				
				if (level.foreground) {
					foreground.add(level.foreground);
				}
				
				if (level.map) {
					blocks.add(level.map);
				}
				
				if (level.lethal) {
					level.lethal.addX(screen * FlxG.width);
					lethal.add(level.lethal);
				}
			}

			// Camera
			FlxG.worldBounds = new FlxRect(0, 0, length * FlxG.width, FlxG.height);
			FlxG.camera.setBounds(0, 0, length * FlxG.width, FlxG.height, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
		}
	}
}