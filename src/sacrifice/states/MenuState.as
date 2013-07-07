package sacrifice.states
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import sacrifice.hud.TextTitle;
	
	public class MenuState extends FlxState
	{
		override public function create():void
		{
			FlxG.flash(0xFF000000, 0.4);
			
			var text:FlxText;
			
			text = new TextTitle(0, 4, 160, "Sacrifice...");
			add(text);
			
			var startButton:FlxButton = new FlxButton(0, 32, "PLAY", startGame); 
			startButton.x = (FlxG.width-startButton.width)/2;
			add(startButton);
			
			var howTo:FlxButton = new FlxButton(0, 57, "HOW TO", startHelp);
			howTo.x = (FlxG.width-startButton.width)/2;
			add(howTo);

			var credits:FlxButton = new FlxButton(0, 82, "CREDITS", startCredits);
			credits.x = (FlxG.width-startButton.width)/2;
			add(credits);
			
			var moly: FlxText = new FlxText(0, 105, 160, "Molyjam 2013");
			moly.setFormat("AESystematicTT", 11, 0xFFFFFF, "right");
			add(moly);

			
			add(new FlxText(100, 130, 300, 
				"Moving: Arrow keys \n" +
				"Actions: Spacebar \n" + 
				"Inventory: X"));
			
			// Show mouse.
			FlxG.mouse.show();
		}
		private function startGame():void
		{
			FlxG.switchState(new PlayState);
		}
		private function startHelp():void
		{
			FlxG.switchState(new HelpState);
		}
		private function startCredits():void
		{
			FlxG.switchState(new CreditsState);
		}
	}
}
