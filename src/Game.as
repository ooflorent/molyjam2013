package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	import sacrifice.managers.EntityManager;
	import sacrifice.managers.LevelManager;
	import sacrifice.managers.WeaponManager;
	import sacrifice.states.PlayState;
	import sacrifice.states.SplashState;
	
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
			super(160, 120, GameModel.DEBUG ? PlayState : SplashState, 4);
			
			if (GameModel.DEBUG) {
				FlxG.visualDebug = false;
				forceDebugger = true;
			}
			
			EntityManager.init();
			LevelManager.init();
			WeaponManager.init();
		}
	}
}