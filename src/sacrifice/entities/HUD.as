package sacrifice.entities
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	import sacrifice.managers.AssetManager;
	
	public class HUD extends FlxGroup
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function HUD()
		{
			super();
			
			add(new FlxSprite(0, 104, AssetManager.getClass("HUD")));
			
			setAll("scrollFactor", new FlxPoint(0, 0));
			setAll("cameras", [FlxG.camera]);
		}
	}
}