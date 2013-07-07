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
			var i:uint;
			
			add(new FlxSprite(0, 104, AssetManager.getClass("HUD")));
			
			add(iconBolt = new SpellIcon(3, 106, "IconBolt"));
			add(iconFireCone = new SpellIcon(22, 106, "IconFireCone"));
			add(iconMeteorites = new SpellIcon(41, 106, "IconMeteorites"));
			
			hearts = new FlxSprite(58, 108);
			hearts.loadGraphic(AssetManager.getClass("HUDHearts"), true, false, 50, 8);
			
			for (i = 0; i <= 5; ++i) {
				hearts.addAnimation("heart" + (5 - i), [i]);
			}

			hearts.play("heart5");
			add(hearts);
			
			mana = new FlxSprite(115, 108);
			mana.loadGraphic(AssetManager.getClass("HUDMana"), true, false, 37, 8);
			
			for (i = 0; i <= 5; ++i) {
				mana.addAnimation("mana" + (5 - i), [i]);
			}

			mana.play("mana5");
			add(mana);
			
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
		private var mana:FlxSprite;
		
		public function setPlayerHealth(value:uint):void
		{
			hearts.play("heart" + value);
		}
		
		public function setPlayerMana(value:uint):void
		{
			mana.play("mana" + value);
		}
	}
}