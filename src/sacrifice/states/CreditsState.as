package sacrifice.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import sacrifice.hud.ButtonBack;
	import sacrifice.hud.TextTitle;
	
	public class CreditsState extends FlxState
	{
		override public function create():void
		{
			FlxG.flash(0xFF000000, 0.4);
			
			var title:TextTitle = new TextTitle(0, 4, 160, "CREDITS");
			add(title);
			
			var florent:FlxText = new FlxText(0, 30, 160, "Florent CAILHOL");
			florent.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(florent);
			
			var floText:FlxText = new FlxText(0, 43, 160, "Concept - Code Wizardry");
			floText.setFormat("AESystematicTT", 12, 0xFFFFFF, "center");
			add(floText);
			
			var julien:FlxText = new FlxText(0, 64, 160, "Julien LE CADRE");
			julien.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(julien);
			
			var julText:FlxText = new FlxText(0, 78, 160, "Game Design - Pixel War");
			julText.setFormat("AESystematicTT", 12, 0xFFFFFF, "center");
			add(julText);
			
			var back:ButtonBack = new ButtonBack(0, 100, startMenu);
			back.x = (FlxG.width-back.width)/2;
			add(back);
		}
		private function startMenu():void
		{
			FlxG.switchState(new MenuState);
		}
	}
}