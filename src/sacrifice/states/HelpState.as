package sacrifice.states
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import sacrifice.hud.TextTitle;
	import sacrifice.managers.AssetManager;
	
	public class HelpState extends FlxState
	{
		public function HelpState()
		{
			var title: TextTitle = new TextTitle(0, 4, 160, "HOW TO PLAY");
			add(title);

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