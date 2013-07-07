package sacrifice.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	import sacrifice.hud.TextTitle;
	
	public class WinState extends FlxState
	{
		override public function create():void
		{
			FlxG.flash(0xFF000000, 0.4);
			
			var title:TextTitle = new TextTitle(0, 60, 160, "YOU WIN!");
			add(title);
		}
		
		override public function update():void
		{
			if (FlxG.keys.any()) {
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