package managers
{
	public class AssetManager
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		[Embed("../assets/images/hud.png")]
		private static const HUD:Class;	
		
		[Embed("../assets/images/knight.png")]
		private static const Knight:Class;
		
		[Embed("../assets/images/wizard.png")]
		private static const Wizard:Class;
		
		[Embed("../assets/images/tileset-cave.png")]
		private static const TilesetCave:Class;
		
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		public static function getClass(asset:String):Class
		{
			return Class(AssetManager[asset]);
		}
	}
}