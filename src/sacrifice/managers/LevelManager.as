package sacrifice.managers
{
	import flash.utils.describeType;
	
	import sacrifice.entities.Level;

	public class LevelManager
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		public static const LAYERS:Array = ["background", "foreground", "blocks", "lethal", "enemies"];
		public static const MAP_WIDTH:uint = 20;
		public static const MAP_HEIGHT:uint = 15;
		
		[Embed("../assets/maps/00.xml", mimeType="application/octet-stream")]
		public static const Map00:Class;
		
		[Embed("../assets/maps/01.xml", mimeType="application/octet-stream")]
		public static const Map01:Class;
		
		[Embed("../assets/maps/02.xml", mimeType="application/octet-stream")]
		public static const Map02:Class;
		
		[Embed("../assets/maps/03.xml", mimeType="application/octet-stream")]
		public static const Map03:Class;
		
		[Embed("../assets/maps/04.xml", mimeType="application/octet-stream")]
		public static const Map04:Class;
		
		[Embed("../assets/maps/05.xml", mimeType="application/octet-stream")]
		public static const Map05:Class;
		
		[Embed("../assets/maps/06.xml", mimeType="application/octet-stream")]
		public static const Map06:Class;
		
		[Embed("../assets/maps/07.xml", mimeType="application/octet-stream")]
		public static const Map07:Class;
		
		[Embed("../assets/maps/08.xml", mimeType="application/octet-stream")]
		public static const Map08:Class;
		
		[Embed("../assets/maps/09.xml", mimeType="application/octet-stream")]
		public static const Map09:Class;
		
		[Embed("../assets/maps/10.xml", mimeType="application/octet-stream")]
		public static const Map10:Class;
		
		[Embed("../assets/maps/11.xml", mimeType="application/octet-stream")]
		public static const Map11:Class;
		
		[Embed("../assets/maps/12.xml", mimeType="application/octet-stream")]
		public static const Map12:Class;
		
		[Embed("../assets/maps/13.xml", mimeType="application/octet-stream")]
		public static const Map13:Class;
		
		//----------------------------------------------------------------------
		//
		//  Class variables
		//
		//----------------------------------------------------------------------
		
		private static var emptyRow:String;
		private static var maps:Array;
		
		//----------------------------------------------------------------------
		//
		//  Class methods
		//
		//----------------------------------------------------------------------
		
		public static function init():void
		{
			maps = [];
			
			for each (var map:XML in describeType(LevelManager).constant) {
				var name:String = map.@name.toString();
				if (0 == name.indexOf("Map")) {
					maps.push(parseMap(name, map));
				}
			}
			
			maps.sort(function (map1:Object, map2:Object):int {
				return map1.name < map2.name ? -1 : 1;
			});
			
			for (var tx:uint; tx < MAP_WIDTH; ++tx) {
				if (0 == tx) {
					emptyRow = "0"
				} else {
					emptyRow += ",0"
				}
			}
		}
		
		private static function parseMap(name:String, xml:XML):Object
		{
			xml = new XML(new LevelManager[xml.@name]);
			
			var layer:XML;
			var map:Object = {
				name: name
			};
			
			for each (layer in xml.layer) {
				map[layer.@name] = layer.toString().split("\n");
			}

			return map;
		}
		
		public static function generateLevel(screens:uint):Level
		{
			var data:Object = {
				backgroundData: [],
				foregroundData: [],
				blocksData: [],
				lethalData: [],
				enemiesData: []
			};
			
			var screen:uint;
			var layer:String;
			var level:Object;
			var row:String;
			var ty:uint;
			
			for (screen = 0; screen < screens; ++screen) {
				if (0 == screen) {
					level = getMap(1);
				} else if (screen + 1 == screens) {
					level = getMap(0);
				} else {
					level = getRandomMap();
				}
				
				trace("Using " + level.name);
				
				for (ty = 0; ty < MAP_HEIGHT; ++ty) {
					for each (layer in LAYERS) {
						row = level[layer][ty];
						if (0 == screen) {
							data[layer + "Data"][ty] = row;
						} else {
							data[layer + "Data"][ty] += "," + row;
						}
					}
				}
			}
			
			return new Level(
				data.backgroundData.join("\n"),
				data.foregroundData.join("\n"),
				data.blocksData.join("\n"),
				data.lethalData.join("\n"),
				data.enemiesData.join("\n")
			);
		}
		
		public static function getMap(index:uint):Object
		{
			return maps[index % maps.length];
		}
		
		public static function getRandomMap():Object
		{
			return getMap(Math.round(Math.random() * (maps.length - 1)));
		}
	}
}