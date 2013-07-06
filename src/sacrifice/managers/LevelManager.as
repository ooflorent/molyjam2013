package sacrifice.managers
{
	import flash.utils.describeType;
	
	import org.flixel.FlxTilemap;

	public class LevelManager
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		public static const MAP_WIDTH:uint = 20;
		public static const MAP_HEIGHT:uint = 13;
		
		[Embed("../assets/maps/01.tmx", mimeType="application/octet-stream")]
		public static const Map01:Class;
		/*
		[Embed("../assets/maps/02.tmx", mimeType="application/octet-stream")]
		public static const Map02:Class;
		*/
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
				var name:String = map.@name.toString();
				if (0 == name.indexOf("Map")) {
					maps.push(parseMap(map));
				}
			}
		}
		
		private static function parseMap(xml:XML):Level
		{
			xml = new XML(new LevelManager[xml.@name]);
			return new Level(
				parseLayer(xml.layer.(@name == "background")[0]),
				parseLayer(xml.layer.(@name == "blocks")[0]),
				parseLayer(xml.layer.(@name == "lethal")[0]),
				parseLayer(xml.layer.(@name == "foreground")[0])
			);
		}
		
		private static function parseLayer(xml:XML):String
		{
			if (!xml) {
				return null;
			}
			
			var tiles:Array = xml.data.toString().replace(/\n/g, "").split(",");
			var i:uint;
			var n:uint = tiles.length;
			
			for (; i < n; ++i) {
				if (tiles[i] != "0") {
					tiles[i] = int(tiles[i]) - 1;
				}
			}
			
			return FlxTilemap.arrayToCSV(tiles, MAP_WIDTH);
		}
		
		public static function generate():Object
		{
			var level:Level = maps[Math.round(Math.random() * (maps.length - 1))];
			var maps:Object = {};
			var map:FlxTilemap;
			
			for each (var layer:String in ["background", "blocks", "lethal", "foreground"]) {
				if (level[layer]) {
					map = maps[layer] = new FlxTilemap();
					map.loadMap(level[layer], AssetManager.getClass("TilesetBlocks"), 8, 8, FlxTilemap.OFF);
				}
			}
			
			return maps;
		}
	}
}