package entities
{
	import components.Characteristics;
	
	import managers.DataManager;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class PlayerWizard extends FlxSprite
	{
		//----------------------------------------------------------------------
		//
		//  Class constants
		//
		//----------------------------------------------------------------------
		
		[Embed("../assets/images/wizard.png")]
		private static const AssetWizard:Class;
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function PlayerWizard(x:Number = 0, y:Number = 0)
		{
			super(x, y);
			
			loadGraphic(AssetWizard, true, true, 8, 8, true);
			
			addAnimation("idle", [0]);
			addAnimation("walk", [2, 3], 10, true);
			addAnimation("attack", [4, 5], 10, false);
			addAnimation("death", [6]);
			
			facing = RIGHT;
			play("idle");
			
			charateristics = DataManager.getCharacteristics("wizard");
		}
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public var charateristics:Characteristics;
		
		//----------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function update():void
		{
			velocity.x = 0;
			
			if (FlxG.keys.LEFT) {
				velocity.x = -50;
				facing = LEFT;
			} else if (FlxG.keys.RIGHT) {
				velocity.x = +50;
				facing = RIGHT;
			} else {
				velocity.x = 0;
			}
			
			if (0 == velocity.x) {
				play("idle");
			} else {
				play("walk");
			}
			
			super.update();
		}
	}
}