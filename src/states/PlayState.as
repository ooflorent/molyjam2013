package states 
{
	import entities.PlayerWizard;
	
	import org.flixel.FlxState;
	
	public class PlayState extends FlxState
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var player:PlayerWizard;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function create():void
		{
			player = new PlayerWizard(40, 40);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}