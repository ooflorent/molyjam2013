package sacrifice.states 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	import sacrifice.entities.Entity;
	import sacrifice.entities.Gibs;
	import sacrifice.entities.Level;
	import sacrifice.entities.Player;
	import sacrifice.hud.HUD;
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
		private var end:FlxSprite;
		
		// Layer groups
		private var level:Level;
		
		// Entity groups
		private var blocks:FlxGroup;
		private var lethal:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var playerBullets:FlxGroup;
		private var gibs:Gibs;
		private var entities:FlxGroup;
		
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
			
			level = LevelManager.generateLevel(20);
			
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
			
			end = new FlxSprite();
			end.loadGraphic(AssetManager.getClass("Shield"), true, false, 12, 12);
			end.addAnimation("normal", [0, 1, 2, 3], 20, true);
			end.play("normal");
			end.x = level.map.width - 3 * GameModel.TILE_SIZE - 4;
			end.y = player.y - 4;
			
			add(level.background);
			add(blocks);
			add(level.enemies);
			add(player);
			add(end);
			add(gibs);
			add(level.foreground);
			add(enemyBullets);
			add(playerBullets);
			
			// Build HUD
			hud = new HUD;
			hud.setPlayerHealth(player.health);
			add(hud);
			
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
		
		override public function update():void
		{
			super.update();
			
			// Blocking collisions between entities
			FlxG.collide(entities, entities);
			FlxG.collide(blocks, objects, destroyBullet);
			
			// Script collisions
			FlxG.overlap(player, end, youWin);
			FlxG.overlap(lethal, objects, killObject);
			FlxG.overlap(hazards, player, hurtObject);
			FlxG.overlap(playerBullets, hazards, hurtObject);
			
			hud.setPlayerMana(player.willpower);
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		private function youWin(player:FlxObject, end:FlxObject):void
		{
			level.enemies.setAll("chaseTarget", null);
			Player(player).invincible = true;
			
			FlxG.flash();
			FlxG.camera.shake(0.005, 2);
			FlxG.fade(0xff000000, 2, function ():void {
				FlxG.switchState(new WinState);
			});
		}
		
		private function destroyBullet(block:FlxObject, object:FlxObject):void
		{
			if (object is Bullet && object.touching) {
				object.kill();
			}
		}
		
		private function killObject(lethal:FlxObject, object:FlxObject):void
		{
			object.kill();
		}
		
		private function hurtObject(source:FlxObject, target:FlxObject):void
		{
			var damage:uint;
			if (source is Bullet) {
				source.kill();
				damage = Bullet(source).weapon.bulletDamage;
			} else if (source is Entity) {
				damage = Entity(source).attack;
			} else {
				damage = 1;
			}
			
			if (target is Bullet) {
				target.kill();
				return;
			}
			
			target.hurt(damage);
			
			if (target is Player) {
				hud.setPlayerHealth(target.health);
			}
		}
	}
}