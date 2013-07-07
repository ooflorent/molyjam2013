package sacrifice.hud
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
			
			add(iconBolt = new SpellIcon(3, 106, "IconBolt"));
			add(iconFireCone = new SpellIcon(22, 106, "IconFireCone"));
			add(iconMeteorites = new SpellIcon(41, 106, "IconMeteorites"));
			
			setAll("scrollFactor", new FlxPoint(0, 0));
			setAll("cameras", [FlxG.camera]);
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var iconBolt:SpellIcon;
		private var iconFireCone:SpellIcon;
		private var iconMeteorites:SpellIcon;
	}
}