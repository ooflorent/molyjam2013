package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	import sacrifice.managers.EntityManager;
	import sacrifice.managers.LevelManager;
	import sacrifice.states.MenuState;
	import sacrifice.states.PlayState;
	
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
			super(160, 120, MenuState, 4);
			
			if (GameModel.DEBUG) {
				FlxG.visualDebug = true;
				forceDebugger = true;
			}
			
			EntityManager.init();
			LevelManager.init();
		}
	}
}