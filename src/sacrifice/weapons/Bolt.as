package sacrifice.weapons
{
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
	public class Bolt extends FlxWeapon
	{
		public function Bolt(name:String, parentRef:* = null)
		{
			super(name, parentRef, "x", "y");
		}
	}
}
