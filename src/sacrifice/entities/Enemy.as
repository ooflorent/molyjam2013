package sacrifice.entities
{
	import org.flixel.FlxSprite;
	
	public class Enemy extends Entity
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Enemy()
		{
			super();
			facing = 0 == Math.round(Math.random()) ? LEFT : RIGHT;
		}
	}
}