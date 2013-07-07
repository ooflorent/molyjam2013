package sacrifice.managers
{
	import flash.utils.Dictionary;
	
	import sacrifice.entities.Enemy;
	import sacrifice.entities.Entity;
	import sacrifice.entities.Player;

	public class EntityManager
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		[Embed("../assets/data/entities.xml", mimeType="application/octet-stream")]
		private static const entitiesClass:Class;
		
		//----------------------------------------------------------------------
		//
		//  Class variables
		//
		//----------------------------------------------------------------------
		
		private static var entities:Dictionary = new Dictionary();
		
		//----------------------------------------------------------------------
		//
		//  Class methods
		//
		//----------------------------------------------------------------------
		
		public static function init():void
		{
			var entitiesXML:XML = new XML(new entitiesClass);
			var entity:XML;
			
			for each (entity in entitiesXML.entity) {
				entities[String(entity.@name)] = entity;
			}
		}
		
		public static function createPlayer(name:String):Player
		{
			return Player(configureEntity(new Player, name));
		}
		
		public static function createEnemy(name:String):Enemy
		{
			return Enemy(configureEntity(new Enemy, name));
		}
		
		private static function configureEntity(object:Entity, name:String):Entity
		{
			if (!name) {
				throw new Error("Entity name is required");
			}
			
			var entity:XML = entities[name];
			if (!entity) {
				throw new Error("Unknown entity '" + name + "'");
			}
			
			// Parse characteristics
			for each (var characteristic:XML in entity.characteristics.*) {
				object[characteristic.localName()] = int(characteristic.toString());
			}
			
			// Set derived characteristics
			object.health = object.maxHealth;
			object.mana = object.maxMana;
			
			// Parse assets
			object.loadGraphic(AssetManager.getClass(entity.asset.name), true, true, int(entity.asset.width), int(entity.asset.height));
			
			// Parse bounding box
			if (entity.bounds) {
				object.originalOffset.x = int(entity.bounds.x);
				object.originalOffset.y = int(entity.bounds.y);
				object.width = entity.bounds.width.length() ? int(entity.bounds.width) : (entity.asset.width - object.originalOffset.x);
				object.height = entity.bounds.height.length() ? int(entity.bounds.height) : (entity.asset.height - object.originalOffset.y);
			}
			
			// Parse weapon position
			if (entity.weapon) {
				object.weaponOffset.x = int(entity.weapon.x);
				object.weaponOffset.y = int(entity.weapon.y);
			}
			
			// Custom entity initialization
			object.create();
			
			return object;	
		}
	}
}