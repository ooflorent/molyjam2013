package sacrifice.states 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxState;
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
			player.x = 30;
			
			playerBullets.add(player.bolt.group);
			playerBullets.add(player.fireCone.group);
			playerBullets.add(player.meteorites.group);
			
			level = LevelManager.generateLevel(5);
			
			// Camera
			FlxG.worldBounds = new FlxRect(0, 0, level.map.width, level.map.height);
			FlxG.camera.setBounds(0, 0, level.map.width, level.map.height, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			add(level.background);
			add(level.map);
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
			
			// Collisions
			FlxG.collide(entities, entities);
			FlxG.collide(level.map, objects);
			FlxG.overlap(level.map, bullets, overlap);
			FlxG.overlap(level.lethal, objects, lethalOverlap);
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
	}
}