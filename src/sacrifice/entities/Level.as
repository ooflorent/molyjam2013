package sacrifice.entities
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxLinkedGroup;
	
	import sacrifice.managers.AssetManager;

	public class Level extends FlxGroup
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Level(backgroundData:String, foregroundData:String, mapData:String, lethalData:String)
		{
			super();
			
			if (backgroundData) {
				background = new FlxTilemap();
				background.loadMap(backgroundData, AssetManager.getClass("TilesetBlocks"), 8, 8, FlxTilemap.OFF);
				add(background);
			}
			
			if (foregroundData) {
				foreground = new FlxTilemap();
				foreground.loadMap(foregroundData, AssetManager.getClass("TilesetBlocks"), 8, 8, FlxTilemap.OFF);
				add(foreground);
			}
			
			if (lethalData) {
				map = new FlxTilemap();
				map.loadMap(mapData, AssetManager.getClass("TilesetBlocks"), 8, 8, FlxTilemap.OFF);
				add(map);
			}
			
			if (lethalData) {
				parseLethalZones(lethalData);
			}
		}
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public var background:FlxTilemap;
		public var foreground:FlxTilemap;
		public var map:FlxTilemap;
		public var lethal:FlxLinkedGroup;
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		private function parseLethalZones(data:String):void
		{
			lethal = new FlxLinkedGroup;
			
			var map:FlxTilemap = new FlxTilemap;
			map.loadMap(data, AssetManager.getClass("TilesetBlocks"));
			
			var tx:uint;
			var ty:uint;
			
			for (; ty < map.heightInTiles; ++ty) {
				for (; tx < map.widthInTiles; ++tx) {
					if (1 == map.getTile(tx, ty)) {
						lethal.add(createLethalBox(tx, ty));
					}
				}
			}
		}
		
		private function createLethalBox(x:uint, y:uint):FlxObject
		{
			var size:uint = GameModel.TILE_SIZE;
			var box:FlxObject = new FlxObject(x * size, y * size, size, size);
			
			box.solid = true;
			return box;
		}
	}
}