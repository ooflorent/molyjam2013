package managers
{
	import components.Characteristics;
	
	import flash.utils.Dictionary;

	public class DataManager
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
		
		private static var entities:Dictionary = new Dictionary;
		
		//----------------------------------------------------------------------
		//
		//  Class methods
		//
		//----------------------------------------------------------------------
		
		public static function init():void
		{
			loadEntities();
		}
		
		public static function getCharacteristics(entity:String):Characteristics
		{
			var characteristics:Characteristics = new Characteristics;
			var characteristic:XML;
			
			for each (characteristic in entities[entity].characteristics.*) {
				characteristics[characteristic.localName()] = int(characteristic.toString());
			}
			
			return characteristics;
		}
		
		private static function loadEntities():void
		{
			var entitiesXML:XML = new XML(new entitiesClass);
			var entity:XML;
			
			for each (entity in entitiesXML.entity) {
				entities[String(entity.@name)] = entity;
			}
		}
	}
}