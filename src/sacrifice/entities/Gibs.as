package sacrifice.entities
{
	import org.flixel.FlxEmitter;
	
	public class Gibs extends FlxEmitter
	{
		public function Gibs(x:Number = 0, y:Number = 0)
		{
			super(x, y, 0);
			particleClass = Gib;
			makeGib(200);
		}
		
		public function makeGib(quantity:uint):void
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
	public function Gib()
	{
		super();
		allowCollisions = NONE;
		
		var size:int = 1 + Math.round(Math.random());
		makeGraphic(size, size);
	}
	
	private var originLifespan:Number;
	
	override public function loadGraphic(Graphic:Class, Animated:Boolean=false, Reverse:Boolean=false, Width:uint=0, Height:uint=0, Unique:Boolean=false):FlxSprite
	{
		return this;
	}
	
	override public function loadRotatedGraphic(Graphic:Class, Rotations:uint=16, Frame:int=-1, AntiAliasing:Boolean=false, AutoBuffer:Boolean=false):FlxSprite
	{
		return this;
	}
	
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
}