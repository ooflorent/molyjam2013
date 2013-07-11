package sacrifice.entities
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	
	import sacrifice.managers.AssetManager;
	import sacrifice.managers.EntityManager;

	public class Level extends FlxGroup
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Level(backgroundData:String, foregroundData:String, mapData:String, lethalData:String, enemiesData:String)
		{
			super();
			
			background = new FlxTilemap();
			background.loadMap(backgroundData, AssetManager.getClass("TilesetBlocks"), GameModel.TILE_SIZE, GameModel.TILE_SIZE, FlxTilemap.OFF, 0, 1, 100);
			add(background);
		
			foreground = new FlxTilemap();
			foreground.loadMap(foregroundData, AssetManager.getClass("TilesetBlocks"), GameModel.TILE_SIZE, GameModel.TILE_SIZE, FlxTilemap.OFF, 0, 1, 100);
			add(foreground);
		
			map = new FlxTilemap();
			map.loadMap(mapData, AssetManager.getClass("TilesetBlocks"), GameModel.TILE_SIZE, GameModel.TILE_SIZE, FlxTilemap.OFF, 0, 7, 7);
			add(map);
		
			parseLethalZones(lethalData);
			parseEnemySpawns(enemiesData);
		}
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public var background:FlxTilemap;
		public var foreground:FlxTilemap;
		public var map:FlxTilemap;
		public var lethal:FlxGroup;
		public var enemies:FlxGroup;
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		private function parseLethalZones(data:String):void
		{
			var tmp:FlxTilemap;
			
			tmp = new FlxTilemap;
			tmp.loadMap(data, AssetManager.getClass("TilesetBlocks"));
			
			var tx:uint;
			var ty:uint;
			
			lethal = new FlxGroup;
			for (; ty < tmp.heightInTiles; ++ty) {
				for (; tx < tmp.widthInTiles; ++tx) {
					if (1 == tmp.getTile(tx, ty)) {
						lethal.add(createLethalBox(tx, ty));
					}
				}
			}
			
			tmp.destroy();
		}
		
		private function parseEnemySpawns(data:String):void
		{
			var tmp:FlxTilemap;
			
			tmp = new FlxTilemap;
			tmp.loadMap(data, AssetManager.getClass("TilesetBlocks"));
			
			var tx:uint;
			var ty:uint;
			var type:uint;
			
			enemies = new FlxGroup;
			for (ty = 0; ty < tmp.heightInTiles; ++ty) {
				for (tx = 0; tx < tmp.widthInTiles; ++tx) {
					if (0 != (type = tmp.getTile(tx, ty))) {
						enemies.add(createEnemy(tx, ty, type));
					}
				}
			}
			
			tmp.destroy();
		}
		
		private function createLethalBox(tx:uint, ty:uint):FlxObject
		{
			return new FlxObject(tx * GameModel.TILE_SIZE, ty * GameModel.TILE_SIZE, GameModel.TILE_SIZE, GameModel.TILE_SIZE);
		}
		
		private function createEnemy(tx:uint, ty:uint, type:uint):Enemy
		{
			var enemy:Enemy;
			var enemyType:String;
			
			switch (type) {
				case 1:
					enemyType = "skeleton";
					break;
				
				default:
				case 2:
					enemyType = "ghost";
					break;
			}
			
			enemy = EntityManager.createEnemy(enemyType);
			enemy.x = tx * GameModel.TILE_SIZE;
			enemy.y = ty * GameModel.TILE_SIZE;
			enemy.map = map;
			
			return enemy;
		}
	}
}