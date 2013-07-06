package managers
{
	import flash.utils.describeType;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;

	public class LevelManager
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		public static const MAP_WIDTH:uint = 40;
		public static const MAP_HEIGHT:uint = 13;
		
		[Embed("../assets/maps/01.tmx", mimeType="application/octet-stream")]
		public static const Map01:Class;
		
		[Embed("../assets/maps/02.tmx", mimeType="application/octet-stream")]
		public static const Map02:Class;
		
		//----------------------------------------------------------------------
		//
		//  Class variables
		//
		//----------------------------------------------------------------------
		
		private static var maps:Vector.<Level>;
		
		//----------------------------------------------------------------------
		//
		//  Class methods
		//
		//----------------------------------------------------------------------
		
		public static function init():void
		{
			maps = new <Level>[];
			
			for each (var map:XML in describeType(LevelManager).constant) {
				if (0 == map.@name.toString().indexOf("Map")) {
					parseMap(map);
				}
			}
		}
		
		private static function parseMap(metadata:XML):void
		{
			var data:XML = new XML(new LevelManager[metadata.@name]);
			var layer:Array = data.layer.(@name == "blocks").data.toString().replace(/\s/g, '').split(",");
			
			var blocks:String = "";
			
			for (var i:uint = 0; i < MAP_HEIGHT; ++i) {
				if (0 < i) {
					blocks += "\n";
				}
				
				blocks += layer.slice(MAP_WIDTH * i, MAP_WIDTH * (i + 1)).join(",");
			}
			
			maps.push(new Level(blocks));
		}
		
		public static function generate():FlxTilemap
		{
			var level:Level = maps[Math.round(Math.random() * (maps.length - 1))];
			var map:FlxTilemap = new FlxTilemap();
			
			map.loadMap(level.blocks, AssetManager.getClass("TilesetCave"), 8, 8);
			
			return map;
		}
	}
}