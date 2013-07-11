package sacrifice.hud
{
	import org.flixel.FlxText;
	
	public class TextTitle extends FlxText
	{
		public function TextTitle(x:Number, y:Number, width:uint, text:String = null)
		{
			super(x, y, width, text);
			setFormat("AESystematicTT", 18, 0xF3F3F3, "center", 0xFF0000);
		}
	}
}