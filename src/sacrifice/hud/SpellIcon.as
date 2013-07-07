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
			super(x, y);
			
			loadGraphic(AssetManager.getClass(asset), true, false, 12, 12);
			addAnimation("normal", [0]);
			addAnimation("disabled", [1]);
			play("normal");
		}
	}
}