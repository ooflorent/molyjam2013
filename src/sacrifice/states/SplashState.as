package sacrifice.states
{
	import flash.utils.getTimer;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import sacrifice.hud.TextTitle;
	
	public class SplashState extends FlxState
	{
		private var delay:uint = 10000;
		private var endTime:uint;

		override public function create():void
		{
			FlxG.flash(0xFF000000, 0.4);
			
			var quote:FlxText = new FlxText(0, 6, 160, "This time I'm going to make it really tough to be good.\nTruly being good is all about sacrifice.\nHow much are you going to sacrifice to do good?");
			quote.setFormat("AESystematicTT", 12, 0xF3F3F3, "left");
			add(quote);
			
			var sign:FlxText = new FlxText(0, 98, 150, "- Peter Molyneux");
			sign.setFormat("AESystematicTT", 12, 0xF3F3F3, "right");
			add(sign);
			
			endTime = getTimer() + delay;
		}
		
		override public function update():void
		{
			if (getTimer() >= endTime || FlxG.keys.any()) {
				FlxG.fade(0xFF000000, 1, onFadeCompleted);
			}
			
			super.update();
		}
		
		public function onFadeCompleted():void
		{
			FlxG.switchState(new MenuState());
		}
	}
}