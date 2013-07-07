package sacrifice.hud
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	import sacrifice.managers.AssetManager;
	
	public class SpellIcon extends FlxSprite
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function SpellIcon(x:Number, y:Number, asset:String)
		{
			super(x, y, AssetManager.getClass(asset));
		}
	}
}