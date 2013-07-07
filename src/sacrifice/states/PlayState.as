package sacrifice.states 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	import sacrifice.entities.Entity;
	import sacrifice.entities.Gibs;
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
		private var level:Level;
		
		// Entity groups
		private var blocks:FlxGroup;
		private var lethal:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var playerBullets:FlxGroup;
		private var gibs:Gibs;
		
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
			
			gibs = new Gibs;
			enemyBullets = new FlxGroup;
			playerBullets = new FlxGroup;
			
			player = EntityManager.createPlayer("wizard");
			player.x = GameModel.TILE_SIZE * 1;
			player.y = GameModel.TILE_SIZE * 11;
			
			playerBullets.add(player.bolt.group);
			playerBullets.add(player.fireCone.group);
			playerBullets.add(player.meteorites.group);
			
			level = LevelManager.generateLevel(5);
			
			blocks = new FlxGroup;
			blocks.add(new FlxTileblock(0, 0, level.map.width, GameModel.TILE_SIZE)); // Sky
			blocks.add(new FlxTileblock(0, 0, GameModel.TILE_SIZE, level.map.height)); // Left
			blocks.add(new FlxTileblock(level.map.width - GameModel.TILE_SIZE, 0, GameModel.TILE_SIZE, level.map.height)); // Right
			blocks.add(level.map);
			
			lethal = new FlxGroup;
			lethal.add(new FlxTileblock(0, 14 * GameModel.TILE_SIZE, level.map.width, GameModel.TILE_SIZE));
			lethal.add(level.lethal);
			
			// Camera
			FlxG.worldBounds = new FlxRect(0, 0, level.map.width, level.map.height);
			FlxG.camera.setBounds(0, 0, level.map.width, level.map.height, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			add(level.background);
			add(blocks);
			add(level.enemies);
			add(player);
			add(gibs);
			add(level.foreground);
			
			if (FlxG.visualDebug) {
				add(level.lethal);
			}
			
			add(enemyBullets);
			add(playerBullets);
			
			// Build HUD
			add(hud = new HUD);
			
			// Destructible but dangerous entities
			hazards = new FlxGroup;
			hazards.add(level.enemies);
			hazards.add(enemyBullets);
			
			// Solid entities
			objects = new FlxGroup;
			objects.add(level.enemies);
			objects.add(player);
			objects.add(enemyBullets);
			objects.add(playerBullets);
			
			// Bullets
			bullets = new FlxGroup;
			bullets.add(enemyBullets);
			bullets.add(playerBullets);
			
			level.enemies.setAll("chaseTarget", player);
			
			entities = new FlxGroup;
			entities.add(player);
			entities.add(level.enemies);
			entities.setAll("gibs", gibs);
		}
		
		private var entities:FlxGroup;
		
		override public function update():void
		{
			super.update();
			
			// Blocking collisions between entities
			FlxG.collide(entities, entities);
			FlxG.collide(blocks, objects, destroyBullet);
			
			// Script collisions
			FlxG.overlap(lethal, objects, killObject);
			FlxG.overlap(hazards, player, overlap);
			FlxG.overlap(playerBullets, hazards, overlap);
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		private function destroyBullet(block:FlxObject, object:FlxObject):void
		{
			if (object is Bullet) {
				object.kill();
			}
		}
		
		private function killObject(lethal:FlxObject, object:FlxObject):void
		{
			object.kill();
		}
		
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
			object2.kill();
		}
	}
}