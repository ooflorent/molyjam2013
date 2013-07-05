package
{
	import managers.DataManager;
	
	import org.flixel.FlxGame;
	
	import states.PlayState;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class Game extends FlxGame
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Game()
		{
			super(160, 120, PlayState, 4);
			
			DataManager.init();
		}
	}
}