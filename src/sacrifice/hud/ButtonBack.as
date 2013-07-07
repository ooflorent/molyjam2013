package sacrifice.hud
{
	import org.flixel.FlxButton;
	
	import sacrifice.managers.AssetManager;
	
	public class ButtonBack extends FlxButton
	{
		public function ButtonBack(x:Number = 0, y:Number = 0, onClick:Function = null)
		{
			super(x, y, "BACK", onClick);
			
			loadGraphic(AssetManager.getClass("SmallButton"), false, false, 60, 16);
			labelOffset.y = 1;
		}
	}
}