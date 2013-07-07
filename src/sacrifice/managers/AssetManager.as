package sacrifice.managers
{
	public class AssetManager
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		//----------------------------------
		//  HUD
		//----------------------------------
		
		[Embed("../assets/fonts/aesymatt.ttf", fontName="AESystematicTT", embedAsCFF=false)]
		private static const Font:Class;	
		
		[Embed("../assets/images/hud.png")]
		private static const HUD:Class;	
		
		[Embed("../assets/images/icons/bolt.png")]
		private static const IconBolt:Class;	
		
		[Embed("../assets/images/icons/firecone.png")]
		private static const IconFireCone:Class;	
		
		[Embed("../assets/images/icons/meteorites.png")]
		private static const IconMeteorites:Class;	
		
		//----------------------------------
		//  Entities
		//----------------------------------
		
		[Embed("../assets/images/fly.png")]
		private static const Fly:Class;
		
		[Embed("../assets/images/knight.png")]
		private static const Knight:Class;
		
		[Embed("../assets/images/snake.png")]
		private static const Snake:Class;
		
		[Embed("../assets/images/skeleton.png")]
		private static const Skeleton:Class;
		
		[Embed("../assets/images/wizard.png")]
		private static const Wizard:Class;
		
		//----------------------------------
		//  World
		//----------------------------------
		
		[Embed("../assets/images/background.png")]
		private static const Background:Class;
		
		[Embed("../assets/images/tilesets/blocks.png")]
		private static const TilesetBlocks:Class;
		
		[Embed("../assets/images/bullets/projectile.png")]
		private static const BulletProjectile:Class;
		
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		public static function getClass(asset:String):Class
		{
			if (!asset) {
				throw new Error("Asset name is required");
			}
			
			var assetClass:Class = Class(AssetManager[asset]);
			if (!assetClass) {
				throw new Error("Uknown asset '" + asset + "'");
			}
			
			return assetClass;
		}
	}
}