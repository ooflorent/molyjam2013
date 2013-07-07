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
		
		public static const MAP_WIDTH:uint = 20;
		public static const MAP_HEIGHT:uint = 15;
		
		[Embed("../assets/maps/01.xml", mimeType="application/octet-stream")]
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
					maps.push(parseMap(map));
				}
			}
		}
		
		private static function parseMap(xml:XML):Object
		{
			xml = new XML(new LevelManager[xml.@name]);
			
			var layers:Object = {};
			var layer:XML;
			
			for each (layer in xml.layer) {
				layers[layer.@name] = layer;
			}

			return layers;
		}
		
		public static function getMap(index:uint):Level
		{
			var data:Object = maps[index % maps.length];
			return new Level(
				data.background,
				data.foreground,
				data.blocks,
				data.lethal
			);
		}
		
		public static function getRandomMap():Level
		{
			return getMap(Math.round(Math.random() * (maps.length - 1)));
		}
	}
}