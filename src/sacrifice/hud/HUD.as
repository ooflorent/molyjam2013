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
			
			hearts = new FlxSprite(58, 108);
			hearts.loadGraphic(AssetManager.getClass("HUDHearts"), true, false, 50, 8);
			
			for (var heart:uint = 0; heart <= 5; ++heart) {
				hearts.addAnimation("heart" + (5 - heart), [heart]);
			}

			hearts.play("heart5");
			add(hearts);
			
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
		private var hearts:FlxSprite;
		
		public function setPlayerHealth(health:uint):void
		{
			hearts.play("heart" + health);
		}
	}
}