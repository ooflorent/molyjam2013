package sacrifice.states
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import sacrifice.hud.ButtonBack;
	import sacrifice.hud.TextTitle;
	import sacrifice.managers.AssetManager;
	
	public class HelpState extends FlxState
	{
		override public function create():void
		{
			FlxG.flash(0xFF000000, 0.4);
			
			var title: TextTitle = new TextTitle(0, 4, 160, "HOW TO PLAY");
			add(title);
			
			var firstLine:FlxText = new FlxText(0, 27, 160, "Use LEFT/RIGHT to move");
			firstLine.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(firstLine);
			
			var secondLine:FlxText = new FlxText(0, 40, 160, "Use UP to jump");
			secondLine.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(secondLine);

			var thirdLine:FlxText = new FlxText(0, 53, 160, "Use DOWN to block");
			thirdLine.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(thirdLine);

			var fourthLine:FlxText = new FlxText(0, 66, 160, "Use X to cast bolts");
			fourthLine.setFormat("AESystematicTT", 12, 0xFFFFFF, "left");
			add(fourthLine);
			
			var fifthLine:FlxText = new FlxText(0, 81, 160, "Sacrifice yourself!");
			fifthLine.setFormat("AESystematicTT", 12, 0xFFFFFF, "center");
			add(fifthLine);

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