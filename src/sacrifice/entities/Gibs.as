package sacrifice.entities
{
	import org.flixel.FlxEmitter;
	
	public class Gibs extends FlxEmitter
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Gibs()
		{
			super();
			particleClass = Gib;
			makeGib(200);
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		private function makeGib(quantity:uint):void
		{
			var gib:Gib;
			var i:uint;
			
			while (i++ < quantity) {
				gib = new Gib();
				gib.exists = false;
				add(gib);
			}
		}
	}
}

import org.flixel.FlxParticle;
import org.flixel.FlxSprite;

internal class Gib extends FlxParticle
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function Gib()
	{
		super();
		allowCollisions = NONE;
		
		var size:int = 1 + Math.round(Math.random());
		makeGraphic(size, size);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var originLifespan:Number;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	override public function onEmit():void
	{
		alpha = 1;
		originLifespan = lifespan;
	}
	
	override public function update():void 
	{
		alpha = lifespan / originLifespan;
		super.update();
	}
	
	override public function loadGraphic(graphic:Class, animated:Boolean = false, reverse:Boolean = false, width:uint = 0, height:uint = 0, unique:Boolean = false):FlxSprite { return this; }
	override public function loadRotatedGraphic(graphic:Class, rotations:uint = 16, frame:int = -1, antiAliasing:Boolean = false, autoBuffer:Boolean = false):FlxSprite { return this; }
}