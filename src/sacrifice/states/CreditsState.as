package sacrifice.states
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	
	import sacrifice.hud.Button;
	import sacrifice.hud.TextTitle;
	import sacrifice.managers.AssetManager;
	
	public class CreditsState extends FlxState
	{
		public function CreditsState()
		{
			var title:TextTitle = new TextTitle(0, 4, 160, "CREDITS");
			add(title);
			
			var florent:FlxText = new FlxText(0, 30, 160, "Florent CAILHOL");
			florent.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(florent);
			
			var floText:FlxText = new FlxText(0, 44, 160, "Concept - Code Wizardry");
			floText.setFormat("AESystematicTT", 12, 0xFFFFFF, "center");
			add(floText);
			
			var julien:FlxText = new FlxText(0, 64, 160, "Julien LE CADRE");
			julien.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(julien);
			
			var julText:FlxText = new FlxText(0, 79, 160, "Game Design - Pixel War");
			julText.setFormat("AESystematicTT", 12, 0xFFFFFF, "center");
			add(julText);
			
			var back:FlxButton = new FlxButton(0, 100, "BACK", startMenu);
			back.loadGraphic(AssetManager.getClass("SmallButton"), false, false, 60, 15);
			back.labelOffset.y = 1;
			back.x = (FlxG.width-title.width)/2;
			add(back);
		}
		private function startMenu():void
		{
			FlxG.switchState(new MenuState);
		}
	}
}